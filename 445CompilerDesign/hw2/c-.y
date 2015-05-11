%{

  // definitions section

#include <iostream>
#include <cstring>
#include <cctype>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "scanType.h"  
#include "c-.tab.h"

extern int yylex();
extern int yyparse();
extern FILE * yyin;
char *yyfilename;

/*
#define MAXCHILDREN 3
typedef struct treeNode {
  // connectivity in the tree
  struct treeNode *child[MAXCHILDREN];   // children of the node
  struct treeNode *sibling;              // siblings for the node

  // what kind of node
  int lineno;                            // linenum relevant to this node
  NodeKind nodekind;                     // type of node
  union {                                // subtype of type 
    DeclKind decl;                     // used when DeclK
    StmtKind stmt;                     // used when StmtK
    ExpKind exp;                       // used when ExpK
  } kind;
    
  // extra properties about the node depending on type of the node
  union {                                  // relevant data to type -> attr
    OpKind op;                         // type of token (same as in bison)
    int val;                           // used when an integer constant
    char *name;                        // used when IdK
    char *string;                      // used when a string constant
  } attr;                                 
  ExpType expType;		           // used when ExpK for type checking
  bool isStatic;                         // is staticly allocated?
  bool isArray;                          // is this an array
  bool isConstant;                       // can this expression be precomputed?

  // even more semantic stuff will go here in later assignments.
} TreeNode;

// the root of the abstract syntax tree
TreeNode *root;
*/
extern char *yytext;
extern int linnum;

using namespace std;
#define YY_DECL extern "C" int yylex()
//#define YYERROR_VERBOSE
#define YYDEBUG 1
/*
// Prints a token and its lexeme to the listing file
void printToken( TokenType, const char *);
// creates a new statement node for syntax tree construction
TreeNode * newStmtNode( StmtKind );
// creates a new expression node for syntax tree construction
TreeNode * newExpNode( ExpKind );
// allocates and makes a new copy of an existing string
char * copyString( char * );
// prints a syntax tree to the listing file using indentation to indicate subtrees 
void printTree( TreeNode * );
*/
//void printTree(FILE *, TreeNode *); 
// void FreeTree(Node *p);
// void PrintTree(Node *p, int depth);
void yyerror(const char* s);
%}

%union {
  Token * token;
}

%token <token> ID QUIT CHARCONST NUMCONST STRINGCONST
%token <token> IF ELSE WHILE FOREACH IN
%token <token> STATIC INT BOOL CHAR E  
%token <token> TRUE FALSE RETURN BREAK 
%token <token> OR NOT INC DEC
%token <token> LEQ GEQ EQ NEQ PASSIGN MASSIGN 

%token <token> lt gt equal plus minus 
%token <token> multiply divide mod comma semicolon colon
%token <token> leftp2 leftp leftp3 rightp2 rightp rightp3
%token <term> AND

%%
			
program: declaration_list     //{ $$ = new pgm($1); root = $$;}
;		 
declaration_list: declaration_list declaration
| declaration
;
declaration: var_declaration
| fun_declaration
;

//4
var_declaration: type_specifier var_decl_list semicolon
;
//5
scoped_var_declaration: scoped_type_specifier var_decl_list semicolon
;
//6
var_decl_list: var_decl_list comma var_decl_initialize
| var_decl_initialize
;

// 7
var_decl_initialize: var_decl_id  
| var_decl_id colon simple_expression
;

//8 
var_decl_id: ID id_exp0;
id_exp0: /* empty */
| leftp3 NUMCONST rightp3 
;

//9
scoped_type_specifier: STATIC type_specifier
| type_specifier
;
type_specifier: INT
| BOOL
| CHAR
;

// 11
fun_declaration: type_specifier ID leftp params rightp statement
| ID leftp params rightp statement
;

// 12
params: param_list
| 
;
// 13
param_list: param_list semicolon param_type_list
| param_type_list
;
// 14
param_type_list: type_specifier param_id_list
;
// 15
param_id_list: param_id_list comma param_id
| param_id
;

//16
param_id: ID
| ID leftp3 mid_exp rightp3
;
mid_exp: NUMCONST
| /* empty */
;

// 17
statement: expression_stmt 
| compound_stmt
| selection_stmt
| iteration_stmt
| return_stmt
| break_stmt
;
// 18
compound_stmt: leftp2 local_declarations statement_list rightp2
;
// 19
local_declarations: local_declarations scoped_var_declaration
| 
;
// 20
statement_list: statement_list statement
| 
;
// 21
expression_stmt: expression semicolon
| semicolon
;

//22
selection_stmt: matched
| unmatched
;
matched: IF leftp simple_expression rightp matched ELSE matched
| expression_stmt 
| compound_stmt
| iteration_stmt
| return_stmt
| break_stmt  
;
unmatched: IF leftp simple_expression rightp unmatched_exp
;
unmatched_exp: matched_exp
| unmatched
;
matched_exp: matched matched_else_exp
;
matched_else_exp: /* empty */
| ELSE unmatched
;
/*
unmatched: 
  IF leftp simple_expression rightp matched
| IF leftp simple_expression rightp unmatched
| IF leftp simple_expression rightp matched ELSE unmatched
;
*/

// 23
iteration_stmt: WHILE leftp simple_expression rightp statement
| FOREACH leftp mutable IN simple_expression rightp statement
;
// 24
return_stmt: RETURN semicolon
| RETURN expression semicolon
;
// 25
break_stmt: BREAK semicolon
;

// 26
expression: mutable equal expression 
| mutable PASSIGN expression 
| mutable MASSIGN expression
| mutable INC 
| mutable DEC 
| simple_expression
;
simple_expression: simple_expression OR and_expression 
| and_expression
;
and_expression: and_expression AND unary_rel_expression 
| unary_rel_expression
;

//29
unary_rel_expression: NOT unary_rel_expression 
| rel_expression
;

//30
rel_expression: sum_expression sum_expression_rest;
sum_expression_rest:  /* empty */
| relop sum_expression 
;

relop: lt
| gt
| LEQ
| GEQ 
| EQ 
| NEQ 
;

//32
sum_expression: sum_expression sumop term 
| term
;
sumop: plus 
| minus
;
term: term mulop unary_expression 
| unary_expression
;
mulop: multiply
| divide
| mod
;
unary_expression: unaryop unary_expression 
| factor
;
unaryop: minus
| multiply
;


factor: immutable 
| mutable
;

//39
mutable: ID id_exp39
;
id_exp39: /* empty */
| leftp3 expression rightp3
;
// 40
immutable: leftp expression rightp
| call 
| constant
;
//41 
call: ID leftp args rightp
;

// 42
args: arg_list 
| 
;

arg_list: expression comma arg_list  
| expression
;
constant: NUMCONST 
| CHARCONST 
| STRINGCONST 
| TRUE 
| FALSE
;

%%

main(int argc, char* argv[]){

  int d_flag = 0;
  char * d_value = NULL;
  int c;

  if (argc == 1) 
    yyin = stdin;
  else if (argc == 2) {
      yyin = fopen(argv[1], "r");
  } else if (argc > 2) {  
      while ((c = getopt (argc, argv, "d")) != -1)
	switch (c) {      
	case 'd':
	  d_flag = 1;
	  break;
	default:
	  abort ();
	}
      if (d_flag == 1)
	yydebug = 1;
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
    //    printTree(stdout, syntaxTree);
  }   while ( !feof(yyin)) ;

  if (argc != 1)
    fclose(yyin);
}

/*
// Prints a token and its lexeme to the listing file
void printToken( TokenType token, const char * tokenString){
  switch (token){
  case IF: 
  case THEN: 
  case ELSE: 
  case END:
  case REPEAT:
  case UNTIL:
  case READ:
  case WRITE:
    fprintf(listing, "reserved word: %s\n", tokenString);
    break;
  case ASSIGN: fprintf(listing, ":=\n"); break;
  case LT: fprintf(listing, "<\n"); break;
  case EQ: fprintf(listing, "=\n"); break;
  case LPAREN: fprintf(listing, "(\n"); break;
  case RPAREN: fprintf(listing, ")\n"); break;
  case SEMI: fprintf(listing, ";\n"); break;
  case PLUS: fprintf(listing, "+\n"); break;
  case MINUS: fprintf(listing, "-\n"); break;
  case TIMES: fprintf(listing, "*\n"); break;
  case OVER: fprintf(listing, "/n"); break;
  case ENDFILE: fprintf(listing, "EOF\n"); break;
  case NUM:
        fprintf(listing, "NUM, val= %s\n", tokenString);
	break;
  case ID:
        fprintf(listing, "ID, name= %s\n", tokenString);
	break;
  case ERROR:
        fprintf(listing, "ERROR: %s\n", tokenString);
	break;
  default: 
        fprintf(listing, "Unknow token: %s\n", tokenString);
	break;
  }
}

// creates a new statement node for syntax tree construction
TreeNode * newStmtNode( StmtKind kind){
  TreeNode * t = (TreeNode*) malloc(sizeof(TreeNode));
  int i; 
  if (t==NULL)
    fprintf(listing, "Out of memory error at line %d\n", lineno);
  else {
    for (i = 0; i < MAXCHILDREN; i++)
      t->child[i] = NULL; 
    t->sibling = NULL;
    t->nodekind = StmtK;
    t->kind.stmt = kind; 
  }
  return t;
}

// creates a new expression node for syntax tree construction
TreeNode * newExpNode( ExpKind kind){
  TreeNode * t = (TreeNode*) malloc(sizeof(TreeNode));
  int i; 
  if (t==NULL)
    fprintf(listing, "Out of memory error at line %d\n", lineno);
  else {
    for (i = 0; i < MAXCHILDREN; i++)
      t->child[i] = NULL; 
    t->sibling = NULL;
    t->nodekind = ExpK;
    t->kind.stmt = kind; 
    t->type = void;
  }
  return t;
}

// allocates and makes a new copy of an existing string
char * copyString( char * s){
  int n; 
  if (s==NULL) return NULL;
  n = strlen(s) + 1;
  t = malloc(n);
  if (t==NULL)
    fprintf(listing, "Out of memory error at line %d\n", lineno);
  else strcpy(t, s);
  return t;
}

// Variable indentno is used by printTree to store current number of spaces to indetn
static indentno = 0;

// macros to increase/decrease indentation
#define INDENT indentno += 2
#define UNINDENT indentno -= 2

// indents by printing spaces
static void printSpaces(void){
  int i;
  for (i = 0; i < indentno; i++){
    fprintf(listing, "  ");
  }
}

// prints a syntax tree to the listing file using indentation to indicate subtrees 
void printTree( TreeNode * tree){
  int i; 
  INDENT;
  while (tree != NULL){
    printSpaces();
    if (tree->nodekind == StmtK){
      switch (tree->kind.stmt){
      case IfK:
	fprintf(listing, "If\n");
	break;
      case RepeatK:
	fprintf(listing, "Repeat\n");
	break;
      case AssignK:
	fprintf(listing, "Assign to: %s\n", tree->attr.name);
	break;
      case ReadK:
	fprintf(listing, "Read: %s\n", tree->attr.name);
	break;
      case WriteK:
	fprintf(listing, "Write\n");
	break;
      default:
	fprintf(listing, "Unknown ExpNode kind\n");
	break;
      }
    }
    else if (tree->nodekind == ExpK){
      switch (tree->kind.exp){
      case OpK:
	fprintf(listing, "Op: ");
	printToken(tree->attr.op, "\0");
	break;
      case ConstK:
	fprintf(listing, "const: %d\n", tree->attr.val);
	break;
      case IdK:
	fprintf(listing, "Id: %s\n", tree->attr.name);
	break;
      default:
	fprintf(listing, "Unknown ExpNode kind\n");
	printToken(tree->attr.op, "\0");
	break;
      }
    }
    else fprintf(listing, "Unknown node kind\n");
    for (i = 0; i < MAXCHILDREN; i++)
      printTree(tree->child[i]);
    tree = tree->sibling; 
  }
  UNINDENT;
}
*/

/*
void PrintTree(Node *p, int depth){  
  for (int i = 0; i < depth; i++) cout << '\t';        
  if(!p->arrived_value.empty()){  
    cout<<p->arrived_value<<endl;  
    for (int i = 0; i < depth+1; i++) cout << '\t';   
  }  
  cout<<p->attribute;  
  //cout<<p->attribute<< "\t cnt:" << p->cnt << endl; 
  if ( (!p->attribute.compare(yes)) || (!p->attribute.compare(no)) )
		cout << "\t cnt:" << p->cnt << endl;
  else
		cout << endl;
  for (vector<Node*>::iterator it = p->childs.begin(); it != p->childs.end(); it++){  
    PrintTree(*it, depth + 1);  
  }  
}  

void FreeTree(Node *p){  
  if (p == NULL)  
    return;  
  //rootcnt = p->cnt;
  for (vector<Node*>::iterator it = p->childs.begin(); it != p->childs.end(); it++){  
	totalcnt += (*it)->cnt ;
    FreeTree(*it);  
  }  
  delete p;  
  tree_size++;  
}  
*/

void yyerror(const char* s){
  fprintf(stderr, "%s in line %d in token %s\n", s, linnum, yytext);
  //printf("ERROR lineno(%d):%s. I got: %s\n", linnum, s, yytext);
  exit(-1);
}

