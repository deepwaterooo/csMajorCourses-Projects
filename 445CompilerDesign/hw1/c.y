// c-.y

%{

#include <stdio.h>
#include <stdio.h>
#include "scanType.h"

// stuff from flex that Bison needs to know about: 
extern int yylex();
extern int yyparse();
extern FILE * yyin;

void yyerror(const char * s);

%}


// user defined yystype for tokens of any arbitrary data type
// C union holds each of the types of tokens that Flex could return, 
// has Bison use that union instead of "int" for the definition of "yystype"
%union {
  struct TokenData * tokenData;
  double value;
}


// define the "terminal symbol" token types I am going to use
// in CAPS by convention, and associate each with a field of the union
%token <tokenData> NUMBER ID QUIT CHARCONST NUMCONST STRINGCONST
%type <value> term   // exp varornum

%term stat intc bool charc e  
%term ifc elsec whilec foreach in
%term truec falsec voidc
%term returnc breakc 

%nonassoc or and not
%nonassoc  '<' '>' '=' lteq gteq equ nequ pleq mieq 
			    // '<=' '>=' '==' '!=' '+=' '-='
%left '+' '-' '*' '/' '%' ',' ';' ':'
%left '{' '(' '['
%right '}' ')' ']'

%start program
 
%%
			
// this is the actual grammar that Bison will parse		       
program: declaration-list
;		 
declaration-list: declaration-list declaration
| declaration
;
declaration: var-declaration
| fun-declaration
;
var-declaration: type-specifier var-decl-list
;

scoped-var-declaration: scoped-type-specifier var-decl-list
;
var-decl-list: var-decl-list ',' var-decl-initialize
| var-decl-initialize
;

// 7
var-decl-initialize: var-decl-id  
| var-decl-id ':' simple-expression
;
var-decl-id: ID
| ID '[' NUMCONST ']'
;

//9
scoped-type-specifier: stat type-specifier
| type-specifier
;
type-specifier: intc
| bool
| charc
;

// 11
fun-declaration: type-specifier ID '(' params ')' statement
| ID '(' params ')' statement
;

// 12
params: param-list
| e
;
param-list: param-list ';' param-type-list
| param-type-list
;
param-type-list: type-specifier param-id-list
;
param-id-list: param-id-list ',' param-id
| param-id
;
param-id: ID
| ID '[' ']'
;

// 17
statement: expression-stmt 
| compound-stmt
| selection-stmt
| iteration-stmt
| return-stmt
| break-stmt
;
compound-stmt: '{' local-declarations statement-list '}'
;
local-declarations: local-declarations scoped-var-declaration
| e
;
statement-list: statement-list statement
| e
;
expression-stmt: expression ';'
| ';'
;
selection-stmt: ifc '(' simple-expression ')' statement
| ifc '(' simple-expression ')' statement elsec statement
;
iteration-stmt: whilec '(' simple-expression ')' statement
| foreach '(' mutable in simple-expression ')' statement
;
return-stmt: returnc ';'
| returnc expression ';'
;
break-stmt: breakc ';'
;

// 26
expression: mutable '=' expression 
| mutable '+=' expression 
| mutable '−=' expression
| mutable '++' 
| mutable '−−' 
| simple-expression
;
simple-expression: simple-expression or and-expression 
| and-expression
;
and-expression: and-expression and unary-rel-expression 
| unary-rel-expression
;
unary-rel-expression: not unary-rel-expression 
| rel-expression
;
rel-expression: sum-expression relop sum-expression 
| sum-expression
;
relop: '<' 
| '>' 
| '<='
| '>=' 
| '==' 
| '!='  // something maybe wrong here
;
sum-expression: sum-expression sumop term 
| term
;
sumop: '+' 
| '−'
;
term: term mulop unary-expression 
| unary-expression
;
mulop: '∗' 
| '/' 
| '%'
;
unary-expression: unaryop unary-expression 
| factor
;
unaryop: '−' 
| '∗'
;
factor: immutable 
| mutable
;
mutable: ID 
| ID '[' expression ']'
;
immutable: '(' expression ')'
| call 
| constant
;
call: ID '(' args ')'
;
args: arg-list 
| e
;
arg-list: arg-list ',' expression 
| expression
;
constant: NUMCONST 
| CHARCONST 
| STRINGCONST 
| truec 
| falsec
;

