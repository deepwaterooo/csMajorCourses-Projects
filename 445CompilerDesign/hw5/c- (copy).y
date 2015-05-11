%{
#include <iostream>
  //#include <stdio.h>
#include <fstream>
#include <cstring>
#include <cctype>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "scanType.h"  
#include "c-.tab.h"
#include "symtab.h"
#include "emitCode.h"

extern int yylex();
extern int yyparse();
extern FILE * yyin;
FILE* code; 
char *yyfilename;
extern char *yytext;
extern int linnum;
extern char tokenString[];
extern char* optarg;

#define MAXCHILDREN 3
#define gp GP   //0  The global pointer
#define fp FP   //1  The local frame pointer
#define rt RT   //2  Return value
#define ac AC   //3  Accumulator
#define ac1 AC1 //4  Accumulator
#define ac2 AC2 //5  Accumulator
#define ac3 AC3 //6  Accumulator
#define pc PC   //7  The program counter
#define TRUE 1
#define FALSE 0

int goffset = 0;
int toff;
int foffset, loc_main;

typedef int TokenType;
typedef enum {DeclK, StmtK, ExpK} NodeKind; 
typedef enum {VarK, FuncK, ParamK} DeclKind;
typedef enum {IfK, WhileK, ForEachK, CompoundK, ReturnK, BreakK} StmtKind;
typedef enum {OpK, ConstantK, IdK, AssignK, CallK} ExpKind;
typedef enum {Local, Global, Parameter, LocalStatic} typeallocation;

typedef struct treeNode {
  struct treeNode *child[MAXCHILDREN]; // children of the node
  struct treeNode *sibling;            // siblings for the node
  int linnum;                          // linenum relevant to this node
  NodeKind nodekind;                   // type of node
  union {                              // subtype of type 
    DeclKind decl;                     // used when DeclK
    StmtKind stmt;                     // used when StmtK
    ExpKind exp;                       // used when ExpK
  } kind;
  union {                              // relevant data to type -> attr
    TokenType op;                      // type of token (same as in bison)
    int val;                           // used when an integer constant
    char *name;                        // used when IdK
  } attr;                                 
  char* string;                        // used when a string constant
  ExpType expType;                     // used when ExpK for type checking
  bool isStatic;                       // is staticly allocated?
  bool isArray;                        // is this an array
  bool isConstant;                     // can this expression be precomputed?

  int loc; 
  int size; 
  typeallocation TypeAllocation;

} TreeNode;

static TreeNode* savedTree; // stores syntax tree for later return

using namespace std;
//#define YY_DECL extern "C" int yylex()
#define YYDEBUG 1
TreeNode * newStmtNode( StmtKind );
TreeNode * newDeclNode(DeclKind kind);
TreeNode * newExpNode( ExpKind );
//void FreeTree(Node *p);
static TokenData token; /* holds current token */
void yyerror(const char* s);
char* getType(int x);
char* getTypeAlloc(int x);
char * copyString( char * s);

static int indentno = 0;
#define INDENT indentno += 1
#define UNINDENT indentno -= 1
void printNode( TreeNode * tree);
void printTree( TreeNode * tree, int depth, unsigned int sepbits);
//void printTree( TreeNode * tree);
static void printSpaces(void);
static void insertCheckNode( TreeNode * t);
TreeNode* siblingNode(TreeNode* t, ExpType expType, char* string, ExpType argType, char*);
char str[64];

static int tempOffset = 0;
static void cgen(TreeNode* tree);
void emitIO(char * string);
int backPatchJumpToHere(int addr, char *comment);
int backPatchJumpToHere2(int addr, char *comment, char *cc);
void genGlobal();
bool isIO(TreeNode* t);

int i = 0;
int cmpi = 0;
int funci = 0;
int ifi = 0;
int whilei = 0;
int opi = 0;
int assigni = 0;
bool ReturnFlag = false;
bool LoopFlag = false;
//int pcnt = 0;
bool WhileFlag = false;
bool ForEachFlag = false;
bool cpflag = false;
int depthcnt = 0;
int callcnt = 0;
int bkcnt = 0;

%} 

%union {
  ExpType type;    
  int number;
  TokenData * tokenData;
  struct treeNode * nodeptr;
}
%token <tokenData> PASSIGN MASSIGN INC DEC EQ NEQ LEQ GEQ 
%token <tokenData> ID CHARCONST NUMCONST STRINGCONST
%token <tokenData> IF ELSE WHILE FOREACH IN
%token <tokenData> STATIC INT BOOL CHAR VOID  
%token <tokenData> TRUE FALSE RETURN BREAK 
%token <tokenData> ',' ';' ':'
%token <tokenData> '{' '(' '[' '}' ')' ']'
%token <tokenData> AND OR NOT '<' '=' '>' '*' '%' '/' '-' // '+' EQ
%token <tokenData> '+' 
%type <type> type_specifier //type_specifier_func scoped_type_specifier 
%type <nodeptr> and_expression arg_list call compound_stmt declaration declaration_list expression 
%type <nodeptr> expression_stmt factor fun_declaration ifmatched ifunmatched immutable local_declarations
%type <nodeptr> mulop mutable param_id param_id_list param_list rel_expression                            
%type <nodeptr> scoped_var_declaration simple_expression statement statement_list sum_expression term         
%type <nodeptr> unary_expression unary_rel_expression unaryop var_decl_initialize var_decl_list 
%type <nodeptr> var_declaration params args  
    
%%

program : declaration_list { savedTree = $1; }
        ;                
declaration_list : declaration_list declaration 
                 {
		   TreeNode* t = $1;
		   if (t != NULL){
		     while (t->sibling != NULL) t = t->sibling;
		     t->sibling = $2;
		     $$ = $1;
		   } else
		     $$ = $2;
		 }
                 | declaration { $$ = $1; }
                 ;
declaration : var_declaration { $$ = $1;}
            | fun_declaration { $$ = $1;}
            ;

var_declaration : type_specifier var_decl_list ';' 
                {
		  TreeNode* t = $2;
		  if (t != NULL){
		    t->expType = $1;
		    while (t->sibling != NULL) {
		      t = t->sibling;
		      t->expType = $1;
		    }
		    $$ = $2;
		  }
		}
                ;
scoped_var_declaration : STATIC type_specifier var_decl_list ';' 
                       { 
			 TreeNode* t = $3;
			 if (t != NULL){
			   t->expType = $2;
			   t->isStatic = true;
			   while (t->sibling != NULL) {
			     t = t->sibling;
			     t->expType = $2;
			     t->isStatic = true;
			   }
			 }
			 $$ = $3;
		       }
		       | type_specifier var_decl_list ';'  
                       { 
			 TreeNode* t = $2;
			 if (t != NULL){
			   t->expType = $1;
			   while (t->sibling != NULL) {
			     t = t->sibling;
			     t->expType = $1;
			   }
			 }
			 $$ = $2;
		       }
                       ;

var_decl_list : var_decl_list ',' var_decl_initialize 
              {
		TreeNode* t = $1;
		if (t != NULL){
		  while (t->sibling != NULL) t = t->sibling;
		  t->sibling = $3;
		  $$ = $1;
		} else
		  $$ = $3;
	      }
              | var_decl_initialize { $$ = $1; }
              ;
var_decl_initialize : ID 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->string = $1->tokenstr;
		    }
                    | ID '[' NUMCONST ']' 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->string = $1->tokenstr;
		      //$$->child[0] = $3;
		      $$->isArray = true;
		      $$->size = $3->iValue; 
		    }
                    | ID ':' simple_expression 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->string = $1->tokenstr;
		      $$->child[0] = $3;
		    }
                    | ID '[' NUMCONST ']' ':' simple_expression 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->string = $1->tokenstr;
		      $$->size = $3->iValue; 
		      $$->child[0] = $6;
		      $$->isArray = true;
		    }
                    ;
type_specifier : INT  { $$ = Integer; }
               | BOOL { $$ = Boolean; }
               | CHAR { $$ = Character; }
               | VOID { $$ = Void; }
               ;

fun_declaration : type_specifier ID '(' params ')' statement 
                {
		  TreeNode* t = newDeclNode(FuncK); 
		  t->string = $2->tokenstr;
		  t->linnum = $2->linnum;
		  t->expType = $1;
		  $$ = t;
		  $$->child[0] = $4;
		  $$->child[1] = $6;
		  //$$->child[1]->string = $2->tokenstr;
		}
                | ID '(' params ')' statement 
		{
		  TreeNode* t = newDeclNode(FuncK);
		  t->string = $1->tokenstr;
		  t->linnum = $1->linnum;
		  t->expType = Void;  // 0
		  $$ = t;
		  $$->child[0] = $3;
		  $$->child[1] = $5;
		  //$$->child[1]->string = $2->tokenstr;
		}
		;
params : param_list { $$ = $1; }
       | /* empty*/ { $$ = NULL; }
       ;

param_list : param_list ';' type_specifier param_id_list 
           {
	     TreeNode* t = $1;
	     TreeNode* v = $4;
	     if (v != NULL){
	       v->expType = $3;
	       while (v->sibling != NULL) {
		 v = v->sibling;
		 v->expType = $3;
	       }
	     }
	     if (t != NULL){
	       while (t->sibling != NULL) t = t->sibling;
	       t->sibling = $4;
	       $$ = $1;
	     } else
	       $$ = $4;
	   }
	   | type_specifier param_id_list 
	   {
	     TreeNode* v = $2;
	     if (v != NULL){
	       v->expType = $1;
	       while (v->sibling != NULL) {
		 v = v->sibling;
		 v->expType = $1;
	       }
	     } 
	     $$ = $2;
	   }
	   ;
param_id_list : param_id_list ',' param_id 
              {
		TreeNode* t = $1;
		if (t != NULL){
		  while (t->sibling != NULL) t = t->sibling;
		  t->sibling = $3;
		  $$ = $1;
		} else
		  $$ = $3;
	      }
              | param_id  { $$ = $1; }
              ;
param_id : ID 
         {
	   $$ = newDeclNode(ParamK);
	   $$->linnum = $1->linnum;
	   $$->string = $1->tokenstr;
	 }
	 | ID '[' ']' 
         {
	   $$ = newDeclNode(ParamK);
	   $$->linnum = $1->linnum;
	   $$->string = $1->tokenstr;
	   $$->isArray = true;
	 }
	 ;

statement : ifmatched { $$ = $1; }
          | ifunmatched { $$ = $1; }
          ;
ifmatched : IF '(' simple_expression ')' ifmatched ELSE ifmatched 
          { 
	    $$ = newStmtNode(IfK);
	    $$->string = $1->tokenstr;
	    $$->linnum = $1->linnum;
	    $$->child[0] = $3;
	    $$->child[1] = $5;
	    $$->child[1]->expType = Boolean;
	    $$->child[2] = $7;
	  }
          | WHILE '(' simple_expression ')' ifmatched
          { 
	    $$ = newStmtNode(WhileK);
	    $$->linnum = $1->linnum;
	    $$->string = $1->tokenstr;
	    $$->child[0] = $3;
	    $$->child[1] = $5;
	    //$$->child[1]->expType = Boolean;
	  }
          | FOREACH '(' mutable IN simple_expression ')' ifmatched 
          { 
	    $$ = newStmtNode(ForEachK);
	    $$->string = $1->tokenstr;
	    $$->linnum = $1->linnum;
	    $$->child[0] = $3;
	    $$->child[1] = $5;
	    $$->child[2] = $7;
	  }
          | expression_stmt { $$ = $1; }
    	  ;
ifunmatched : IF '(' simple_expression ')' ifmatched ELSE ifunmatched
            { 
	      $$ = newStmtNode(IfK);
	      $$->linnum = $1->linnum;
	      $$->string = $1->tokenstr;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	      $$->child[1]->expType = Boolean;
	      $$->child[2] = $7;
	    }
            | IF '(' simple_expression ')' statement
            { 
	      $$ = newStmtNode(IfK);
	      $$->string = $1->tokenstr;
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	      //$$->child[1]->expType = Boolean;
	    }
            | WHILE '(' simple_expression ')' ifunmatched
            { 
	      $$ = newStmtNode(WhileK);
	      $$->string = $1->tokenstr;
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	      //$$->child[1]->expType = Boolean;
	    }
            | FOREACH '(' mutable IN simple_expression ')' ifunmatched 
            { 
	      $$ = newStmtNode(ForEachK);
	      $$->string = $1->tokenstr;
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	      $$->child[2] = $7;
	    }
            ;
expression_stmt: compound_stmt { $$ = $1; }
               | RETURN ';' 
               {
		 $$ = newStmtNode(ReturnK);
		 $$->linnum = $1->linnum;
		 $$->expType = Void;
	       }
               | RETURN expression ';'  
               {
		 $$ = newStmtNode(ReturnK);
		 $$->linnum = $1->linnum;
		 $$->child[0] = $2;
		 $$->expType = $2->expType; 
	       }
              | BREAK ';'  
              {
		$$ = newStmtNode(BreakK);
		$$->string = $1->tokenstr;
		$$->linnum = $1->linnum;
	      }
              | expression ';' { $$ = $1; }
              | ';' { $$ = NULL; }
              ;     /*
expression_stmt : expression ';' { $$ = $1; }
                | ';' { $$ = NULL; }
                ;
		    */
compound_stmt : '{' local_declarations statement_list '}' 
              {
		$$ = newStmtNode(CompoundK);
		$$->linnum = $1->linnum;
		$$->child[0] = $2;
		$$->child[1] = $3;
	      }
	      ;
local_declarations : local_declarations scoped_var_declaration 
                   {
		     TreeNode* t = $1;
		     if (t != NULL){
		       while (t->sibling != NULL) t = t->sibling;
		       t->sibling = $2;
		       $$ = $1;
		     } else
		       $$ = $2;
		   }
                   | { $$ = NULL; } 
                   ;
statement_list : statement_list statement 
               {
		 TreeNode* t = $1;
		 if (t != NULL){
		   while (t->sibling != NULL) t = t->sibling;
		   t->sibling = $2;
		   $$ = $1;
		 } else
		   $$ = $2;
	       }
               |  { $$ = NULL; } 
               ;
expression : mutable '=' expression // this grammar may have problems
           {
	     $$ = newExpNode(AssignK); 
	     $$->attr.op = $2->tokenClass;
	     $$->string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->expType = $1->expType;  // modified here
	     $$->child[0] = $1;
	     $$->child[1] = $3;
	   }
           | mutable PASSIGN expression 
           {
	     $$ = newExpNode(AssignK);
	     $$->string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->attr.op = $2->tokenClass;
	     $$->child[0] = $1;
	     $$->child[1] = $3;
	   }
           | mutable MASSIGN expression 
           {
	     $$ = newExpNode(AssignK);
	     $$->string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->attr.op = $2->tokenClass;
	     $$->child[0] = $1;
	     $$->child[1] = $3;
	   }
           | mutable INC
           {
	     $$ = newExpNode(AssignK);
	     $$->string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->attr.op = $2->tokenClass;
	     $$->child[0] = $1;
	   }
           | mutable DEC
           {
	     $$ = newExpNode(AssignK);
	     $$->string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->attr.op = $2->tokenClass;
	     $$->child[0] = $1;
	   }
           | simple_expression { $$ = $1; }
           ;
simple_expression : simple_expression OR and_expression  
                  {
		    $$ = newExpNode(OpK); 
		    $$->attr.op = $2->tokenClass;
		    $$->string = $2->tokenstr;
		    $$->linnum = $2->linnum; 
		    $$->child[0] = $1;
		    $$->child[1] = $3;
		  }
                  | and_expression { $$ = $1; }
                  ;
and_expression : and_expression AND unary_rel_expression  
               {
		 $$ = newExpNode(OpK); 
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | unary_rel_expression { $$ = $1; }
               ;
unary_rel_expression : NOT unary_rel_expression
                     { 
		       $$ = newExpNode(OpK);
		       $$->attr.op = $1->tokenClass;
		       $$->string = $1->tokenstr;
		       $$->linnum = $1->linnum; 
		       $$->child[0] = $2;
		     }
                     | rel_expression { $$ = $1; }
                     ;
rel_expression : sum_expression '<' sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression '>' sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression LEQ sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression GEQ sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression EQ sum_expression
               {
		 $$ = newExpNode(OpK); // '=='
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression NEQ sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression { $$ = $1; }
               ;
sum_expression : sum_expression '+' term  
               {
		 $$ = newExpNode(OpK);
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum;
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression '-' term  
               {
		 $$ = newExpNode(OpK);
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum;
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | term { $$ = $1; }
               ;
term : term mulop unary_expression 
     {
       $$ = $2;
       $$->child[0] = $1;
       $$->child[1] = $3;
     }
     | unary_expression { $$ = $1; }
     ;
mulop : '*' 
      { 
	$$ = newExpNode(OpK); 
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      | '/'
      { 
	$$ = newExpNode(OpK); 
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      | '%'
      { 
	$$ = newExpNode(OpK); 
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      ;
unary_expression : unaryop unary_expression  
                 {
		   $$ = $1; 
		   $$->child[0] = $2;
		 }
                 | factor { $$ = $1; }
                 ;
unaryop : '-' 
        { 
	  $$ = newExpNode(OpK); 
	  $$->attr.op = $1->tokenClass;
	  $$->string = $1->tokenstr;
	  $$->linnum = $1->linnum; 
	}
        | '*' 
        { 
	  $$ = newExpNode(OpK); 
	  $$->attr.op = $1->tokenClass;
	  $$->string = $1->tokenstr;
	  $$->linnum = $1->linnum; 
	}
        ;
factor : immutable { $$ = $1; }
       | mutable { $$ = $1; }
       ;
mutable : ID 
        {
	  $$ = newExpNode(IdK);
	  $$->string = $1->tokenstr;
	  $$->linnum = $1->linnum;
	}
        | ID '[' expression ']' 
        {
	  $$ = newExpNode(IdK);
	  $$->string = $1->tokenstr;
	  $$->linnum = $1->linnum;
	  $$->isArray = true; // or false???
	  $$->child[0] = $3;
	}
        ;
immutable : '(' expression ')' { $$ = $2; }
          | call  { $$ = $1; }
          | NUMCONST
	  {
	    $$ = newExpNode(ConstantK);
	    //sprintf($$->string, "%d", $1->iValue);
	    $$->attr.val = $1->iValue;
	    $$->linnum = $1->linnum; 
	    $$->expType = Integer;
	    $$->isConstant = true;
	  }
          | CHARCONST
	  {
	    $$ = newExpNode(ConstantK);
	    $$->linnum = $1->linnum; 
	    $$->string = $1->tokenstr;
	    $$->expType = Character;
	    $$->isConstant = true;
	  }
          | STRINGCONST
	  {
	    $$ = newExpNode(ConstantK);
	    $$->string = $1->tokenstr;
	    $$->linnum = $1->linnum; 
	    $$->expType = Character;
	    $$->isArray = true;
	    $$->isConstant = true;
	  }
          | TRUE  
	  {
	    $$ = newExpNode(ConstantK);
	    $$->string = $1->tokenstr;
	    $$->linnum = $1->linnum; 
	    $$->expType = Boolean;
	    $$->isConstant = true;
	  }
          | FALSE
	  {
	    $$ = newExpNode(ConstantK);
	    $$->string = $1->tokenstr;
	    $$->linnum = $1->linnum;
	    $$->expType = Boolean;
	    $$->isConstant = true;
	  }
          ;
call : ID '(' args ')' 
     {
       $$ = newExpNode(CallK);
       $$->string = $1->tokenstr;
       $$->linnum = $1->linnum;
       $$->child[0] = $3;
     }
     ;
args : arg_list { $$ = $1; }
     | { $$ = NULL; }
     ;
arg_list : arg_list ',' expression
         {
	   TreeNode * t = $1;
	   if (t != NULL){
	     while  (t->sibling != NULL) t = t->sibling;
	     t->sibling = $3;
	     $$ = $1;
	   } else
	     $$ = $3;
	 }
         | expression { $$ = $1; }
         ;

%%

void nodePrint(void * p){
    TreeNode * t = (TreeNode*)p;
    //printTree(t, 0, 0);
    printNode(t);
}
SymTab * st = new SymTab(nodePrint);

int numError = 0; 
int numWarnings = 0;
char nameCompoundStat[64];
char nameParam[32];
int depth = 1;
int depcp = 0;

main(int argc, char* argv[]){
  int d_flag = 0;
  int s_flag = 0;
  char *d_value = NULL;
  char *s_value = NULL;
  int c;
  /*
    if (argc == 1) 
    yyin = stdin;
    else if (argc == 2) {
    yyin = fopen(argv[1], "r");
    } else if (argc > 2) {     */

  while ((c = getopt (argc, argv, "o:p")) != -1) {
    switch (c) {      
    case 'p':   // printTree
      d_flag = 1;
      break;
    case 'o':  // output file
      s_flag = 1;
      s_value = optarg;
      //printf("filename: %s\n", s_value);

      //code = fopen(optarg, "w");
      break;
    default:
      abort ();
      break;
    }
  }
      /*
      yyin = fopen(argv[2], "r");
    } else {
      printf("Usage:./c- TestFileName\nUsage:./c- < TestFileName\nUsage: cat TestFileName | ./c-\n");
        exit(-1);
    }
    if (yyin == NULL){
        printf("Can't open/read '%s'\n", argv[2]);
        exit(-1);
    }
    yyfilename = argv[1];  */

  yyin = fopen(argv[optind], "r");
  linnum = 1;

  yyparse();
  savedTree = siblingNode(savedTree, Integer, (char*)("input"), Void, (char*)(" "));
  savedTree = siblingNode(savedTree, Void, (char*)("output"), Integer, (char*)("xyz"));
  savedTree = siblingNode(savedTree, Boolean, (char*)("inputb"), Void, (char*)(" "));
  savedTree = siblingNode(savedTree, Void, (char*)("outputb"), Boolean, (char*)("xyz"));
  savedTree = siblingNode(savedTree, Void, (char*)("outnl"), Void, (char*)(" "));
  savedTree = siblingNode(savedTree, Character, (char*)("inputc"), Void, (char*)(" "));
  savedTree = siblingNode(savedTree, Void, (char*)("outputc"), Character, (char*)("xyz"));
  insertCheckNode(savedTree);  
 
  if (!st->lookup("main")) {
    printf("ERROR(LINKER): Procedure main is not defined.\n");
    ++numError;
    printf("Number of warnings: %d\n", numWarnings);
    printf("Number of errors: %d\n", numError);
  }

  if (s_flag == 1) {
    //printf("s_value: %s\n", s_value);
    code = fopen(s_value, "w");
  } else {   
    //if (s_flag != 1) {
    char* filename = argv[optind];
    int length = strlen(filename);
    filename[length-1] = 'm';
    filename[length-2] = 't';
    s_value = filename;
    code = fopen(filename, "w");
  }
  //st->print();

  emitComment("C- compiler version C-F07");
  emitComment("Author: Heyan Huang");
  emitComment("Backend adapted from work by Jorge Williams (2001)");
  emitComment2("File compiled: ", s_value);
  emitComment("Nov 29, 2007");
  emitSkip(1);  // for initial later on
  emitIO("input");
  emitIO("output");
  emitIO("inputb");
  emitIO("outputb");
  emitIO("outnl");

  cgen(savedTree);

  backPatchJumpToHere(0, "Jump to init");
  emitComment("BEGIN Init");
  emitRM("LD", gp, 0, gp, "Set the global pointer");
  goffset = 0;
  genGlobal();

  emitRM("LDA", fp, goffset, gp, "set first frame at end of globals");
  emitRM("ST", fp, 0, fp, "store old fp (point to self)");
  emitRM("LDA", ac, 1, pc, "Return address in ac");
  emitRMAbs("LDA", pc, ((TreeNode*)(st->lookup("main")))->loc, "Jump to main");
  emitRO("HALT", gp, 0, gp, "DONE!");
  emitComment("END Init");

  if (d_flag == 1) {
    printTree(savedTree, 0, 0);
  }

  printf("Number of warnings: %d\n", numWarnings);
  printf("Number of errors: %d\n", numError);

  if (argc != 1)
    fclose(yyin);
  fclose (code);
}

static void cgen(TreeNode* t) {
  if (t) {
  switch (t->nodekind) {
  case DeclK:
    TreeNode *r, *s, *u;
    int savedLoc1, sadLoc2, currloc;
    int loc;

    switch(t->kind.decl) {    
    case VarK:
      if (t->isArray) {
	emitRM2("LDC", ac, t->size, ac3, "load size of array", t->string);
	emitRM2("ST", ac, t->loc+1, fp, "save size of array", t->string);
      }
      if (t->sibling)
	cgen(t->sibling);
      break;

    case FuncK:
      if (isIO(t)) {
	if (t->string == "input") {
	  t->loc = 1;
	  t->size = -1;
	  t->TypeAllocation = Global;
	} else if (t->string == "output") {
	  t->loc = 6;
	  t->size = -2;
	  t->TypeAllocation = Global;
	} else if (t->string == "inputb") {
	  t->loc = 13;
	  t->size = -1;
	  t->TypeAllocation = Global;
	} else if (t->string == "outputb") {
	  t->loc = 18;
	  t->size = -2;
	  t->TypeAllocation = Global;
	} else if (t->string == "outnl") {
	  t->loc = 25;
	  t->size = -1;
	  t->TypeAllocation = Global;
	}
      } else {
	emitComment2((char*)("BEGIN function"), t->string);
	t->loc = emitSkip(0);
	TreeNode* p = (TreeNode*)(st->lookup(t->string));
	toff = p->size; 
	//printf("FuncK->size: %d\n", toff);

	emitRM("ST", ac, -1, fp, "Store return address");
	r=t->child[0];
	s=t->child[1];
	cgen(r);
	cgen(s);

	emitComment("Add standard closing in case there is no return statement");
	emitRM("LDC", rt, 0, ac3, "Set return value to 0");
	emitRM("LD", ac, -1, fp, "Load return address");
	emitRM("LD", FP, 0, FP, "Adjust fp");
	emitRM("LDA", PC, 0, AC, "Return");

	emitComment2((char*)("END function"), t->string);
      }
      if ( (t->sibling) && (((TreeNode*)(st->lookup(t->sibling->string)))->kind.decl == VarK) )
	t = t->sibling;
      if ( (t->sibling) && (((TreeNode*)(st->lookup(t->sibling->string)))->kind.decl == FuncK) )
	cgen(t->sibling);
      break;

    case ParamK:
      //r = t->child[0];
      //cgen(r);
      //loc=st_lookup(t->attr.name);
      //emitRM("ST", ac, loc, gp, "assign value"); //变量赋值
      if (t->sibling) 
	cgen(t->sibling);
      break;
    }
    break;

  case StmtK:
    switch(t->kind.stmt) {   
 
    case IfK:
      emitComment("IfK:");
      r=t->child[0];
      s=t->child[1];
      u=t->child[2];

      //逻辑表达式的代码
      emitComment("IfK: t->child[0] condition");
      cgen(r);
      savedLoc1=emitSkip(1); //回填位置1

      //then部分代码
      emitComment("IfK: t->child[1] then part");
      cgen(s);
      sadLoc2=emitSkip(1);//回填位置2
      currloc=emitSkip(0);
      emitBackup(savedLoc1);
      emitRMAbs("JEQ", ac, currloc, "if: jmp to else"); //回填位置1的代码
      emitRestore();

      //else部分代码
      emitComment("IfK: t->child[2] else part");
      cgen(u);
      currloc=emitSkip(0);
      emitBackup(sadLoc2);

      emitRMAbs("LDA", pc, currloc, "jmp to end"); //回填位置2的代码
      emitRestore();
      emitComment("ENDIF");

      if (t->sibling)
	cgen(t->sibling);
      break;

    case WhileK:
      {
	emitComment("WHILE");
	currloc = emitSkip(0);             // return to here to do the test
	cgen(t->child[0]);

	emitRM("JGT", AC, 1, PC, "Jump to while part"); // JEQ
	emitComment("DO");
	//skiploc = breakloc;              // save the old break statement return point
	int breakloc = emitSkip(1);            // addr of instr that jumps to end of loop
	cgen(t->child[1]);

	emitRMAbs("LDA", PC, currloc, "go to beginning of loop");
	backPatchJumpToHere(breakloc, "No more loop");   // backpatch jump to end of loop
	//breakloc = skiploc;              // restore for break statement
	emitComment("ENDWHILE");

	if (t->sibling)
	  cgen(t->sibling);
	break;
      }

    case ForEachK:
	if (t->sibling)
	  cgen(t->sibling);
      break;

    case CompoundK:
      emitComment("BEGIN compound statement");
      cgen(t->child[0]);
      //emitComment("EXPRESSION STMT");
      cgen(t->child[1]);
      emitComment("END compound statement");
      if (t->sibling)
	cgen(t->sibling);
      break;

    case ReturnK:
      emitComment("RETURN");
      if (t->child[0]) {
	cgen(t->child[0]);
      }
      emitRM("LDA", RT, 0, AC, "Copy result to rt register");
      //emitRM("LD", AC, RETURN_OFFSET, FP, "Load return address");
      emitRM("LD", AC, -1, FP, "Load return address");
      //emitRM("LD", FP, OFPOFF, FP, "Adjust fp");
      emitRM("LD", FP, 0, FP, "Adjust fp");
      emitRM("LDA", PC, 0, AC, "Return");
      if (t->sibling)
	cgen(t->sibling);
      break;

    case BreakK:
      if (t->sibling)
	cgen(t->sibling);
      break;
    }
    break;

  case ExpK:
   TreeNode *f, *j;
   switch(t->kind.exp) {    
   case ConstantK:
     emitRM("LDC", ac, t->attr.val, ac3, "Load constant");    
     break;

   case IdK:
     {
       if (!t->child[0])
	 emitRM2("LD", ac, t->loc, fp, "Load variable", t->string);
       else { // t->child[0]
	 cgen(t->child[0]);
	 emitRM("ST", ac, toff--, fp, "Save index");
       }
       if ( (t->sibling) && (callcnt == 0) )
	 cgen(t->sibling);
       break;
     }

   case CallK:
     { 
       callcnt++;
       emitComment("EXPRESSION STMT");
       //printf("toff in CallK: %d\n", toff);
       emitRM("ST", fp, toff, fp, "Store old frame in ghost frame");
       int temp = toff;
       toff -= 2; // rt address

       TreeNode* tmp = t->child[0];
       if (tmp) {
	 cgen(tmp);
	 emitRM("ST", ac, toff--, fp, "Store parameter");
	 while (tmp->sibling) {
	   tmp = tmp->sibling; 
	   cgen(tmp);
	   emitRM("ST", ac, toff--, fp, "Store parameter");
	 }
       }
       emitRM("LDA", fp, temp, fp, "Load address of new frame");
       emitRM("LDA", ac, 1, pc, "Return address in ac");
       emitRMAbs2("LDA", pc, ((TreeNode*)(st->lookup(t->string)))->loc, "CALL", t->string);
       emitRM("LDA", ac, 0, rt, "Save the result in ac");
       toff = temp;
       callcnt--;

       if ( (t->sibling) && (!callcnt) )
	 cgen(t->sibling);
       break;
     }

   case AssignK:
     {
       emitComment("EXPRESSION STMT");
       f = t->child[0];
       if (t->child[1])
	 j = t->child[1];

       if ( (f->kind.exp == IdK) && f->child[0]
	    && (j->kind.exp == IdK) && j->child[0] ) {
	 //emitRM("LDC", ac, f->child[0]->attr.val, ac3, "Load constant");
	 cgen(f->child[0]);
	 emitRM("ST", ac, toff--, fp, "Save index");
	 //emitRM("LDC", ac, j->child[0]->attr.val, ac3, "Load constant");
	 cgen(j->child[0]);

	 if (j->TypeAllocation == Global || j->TypeAllocation == LocalStatic )
	   emitRM2("LDA", ac1, j->loc, gp, "Load address of base of array", j->string);
	 if (j->TypeAllocation == Local || j->TypeAllocation == Parameter )
	   emitRM2("LDA", ac1, j->loc, fp, "Load address of base of array", j->string);
	 emitRO("SUB", ac, ac1, ac, "Compute offset of value");
	 emitRM("LD", ac, 0, ac, "Load the value");
	 emitRM("LD", ac1, ++toff, fp, "Restore index");

	 if (f->TypeAllocation == Global || f->TypeAllocation == LocalStatic )
	   emitRM2("LDA", ac2, f->loc, gp, "Load address of base of array", f->string);
	 if (f->TypeAllocation == Local || f->TypeAllocation == Parameter )
	   emitRM2("LDA", ac2, f->loc, fp, "Load address of base of array", f->string);
	 emitRO("SUB", ac2, ac2, ac1, "Compute offset of value");
	 emitRM2("ST", ac, 0, ac2, "Store variable", f->string);
       } else {
	 if (f && j) {
	   if (f->child[0])
	     cgen(f);
	   cgen(j);
	   emitRM2("ST", ac, f->loc, fp, "Store variable", f->string);
	 } else if ( f && !j) {
	   switch (t->attr.op) {
	   case DEC:
	     if (f->TypeAllocation == Local || f->TypeAllocation == Parameter ) {
	       emitRM2("LD", AC, f->loc, fp, "load lhs variable", f->string);		     
	       emitRM2("LDA", AC, -1, AC, "decrement value of", f->string);		     
	       emitRM2("ST", AC, f->loc, fp, "Store variable", f->string);	
	     }	 /*    
	     if (j->TypeAllocation == Global || j->TypeAllocation == LocalStatic ) {
	       emitRM2("LD", AC, f->loc, gp, "load lhs variable", f->string);		     
	       emitRM2("LDA", AC, -1, AC, "decrement value of", f->string);		     
	       emitRM2("ST", AC, f->loc, gp, "Store variable", f->string);	
	       } */ // goff-- ?
	     break;
	   }
	 }
       }

       if (t->sibling)
	 cgen(t->sibling);
       break;
     }

   case OpK:
     {
       f=t->child[0];
       j=t->child[1];
       cgen(f);   // process lhs

       if (j) {   // process rhs if binary operator
	 //printf("toff: %d\n", toff);

	 emitRM("ST", AC, toff--, FP, "Save left side");
	 cgen(j);
	 emitRM("LD", AC1, ++toff, FP, "Load left into ac1" );
       }

       switch(t->attr.op) {        
       case '+':
	 emitRO("ADD", ac, ac1, ac, "Op +");
	 break;
       case '-':
	 if (!j) {
	   emitRM("LDC", ac1, 0, ac3, "Load 0");
	   emitRO("SUB",ac, ac1,ac, "Op unary -");
	 } else
	   emitRO("SUB",ac, ac1,ac, "Op -");
	 break;
       case '*':
	 emitRO("MUL",ac, ac1, ac, "Op *");
	 break;
       case '/':
	 emitRO("DIV", ac, ac1, ac, "Op /");
	 break;
       case '<':
	 emitRO("SUB", ac1, ac1, ac, "Op <");
	 emitRM("LDC", ac, 1, ac3, "True case"); //reg[ac]=1
	 emitRM("JLT", ac1, 1, pc, "Jump if true");
	 emitRM("LDC", ac, 0, ac3, "False case");//reg[ac]=0
	 //emitRM("LDA", pc, 1, pc, "unconditional jmp");//跳过下面这一句
	 break;

       case '>':
	 emitRO("SUB", ac1, ac1, ac, "Op >");
	 emitRM("LDC", ac, 1, ac3, "True case"); //reg[ac]=1
	 emitRM("JLT", ac1, 1, pc, "Jump if true");
	 emitRM("LDC", ac, 0, ac3, "False case");//reg[ac]=0
	 //emitRM("LDA", pc, 1, pc, "unconditional jmp");//跳过下面这一句
	 break;

       case EQ:
	 emitRO("SUB", ac1, ac1, ac, "Op ==");
	 emitRM("LDC", ac, 1, ac3, "True case"); //reg[ac]=1
	 emitRM("JEQ", ac1, 1, pc, "Jump if true");
	 emitRM("LDC", ac, 0, ac3, "False case");//reg[ac]=0
	 //emitRM("LDA", pc, 1, pc, "unconditional jmp");//跳过下面这一句
	 break;

       case AND: 
	 emitRM("JEQ", ac, 1, pc, "Op AND");
	 emitRM("LDA", ac, 0, ac1, "");
       } //t->attr.op
       if (t->sibling)
	 cgen(t->sibling);
       break;
     } // OpK

     break;
   } // ExpK
  }
  }
}

//根据语法树生成代码
void codeGen(TreeNode* syntaxTree, char *codefile) {
    //从内存的地址0处加载内存最大地址到reg[mp]处
    emitRM("LD", pc, 0, 0, "load maxaddress from location 0");
    //清除内存地址0处的值
    emitRM("ST", 0, 0, 0, "clear location 0");
    cgen(syntaxTree);
    emitRO("HALT", 0, 0, 0, "");
}

void genGlobal() {
  //printf("Loop through global scope\n");
  for (SymTabEntry *ste = st->findScope((char *)"globals") + 1; st->moreScope(ste); ste = st->nextSymTabEntry(ste)) {
    if ( ((TreeNode*)(ste->ptr))->isArray )  {
      emitComment("BEGIN init of global array sizes");
      emitRM2("LDC", ac, ((TreeNode*)(ste->ptr))->size, ac3, "load size of array", ste->name);
      emitRM2("ST", ac, --goffset, gp, "save size of array", ste->name);
      goffset -= ((TreeNode*)(ste->ptr))->size;
      emitComment("END init of global array sizes");
    } else if ( ((TreeNode*)(ste->ptr))->kind.decl == VarK )
      goffset -= 1;

    fflush(stdout);
  }
}

bool isIO(TreeNode* t) {
  if ( (t->nodekind == DeclK) && (t->kind.decl == FuncK) 
       && ((t->string == "output")
	   || (t->string == "outputb")
	   || (t->string == "outputc")
	   || (t->string == "input")
	   || (t->string == "inputb")
	   || (t->string == "inputc")
	   || (t->string == "outnl")) )
    return true; 
  else
    return false;
}

// the classic backpatch using the emit functions
int backPatchJumpToHere(int addr, char *comment) {
    int currloc;
    currloc = emitSkip(0);
    emitBackup(addr);
    emitRMAbs("LDA", PC, currloc, comment);
    emitBackup(currloc);
}

int backPatchJumpToHere2(int addr, char *comment, char* cc) {
    int currloc;
    currloc = emitSkip(0);
    emitBackup(addr);
    emitRMAbs2("LDA", PC, currloc, comment, cc);
    emitBackup(currloc);
}

void emitIO(char * string) {
  if (string == "input") {
    emitComment2((char*)("BEGIN function"), (char*)("input"));
    emitRM((char*)("ST"),AC,-1, FP, (char*)("Store return address"));
    emitRO((char*)("IN"),RT, 2, RT, (char*)("Grab int input"));
    emitRM((char*)("LD"),AC,-1, FP, (char*)("Load return address"));
    emitRM((char*)("LD"),FP,0, FP, (char*)("Adjust fp")); 
    emitRM((char*)("LDA"),PC,0, AC, (char*)("Return")); 
    emitComment2((char*)("END of function"), (char*)("input"));
  }
  else if (string == "output") {
    emitComment2((char*)("BEGIN function"), (char*)("output"));
    emitRM((char*)("ST"),AC,-1, FP, (char*)("Store return address")); 
    emitRM((char*)("LD"),AC,-2, FP, (char*)("Load parameter")); 
    emitRO((char*)("OUT"),AC,3, AC, (char*)("Output integer")); 
    emitRM((char*)("LDC"),RT,0, AC3, (char*)("Set return to 0")); 
    emitRM((char*)("LD"),AC,-1, FP, (char*)("Load return address")); 
    emitRM((char*)("LD"),FP,0, FP, (char*)("Adjust fp")); 
    emitRM((char*)("LDA"),PC,0, AC, (char*)("Return")); 
    emitComment2((char*)("END of function"), (char*)("output"));
  } else if (string == "inputb") {
    emitComment2((char*)("BEGIN function"), (char*)("inputb"));
    emitRM((char*)("ST"),AC,-1, FP, (char*)("Store return address")); 
    emitRO((char*)("INB"),RT,2,2, (char*)("Grab bool input")); 
    emitRM((char*)("LD"),AC,-1, FP, (char*)("Load return address")); 
    emitRM((char*)("LD"),FP,0, FP, (char*)("Adjust fp")); 
    emitRM((char*)("LDA"),PC,0, AC, (char*)("Return")); 
    emitComment2((char*)("END of function"), (char*)("inputb"));
  } else if (string == "outputb") {
    emitComment2((char*)("BEGIN function"), (char*)("outputb"));
    emitRM((char*)("ST"),AC,-1, FP, (char*)("Store return address")); 
    emitRM((char*)("LD"),AC,-2, FP, (char*)("Load parameter")); 
    emitRO((char*)("OUTB"),AC,3, AC, (char*)("Output bool")); 
    emitRM((char*)("LDC"),RT,0, AC3, (char*)("Set return to 0")); 
    emitRM((char*)("LD"),AC,-1, FP, (char*)("Load return address")); 
    emitRM((char*)("LD"),FP,0, FP, (char*)("Adjust fp")); 
    emitRM((char*)("LDA"),PC,0, AC, (char*)("Return")); 
    emitComment2((char*)("END of function"), (char*)("outputb"));
  } else if (string == "outnl") {
    emitComment2((char*)("BEGIN function"), (char*)("outnl"));
    emitRM((char*)("ST"),AC,-1, FP, (char*)("Store return address")); 
    emitRO((char*)("OUTNL"),AC,3, AC, (char*)("Output a newline")); 
    emitRM((char*)("LD"),AC,-1, FP, (char*)("Load return address")); 
    emitRM((char*)("LD"),FP,0, FP, (char*)("Adjust fp")); 
    emitRM((char*)("LDA"),PC,0, AC, (char*)("Return")); 
    emitComment2((char*)("END of function"), (char*)("outnl"));
  }
}

TreeNode* siblingNode(TreeNode* t, ExpType expType, char* string, ExpType argType, char* id) {
  TreeNode* newTree; 
  newTree = newDeclNode(FuncK);
  newTree->string = string; 
  newTree->linnum = -1;
  newTree->expType = expType;
  if (argType != Void) {
    newTree->child[0] = newDeclNode(ParamK);
    newTree->child[0]->string = id;
    newTree->child[0]->expType = argType;
  }
  newTree->sibling = t;
  return newTree;
}

static void insertCheckNode( TreeNode * t)  {

  switch (t->nodekind) {
  case DeclK:  
    switch(t->kind.decl){

    case VarK:
      if (!t->isArray)
	t->size = 1;

      switch(t->TypeAllocation) {
      case Local:
	if (!t->isArray)
	  t->loc = foffset; 
	else {
	  t->loc = foffset-1; 
	  foffset -= 1;
	  toff -= 1;
	}
	foffset -= t->size;
	toff -= t->size;
	break; 
      case Parameter:
	t->loc = foffset; 
	foffset -= 1;//t->size;
	toff -= 1;   //t->size;
	break; 
      case Global: 
	t->loc = goffset-1; 
	goffset -= t->size + 1; // +1
	break; 
      case LocalStatic: 
	t->loc = goffset; 
	goffset -= t->size + 1; // +1
	break; 
      default: 
	break; 
      }

      if (t->child[0]) {
	insertCheckNode(t->child[0]);

	if (t->child[0]->isConstant == false) {
	  printf("ERROR(%d): Initializer for variable '%s' is not a constant expression.\n", 
		 t->child[0]->linnum, t->string);
	  ++numError;
	}

	// initialize array variable
	if ( (t->isArray == true) && (t->child[0] != NULL) ) {
	  //if ( (t->child[0]->isArray) && (t->child[0]->expType != Character) ) { // Character	  
	  //if (t->child[0]->expType != Character) { // Character	  
	  if (t->expType != Character) { // Character	  
	    printf("ERROR(%d): Array '%s' must be of type char to be initialized, but is of type %s.\n",
		   t->linnum, t->string, getType(t->expType));
	    ++numError;
	  }
	  if ( t->child[0]->isArray == false ) {
	    printf("ERROR(%d): Initializer for array variable '%s' must be a string, but is of nonarray type %s.\n",
		   t->child[0]->linnum, t->string, getType(t->child[0]->expType));
	    ++numError;
	  } 
	  if ( (t->child[0]->isArray) && (t->child[0]->expType != Character) ) {
	    printf("ERROR(%d): Array '%s' must be of type char to be initialized, but is of type %s.\n", 
		   t->linnum, t->string, getType(t->expType));
	    ++numError;
	  }
	}
      }

      if ( (t->isArray == false) && (t->child[0] != NULL) ) {
	if ( (t->expType != t->child[0]->expType) && (t->child[0]->expType != Undefined) ){
	  printf("ERROR(%d): Variable '%s' is of type %s but is being initialized with an expression of type %s.\n", 
		 t->linnum, t->string, getType(t->expType), getType(t->child[0]->expType));
	  ++numError;
	}
      }

      //st->print();
      if ((st->lookup(t->string) == NULL) || //(depcp) ||
	  ( ((st->lookupSymTabEntry(t->string))->depth != st->depth()-1 ) //ParamK
	    //&& (st->lookupSymTabEntry(t->string))->depth != st->depth()-2) 
	    && (st->lookupSymTabEntry(t->string))->depth != st->depth()) ) {
	  //|| ((cpflag == true) && depcp)) { 
	 
	st->insert(t->string, (void*)t ); 

	if (t->child[0] != NULL) {
	  /*	  if ( (t->isArray == false) && (t->expType != t->child[0]->expType) ) {
	    printf("ERROR(%d): Variable '%s' is of type %s but is being initialized with an expression of type %s.\n", 
		   t->linnum, t->string, getType(t->expType), getType(t->child[0]->expType));
	    ++numError;
	    }  */   
	  if ( (t->isArray == false) && (t->child[0]->isArray == true) ) {
	    printf("ERROR(%d): Initializer for nonarray variable '%s' of type %s cannot be initialized with an array.\n",
		   t->child[0]->linnum, t->string, getType(t->expType));
	    ++numError;
	  }
	} // child[0] != NULL

      } else { // exist in symtab
	//cout << "st->depth: " << st->depth() << endl;
	//sprintf(str, "Compound Statement:%d", st->depth());
	//if (st->lookupSymTabEntry(t->string)->scope != str) {  // logic is not correct

	//st->print();
	//cout << "st->depth: " << st->depth() << endl;

	//if ( (depcp && ((st->lookupSymTabEntry(t->string))->depth == st->depth()-1)) || (!depcp) ) {
	  printf("ERROR(%d): Symbol '%s' is already defined at line %d.\n", 
		 t->linnum, t->string, ((TreeNode*)(st->lookup(t->string)))->linnum);
	  ++numError;
	  //}
      }

      if  (t->sibling != NULL) {
	//t->sibling->TypeAllocation = t->TypeAllocation; 
	insertCheckNode(t->sibling);
      }
      break;

    case FuncK:
      t->TypeAllocation = Global; 
      if (st->lookup(t->string) == NULL) {   
	st->insert(t->string, (void*)t ); 
      } else { 
	printf("ERROR(%d): Symbol '%s' is already defined at line %d.\n", t->linnum, t->string, 
	       ((TreeNode*)(st->lookup(t->string)))->linnum);
	++numError;
      }

      st->enter(t->string);
      foffset = -2;
      toff = -2;

      if (t->child[0]) {
	t->child[0]->TypeAllocation = Parameter;  
	insertCheckNode(t->child[0]);
      }
      if (t->child[1])
	insertCheckNode(t->child[1]);

      if (t->child[1] != NULL){
	if ( (t->expType == 0) && (t->child[1]->expType != 0) ) {
	  printf("ERROR(%d): Function '%s' at line %d is expecting no return value, but return has return value.\n", 
		 t->child[1]->linnum, t->string, t->linnum);
	  ++numError;
	} else if ( (t->expType == 0) && (ReturnFlag == true) && (t->child[1]->expType != 0) ) {
	  //} else if ( (t->expType == 0) && (ReturnFlag == true) ) {
	  printf("ERROR(%d): Function '%s' at line %d is expecting no return value, but return has return value.\n", 
		 t->child[1]->linnum, t->string, t->linnum);
	  ++numError;
	} else if (t->expType != 0) {
	  if ( (t->child[1]->expType == 0) && (ReturnFlag == true) ) {
	    printf("ERROR(%d): Function '%s' at line %d is expecting to return type %s but return has no return value.\n", 
		   t->child[1]->linnum, t->string, t->linnum, getType(t->expType));
	    ++numError;
	  } else if  ((t->child[1]->expType != 0) && (t->expType != t->child[1]->expType)) {
	    printf("ERROR(%d): Function '%s' at line %d is expecting to return type %s but got type %s.\n", 
		   t->child[1]->linnum, t->string, t->linnum, getType(t->expType), getType(t->child[1]->expType));
	    ++numError;
	  } else if ( (t->child[1]->expType == 0) && (ReturnFlag == false) ){
	    printf("WARNING(%d): Expecting to return type %s but function '%s' has no return statement.\n", 
		   t->linnum, getType(t->expType), t->string);
	    ++numWarnings;
	  }
	}
	ReturnFlag = false; // set back to default
      } // child1
      st->leave();

      if ( (t->child[1] == NULL) && (t->expType != Void) 
	   && ((t->string != (char*)"input") && (t->string != (char*)"inputb") && (t->string != (char*)"inputc"))) {
	printf("WARNING(%d): Expecting to return type %s but function '%s' has no return statement.\n", 
	       t->linnum, getType(t->expType), t->string);
	++numWarnings;
      }
      t->size = foffset; 

      if (t->sibling != NULL) {
	t->sibling->TypeAllocation = Global; 
	insertCheckNode(t->sibling);
      }
      break;

    case ParamK:
      t->loc = foffset; 
      t->size = 1; // could be different
      t->TypeAllocation = Parameter;  
      foffset -= t->size;
      toff -= t->size;

      st->insert(t->string, (void*)t );
      /*      for (int i = 0; i < MAXCHILDREN; i++) {
	if (t->child[i])
	  insertCheckNode(t->child[i]);
	  }   */
      if (t->sibling != NULL) {   
	insertCheckNode(t->sibling);
      }  
      break;
    }
    break;

  case StmtK:   
    switch (t->kind.stmt) {
    case WhileK:
      ++depthcnt;
      LoopFlag = true;

      if (st->lookup(t->string) == NULL)   
	st->insert(t->string, (void*)t );  

      for (ifi = 0; ifi < MAXCHILDREN; ifi++) {
	if (t->child[ifi] != NULL)
	  insertCheckNode(t->child[ifi]);
      }
      if (t->child[0] != NULL) {
	if (t->child[0]->expType != 2) {
	  printf("ERROR(%d): Expecting Boolean test condition in %s statement but got type %s.\n", 
		 t->child[0]->linnum, t->string, getType(t->child[0]->expType));
	  ++numError;
	} //else if ( (t->child[0]->expType == 2) && (t->child[0]->isArray == true) ) {
	if (t->child[0]->isArray == true) {
	  printf("ERROR(%d): Cannot use array as test condition in %s statement.\n", t->child[0]->linnum, t->string);
	  ++numError;
	} 
      }
      if (t->child[1]) {
	sprintf(str, "Return:%d", st->depth());
	if (st->lookup(str) == NULL) {
	  t->expType = Void;
	  ReturnFlag = false;
	} else {
	  ReturnFlag = true;
	  t->expType = ((TreeNode*)(st->lookup(str)))->expType;
	  //t->linnum = ((TreeNode*)(st->lookup(str)))->linnum;
	}
      }

      --depthcnt;
      LoopFlag = false;
      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case IfK:
      if (st->lookup(t->string) == NULL)   
	st->insert(t->string, (void*)t );  

      for (ifi = 0; ifi < MAXCHILDREN; ifi++) {
	if (t->child[ifi] != NULL)
	  insertCheckNode(t->child[ifi]);
      }

      if (t->child[0]->expType != 2) {
	printf("ERROR(%d): Expecting Boolean test condition in %s statement but got type %s.\n", 
	       t->child[0]->linnum, t->string, getType(t->child[0]->expType));
	++numError;
      } //else if ( (t->child[0]->expType == 2) && (t->child[0]->isArray == true) ) {
      if (t->child[0]->isArray == true) {
	printf("ERROR(%d): Cannot use array as test condition in %s statement.\n", t->child[0]->linnum, t->string);
	++numError;
      } 
      if (t->child[1]) {
	sprintf(str, "Return:%d", st->depth());
	if (st->lookup(str) == NULL) {
	  t->expType = Void;
	  ReturnFlag = false;
	} else {
	  ReturnFlag = true;
	  t->expType = ((TreeNode*)(st->lookup(str)))->expType;
	  //t->linnum = ((TreeNode*)(st->lookup(str)))->linnum;
	}
      }

      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;
  
    case ForEachK:
      ++depthcnt;
      LoopFlag = true;
      for (i = 0; i < MAXCHILDREN; i++)  {
	if (t->child[i] != NULL)
	  insertCheckNode(t->child[i]);
      }

      if (t->child[0] != NULL) {
	//if ( ((TreeNode*)(t->child[0]->string))->isArray == true )  {  //need work here
	if ( t->child[0]->isArray == true )  {
	  printf("ERROR(%d): In foreach statement the variable to the left of 'in' must not be an array.\n", t->linnum);
	  ++numError;
	}
	if (t->child[1] != NULL) {
	  if (t->child[1]->isArray == true) {
	    if (t->child[0]->expType != t->child[1]->expType) {
	      printf("ERROR(%d): Foreach requires operands of 'in' be the same type but lhs is type %s and rhs array is type %s.\n", 
		     t->linnum, getType(t->child[0]->expType), getType(t->child[1]->expType));  
	      ++numError;  
	    }
	  } else { //t->child[1]->isArray == false
	    if ( t->child[0]->expType != Integer ) {
	      printf("ERROR(%d): If not an array, foreach requires lhs of 'in' be of type int but it is type %s.\n", 
		     t->linnum, getType(t->child[0]->expType)); 
	      ++numError;
	      t->child[0]->expType = Integer; 
	    } 
	    if (t->child[1]->expType != Integer) {
	      printf("ERROR(%d): If not an array, foreach requires rhs of 'in' be of type int but it is type %s.\n", 
		     t->linnum, getType(t->child[1]->expType)); 
	      ++numError;
	      t->child[1]->expType = Integer; 
	    }
	  }
	} //t->child[1] != NULL
	if (t->child[2]) {
	  sprintf(str, "Return:%d", st->depth());
	  if (st->lookup(str) == NULL) {
	    t->expType = Void;
	    ReturnFlag = false;
	  } else {
	    ReturnFlag = true;
	    t->expType = ((TreeNode*)(st->lookup(str)))->expType;
	    //t->linnum = ((TreeNode*)(st->lookup(str)))->linnum;
	  }
	}
      }
      --depthcnt;
      LoopFlag = false;
      if (t->sibling != NULL) 
	insertCheckNode(t->sibling);
      break;

    case BreakK:
      if ( (LoopFlag == false) && (!depthcnt) ) {   // potential problems with nested loops
      //if ( LoopFlag == false ) {
	printf("ERROR(%d): Cannot have a break statement outside of loop.\n", t->linnum);  
	++numError;
      } 
      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case ReturnK:  
      if (t->child[0] == NULL) 
	t->expType = Void;
      
      if (t->child[0] != NULL) {
	insertCheckNode(t->child[0]);
	if (t->child[0]->expType == Void)
	  t->expType = Undefined;
	else
	  t->expType = t->child[0]->expType;
	if ( (t->child[0]->kind.exp == IdK) && (t->child[0]->isArray) ) {
	  printf("ERROR(%d): Cannot return an array.\n", t->linnum);  
	  ++numError;
	  t->child[0]->isArray = false; 
	} 
      }
      sprintf(str, "Return:%d", st->depth());
      st->insert(str, (void*)t );
      if (t->sibling != NULL)  // just added
	insertCheckNode(t->sibling);
      break;

    case CompoundK:  
      //depth = st->depth() + 1;
      sprintf(nameCompoundStat, "Compound Statement:%d", st->depth()+1);
      st->enter(nameCompoundStat);
      cpflag = true;
      depcp++;

      /*
      for (cmpi = 0; cmpi < MAXCHILDREN; cmpi++) { 
	if (t->child[cmpi] != NULL) 
	  insertCheckNode(t->child[cmpi]);
      }
      */

      if (t->child[0]) {
	if (t->child[0]->isStatic==true)
	  t->child[0]->TypeAllocation = LocalStatic; 
	else
	  t->child[0]->TypeAllocation = Local; 
	insertCheckNode(t->child[0]);
      }

      if (t->child[1]) 
	insertCheckNode(t->child[1]);

      /*  // not sure if this one is necessary any more
      if (t->sibling != NULL) 
	insertCheckNode(t->sibling);
      */

      sprintf(str, "Return:%d", st->depth());
      if (st->lookup(str) == NULL) {
	t->expType = Void;
	ReturnFlag = false;
	/*     } else if (t->child[1]) {
	  t->expType = t->child[1]->expType;
	  if (t->expType)
	    ReturnFlag = true;
	    cout << "t->expType: A " << t->expType << endl;    */
      } else {
	ReturnFlag = true;
	t->expType = ((TreeNode*)(st->lookup(str)))->expType;
	t->linnum = ((TreeNode*)(st->lookup(str)))->linnum;
      }

      st->leave();
      cpflag = false;
      if (ReturnFlag && t->expType) {
	sprintf(str, "Return:%d", st->depth());
	st->insert(str, (void*)t );
      }

      depcp--;
      //depth--;
      if (t->sibling != NULL)  // just added
	insertCheckNode(t->sibling);
      break;

    }
    break;

  case ExpK:  
    switch (t->kind.exp){

    case ConstantK: 
      break;

    case AssignK:
      if (st->lookup(t->string) == NULL)   
	st->insert(t->string, (void*)t );   
      for (assigni = 0; assigni < MAXCHILDREN; assigni++) {
	if (t->child[assigni] != NULL)
	  insertCheckNode(t->child[assigni]);
      }

      if ( (t->child[0] != NULL) && (t->child[1] != NULL) 
	   && (t->child[0]->expType != t->child[1]->expType) )  {

	if ( (t->attr.op == PASSIGN) || (t->attr.op == MASSIGN) ) {
	  if (t->child[0]->expType != Integer) {
	    printf("ERROR(%d): '%s' requires operands of type int but lhs is of type %s.\n", 
		   t->linnum, t->string, getType(t->child[0]->expType));
	    ++numError;
	  } else {
	    printf("ERROR(%d): '%s' requires operands of type int but rhs is of type %s.\n", 
		   t->linnum, t->string, getType(t->child[1]->expType));
	    ++numError;
	  }
	} else if (t->attr.op == '=') {
	  /*if ( t->child[0]->isArray != t->child[1]->isArray ){
	    printf("ERROR(%d): '%s' requires that if one operand is an array so must the other operand.\n", 
		   t->linnum, t->string);
	    ++numError;
	    } */
	  if ( (t->child[0]->expType != Undefined) && (t->child[1]->expType != Undefined) ) {
	    printf("ERROR(%d): '%s' requires operands of the same type but lhs is type %s and rhs is type %s.\n", 
		   t->linnum, t->string, getType(t->child[0]->expType), getType(t->child[1]->expType));
	    ++numError;
	    t->expType = t->child[0]->expType; 
	  }
	  if (t->child[1]->expType == Undefined)
	    t->expType = t->child[0]->expType; 
	  //else if ( (t->child[0]->expType == Undefined) && (t->child[1]->expType != Undefined) )
	  else if (t->child[0]->expType == Undefined)
	    t->expType = Undefined; 
	} else { 
	  printf("ERROR(%d): '%s' requires operands of the same type but lhs is type %s and rhs is type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType), getType(t->child[1]->expType));
	  ++numError;
	}
      }

      if ( ((t->attr.op == INC) || (t->attr.op == DEC))
	   && (t->child[0] != NULL) && (t->child[1] == NULL) ) {
	if (t->child[0]->expType != Integer) {
	  printf("ERROR(%d): Unary '%s' requires an operand of type int but was given type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType));
	  ++numError;
	}
	if (t->child[0]->isArray == true) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
	t->expType = Integer; 
      }

      if ( (t->attr.op == '=') && t->child[0] && t->child[1] ) {
	if ( (t->child[0]->isArray != t->child[1]->isArray)
	     && ((t->child[0]->expType != Undefined) && (t->child[1]->expType != Undefined)) ) {
	     //&& ((t->child[0]->expType != Character) && (t->child[1]->expType != Character)) ) {

	  //cout << "t->child[0]->isArray: " << t->child[0]->isArray << endl;
	  //cout << "t->child[1]->isArray: " << t->child[1]->isArray << endl;

	  printf("ERROR(%d): '%s' requires that if one operand is an array so must the other operand.\n", 
		 t->linnum, t->string);
	  ++numError;
	}
	if (t->child[0]->expType == t->child[1]->expType)
	  t->expType = t->child[0]->expType;
      }

      if ( ((t->attr.op == PASSIGN) || (t->attr.op == MASSIGN)) && (t->child[0]) && (t->child[1]) ) {
	if (t->child[0]->expType == t->child[1]->expType)
	  t->expType = t->child[0]->expType;
      }

      if ( (t->sibling != NULL) && (callcnt == 0))
	//if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case CallK:
      callcnt++;
      if (st->lookup(t->string) == NULL) {
	printf("ERROR(%d): Symbol '%s' is not defined.\n", t->linnum, t->string);
	++numError;
	if (t->child[0]) {
	  TreeNode* tmpt = t->child[0];
	  insertCheckNode(tmpt);
	  while (tmpt->sibling != NULL) {
	    tmpt = tmpt->sibling;
	    insertCheckNode(tmpt);
	  }
	}
	t->expType = Undefined; 
      } else {
	if ( (((TreeNode*)(st->lookup(t->string)))->kind.decl == VarK)
	     || (((TreeNode*)(st->lookup(t->string)))->kind.decl == ParamK) ) {
	  printf("ERROR(%d): '%s' is a simple variable and cannot be called.\n", t->linnum, t->string);
	  ++numError;
	  t->expType = Undefined;
	  if ( t->child[0] ) {
	    TreeNode* tmpt = t->child[0];
	    insertCheckNode(tmpt);
	    while (tmpt->sibling != NULL) {
	      tmpt = tmpt->sibling;
	      insertCheckNode(tmpt);
	    }
	  }
	  t->expType = Undefined; 
	} else { //FuncK
	  TreeNode* tmp = t; 
	  TreeNode* p = (TreeNode*)(st->lookup(t->string));
	  if ( (tmp->child[0] == NULL) && (p->child[0] != NULL) ) {
	    printf("ERROR(%d): Too few parameters passed for function '%s' defined on line %d.\n", 
		   tmp->linnum, tmp->string, p->linnum);
	    ++numError;
	  }
	  if (tmp->child[0]) {
	    insertCheckNode(tmp->child[0]);  // process whole list, order: before or after?
	    if (p->child[0] == NULL) {
	      printf("ERROR(%d): Too many parameters passed for function '%s' defined on line %d.\n", 
		     tmp->child[0]->linnum, tmp->string, p->linnum);
	      ++numError;
	    } else {
	      int pcnt = 0;
	      TreeNode* tmp_p = p->child[0];
	      TreeNode* tmp_t = tmp->child[0];

	      if ((tmp->child[0]->expType != p->child[0]->expType) && (tmp->child[0]->expType != Undefined) ) {
		printf("ERROR(%d): Expecting type %s in parameter %i of call to '%s' defined on line %d but got type %s.\n", 
		       t->linnum, getType(p->child[0]->expType), pcnt+1, t->string, p->linnum, getType(tmp->child[0]->expType));
		++numError;
	      }
	      if ( (tmp->child[0]->isArray == true) && (p->child[0]->isArray == false) ) {
		printf("ERROR(%d): Not expecting array in parameter %i of call to '%s' defined on line %d.\n", 
		       t->linnum, pcnt+1, t->string, p->linnum);
		++numError;
	      }
	      if ( (tmp->child[0]->isArray == false) && (p->child[0]->isArray == true) ) {
		printf("ERROR(%d): Expecting array in parameter %i of call to '%s' defined on line %d.\n", 
		       t->linnum, pcnt+1, t->string, p->linnum);
		++numError;
	      }

	      while (tmp_t->sibling && tmp_p->sibling) {
		pcnt++;
		tmp_t = tmp_t->sibling;
		tmp_p = tmp_p->sibling;
		insertCheckNode(tmp_t);
		if ((tmp_t->expType != tmp_p->expType) && (tmp_t->expType != Undefined) ) {
		  printf("ERROR(%d): Expecting type %s in parameter %i of call to '%s' defined on line %d but got type %s.\n", 
			 t->linnum, getType(tmp_p->expType), pcnt+1, t->string, p->linnum, getType(tmp_t->expType));
		  ++numError;
		}
		if ( (tmp_t->isArray == true) && (tmp_p->isArray == false) ) {
		  printf("ERROR(%d): Not expecting array in parameter %i of call to '%s' defined on line %d.\n", 
			 t->linnum, pcnt+1, t->string, p->linnum);
		  ++numError;
		}
		if ( (tmp_t->isArray == false) && (tmp_p->isArray == true) ) {
		  printf("ERROR(%d): Expecting array in parameter %i of call to '%s' defined on line %d.\n", 
			 t->linnum, pcnt+1, t->string, p->linnum);
		  ++numError;
		}
		tmp_t->expType = tmp_p->expType;
		tmp_t->isArray = tmp_p->isArray;
	      } //while

	      if ( (tmp_t->sibling == NULL) &&  (tmp_p->sibling != NULL) ) {
		printf("ERROR(%d): Too few parameters passed for function '%s' defined on line %d.\n", 
		       t->linnum, t->string, p->linnum);
		++numError;
	      }
	      if ( (tmp_t->sibling != NULL) && (tmp_p->sibling == NULL) ) {
		printf("ERROR(%d): Too many parameters passed for function '%s' defined on line %d.\n", 
		       t->linnum, t->string, p->linnum);
		++numError;
		while (tmp_t->sibling!=NULL) {
		  tmp_t = tmp_t->sibling;
		  insertCheckNode(tmp_t);
		}
	      }
	    } // end p->child[0]
	  } // if
	  t->expType = p->expType; 
	} //   end t->child[0] 
      }
      callcnt--;
      if ( (t->sibling != NULL) && (!callcnt) )
	insertCheckNode(t->sibling);
      break;

    case IdK:
      if (st->lookup(t->string) == NULL) { 	   
	printf("ERROR(%d): Symbol '%s' is not defined.\n", t->linnum, t->string);
	++numError;
	t->expType = Undefined; //4 Undefined
	t->isArray = false;
	t->isConstant = false;
	t->isStatic = false;
	if (t->child[0] != NULL) {
	  insertCheckNode(t->child[0]);
	  t->isArray = false;  } //double check
      } else {  // symtab != NULL

	if ( ((TreeNode*)(st->lookup(t->string)))->kind.decl == FuncK ) {
	  printf("ERROR(%d): Cannot use function '%s' as a simple variable.\n", t->linnum, t->string);
	  ++numError;
	  t->expType = ((TreeNode*)(st->lookup(t->string)))->expType; 
	  //t->expType = Undefined;
	  if (t->child[0] != NULL) {
	    insertCheckNode(t->child[0]);
	    t->isArray = false;  } //double check
	} else { //if ( ((TreeNode*)(st->lookup(t->string)))->kind.decl == VarK ) {
	  TreeNode* p = (TreeNode*)(st->lookup(t->string));
	  t->loc = p->loc; 
	  t->size = p->size; 
	  t->TypeAllocation = p->TypeAllocation;

	  // Dealing Array or Not
	  if (((TreeNode*)(st->lookup(t->string)))->isArray == false) {
	    t->isArray = false;
	    t->expType = ((TreeNode*)(st->lookup(t->string)))->expType;
	    if (t->child[0] != NULL) {
	      printf("ERROR(%d): Cannot index nonarray '%s'.\n", t->linnum, t->string);
	      ++numError;
	    } 
	  } else { //isArray == true

	    if (t->child[0] != NULL) {
	      insertCheckNode(t->child[0]);

	      if ( (t->child[0]->expType != Integer) && (t->child[0]->expType != Undefined) ) { //t->child[0]->expType: int
		printf("ERROR(%d): Array '%s' should be indexed by type int but got type %s.\n", 
		       t->linnum, t->string, getType(t->child[0]->expType));
		++numError;
		t->child[0]->expType == Integer;
		t->isArray = false;
	      }
	      if (t->child[0]->isArray == true) {
		printf("ERROR(%d): Array index is the unindexed array '%s'.\n", 
		       t->child[0]->linnum, t->child[0]->string);
		++numError;
	      }
	      t->isArray = false;
	    } else  // child[0] != NULL
	    t->isArray = true; 
	  }
	  t->expType = ((TreeNode*)(st->lookup(t->string)))->expType;
	} // VarK
	t->isConstant = ((TreeNode*)(st->lookup(t->string)))->isConstant;  // double check when array beco nonarr
      }
      //if (t->sibling != NULL)
      if ( (t->sibling != NULL) && (callcnt ==0))
	insertCheckNode(t->sibling);
      break;

    case OpK:  // + - * / % < > == != <= >= or not and
      int opi;
      for (opi = 0; opi < MAXCHILDREN; opi++) {
	if (t->child[opi] != NULL)
	  insertCheckNode(t->child[opi]);
      }
 
      if ( ((t->attr.op == '+') || (t->attr.op == '-') || (t->attr.op == '*') 
	  || (t->attr.op == '/') || (t->attr.op == '%'))
	   && ((t->child[0] != NULL) && (t->child[1] != NULL)) ) {
	if ( (t->child[0]->expType != Integer) && (t->child[0]->expType != Undefined) ) {
	  printf("ERROR(%d): '%s' requires operands of type %s but lhs is of type %s.\n", t->linnum, t->string, 
		 getType(1), getType(t->child[0]->expType));
	  ++numError;
	  t->child[0]->expType = Integer; 
	} 
	if ( (t->child[1]->expType != Integer) && (t->child[1]->expType != Undefined) ) {
	  printf("ERROR(%d): '%s' requires operands of type %s but rhs is of type %s.\n", t->linnum, t->string, 
		 getType(1), getType(t->child[1]->expType));
	  ++numError;
	  t->child[1]->expType = Integer; 
	} 
	t->expType = Integer; 
	if ( (t->child[0]->isConstant == true) && (t->child[1]->isConstant == true) )
	  t->isConstant = true;
      }  

      if ((t->attr.op == '-') && (t->child[0] != NULL) && (t->child[1] == NULL)) {
	if (t->child[0]->expType != Integer) {
	  printf("ERROR(%d): Unary '%s' requires an operand of type int but was given type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType));	       
	  ++numError;
	  t->child[0]->expType = Integer; 
	}
	if ( t->child[0]->isConstant == true ) {
	  t->isConstant = true;
	}
	t->expType = Integer;
      }

      if ( (t->attr.op == '+') || (t->attr.op == '-') || (t->attr.op == '*') ) {
	if ( (t->child[0] != NULL) && (t->child[1] != NULL) && //both sides
	     ((t->child[0]->isArray == true) || (t->child[1]->isArray == true)) ) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	} 
      } 

      if ( (t->attr.op == '*') && (t->child[0] != NULL) && (t->child[1] == NULL) ) {
	if (t->child[0]->isArray == false) {
	  printf("ERROR(%d): The operation '%s' only works with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
	//if ( (t->child[0]->isArray == true) && (t->child[0]->expType == Character) ) {
	if ( (t->child[0]->isArray == true) && (t->child[0]->isConstant == true) ) {
	  t->isConstant = true;
	}
	t->expType = Integer; 
      }

      if ( ((t->attr.op == EQ) || (t->attr.op == NEQ))
	   && (t->child[0] != NULL) && (t->child[1] != NULL) ) {
	if (t->child[0]->expType != t->child[1]->expType) {
	  printf("ERROR(%d): '%s' requires operands of the same type but lhs is type %s and rhs is type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType), getType(t->child[1]->expType));
	  ++numError;
	} 
	t->expType = Boolean;
	if (t->child[0]->isArray != t->child[1]->isArray) {
	  printf("ERROR(%d): '%s' requires that if one operand is an array so must the other operand.\n", 
		 t->linnum, t->string);
	  ++numError;
	}
      }

      if ( (t->attr.op == AND) && t->child[0] && t->child[1] ) {
	if ( (t->child[0]->expType != Boolean) && (t->child[0]->expType != Undefined) ) { //Undefined
	  printf("ERROR(%d): '%s' requires operands of type bool but lhs is of type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType));
	  ++numError;
	  t->child[0]->expType = Boolean;
	}
	if ( (t->child[1]->expType != Boolean) && (t->child[1]->expType != Undefined) ) {
	  printf("ERROR(%d): '%s' requires operands of type bool but rhs is of type %s.\n", 
		 t->linnum, t->string, getType(t->child[1]->expType));
	  ++numError;
	  t->child[1]->expType = Boolean;
	}
	//t->expType = Boolean; 
	if ((t->child[0]->isArray == true) || (t->child[1]->isArray == true)) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
	t->expType = Boolean; 
      }

      if ( (t->attr.op == '>') || (t->attr.op == '<') || (t->attr.op == GEQ) || (t->attr.op == LEQ) ) {
	if ( (t->child[0] != NULL) && (t->child[0]->expType != Integer) && (t->child[0]->expType != Character) ) {
	  printf("ERROR(%d): '%s' requires operands of type char or type int but lhs is of type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType));
	  ++numError;
	  t->expType = Boolean;
	} 
	if ( (t->child[1] != NULL) && (t->child[1]->expType != Integer) && (t->child[1]->expType != Character) ) {
	  printf("ERROR(%d): '%s' requires operands of type char or type int but rhs is of type %s.\n", 
		 t->linnum, t->string, getType(t->child[1]->expType));
	  ++numError;
	  t->expType = Boolean;
	}

	if ( ((t->child[0] != NULL) && (t->child[1] != NULL)) 
	     && ((t->child[0]->isArray == true) || (t->child[1]->isArray == true)) ) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
      }

      if ( ((t->child[0] != NULL) && (t->child[1] != NULL)) && 
	   ((t->child[0]->expType == 1) && (t->child[1]->expType == 1)) ) {
	if ( (t->attr.op == EQ) || (t->attr.op == NEQ) || (t->attr.op == LEQ) || (t->attr.op == GEQ) 
	     || (t->attr.op == '<') || (t->attr.op == '>') ) 
	  t->expType = Boolean;
	else 
	  t->expType = Integer;
      }

      if (t->attr.op == OR) {
	if ( (t->child[0] != NULL) && (t->child[0]->expType != 2) ) { //Undefined
	  printf("ERROR(%d): '%s' requires operands of type bool but lhs is of type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType));
	  ++numError;
	  t->child[0]->expType = Boolean;
	}
	if ( (t->child[1] != NULL) && (t->child[1]->expType != 2) ) {
	  printf("ERROR(%d): '%s' requires operands of type bool but rhs is of type %s.\n", 
		 t->linnum, t->string, getType(t->child[1]->expType));
	  ++numError;
	  t->child[1]->expType = Boolean;
	}
	t->expType = Boolean; 
      }

      if (t->attr.op == NOT) {
	if ( (t->child[0] != NULL) && (t->child[1] == NULL) && (t->child[0]->expType != 2) ) {
	  printf("ERROR(%d): Unary '%s' requires an operand of type bool but was given type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType));
	  ++numError;
	  t->child[0]->expType = Boolean; 
	}

	if ( (t->child[0]) && (!t->child[1]) && (t->child[0]->isConstant == true) )
	  t->isConstant = true;

	if ( (t->child[0] != NULL) && (t->child[0]->isArray == true) ) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	  t->child[0]->expType = Boolean; 
	}
	t->expType = Boolean; 
      }

      if ( (t->attr.op == '+') || (t->attr.op == '-') ) {
	if ( (((t->child[0] != NULL) && (t->child[0]->isArray == 1)) && (t->child[1] == NULL)) || 
	     (((t->child[1] != NULL) && (t->child[1]->isArray == 1)) && (t->child[0] == NULL)) ) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
      }
   
      if ( ((t->child[0] != NULL) && (t->child[1] != NULL)) && 
	   ((t->child[0]->isConstant == true) && (t->child[1]->isConstant == true)) ) 
	t->isConstant = true;
      //else 
      //t->isConstant = false;
    
      if ( ((t->child[0] != NULL) && (t->child[1] != NULL)) && 
	   ((t->child[0]->expType != Integer) || (t->child[1]->expType != Integer)) ) {  
	if ( (t->attr.op == '<') || (t->attr.op == '>') || (t->attr.op == AND) || (t->attr.op == OR) 
	     || (t->attr.op == EQ) || (t->attr.op == NEQ) || (t->attr.op == LEQ) || (t->attr.op == GEQ) )
	  t->expType = Boolean;   
	else   
	  t->expType = Integer;   
      }

      //if (t->sibling != NULL)
      if ( (t->sibling != NULL) && (callcnt == 0))
	insertCheckNode(t->sibling);
      break;  // OpK
    }
    break;  // exp
  }
}


static void printSpaces(int indent){
  for ( int i = 0; i < indent; i++){
    printf("|  ");
  }
}

void printNode( TreeNode * tree) {
  if (tree->nodekind == DeclK) {
    switch(tree->kind.decl){
      case VarK:
	printf("Var %s ", tree->string);
	switch (tree->isArray){
	case true:
	  printf(" is array of type %s allocated as %s of size %d at location %d. foffset: %d; goffset: %d \n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc, foffset, goffset);
	  break;
	default:
	  printf(" of type %s allocated as %s of size %d at location %d. foffset: %d; goffset: %d \n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc, foffset, goffset);
	  break;
	}
	break;
      case FuncK:
	printf("Func %s returns type %s allocated as %s of size %d at location %d.\n", 
	       tree->string, getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	break;
      case ParamK:
	printf("Param %s ", tree->string);
	switch (tree->isArray){
	case true:
	  printf(" is array of type %s allocated as %s of size %d at location %d.\n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	  break;
	default:
	  printf(" of type %s allocated as %s of size %d at location %d.\n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	  break;
	}
	break;
      default: 
	printf("Unknown DeclNode kind. ");
	break;
      }
  }
}

void printTree( TreeNode * tree, int depth, unsigned int sepbits){
  int counter = 0; 
  while (tree != NULL){
    INDENT;
    printSpaces(depth);
    if (tree->nodekind == DeclK){  
      switch(tree->kind.decl){
      case VarK:
	printf("Var %s ", tree->string);
	switch (tree->isArray){
	case true:
	  //printf(" is array of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" is array of type %s allocated as %s of size %d at location %d. foffset: %d; goffset: %d \n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc, foffset, goffset);
	  break;
	default:
	  //printf(" of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" of type %s allocated as %s of size %d at location %d. foffset: %d; goffset: %d \n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc, foffset, goffset);
	  break;
	}
	break;
      case FuncK:
	//printf("Func %s returns type %s [line: %d]\n", tree->string, getType(tree->expType), tree->linnum);
	printf("Func %s returns type %s allocated as %s of size %d at location %d.\n", 
	       tree->string, getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	break;

      case ParamK:
	printf("Param %s ", tree->string);
	switch (tree->isArray){
	case true:
	  //printf(" is array of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" is array of type %s allocated as %s of size %d at location %d.\n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	  break;
	default:
	  //printf(" of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" of type %s allocated as %s of size %d at location %d.\n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	  break;
	}
	break;
      default: 
	printf("Unknown DeclNode kind. ");
	break;
      }
    } else if (tree->nodekind == StmtK){    
      switch (tree->kind.stmt){
      case IfK:
	printf("If [line: %d]\n", tree->linnum);
        break;
      case WhileK:
	printf("While [line: %d]\n", tree->linnum);
        break;
      case ForEachK:
	printf("Foreach [line: %d]\n", tree->linnum);
	break;
      case CompoundK:
	printf("Compound [line: %d]\n", tree->linnum);
	break;
      case ReturnK:
	printf("Return [line: %d]\n", tree->linnum);
	break;
      case BreakK:
	printf("Break [line: %d]\n", tree->linnum);
	break;
      default:
	printf("Unknown DeclNode kind. ");
        break;
      }
    } else if (tree->nodekind == ExpK){   
      switch (tree->kind.exp){
      case OpK:
	printf("Op: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      case ConstantK:
	printf("Const: ");
	switch ( tree->expType ){
	case Integer:
	  printf("%d [line: %d]\n", tree->attr.val, tree->linnum);
	  break;
	case Boolean:
	  printf("%s [line: %d]\n", tree->string, tree->linnum);
	  break;
	case Character:
	  printf("%s [line: %d]\n", tree->string, tree->linnum);
	  break;
	}
        break;
      case IdK:
	//printf("Id: %s [line: %d]\n", tree->string, tree->linnum);
	printf("Id: %s [line: %d] of type %s allocated as %s of size %d at location %d.\n", 
	       tree->string, tree->linnum, getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
        break;
      case AssignK:
	printf("Assign: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      case CallK:
	printf("Call: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      default:
	printf("Unknown ExpNode kind: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      }
    } else
      printf("Unknown DeclNode kind. ");

    int childcnt = 0;
    for (int i = 0; i < MAXCHILDREN; i++){
      if (tree->child[i] == NULL) 
	continue;
      else {
	printSpaces(depth);
	printf("Child: %d\n", i+1);
	childcnt++;
	depth++;
	printTree(tree->child[i], depth, depth);
	depth--;
      } 
    } 

    tree = tree->sibling; 
    if (tree != NULL){
      counter++;
      if ( counter > 0 && depth ){
	printSpaces(depth-1);
	printf("Sibling: %d\n", counter);
      }
    }
  }
  UNINDENT;
}


/*
void printTree( TreeNode * tree, int depth, unsigned int sepbits){
  int counter = 0; 
  while (tree != NULL){
    INDENT;
    printSpaces(depth);
    if (tree->nodekind == DeclK){  
      switch(tree->kind.decl){
      case VarK:
	printf("Var %s ", tree->string);
	switch (tree->isArray){
	case true:
	  //printf(" is array of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" is array of type %s allocated as %s of size %d at location %d. foffset: %d; goffset: %d \n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc, foffset, goffset);
	  break;
	default:
	  //printf(" of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" of type %s allocated as %s of size %d at location %d. foffset: %d; goffset: %d \n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc, foffset, goffset);
	  break;
	}
	break;
      case FuncK:
	//printf("Func %s returns type %s [line: %d]\n", tree->string, getType(tree->expType), tree->linnum);
	printf("Func %s returns type %s allocated as %s of size %d at location %d.\n", 
	       tree->string, getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	break;

      case ParamK:
	printf("Param %s ", tree->string);
	switch (tree->isArray){
	case true:
	  //printf(" is array of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" is array of type %s allocated as %s of size %d at location %d.\n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	  break;
	default:
	  //printf(" of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" of type %s allocated as %s of size %d at location %d.\n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	  break;
	}
	break;
      default: 
	printf("Unknown DeclNode kind. ");
	break;
      }
    } else if (tree->nodekind == StmtK){    
      switch (tree->kind.stmt){
      case IfK:
	printf("If [line: %d]\n", tree->linnum);
        break;
      case WhileK:
	printf("While [line: %d]\n", tree->linnum);
        break;
      case ForEachK:
	printf("Foreach [line: %d]\n", tree->linnum);
	break;
      case CompoundK:
	printf("Compound [line: %d]\n", tree->linnum);
	break;
      case ReturnK:
	printf("Return [line: %d]\n", tree->linnum);
	break;
      case BreakK:
	printf("Break [line: %d]\n", tree->linnum);
	break;
      default:
	printf("Unknown DeclNode kind. ");
        break;
      }
    } else if (tree->nodekind == ExpK){   
      switch (tree->kind.exp){
      case OpK:
	printf("Op: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      case ConstantK:
	printf("Const: ");
	switch ( tree->expType ){
	case Integer:
	  printf("%d [line: %d]\n", tree->attr.val, tree->linnum);
	  break;
	case Boolean:
	  printf("%s [line: %d]\n", tree->string, tree->linnum);
	  break;
	case Character:
	  printf("%s [line: %d]\n", tree->string, tree->linnum);
	  break;
	}
        break;
      case IdK:
	printf("Id: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      case AssignK:
	printf("Assign: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      case CallK:
	printf("Call: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      default:
	printf("Unknown ExpNode kind: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      }
    } else
      printf("Unknown DeclNode kind. ");

    int childcnt = 0;
    for (int i = 0; i < MAXCHILDREN; i++){
      if (tree->child[i] == NULL) 
	continue;
      else {
	printSpaces(depth);
	printf("Child: %d\n", i+1);
	childcnt++;
	depth++;
	printTree(tree->child[i], depth, depth);
	depth--;
      } 
    } 

    tree = tree->sibling; 
    if (tree != NULL){
      counter++;
      if ( counter > 0 && depth ){
	printSpaces(depth-1);
	printf("Sibling: %d\n", counter);
      }
    }
  }
  UNINDENT;
}
*/

char* getTypeAlloc(int x){
  char* typeall;
  switch (x){
  case 0: 
    typeall = (char*)"Local";
    break;
  case 1:
    typeall = (char*)"Global";
    break;
  case 2:
    typeall = (char*)"Parameter";
    break;
  case 3:
    typeall = (char*)"LocalStatic";
    break;
  }
  return typeall;
}

char* getType(int x){
  char* typeString;
  switch (x){
  case 0: 
    typeString = (char*)"void";
    break;
  case 1:
    typeString = (char*)"int";
    break;
  case 2:
    typeString = (char*)"bool";
    break;
  case 3:
    typeString = (char*)"char";
    break;
  }
  return typeString;
}

TreeNode * newStmtNode( StmtKind kind){
  TreeNode * t = (TreeNode*) malloc(sizeof(TreeNode));
  int i; 
  if (t==NULL)
    printf("Out of memory error at line %d\n", linnum);
  else {
    for (i = 0; i < MAXCHILDREN; i++)
      t->child[i] = NULL; 
    t->sibling = NULL;
    t->nodekind = StmtK;
    t->kind.stmt = kind;   
    t->linnum = linnum;
    t->isArray = false;
    t->isConstant = false;
    t->isStatic = false;
  }
  return t;
}

TreeNode * newDeclNode(DeclKind kind){
  TreeNode * t = (TreeNode*) malloc(sizeof(TreeNode));
  int i; 
  if (t==NULL)
    printf("Out of memory error at line %d\n", linnum);
  else {
    for (i = 0; i < MAXCHILDREN; i++)
      t->child[i] = NULL; 
    t->sibling = NULL;
    t->nodekind = DeclK;
    t->kind.decl = kind;   
    t->linnum = linnum;
    t->isArray = false;
    t->isConstant = false;
    t->isStatic = false;
  }
  return t;
}

TreeNode * newExpNode( ExpKind kind){
  TreeNode * t = (TreeNode*) malloc(sizeof(TreeNode));
  int i; 
  if (t==NULL)
    printf("Out of memory error at line %d\n", linnum);
  else {
    for (i = 0; i < MAXCHILDREN; i++)
      t->child[i] = NULL; 
    t->sibling = NULL;
    t->nodekind = ExpK;
    t->kind.exp = kind; 
    t->linnum = linnum;
    t->expType = Void;        // added type here compared with newStmtNode
    t->isArray = false;
    t->isConstant = false;
    t->isStatic = false;
  }
  return t;
}

// allocates and makes a new copy of an existing string
char * copyString( char * s){
  int n; 
  if (s==NULL) return NULL;
  n = strlen(s) + 1;
  char * t = (char*)malloc(n);
  if (t==NULL)
    printf("Out of memory error at line %d\n", linnum);
  else strcpy(t, s);
  return t;
}

void yyerror(const char* s){
  fprintf(stderr, "%s in line %d in token %s\n", s, linnum, yytext);
  //printf("ERROR linnum(%d):%s. I got: %s\n", linnum, s, yytext);
  exit(-1);
}

/*
static void traverse( TreeNode * t, void (* preProc) (TreeNode *), void (* postProc) (TreeNode *) ) {
  if (t != NULL) {
    preProc(t);   
    { 
      int i;   
      for (i=0; i < MAXCHILDREN; i++) 
	traverse(t->child[i],preProc,postProc);   
    }   
    postProc(t);   
    traverse(t->sibling,preProc,postProc);   
  }   
}   
*/
