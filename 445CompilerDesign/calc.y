%{ 
#include <stdio.h>
#include <stdlib.h>

#ifdef CPLUSPLUS
#include <string.h>
extern int yylex();
#endif

#define YYERROR_VERBOSE
#define TRUE 1
#define FALSE 0

int vars[26];

void yyerror(const char *msg)
{
      printf("ERROR(PARSER): %s\n", msg);
}
%}

%union {
        int lvalue;
        char *svalue;
        int varindex;
}

%token <lvalue> T
%token <lvalue> F
%token <varindex> NAME
%token <svalue> STRING
%token OR AND XOR IMPLIES NOT QUIT

%type <lvalue> assign
%type <lvalue> iterm
%type <lvalue> oterm
%type <lvalue> aterm
%type <lvalue> varortf
%%
statementlist : statement statementlist
              | statement 
              ;

statement : assign '\n'      { printf("ANS: %s\n", $1 ? "T" : "F");  }
          | QUIT '\n'        { exit(0); }
          ;

assign : NAME '=' assign     { vars[$1] = $3; $$ = $3; }
       | iterm               { $$ = $1; }
       ;

iterm : iterm IMPLIES oterm  { $$ = (1-$1) | $3; }
      | oterm                { $$ = $1; }
      ;

oterm: oterm OR aterm        { $$ = $1 | $3; }
     | oterm XOR aterm        { $$ = $1 ^ $3; }
     | aterm                  { $$ = $1; }
     ;

aterm : aterm AND varortf    { $$ = $1 & $3; }
     | varortf               { $$ = $1; }
     ;

varortf : T                  { $$ = $1; }
        | F                  { $$ = $1; }
        | NAME               { $$ = vars[$1]; }
        | STRING             { printf("%s\n", $1 ); $$=TRUE; }
        | '(' assign ')'     { $$ = $2; }
        | '(' assign '?' assign ':' assign ')' { $$ = ($2 ? $4 : $6); }
        | '(' assign '?' assign ')'             { $$ = ($2 ? $4 : FALSE); }
        | NOT varortf        { $$ =  (1-$2); }
        ;

%%
