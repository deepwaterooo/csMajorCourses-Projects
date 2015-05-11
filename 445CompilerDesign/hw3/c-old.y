%{
#include <iostream>
#include <cstring>
#include <cctype>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
  //#include "globals.h"
#include "scanType.h"  
#include "c-.tab.h"
#include "symtab.h"  // the Symbol Table Module
//#include "analyze.h"

extern int yylex();
extern int yyparse();
extern FILE * yyin;
char *yyfilename;
extern char *yytext;
extern int linnum;
extern char tokenString[];

#define MAXCHILDREN 3
typedef int TokenType;
typedef enum {DeclK, StmtK, ExpK} NodeKind; 
typedef enum {VarK, FuncK, ParamK} DeclKind;
typedef enum {IfK, WhileK, ForEachK, CompoundK, ReturnK, BreakK} StmtKind;
typedef enum {OpK, ConstantK, IdK, AssignK, CallK} ExpKind;
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
    char *string;                      // used when a string constant
  } attr;                                 
  ExpType expType;                     // used when ExpK for type checking
  bool isStatic;                       // is staticly allocated?
  bool isArray;                        // is this an array
  bool isConstant;                     // can this expression be precomputed?
} TreeNode;

static TreeNode* savedTree; // stores syntax tree for later return

using namespace std;
#define YY_DECL extern "C" int yylex()
#define YYDEBUG 1
//#define YYERROR_VERBOSE
TreeNode * newStmtNode( StmtKind );
TreeNode * newDeclNode(DeclKind kind);
TreeNode * newExpNode( ExpKind );
//void printTree( TreeNode * );
//void printTree(FILE *, TreeNode *); 
//void FreeTree(Node *p);
static TokenData token; /* holds current token */
void yyerror(const char* s);
string getType(int x);
char * copyString( char * s);
// indentno is used by printTree to store current number of spaces to store current number of spaces to indent
static int indentno = 0;
// macros to increase/decrease indentation
#define INDENT indentno += 3
#define UNINDENT indentno -= 3

// Function buildSymtab constructs the symbol table by preorder traversal of the syntax tree 
void buildSymtab(TreeNode * syntaxTree); 
// Procedure typeCheck performs type checking by a postorder syntax tree traversal 
void typeCheck(TreeNode * syntaxTree);
static void traverse( TreeNode * t, void (* preProc) (TreeNode *), void (* postProc) (TreeNode *) );
static void nullProc(TreeNode * t);
static void insertNode( TreeNode * t);
static void typeError(TreeNode * t, char * message);
static void checkNode(TreeNode * t);

%}

%union {
  ExpType type;    
  int number;
  TokenData * tokenData;
  struct treeNode * nodeptr;
}
%token <tokenData> ID CHARCONST NUMCONST STRINGCONST
%token <tokenData> IF ELSE WHILE FOREACH IN
%token <tokenData> STATIC INT BOOL CHAR   
%token <tokenData> TRUE FALSE RETURN BREAK 
%token <tokenData> comma semicolon colon
%token <tokenData> leftp2 leftp leftp3 rightp2 rightp rightp3
%token <tokenData> AND OR NOT INC DEC LEQ MASSIGN PASSIGN NEQ GEQ lt equal gt multiply mod divide minus EQ // plus EQ
%token <tokenData> '+' 
%type <type> scoped_type_specifier type_specifier //type_specifier_func
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
declaration : var_declaration { $$ = $1; }
            | fun_declaration { $$ = $1; }
            ;

var_declaration : type_specifier var_decl_list semicolon 
                {
		  // attach type in $1 to everybody in list $2
		  // $1 is of type TokenData*
		  // tagTypeInList($1, $2);
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
scoped_var_declaration : scoped_type_specifier var_decl_list semicolon 
                       { 
			 // attach type and scope in $1 to everybody in list $2  
			 TreeNode* t = $2;
			 if (t != NULL){
			   t->expType = $1;
			   t->isStatic = true;
			   while (t->sibling != NULL) {
			     t = t->sibling;
			     t->expType = $1;
			     t->isStatic = true;
			   }
			 }
			 $$ = $2;
		       }
                       ;
var_decl_list : var_decl_list comma var_decl_initialize 
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
		      $$->attr.string = $1->tokenstr;
		    }
                    | ID leftp3 NUMCONST rightp3 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->attr.string = $1->tokenstr;
		      $$->isArray = true;
		    }
                    | ID colon simple_expression 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->attr.string = $1->tokenstr;
		      $$->child[0] = $3;
		    }
                    | ID leftp3 NUMCONST rightp3 colon simple_expression 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->attr.string = $1->tokenstr;
		      $$->child[0] = $6;
		      $$->isArray = true;
		    }
                    ;
scoped_type_specifier : STATIC type_specifier { $$ = $2; }
                      | type_specifier { $$ = $1; }
                      ;
type_specifier : INT  { $$ = Integer; }
               | BOOL { $$ = Boolean; }
               | CHAR { $$ = Character; }
               ;

fun_declaration : type_specifier ID leftp params rightp statement 
                {
		  TreeNode* t = newDeclNode(FuncK); 
		  t->attr.string = $2->tokenstr;
		  t->linnum = $2->linnum;
		  t->expType = $1;
		  $$ = t;
		  $$->child[0] = $4;
		  $$->child[1] = $6;
		}
                | ID leftp params rightp statement 
		{
		  TreeNode* t = newDeclNode(FuncK);
		  t->attr.string = $1->tokenstr;
		  t->linnum = $1->linnum;
		  $$ = t;
		  $$->child[0] = $3;
		  $$->child[1] = $5;
		}
		;
params : param_list { $$ = $1; }
       | /* empty*/ { $$ = NULL; }
       ;

param_list : param_list semicolon type_specifier param_id_list 
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
param_id_list : param_id_list comma param_id 
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
	   $$->attr.string = $1->tokenstr;
	 }
	 | ID leftp3 rightp3 
         {
	   $$ = newDeclNode(ParamK);
	   $$->linnum = $1->linnum;
	   $$->attr.string = $1->tokenstr;
	   $$->isArray = true;
	 }
	 ;

statement : ifmatched { $$ = $1; }
          | ifunmatched { $$ = $1; }
          ;
ifmatched : IF leftp simple_expression rightp ifmatched ELSE ifmatched 
          { 
	    $$ = newStmtNode(IfK);
	    $$->linnum = $1->linnum;
	    $$->child[0] = $3;
	    $$->child[1] = $5;
	    $$->child[2] = $7;
	  }
          | WHILE leftp simple_expression rightp ifmatched
          { 
	    $$ = newStmtNode(WhileK);
	    $$->linnum = $1->linnum;
	    $$->child[0] = $3;
	    $$->child[1] = $5;
	  }
          | FOREACH leftp mutable IN simple_expression rightp ifmatched 
          { 
	    $$ = newStmtNode(ForEachK);
	    $$->linnum = $1->linnum;
	    $$->child[0] = $3;
	    $$->child[1] = $5;
	    $$->child[2] = $7;
	  }
          | expression_stmt { $$ = $1; }
    	  ;
ifunmatched : IF leftp simple_expression rightp ifmatched ELSE ifunmatched
            { 
	      $$ = newStmtNode(IfK);
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	      $$->child[2] = $7;
	    }
            | IF leftp simple_expression rightp statement
            { 
	      $$ = newStmtNode(IfK);
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	    }
            | WHILE leftp simple_expression rightp ifunmatched
            { 
	      $$ = newStmtNode(WhileK);
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	    }
            | FOREACH leftp mutable IN simple_expression rightp ifunmatched 
            { 
	      $$ = newStmtNode(ForEachK);
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	      $$->child[2] = $7;
	    }
            ;

expression_stmt: compound_stmt { $$ = $1; }
          | RETURN semicolon 
          {
	    $$ = newStmtNode(ReturnK);
	  }
          | RETURN expression semicolon  
          {
	    $$ = newStmtNode(ReturnK);
	    $$->child[0] = $2;
	  }
          | BREAK semicolon  
          {
	    $$ = newStmtNode(BreakK);
	  }
          ;
compound_stmt : leftp2 local_declarations statement_list rightp2 
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
expression_stmt : expression semicolon { $$ = $1; }
                | semicolon { $$ = NULL; }
                ;
expression : mutable equal expression // this grammar may have problems
           {
	     $$ = newExpNode(AssignK); 
	     $$->attr.string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->child[0] = $1;
	     $$->child[1] = $3;
	   }
           | mutable PASSIGN expression 
           {
	     $$ = newExpNode(AssignK);
	     $$->attr.string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->child[0] = $1;
	     $$->child[1] = $3;
	   }
           | mutable MASSIGN expression 
           {
	     $$ = newExpNode(AssignK);
	     $$->attr.string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->child[0] = $1;
	     $$->child[1] = $3;
	   }
           | mutable INC
           {
	     $$ = newExpNode(AssignK);
	     $$->attr.string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->child[0] = $1;
	   }
           | mutable DEC
           {
	     $$ = newExpNode(AssignK);
	     $$->attr.string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->child[0] = $1;
	   }
           | simple_expression { $$ = $1; }
           ;
simple_expression : simple_expression OR and_expression  
                  {
		    $$ = newExpNode(OpK); 
		    $$->attr.string = $2->tokenstr;
		    $$->linnum = $2->linnum; 
		    $$->child[0] = $1;
		    $$->child[1] = $3;
		  }
                  | and_expression { $$ = $1; }
                  ;
and_expression : and_expression AND unary_rel_expression  
               {
		 $$ = newExpNode(OpK); 
		 $$->attr.string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | unary_rel_expression { $$ = $1; }
               ;
unary_rel_expression : NOT unary_rel_expression
                     { 
		       $$ = newExpNode(OpK);
		       $$->attr.string = $1->tokenstr;
		       $$->linnum = $1->linnum; 
		       $$->child[0] = $2;
		     }
                     | rel_expression { $$ = $1; }
                     ;
rel_expression : sum_expression lt sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->attr.string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression gt sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->attr.string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression LEQ sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->attr.string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression GEQ sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->attr.string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression EQ sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->attr.string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression NEQ sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->attr.string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression { $$ = $1; }
               ;
sum_expression : sum_expression '+' term  
               {
		 $$ = newExpNode(OpK);
		 $$->attr.string = $2->tokenstr;
		 $$->linnum = $2->linnum;
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression minus term  
               {
		 $$ = newExpNode(OpK);
		 $$->attr.string = $2->tokenstr;
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
mulop : multiply 
      { 
	$$ = newExpNode(OpK); 
	$$->attr.string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      | divide
      { 
	$$ = newExpNode(OpK); 
	$$->attr.string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      | mod
      { 
	$$ = newExpNode(OpK); 
	$$->attr.string = $1->tokenstr;
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
unaryop : minus 
        { 
	  $$ = newExpNode(OpK); 
	  $$->attr.string = $1->tokenstr;
	  $$->linnum = $1->linnum; 
	}
        | multiply 
        { 
	  $$ = newExpNode(OpK); 
	  $$->attr.string = $1->tokenstr;
	  $$->linnum = $1->linnum; 
	}
        ;
factor : immutable { $$ = $1; }
       | mutable { $$ = $1; }
       ;
mutable : ID 
        {
	  $$ = newExpNode(IdK);
	  $$->attr.name = $1->tokenstr;
	  $$->linnum = $1->linnum;
	}
        | ID leftp3 expression rightp3 
        {
	  $$ = newExpNode(IdK);
	  $$->attr.name = $1->tokenstr;
	  $$->linnum = $1->linnum;
	  $$->isArray = true;
	  $$->child[0] = $3;
	}
        ;
immutable : leftp expression rightp { $$ = $2; }
          | call  { $$ = $1; }
          | NUMCONST
	  {
	    $$ = newExpNode(ConstantK);
	    $$->attr.val = $1->iValue;
	    $$->linnum = $1->linnum; 
	    $$->expType = Integer;
	    $$->isConstant = true;
	  }
          | CHARCONST
	  {
	    $$ = newExpNode(ConstantK);
	    $$->linnum = $1->linnum; 
	    $$->attr.string = $1->tokenstr;
	    $$->expType = Character;
	    $$->isConstant = true;
	  }
          | STRINGCONST
	  {
	    $$ = newExpNode(ConstantK);
	    $$->attr.string = $1->tokenstr;
	    $$->linnum = $1->linnum; 
	    $$->expType = Character;
	    $$->isConstant = true;
	  }
          | TRUE  
	  {
	    $$ = newExpNode(ConstantK);
	    $$->attr.string = $1->tokenstr;
	    $$->linnum = $1->linnum; 
	    $$->expType = Boolean;
	    $$->isConstant = true;
	  }
          | FALSE
	  {
	    $$ = newExpNode(ConstantK);
	    $$->attr.string = $1->tokenstr;
	    $$->linnum = $1->linnum;
	    $$->expType = Boolean;
	    $$->isConstant = true;
	  }
          ;
call : ID leftp args rightp 
     {
       $$ = newExpNode(CallK);
       $$->attr.string = $1->tokenstr;
       $$->linnum = $1->linnum;
       $$->child[0] = $3;
     }
     ;
args : arg_list { $$ = $1; }
     | { $$ = NULL; }
     ;
arg_list : expression comma arg_list   
         {
	   /*TreeNode* t = $3;
	   if (t != NULL){
	     while (t->sibling != NULL) t = t->sibling;
	     t->sibling = $1;
	     $$ = $3;
	   } else
	   $$ = $1; */
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
static void printSpaces(void){
  for ( int i = 0; i < indentno; i++){
    cout << "|  ";
  }
}
void printTree( TreeNode * tree){
  int i; 
  int counter = 1; 

  while (tree != NULL){
    INDENT;
    //printSpaces();
    if (tree->nodekind == DeclK){  
      switch(tree->kind.decl){
      case VarK:
	cout << "Var " << tree->attr.string ;
	switch (tree->isArray){
	case true:
	  cout << " is array of type " << getType(tree->expType) << " [line: " << tree->linnum << "]" << endl;
	  break;
	default:
	  cout << " of type " << getType(tree->expType) << " [line: " << tree->linnum << "]" << endl;
	  break;
	}
	break;
      case FuncK:
	cout << "Func " << tree->attr.string << " returns type " << getType(tree->expType) << " [line: " << tree->linnum << "]" << endl;
	break;
      case ParamK:
	cout << "Param " << tree->attr.string ;
	switch (tree->isArray){
	case true:
	  cout << " is array of type " << getType(tree->expType) << " [line: " << tree->linnum << "]" << endl;
	  break;
	default:
	  cout << " of type " << getType(tree->expType) << " [line: " << tree->linnum << "]" << endl;
	  break;
	}
	break;
      default: 
	cout << "Unknown DeclNode kind. " << endl;
	break;
      }
    } else if (tree->nodekind == StmtK){    
      switch (tree->kind.stmt){
      case IfK:
	cout << "If [line: " << tree->linnum << "]" << endl;
        break;
      case WhileK:
	cout << "While [line: " << tree->linnum << "]" << endl;
        break;
      case ForEachK:
	cout << "Foreach [line: " << tree->linnum << "]" << endl;
	break;
      case CompoundK:
	cout << "Compound [line: " << tree->linnum << "]" << endl;
	break;
      case ReturnK:
	cout << "Return [line: " << tree->linnum << "]" << endl;
	break;
      case BreakK:
	cout << "Break [line: " << tree->linnum << "]" << endl;
	break;
      default:
        cout << "Unknown ExpNode kind" << endl;
        break;
      }
    } else if (tree->nodekind == ExpK){   
      switch (tree->kind.exp){
      case OpK:
        cout << "Op: ";
	cout << tree->attr.string << " [line: " << tree->linnum << "]" << endl;
        break;
      case ConstantK:
        cout << "Const: " ;
	switch ( tree->expType ){
	case Integer:
	  cout << tree->attr.val << " [line: " << tree->linnum << "]" << endl;	  
	  break;
	case Boolean:
	  cout << tree->attr.string << " [line: " << tree->linnum << "]" << endl;	  
	  break;
	case Character:
	  cout << tree->attr.string << " [line: " << tree->linnum << "]" << endl;	  
	  break;
	}
        break;
      case IdK:
        cout << "Id: " << tree->attr.name << " [line: " << tree->linnum << "]" << endl;
        break;
      case AssignK:
        cout << "Assign: " << tree->attr.string << " [line: " << tree->linnum << "]" << endl;
        break;
      case CallK:
        cout << "Call: " << tree->attr.string << " [line: " << tree->linnum << "]" << endl;
        break;
      default:
        cout << "Unknown ExpNode kind: " << tree->attr.op << " [line: " << tree->linnum << "]" << endl;
        break;
      }
    } else cout << "Unknown node kind" << endl;

    int childcnt = 0;
    for (int i = 0; i < MAXCHILDREN; i++){
      if (tree->child[i] == NULL) 
	continue;
      else {
	cout << "Child: " << childcnt+1 << endl;
	childcnt++;
	printTree(tree->child[i]);
      } 
    } 

    if ( (tree->nodekind == DeclK) && (tree->kind.decl == FuncK) )
      counter = 0;
    tree = tree->sibling; 
    if (tree != NULL){
      if ( counter >= 1 ){
	cout << "Sibling: " << counter << endl;
      }
      counter++;
    }
  }
  UNINDENT;
}

void nodePrint(void * p){
  //  TreeNode * t = (TreeNode*)p;
}

SymTab * st = new SymTab(nodePrint);

main(int argc, char* argv[]){
    int d_flag = 0;
    int s_flag = 0;
    char *d_value = NULL;
    int c;

    int numError; 
    int numWarnings;

    if (argc == 1) 
        yyin = stdin;
    else if (argc == 2) {
        yyin = fopen(argv[1], "r");
    } else if (argc > 2) {  
        while ((c = getopt (argc, argv, "ps")) != -1)
            switch (c) {      
            case 'p':
                d_flag = 1;
                break;
	    case 's':
                s_flag = 1;
                break;
            default:
                abort ();
            }
        if (d_flag == 1)
	  yydebug = 1;
	if (s_flag == 1)
	  st->debug(0x2); 

        yyin = fopen(argv[2], "r");
    } else {
        printf("Usage: ./c- TestFileName\nUsage: ./c- < TestFileName\nUsage: cat TestFileName | ./c-\n");
        exit(-1);
    }

    if (yyin == NULL){
        printf("Can't open/read '%s'\n", argv[2]);
        exit(-1);
    }
    yyfilename = argv[1];
    linnum = 1;
    do {
        yyparse();
    }   while ( !feof(yyin)) ;
    printTree(savedTree);

    //    if (printSyntaxTree) printTree(syntaxTree);
    //if (1) printTree(savedTree);
    if (numError == 0) typeCheck(savedTree);

    // report the number of errors and warnings
    cout << "Number of errors: " << numError << endl;
    cout << "Number of warnings: " << numWarnings << endl;

    if (argc != 1)
        fclose(yyin);
}

// Procedure insertNode inserts identifiers stored in t into the symbol table   
static void insertNode( TreeNode * t)  {
  switch (t->nodekind) {

  case DeclK:
    switch(t->kind.decl){
    case VarK:
      if (st->lookup(t->attr.string) == NULL)   
	st->insert(t->attr.string, (void*)t );   
      else 
	//            st->insert(t->attr.name,t->lineno,0);   
	break;
    case FuncK:
      if (st->lookup(t->attr.string) == NULL)   
	st->insert(t->attr.string, (void*)t );   
      else 
	//            st->insert(t->attr.name,t->lineno,0);   
	break;
    case ParamK:
      if (st->lookup(t->attr.string) == NULL)   
	st->insert(t->attr.string, (void*)t );   
      else 
	//            st->insert(t->attr.name,t->lineno,0);   
	break;
    }

    case StmtK:   
      switch (t->kind.stmt){
      case IfK:
	if (st->lookup(t->attr.name) == NULL)   
	  st->insert(t->attr.name, (void*)t );   
	else
	  //            st->insert(t->attr.name,t->lineno,0);   
	  break;
      case WhileK:
	if (st->lookup(t->attr.string) == NULL)   
	  st->insert(t->attr.string, (void*)t );   
	else
	  //            st->insert(t->attr.name,t->lineno,0);   
	  break;
      case ForEachK:
	if (st->lookup(t->attr.string) == NULL)   
	  st->insert(t->attr.string, (void*)t );   
	else // error?
	  //            st->insert(t->attr.name,t->lineno,0);   
	  break;
      case CompoundK:
	if (st->lookup(t->attr.string) == NULL)   
	  st->insert(t->attr.string, (void*)t );   
	else
	  //            st->insert(t->attr.name,t->lineno,0);   
	  break;
      case ReturnK:
	if (st->lookup(t->attr.string) == NULL)   
	  st->insert(t->attr.string, (void*)t );   
	else
	  //            st->insert(t->attr.name,t->lineno,0);   
	  break;
      case BreakK:
	if (st->lookup(t->attr.string) == NULL)   
	  st->insert(t->attr.string, (void*)t );   
	else
	  //            st->insert(t->attr.name,t->lineno,0);   
	  break;
      }

    case ExpK:   
      switch (t->kind.exp){
      case OpK:
	if (st->lookup(t->attr.string) == NULL)   
	  st->insert(t->attr.string, (void*)t );   
	else
	  //            st->insert(t->attr.name,t->lineno,0);   
	  break;
      case ConstantK:
	switch ( t->expType ){
	case Integer:
	  if (st->lookup(t->attr.string) == NULL)   
	    st->insert(t->attr.string, (void*)t );   
	  else
	    //            st->insert(t->attr.name,t->lineno,0);   
	    break;
	case Boolean:
	  if (st->lookup(t->attr.string) == NULL)   
	    st->insert(t->attr.string, (void*)t );   
	  else
	    //            st->insert(t->attr.name,t->lineno,0);   
	    break;
	case Character:
	  if (st->lookup(t->attr.string) == NULL)   
	    st->insert(t->attr.string, (void*)t );   
	  else
	    //            st->insert(t->attr.name,t->lineno,0);   
	    break;
	}
        break;
      case IdK:
	if (st->lookup(t->attr.string) == NULL)   
	  st->insert(t->attr.string, (void*)t );   
	else 
	  //            st->insert(t->attr.name,t->lineno,0);   
	  break;
      case AssignK:
	if (st->lookup(t->attr.string) == NULL)   
	  st->insert(t->attr.string, (void*)t );   
	else 
	  //            st->insert(t->attr.name,t->lineno,0);   
	  break;
      case CallK:
	if (st->lookup(t->attr.string) == NULL)   
	  st->insert(t->attr.string, (void*)t );   
	else 
	  //            st->insert(t->attr.name,t->lineno,0);   
	  break;
      default:
        break;
      }   
  }
}   

// Procedure checkNode performs type checking at a single tree node  
static void checkNode(TreeNode * t) {
  switch (t->nodekind) {

  case DeclK:   
    if (st->lookup(t->attr.string) == NULL)
      cout << "ERROR(" << t->linnum << "): Symbol " << t->attr.string << " is not defined." << endl;
    if (st->lookup(t->attr.string) != NULL)
      cout << "ERROR(" << t->linnum << "): Symbol " << t->attr.string << " is already defined in line " << t->linnum << "." << endl;
    break;   

  case ExpK:   
    switch (t->kind.exp) {
    case OpK:   
      if ((t->attr.string == '+') || (t->attr.string == '-')) {
	if (t->child[0]->expType != Integer) 
	  cout << "ERROR(" << t->linnum << "): Symbol " << t->attr.string << " requires operands of " << getType(1) << "but lrs is of " << getType(t->child[0]->expType) << "." << endl;
	else if (t->child[1]->expType != Integer) 
	  cout << "ERROR(" << t->linnum << "): Symbol " << t->attr.string << " requires operands of " << getType(1) << "but lrs is of " << getType(t->child[1]->expType) << "." << endl;
	  } else if ( (((t->attr.string == "==") || (t->attr.string == "!="))) && (t->child[0]->expType != t->child[1]->expType) )
	cout << "ERROR(" << t->linnum << "): Symbol " << t->attr.string << " requires operands of the same type but lhs is " << getType(t->child[0]->expType) << " and rhs is " << getType(t->child[1]->expType) << "." << endl;
      else if ( (t->attr.string == '>') || (t->attr.string == '<') || (t->attr.string == ">=") || (t->attr.string == "<=") ) {       
	if (t->child[0]->expType != Integer) 
	  cout << "ERROR(" << t->linnum << "): Symbol " << t->attr.string << " requires operands of " << getType(1) << "but lrs is of " << getType(t->child[0]->expType) << "." << endl;
	else if (t->child[1]->expType != Integer) 
	  cout << "ERROR(" << t->linnum << "): Symbol " << t->attr.string << " requires operands of " << getType(1) << "but lrs is of " << getType(t->child[1]->expType) << "." << endl;
	  }

      if ((t->child[0]->expType != Integer) || (t->child[1]->expType != Integer))   
	//typeError(t,"Op applied to non-integer");   
      if ((t->attr.op == EQ) || (t->attr.op == lt))   
	t->expType = Boolean;   
      else   
	t->expType = Integer;   
      break;   
    case ConstantK:   
    case IdK:   
      t->expType = Integer;   
      break;   
    default:   
      break;   
    }   
    break;   

  case StmtK:   
    switch (t->kind.stmt)   
      { case IfK:   
          if (t->child[0]->expType == Integer)   
            //typeError(t->child[0],"if test is not Boolean");   
          break;   
      case AssignK:   
	if (t->child[0]->expType != Integer)   
	  //typeError(t->child[0],"assignment of non-integer value");   
	break;   
      case ReturnK:   
	if (t->child[1]->expType == Integer)   
	  //typeError(t->child[1],"repeat test is not Boolean");   
	break;   
      default:   
	break;   
      }   
    break;   
  default:   
    break;   
  }   
}   

// Procedure traverse is a generic recursive syntax tree traversal routine:  
// it applies preProc in preorder and postProc in postorder to tree pointed to by t  
static void traverse( TreeNode * t, void (* preProc) (TreeNode *), void (* postProc) (TreeNode *) ) {
  if (t != NULL) {
     preProc(t);   
      { int i;   
	for (i=0; i < MAXCHILDREN; i++)   
	  traverse(t->child[i],preProc,postProc);   
      }   
      postProc(t);   
      traverse(t->sibling,preProc,postProc);   
    }   
}   
   
// nullProc is a do-nothing procedure to generate preorder-only or postorder-only traversals from traverse  
static void nullProc(TreeNode * t)   
{ if (t==NULL) return;   
  else return;   
}   
      
// Function buildSymtab constructs the symbol table by preorder traversal of the syntax tree  
void buildSymtab(TreeNode * syntaxTree)   
{ traverse(syntaxTree,insertNode,nullProc);   
  /*  if (TraceAnalyze) {
    fprintf(listing,"\nSymbol table:\n\n");   
    printSymTab(listing);   
    } */  
}   
   
// Procedure typeCheck performs type checking by a postorder syntax tree traversal  
void typeCheck(TreeNode * syntaxTree) { 
  traverse(syntaxTree,nullProc,checkNode);   
}   
/*
static void typeError(TreeNode * t, char * message)   
{ fprintf(listing,"Type error at line %d: %s\n",t->lineno,message);   
  Error = TRUE;   
  } */  
   



string getType(int x){
  string typeString;
  switch (x){
  case 0: 
    typeString = "void";
    break;
  case 1:
    typeString = "int";
    break;
  case 2:
    typeString = "bool";
    break;
  case 3:
    typeString = "char";
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


