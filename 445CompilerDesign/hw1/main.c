// main.c

#include <stdio.h>
#include <stdlib.h>
#include "scanType.h"
//#include "c.tab.h"

extern FILE* yyin;
extern char *yytext;
char *yyfilename;

extern int yylex();
extern int yyparse();
extern int yylineno;
extern int yyntokens;
extern int errlnum;
extern int yydebug;

#define YY_DECL extern "C" int yylex()

void yyerror(const char* s);

int main(int argc, char* argv[]){
  int i;
  yydebug = 1;

  if (argc < 2) {
    printf("Usage: c- TestFileName\n");
    exit(-1);
  }
  yyin = fopen(argv[1], "r");

  if (yyin == NULL){
    printf("Can't open/read '%s'\n", argv[1]);
    exit(-1);
  }

  yyfilename = argv[1];
  yylineno = 0;

  if (yyparse() != 0){
    printf("Parse failed!!!\n");
  } else
    printf("No errors on %d line(s) in with %d tokens.\n", yylineno, yyntokens);

  return 0;
}

void yyerror(const char* s){
  fprintf(stderr, "%s in line %d in token %s\n", s, errlnum, yytext);
  exit(-1);
}
