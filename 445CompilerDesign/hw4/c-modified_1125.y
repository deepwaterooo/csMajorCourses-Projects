%{
#include <iostream>
#include <cstring>
#include <cctype>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
  //#include "c-.tab.h"
#include "symtab.h"
#include "scanType.h"  
#include "yyerror.h"

extern int yylex();
extern int yyparse();
extern FILE * yyin;
char *yyfilename;
extern char *yytext;
extern int linnum;
extern char tokenString[];
int numError; 
int numWarnings;

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
  } attr;                                 
  char* string;                        // used when a string constant
  ExpType expType;                     // used when ExpK for type checking
  bool isStatic;                       // is staticly allocated?
  bool isArray;                        // is this an array
  bool isConstant;                     // can this expression be precomputed?
} TreeNode;

static TreeNode* savedTree; // stores syntax tree for later return
using namespace std;
//#define YY_DECL extern "C" int yylex()
#define YYDEBUG 1
#define YYERROR_VERBOSE

TreeNode * newStmtNode( StmtKind );
TreeNode * newDeclNode(DeclKind kind);
TreeNode * newExpNode( ExpKind );
  //void FreeTree(Node *p);

static TokenData token; /* holds current token */
//void yyerror(const char* s);
char* getType(int x);
char * copyString( char * s);

static int indentno = 0;
#define INDENT indentno += 3
#define UNINDENT indentno -= 3
static void printSpaces(void);

void printTree( TreeNode * tree);
static void insertCheckNode( TreeNode * t);
TreeNode* siblingNode(TreeNode* t, ExpType expType, char* string, ExpType argType, char*);
char str[64];

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
%token <tokenData> STATIC INT BOOL CHAR   
%token <tokenData> TRUE FALSE RETURN BREAK 
%token <tokenData> comma semicolon colon
%token <tokenData> leftp2 leftp leftp3 rightp2 rightp rightp3
%token <tokenData> AND OR NOT lt '=' gt multiply mod divide minus // plus EQ
%token <tokenData> plus 
%type <type> type_specifier //type_specifier_func scoped_type_specifier 
%type <nodeptr> and_expression arg_list call compound_stmt declaration declaration_list expression 
%type <nodeptr> expression_stmt factor fun_declaration ifmatched ifunmatched immutable local_declarations
%type <nodeptr> mulop mutable param_id param_id_list param_list rel_expression param_type_list                            
%type <nodeptr> scoped_var_declaration simple_expression statement statement_list sum_expression term         
%type <nodeptr> unary_expression unary_rel_expression unaryop var_decl_initialize var_decl_list 
%type <nodeptr> var_declaration params args assignop relop sumop constant expressionstmt var_decl_id return_stmt
    
%%

program : declaration_list { savedTree = $1; }
        ;                
declaration_list : declaration_list declaration 
                 {
		   TreeNode* t = $1;
		   if ($2 == NULL)
		     $$ = $1;
		   else {
		     if (t != NULL) {
		       if (t->sibling != NULL) 
			 t = t->sibling;
		       t->sibling = $2;
		       $$ = $1;
		     } else
		       $$ = $2; 
		   }
		 }
                 | declaration { $$ = $1; }
                 | error                    {$$=NULL;}
                 ;
declaration : var_declaration { $$ = $1; }
            | fun_declaration { $$ = $1; }
            ;
var_declaration : type_specifier var_decl_list semicolon 
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
		  yyerrok;
		}
                | type_specifier error semicolon            {$$=NULL; yyerrok;}
                ;
/*
scoped_var_declaration : scoped_type_specifier var_decl_list semicolon 
                       { 
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
			 yyerrok;
		       }
		       | scoped_type_specifier error semicolon           {$$=NULL; yyerrok;}
                       ;
scoped_type_specifier : STATIC type_specifier { $$ = $2; }
                      | type_specifier { $$ = $1; }
                      ;   */
scoped_var_declaration : STATIC type_specifier var_decl_list semicolon 
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
			 yyerrok;
		       }
		       | type_specifier var_decl_list semicolon  
                       { 
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
			 yyerrok;
		       }
		       | type_specifier error semicolon           {$$=NULL; yyerrok;}
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
		yyerrok;
	      }
              | var_decl_initialize { $$ = $1; }
	      | error comma var_decl_initialize {$$=NULL;  yyerrok;}   //modify           
              | var_decl_list comma error { $$ = NULL; }
              ;
/*
var_decl_initialize : ID 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->string = $1->tokenstr;
		    }
                    | ID leftp3 NUMCONST rightp3 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->string = $1->tokenstr;
		      $$->isArray = true;
		    }
                    | ID colon simple_expression 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->string = $1->tokenstr;
		      $$->child[0] = $3;
		    }
                    | ID leftp3 NUMCONST rightp3 colon simple_expression 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->string = $1->tokenstr;
		      $$->child[0] = $6;
		      $$->isArray = true;
		    }
                    | ID colon error     {$$=NULL;}   
		    | ID leftp3 NUMCONST rightp3 colon error {$$=NULL;}   
         	    | ID leftp3 NUMCONST error      {$$=NULL;}   
	            | error leftp3 NUMCONST rightp3        {$$=NULL; yyerrok;}
                    ;
*/
var_decl_initialize : var_decl_id {$$=$1;}
                    | var_decl_id colon simple_expression
		    {
		      $$ = $1;
		      $$->child[0] = $3;
		    }
		    | error colon simple_expression  {$$=NULL; yyerrok;}
		    | var_decl_id colon error        {$$=NULL;}
                    ;
var_decl_id : ID 
            {
	      $$ = newDeclNode(VarK);
	      $$->linnum = $1->linnum;
	      $$->string = $1->tokenstr;
	    }
            | ID leftp3 NUMCONST rightp3 
            {
	      $$ = newDeclNode(VarK);
	      $$->linnum = $1->linnum;
	      $$->string = $1->tokenstr;
	      $$->isArray = true;
	    }
	    | ID leftp3 error         {$$=NULL; }
	    | error leftp3 NUMCONST rightp3        {$$=NULL; yyerrok;}
            ;
type_specifier : BOOL { $$ = Boolean; }
               | CHAR { $$ = Character; }
               | INT  { $$ = Integer; }
               ;










fun_declaration : type_specifier ID leftp params rightp statement 
                {
		  TreeNode* t = newDeclNode(FuncK); 
		  t->string = $2->tokenstr;
		  t->linnum = $2->linnum;
		  t->expType = $1;
		  $$ = t;
		  $$->child[0] = $4;
		  $$->child[1] = $6;
		  //yyerrok;
		}
                | ID leftp params rightp statement 
		{
		  TreeNode* t = newDeclNode(FuncK);
		  t->string = $1->tokenstr;
		  t->linnum = $1->linnum;
		  t->expType = Void;  // 0
		  $$ = t;
		  $$->child[0] = $3;
		  $$->child[1] = $5;
		}
		| type_specifier error leftp params rightp statement   {$$=NULL; yyerrok;}
		| type_specifier ID leftp error                     {$$=NULL;}
		| ID leftp error rightp statement                      {$$=NULL; yyerrok;}
		| error rightp statement                             {$$=NULL; yyerrok;}
		;
/*
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
	     yyerrok;
	   }
	   | error semicolon type_specifier param_id_list  {$$=NULL; yyerrok;}
	   | param_list semicolon type_specifier error     {$$ = $1;}

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
	     yyerrok;
	   }
	   | type_specifier error     {$$=NULL;}
	   ;
*/

params : param_list { $$ = $1; }    // yyerrok; add by myself
       | /* empty*/ { $$ = NULL; }
       ;
param_list : param_list semicolon param_type_list
           {
	     TreeNode* t = $1;
	     if (t) {
	       if (t->sibling != NULL)   //segmentation fault here
		 t = t->sibling;
	       t->sibling = $3;
	       $$ = $1;
	     } else 
	       $$ = $3;
	     //yyerrok;  help help
	   }
           | param_type_list {$$=$1; yyerrok;}   //  yyerrok; by myself
//           | param_list semicolon error {$$=NULL;}
           | error semicolon param_type_list   {$$=$3; yyerrok;} //NULL
           ;
param_type_list : type_specifier param_id_list
                {
		  TreeNode* v = $2;
		  if (v != NULL){
		    v->expType = $1;
		    while (v->sibling != NULL) {
		    //if (v->sibling != NULL) {
		      v = v->sibling;
		      v->expType = $1;
		    }
		    $$ = $2; 
		  } 
		}
                | type_specifier error   {$$=NULL;}
                ;
param_id_list : param_id_list comma param_id 
              {
		TreeNode* t = $1;
		//if ($3) {
		if (t){
		  while (t->sibling != NULL) t = t->sibling;
		  t->sibling = $3;
		  $$ = $1;
		} else
		  $$ = $3;
		//} else $$ = $1;
		yyerrok;
	      }
              | param_id { $$ = $1; }
              | error comma param_id  {$$=$3; yyerrok;}        //$3
              | param_id_list comma error  {$$=$1; yyerrok;}   //$1
              ;
param_id : ID 
         {
	   $$ = newDeclNode(ParamK);
	   $$->linnum = $1->linnum;
	   $$->string = $1->tokenstr;
	 }
	 | ID leftp3 rightp3 
         {
	   $$ = newDeclNode(ParamK);
	   $$->linnum = $1->linnum;
	   $$->string = $1->tokenstr;
	   $$->isArray = true;
	 }
	 | error leftp3 NUMCONST rightp3   {$$=NULL; yyerrok;}
	 | ID leftp3 error             {$$=NULL;}
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
		 //yyerrok;
	       }
               |  { $$ = NULL; }
	       | statement_list error       {$$ = NULL; } 
               ;
statement : ifmatched { $$ = $1; }
          | ifunmatched { $$ = $1; }
          | ifmatched error { $$ = $1; }
          | ifunmatched error { $$ = $1; } // NULL
          ;
ifmatched : IF leftp simple_expression rightp ifmatched ELSE ifmatched 
          { 
	    $$ = newStmtNode(IfK);
	    $$->string = $1->tokenstr;
	    $$->linnum = $1->linnum;
	    $$->child[0] = $3;
	    $$->child[1] = $5;
	    $$->child[2] = $7;
	  }
	  | IF leftp error      {$$=NULL;}
	  | error rightp ifmatched ELSE ifmatched  {$$=NULL; yyerrok;}

          | WHILE leftp simple_expression rightp ifmatched
          { 
	    $$ = newStmtNode(WhileK);
	    $$->linnum = $1->linnum;
	    $$->string = $1->tokenstr;
	    $$->child[0] = $3;
	    $$->child[1] = $5;
	  }
          | WHILE leftp error   {$$=NULL;}

          | FOREACH leftp mutable IN simple_expression rightp ifmatched 
          { 
	    $$ = newStmtNode(ForEachK);
	    $$->string = $1->tokenstr;
	    $$->linnum = $1->linnum;
	    $$->child[0] = $3;
	    $$->child[1] = $5;
	    $$->child[2] = $7;
	  }
	  | FOREACH leftp error      {$$=NULL; }
          | expression_stmt { $$ = $1; }
    	  ;
ifunmatched : IF leftp simple_expression rightp ifmatched ELSE ifunmatched
            { 
	      $$ = newStmtNode(IfK);
	      $$->linnum = $1->linnum;
	      $$->string = $1->tokenstr;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	      $$->child[1]->expType = Boolean;
	      $$->child[2] = $7;
	    }
            | IF leftp simple_expression rightp statement
            { 
	      $$ = newStmtNode(IfK);
	      $$->string = $1->tokenstr;
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	    }
            | IF leftp simple_expression rightp error ELSE ifunmatched    {$$=NULL; yyerrok;}
       	    | IF leftp error           {$$=NULL;}
//	    | error rightp ifunmatched  {$$=NULL; yyerrok;}
	    | error rightp statement    {$$=NULL; yyerrok;}

            | WHILE leftp simple_expression rightp ifunmatched
            { 
	      $$ = newStmtNode(WhileK);
	      $$->string = $1->tokenstr;
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	    }
            | WHILE leftp error   {$$=NULL;}

            | FOREACH leftp mutable IN simple_expression rightp ifunmatched 
            { 
	      $$ = newStmtNode(ForEachK);
	      $$->string = $1->tokenstr;
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	      $$->child[2] = $7;
	    }
	    | FOREACH leftp error        {$$=NULL; }
//	    | FOREACH leftp error rightp IN simple_expression rightp ifunmatched     {$$=NULL; yyerrok;}
//          | FOREACH error mutable IN simple_expression rightp ifunmatched     {$$=NULL; yyerrok;}
//	    | FOREACH leftp error rightp ifunmatched     {$$=NULL; yyerrok;}
            ;
expression_stmt: compound_stmt { $$ = $1; }
               | return_stmt  { $$ = $1; }
               | BREAK semicolon  
               {
		 $$ = newStmtNode(BreakK);
		 $$->string = $1->tokenstr;
		 $$->linnum = $1->linnum;
	       }
              | expressionstmt  { $$ = $1;}
              ;  
return_stmt : RETURN semicolon 
              {
		$$ = newStmtNode(ReturnK);
		$$->linnum = $1->linnum;
		$$->expType = Void;
		yyerrok;
	      }
              | RETURN expression semicolon  
              {
		$$ = newStmtNode(ReturnK);
		$$->linnum = $1->linnum;
		$$->child[0] = $2;
		$$->expType = $2->expType; 
		yyerrok;
	      }
              | RETURN error {$$=NULL;}
              ;
expressionstmt : expression semicolon { $$ = $1; yyerrok;}   
               | semicolon { $$ = NULL; yyerrok;}
  	       | error semicolon { $$ = NULL; yyerrok;}
//  	       | expression error { $$ = NULL;}
               ;
compound_stmt : leftp2 local_declarations statement_list rightp2 
              {
		$$ = newStmtNode(CompoundK);
		$$->linnum = $1->linnum;
		$$->child[0] = $2;
		$$->child[1] = $3;
		yyerrok;
	      }
	      | error rightp2                      {$$=NULL; yyerrok;}
	      | leftp2 error statement_list rightp2   {$$=NULL; yyerrok;}
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
expression : simple_expression { $$ = $1; }
           | mutable assignop expression 
           {
	     $$ = $2; 
	     $$->child[0] = $1;
	     $$->child[1] = $3;
	   }
           | error assignop expression { $$ = NULL; yyerrok; }
           | mutable assignop error { $$ = NULL; }
           | mutable error expression { $$ = NULL; yyerrok; }
           | mutable INC 
           {
	     $$ = newExpNode(AssignK); 
	     $$->attr.op = $2->tokenClass;
	     $$->string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->child[0] = $1;
	   }
           | mutable DEC 
           {
	     $$ = newExpNode(AssignK); 
	     $$->attr.op = $2->tokenClass;
	     $$->string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->child[0] = $1;
	   }
           | error INC { $$ = NULL; yyerrok; }
           | error DEC { $$ = NULL; yyerrok; }
           ;
assignop : '='
         {
	   $$ = newExpNode(AssignK); 
	   $$->attr.op = $1->tokenClass;
	   $$->string = $1->tokenstr;
	   $$->linnum = $1->linnum; 
	 }
	 | PASSIGN
         {
	   $$ = newExpNode(AssignK); 
	   $$->attr.op = $1->tokenClass;
	   $$->string = $1->tokenstr;
	   $$->linnum = $1->linnum; 
	 }
	 | MASSIGN
         {
	   $$ = newExpNode(AssignK); 
	   $$->attr.op = $1->tokenClass;
	   $$->string = $1->tokenstr;
	   $$->linnum = $1->linnum; 
	 }
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
                  | simple_expression OR error { $$=NULL; }
		  | error OR and_expression    { $$=NULL; yyerrok; }
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
               | error AND unary_rel_expression { $$=NULL; yyerrok; }
               | and_expression AND error       { $$=NULL; }
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
                     | NOT error      { $$=NULL; }
                     ;
rel_expression : sum_expression relop sum_expression
               {
		 $$ = $2;
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
	       | sum_expression {$$=$1;}
               | error relop sum_expression {$$=NULL; yyerrok;}
	       | sum_expression relop error {$$=NULL;}
               ;
relop : lt
      {
	$$ = newExpNode(OpK);
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      | gt
      {
	$$ = newExpNode(OpK);
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      | LEQ
      {
	$$ = newExpNode(OpK);
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      | GEQ
      {
	$$ = newExpNode(OpK);
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      | EQ // '=='
      {
	$$ = newExpNode(OpK); 
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      | NEQ
      {
	$$ = newExpNode(OpK);
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      ;
sum_expression : sum_expression sumop term  
               {
		 $$ = $2; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | term { $$ = $1; }
               | error sumop term { $$ = NULL; yyerrok; }
               | sum_expression sumop error { $$ = NULL; }
               ;
sumop : plus
      {
	$$ = newExpNode(OpK);
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum;
      }
      | minus
      {
	$$ = newExpNode(OpK);
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum;
      }
      ;
term : term mulop unary_expression 
     {
       $$ = $2;
       $$->child[0] = $1;
       $$->child[1] = $3;
     }
     | unary_expression { $$ = $1; }
     | error mulop unary_expression { $$ = NULL; yyerrok; }
     | term mulop error { $$ = NULL; }
     ;
mulop : multiply 
      { 
	$$ = newExpNode(OpK); 
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      | divide
      { 
	$$ = newExpNode(OpK); 
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      | mod
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
                 | unaryop error { $$ = NULL; }
                 ;
unaryop : minus 
        { 
	  $$ = newExpNode(OpK); 
	  $$->attr.op = $1->tokenClass;
	  $$->string = $1->tokenstr;
	  $$->linnum = $1->linnum; 
	}
        | multiply 
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
        | ID leftp3 expression rightp3 
        {
	  $$ = newExpNode(IdK);
	  $$->string = $1->tokenstr;
	  $$->linnum = $1->linnum;
	  $$->isArray = true; 
	  $$->child[0] = $3;
	}
	| ID leftp3 error    { $$ = NULL; }
	| error leftp3       { $$ = NULL; yyerrok; }
        ;

immutable : call  { $$ = $1; yyerrok;}
          | leftp expression rightp            { $$ = $2; yyerrok;}
          | constant   { $$ = $1; }
	  | leftp  error          { $$ = NULL; }
	  | error rightp          { $$ = NULL; yyerrok; }
          ;
constant :  NUMCONST
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
call : ID leftp args rightp 
     {
       $$ = newExpNode(CallK);
       $$->string = $1->tokenstr;
       $$->linnum = $1->linnum;
       $$->child[0] = $3;
     }
     | error leftp args rightp   {$$=NULL; yyerrok;}
     | ID leftp error          {$$=NULL;}
args : arg_list { $$ = $1; }
     | { $$ = NULL; }
     ;
arg_list : arg_list comma expression
         {
	   TreeNode * t = $1;
	   if (t != NULL){
	     while  (t->sibling != NULL) t = t->sibling;
	     t->sibling = $3;
	     $$ = $1;
	   } else
	     $$ = $3;
	   yyerrok;
	 }
         | expression { $$ = $1; }
	 | error comma expression    {$$=NULL; yyerrok;}
         ;

%%

void nodePrint(void * p){
  //  TreeNode * t = (TreeNode*)p;
}

SymTab * st = new SymTab(nodePrint);
char nameCompoundStat[64];
char nameParam[32];
int depth = 1;

main(int argc, char* argv[]){
    int d_flag = 0;
    int s_flag = 0;
    char *d_value = NULL;
    int c;

    if (argc == 1) 
        yyin = stdin;
    else if (argc == 2) {
        yyin = fopen(argv[1], "r");
    } else if (argc > 2) {  
      while ((c = getopt (argc, argv, "ps")) != -1)
	switch (c) {      
	case 'p':   // yydebug
	  d_flag = 1;
	  break;
	case 's':  // debug_table
	  s_flag = 1;
	  break;
	default:
	  abort ();
	  break;
	}
      if (d_flag == 1)
	yydebug = 1;
      //printTree(savedTree);
      if (s_flag == 1)
	st->debug(0x2); 
      yyin = fopen(argv[2], "r");
    } else {
      printf("Usage:./c- TestFileName\nUsage:./c- < TestFileName\nUsage: cat TestFileName | ./c-\n");
        exit(-1);
    }
    if (yyin == NULL){
        printf("Can't open/read '%s'\n", argv[2]);
        exit(-1);
    }
    yyfilename = argv[1];
    linnum = 1;
    initYyerror();

    yyparse();
    savedTree = siblingNode(savedTree, Void, (char*)("outnl"), Void, (char*)(" "));
    savedTree = siblingNode(savedTree, Character, (char*)("inputc"), Void, (char*)(" "));
    savedTree = siblingNode(savedTree, Boolean, (char*)("inputb"), Void, (char*)(" "));
    savedTree = siblingNode(savedTree, Integer, (char*)("input"), Void, (char*)(" "));
    savedTree = siblingNode(savedTree, Void, (char*)("outputc"), Character, (char*)("xyz"));
    savedTree = siblingNode(savedTree, Void, (char*)("outputb"), Boolean, (char*)("xyz"));
    savedTree = siblingNode(savedTree, Void, (char*)("output"), Integer, (char*)("xyz"));
    //    insertCheckNode(savedTree);  

    printf("Number of warnings: %d\n", numWarnings);
    printf("Number of errors: %d\n", numError);

    if (argc != 1)
        fclose(yyin);
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

int i = 0;
int cmpi = 0;
int funci = 0;
int ifi = 0;
int whilei = 0;
int opi = 0;
int assigni = 0;
bool ReturnFlag = false;
bool LoopFlag = false;
bool WhileFlag = false;
bool ForEachFlag = false;
int depthcnt = 0;

static void insertCheckNode( TreeNode * t)  {

  switch (t->nodekind) {
  case DeclK:  
    switch(t->kind.decl){

    case VarK:
      if (t->child[0] != NULL) {
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

      if ((st->lookup(t->string) == NULL) || 
	  ( ((st->lookupSymTabEntry(t->string))->depth != st->depth()-1 ) //ParamK
	    && (st->lookupSymTabEntry(t->string))->depth != st->depth()) ) {
	st->insert(t->string, (void*)t ); 

	if (t->child[0] != NULL) {
	  if ( (t->isArray == false) && (t->child[0]->isArray == true) ) {
	    printf("ERROR(%d): Initializer for nonarray variable '%s' of type %s cannot be initialized with an array.\n",
		   t->child[0]->linnum, t->string, getType(t->expType));
	    ++numError;
	  }
	} // child[0] != NULL

      } else { // exist in symtab
	//      } else if ( (st->lookupSymTabEntry(t->string))->depth  ) { // scope
	printf("ERROR(%d): Symbol '%s' is already defined at line %d.\n", 
	       t->linnum, t->string, ((TreeNode*)(st->lookup(t->string)))->linnum);
	++numError;
      }

      if  (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case FuncK:
      if (st->lookup(t->string) == NULL) {   
	st->insert(t->string, (void*)t ); 
      } else { 
	printf("ERROR(%d): Symbol '%s' is already defined at line %d.\n", t->linnum, t->string, 
	       ((TreeNode*)(st->lookup(t->string)))->linnum);
	++numError;
      }

      st->enter(t->string);
      for (funci = 0; funci < 2; funci++) {
	if (t->child[funci] != NULL) {
	  insertCheckNode(t->child[funci]);
	}
      }

      if (t->child[1] != NULL){
	if ( (t->expType == 0) && (t->child[1]->expType != 0) ) {
	  printf("ERROR(%d): Function '%s' at line %d is expecting no return value, but return has return value.\n", 
		 t->child[1]->linnum, t->string, t->linnum);
	  ++numError;
	} else if ( (t->expType == 0) && (ReturnFlag == true) && (t->child[1]->expType != 0) ) {
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
	    printf("WARNING(%d): Expecting to return type %s but function '%s' has no return statement\n", 
		   t->linnum, getType(t->expType), t->string);
	    ++numWarnings;
	  }
	}
	ReturnFlag = false; // set back to default
      }
      st->leave();

      if ( (t->child[1] == NULL) && (t->expType != Void) 
	   && ((t->string != (char*)"input") && (t->string != (char*)"inputb") && (t->string != (char*)"inputc"))) {
	printf("WARNING(%d): Expecting to return type %s but function '%s' has no return statement.\n", 
	       t->linnum, getType(t->expType), t->string);
	++numWarnings;
      }

      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case ParamK:
      st->insert(t->string, (void*)t );
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
      }
      --depthcnt;
      LoopFlag = false;
      if (t->sibling != NULL) 
	insertCheckNode(t->sibling);
      break;

    case BreakK:
      //if ( (LoopFlag == false) && (depthcnt > 0) ) {   // potential problems with nested loops
      if ( LoopFlag == false ) {
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
      depth = st->depth() + 1;
      sprintf(nameCompoundStat, "Compound Statement:%d", depth);
      st->enter(nameCompoundStat);

      for (cmpi = 0; cmpi < MAXCHILDREN; cmpi++) { 
	if (t->child[cmpi] != NULL) 
	  insertCheckNode(t->child[cmpi]);
      }
      if (t->sibling != NULL) 
	insertCheckNode(t->sibling);

      sprintf(str, "Return:%d", st->depth());
      if (st->lookup(str) == NULL) {
	t->expType = Void;
	ReturnFlag = false;
      } else {
	ReturnFlag = true;
	t->expType = ((TreeNode*)(st->lookup(str)))->expType;
	t->linnum = ((TreeNode*)(st->lookup(str)))->linnum;
      }
      st->leave();
      --depth;
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

      if ( (t->attr.op == '=') && (t->child[0] != NULL) && (t->child[1] != NULL) ) {
	if ( (t->child[0]->isArray != t->child[1]->isArray)
	     && ((t->child[0]->expType != Undefined) && (t->child[1]->expType != Undefined)) ) {
	     //&& ((t->child[0]->expType != Character) && (t->child[1]->expType != Character)) ) {
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

      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case CallK:
      if (st->lookup(t->string) == NULL) {
	printf("ERROR(%d): Symbol '%s' is not defined.\n", t->linnum, t->string);
	++numError;
	t->expType = Undefined; 
	if (t->child[0] != NULL)
	  insertCheckNode(t->child[0]);
      } else {
	if ( (((TreeNode*)(st->lookup(t->string)))->kind.decl == VarK)
	     || (((TreeNode*)(st->lookup(t->string)))->kind.decl == ParamK) ) {
	  printf("ERROR(%d): '%s' is a simple variable and cannot be called.\n", t->linnum, t->string);
	  ++numError;
	  t->expType = Undefined;
	  if ( t->child[0] )
	    insertCheckNode(t->child[0]);
	} else { //FuncK
	  TreeNode* p = (TreeNode*)(st->lookup(t->string));
	  if ( (t->child[0] == NULL) && (p->child[0] != NULL) ) {
	    printf("ERROR(%d): Too few parameters passed for function '%s' defined on line %d.\n", 
		   t->linnum, t->string, p->linnum);
	    ++numError;
	  }
	  if (t->child[0] != NULL) {

	    TreeNode* tmpt = t->child[0];
	    int pcnt = 0;

	    while (tmpt) {
	      //if (tmpt) {
	      insertCheckNode(tmpt);

	      if (p->child[0] == NULL) {
		printf("ERROR(%d): Too many parameters passed for function '%s' defined on line %d.\n", 
		       tmpt->linnum, t->string, p->linnum);
		++numError;
	      } else {
		TreeNode* tmpp = p->child[0];
		if ((tmpt->expType != tmpp->expType) && (tmpt->expType != Undefined) ) {
		  printf("ERROR(%d): Expecting type %s in parameter %i of call to '%s' defined on line %d but got type %s.\n", 
			 tmpt->linnum, getType(tmpp->expType), pcnt+1, t->string, p->linnum, getType(tmpt->expType));
		  ++numError;
		}
		//if (tmpt->expType == tmpp->expType) 
		//t->expType = p->expType;
		if ( (tmpt->isArray == true) && (tmpp->isArray == false) ) {
		  printf("ERROR(%d): Not expecting array in parameter %i of call to '%s' defined on line %d.\n", 
			 t->linnum, pcnt+1, t->string, p->linnum);
		  ++numError;
		}
		if ( (tmpt->isArray == false) && (tmpp->isArray == true) ) {
		  printf("ERROR(%d): Expecting array in parameter %i of call to '%s' defined on line %d.\n", 
			 t->linnum, pcnt+1, t->string, p->linnum);
		  ++numError;
		}
		tmpt->expType = tmpp->expType;
		tmpt->isArray = tmpp->isArray;

		if ( (tmpt->sibling != NULL) &&  (tmpp->sibling == NULL) ) {
		  printf("ERROR(%d): Too many parameters passed for function '%s' defined on line %d.\n", 
			 tmpt->linnum, t->string, p->linnum);
		  ++numError;
		  //tmpt = tmpt->sibling;
		  //while (tmpt)
		  //insertCheckNode(tmpt);
		}
		if ( (tmpt->sibling == NULL) &&  (tmpp->sibling != NULL) ) {
		  printf("ERROR(%d): Too few parameters passed for function '%s' defined on line %d.\n", 
			 tmpt->linnum, t->string, p->linnum);
		  ++numError;
		}
		
		//while ( (tmpt->sibling != NULL) &&  (tmpp->sibling != NULL) ) {
		if ( (tmpt->sibling != NULL) &&  (tmpp->sibling != NULL) ) 
		  pcnt++;
		//insertCheckNode(tmpt->sibling);
		tmpp = tmpp->sibling;
		tmpt = tmpt->sibling;
	      } // end p->child[0] != NULL
	      //while (tmpt) {
	      //insertCheckNode(tmpt);
	    } 
	  } //   end t->child[0] != NULL
	  t->expType = p->expType;

	} // FuncK
      } //symtab

      if (t->sibling != NULL)
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

	if (t->child[0] != NULL) 
	  t->isArray = true;  //double check

	if (t->child[0] != NULL) 
	  insertCheckNode(t->child[0]);
      } else {  // symtab != NULL

	if ( ((TreeNode*)(st->lookup(t->string)))->kind.decl == FuncK ) {
	  printf("ERROR(%d): Cannot use function '%s' as a simple variable.\n", t->linnum, t->string);
	  ++numError;
	  t->expType = ((TreeNode*)(st->lookup(t->string)))->expType; 
	} else { //if ( ((TreeNode*)(st->lookup(t->string)))->kind.decl == VarK ) {

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
      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case OpK:  // + - * / % < > == != <= >= or not and
      int opi;
      for (opi = 0; opi < MAXCHILDREN; opi++) {
	if (t->child[opi] != NULL)
	  insertCheckNode(t->child[opi]);
      }
 
      if ( ((t->attr.op == plus) || (t->attr.op == minus) || (t->attr.op == multiply) 
	  || (t->attr.op == divide) || (t->attr.op == mod))
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

      if ((t->attr.op == minus) && (t->child[0] != NULL) && (t->child[1] == NULL)) {
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

      if ( (t->attr.op == plus) || (t->attr.op == minus) || (t->attr.op == multiply) ) {
	if ( (t->child[0] != NULL) && (t->child[1] != NULL) && //both sides
	     ((t->child[0]->isArray == true) || (t->child[1]->isArray == true)) ) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	} 
      } 

      if ( (t->attr.op == multiply) && (t->child[0] != NULL) && (t->child[1] == NULL) ) {
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
	t->expType = Boolean; 
	if ((t->child[0]->isArray == true) || (t->child[1]->isArray == true)) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
      }

      if ( (t->attr.op == gt) || (t->attr.op == lt) || (t->attr.op == GEQ) || (t->attr.op == LEQ) ) {
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
	     || (t->attr.op == lt) || (t->attr.op == gt) ) 
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
	if ( (t->child[0] != NULL) && (t->child[0]->isArray == true) ) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	  t->child[0]->expType = Boolean; 
	}
	t->expType = Boolean; 
      }

      if ( (t->attr.op == plus) || (t->attr.op == minus) ) {
	if ( (((t->child[0] != NULL) && (t->child[0]->isArray == 1)) && (t->child[1] == NULL)) || 
	     (((t->child[1] != NULL) && (t->child[1]->isArray == 1)) && (t->child[0] == NULL)) ) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
      }
   
      if ( ((t->child[0] != NULL) && (t->child[1] != NULL)) && 
	   ((t->child[0]->isConstant == true) && (t->child[1]->isConstant == true)) ) 
	t->isConstant = true;
      else 
	t->isConstant = false;
    
      if ( ((t->child[0] != NULL) && (t->child[1] != NULL)) && 
	   ((t->child[0]->expType != Integer) || (t->child[1]->expType != Integer)) ) {  
	if ( (t->attr.op == lt) || (t->attr.op == gt) || (t->attr.op == AND) || (t->attr.op == OR) 
	     || (t->attr.op == EQ) || (t->attr.op == NEQ) || (t->attr.op == LEQ) || (t->attr.op == GEQ) )
	  t->expType = Boolean;   
	else   
	  t->expType = Integer;   
      }

      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;  // OpK
    }
    break;  // exp
  }
}

static void printSpaces(void){
  for ( int i = 0; i < indentno; i++){
    printf("|  ");
  }
}
/*
void yyerror(const char* s){
  fprintf(stderr, "%s in line %d in token %s\n", s, linnum, yytext);
  //printf("ERROR linnum(%d):%s. I got: %s\n", linnum, s, yytext);
  exit(-1);
  }*/

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

void printTree( TreeNode * tree){
  int i; 
  int counter = 1; 

  while (tree != NULL){
    INDENT;
    //printSpaces();
    if (tree->nodekind == DeclK){  
      switch(tree->kind.decl){
      case VarK:
	printf("Var %s ", tree->string);
	switch (tree->isArray){
	case true:
	  printf(" is array of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  break;
	default:
	  printf(" of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  break;
	}
	break;
      case FuncK:
	printf("Func %s returns type %s [line: %d]\n", tree->string, getType(tree->expType), tree->linnum);
	break;

      case ParamK:
	printf("Param %s ", tree->string);
	switch (tree->isArray){
	case true:
	  printf(" is array of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  break;
	default:
	  printf(" of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
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
	printf("Child: %d\n", childcnt+1);
	childcnt++;
	printTree(tree->child[i]);
      } 
    } 

    if ( (tree->nodekind == DeclK) && (tree->kind.decl == FuncK) )
      counter = 0;
    tree = tree->sibling; 
    if (tree != NULL){
      if ( counter >= 1 ){
	printf("Sibling: %d\n", counter);
      }
      counter++;
    }
  }
  UNINDENT;
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
