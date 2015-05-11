%{

#include <string.h>  
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "scanType.h"
#include "c-.tab.h"

#define MAXTOKENLEN 40
char tokenString[MAXTOKENLEN+1];

int linnum;
int setValue(int linnum, int tokenClass, char * svalue);

%}

%%

"static"                {return setValue(linnum, STATIC, yytext);}
"int"                   {return setValue(linnum, INT, yytext);}
"bool"                  {return setValue(linnum, BOOL, yytext);}
"char"                  {return setValue(linnum, CHAR, yytext);}
"if"                    {return setValue(linnum, IF, yytext);}
"else"                  {return setValue(linnum, ELSE, yytext);}
"while"                 {return setValue(linnum, WHILE, yytext);}
"foreach"               {return setValue(linnum, FOREACH, yytext);}
"in"                    {return setValue(linnum, IN, yytext);}
"return"                {return setValue(linnum, RETURN, yytext);}
"break"                 {return setValue(linnum, BREAK, yytext);}
"or"                    {return setValue(linnum, OR, yytext);}
"and"                   {return setValue(linnum, AND, yytext);}
"not"                   {return setValue(linnum, NOT, yytext);}
"true"                  {return setValue(linnum, TRUE, yytext);}
"false"                 {return setValue(linnum, FALSE, yytext);}
"<="                    {return setValue(linnum, LEQ, yytext);}
">="                    {return setValue(linnum, GEQ, yytext);}
"=="                    {return setValue(linnum, EQ, yytext);}
"!="                    {return setValue(linnum, NEQ,  yytext);}
"+="                    {return setValue(linnum, PASSIGN, yytext);}
"-="                    {return setValue(linnum, MASSIGN, yytext);}
"++"                    {return setValue(linnum, INC, yytext);}
"--"                    {return setValue(linnum, DEC, yytext);}
[0-9]+                  {return setValue(linnum, NUMCONST, yytext);}
[a-zA-Z][0-9a-zA-Z_]*   {return setValue(linnum, ID, yytext);}
\'[^\']\'               {return setValue(linnum, CHARCONST, yytext);}
\"([^\"]*|[\\.]*)\"     {return setValue(linnum, STRINGCONST, yytext);}
[ \t]                   ;
"//"[^\n]*              ;
[\n]                    {++linnum;} 
.                       {return setValue(linnum, yytext[0], yytext);}

%%

int setValue(int linnum, int tokenClass, char * svalue) {
  yylval.tokenData = (TokenData*)malloc(sizeof(TokenData));
  yylval.tokenData->tokenClass = tokenClass;
  yylval.tokenData->linnum = linnum;
  yylval.tokenData->tokenstr = strdup(svalue);
  strncpy(tokenString, svalue, MAXTOKENLEN);

  switch (tokenClass) {
  case NUMCONST: 
    yylval.tokenData->iValue = atoi((char *)yytext);
    break;
  }
  return tokenClass;
}
/*
TokenType getToken(void){
  static int firstTime = TRUE;
  TokenType currentToken;
  if (firstTime){
    firstTime = FALSE;
    linnum++;
    yyin = source;
    yyout = listing;
  }
  currentToken = yylex();
  strncpy(tokenString, yytext,MAXTOKENLEN);
  if (TraceScan){
    fprintf(listing, "\t%d", linnum);
    printToken(currentToken, tokenString);
  }
  } 
*/
