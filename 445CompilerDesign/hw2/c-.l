%{

#include <string.h>  
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "scanType.h"
#include "c-.tab.h" 

int linnum;
int setValue(int linnum, int tokenClass, char * svalue);

%}
%%

"quit"                  {return setValue(linnum, QUIT, yytext);}
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
"("                     {return setValue(linnum, leftp, yytext);}
")"                     {return setValue(linnum, rightp, yytext);}
"{"                     {return setValue(linnum, leftp2, yytext);}
"}"                     {return setValue(linnum, rightp2, yytext);}
[\[]                    {return setValue(linnum, leftp3, yytext);}
[\]]                    {return setValue(linnum, rightp3, yytext);}
","                     {return setValue(linnum, comma, yytext);}
[:]                     {return setValue(linnum, colon, yytext);}
[\;]                    {return setValue(linnum, semicolon, yytext);}
[\+]                    {return setValue(linnum, plus, yytext);}
[\-]                    {return setValue(linnum, minus, yytext);}
[\*]                    {return setValue(linnum, multiply, yytext);}
[\/]                    {return setValue(linnum, divide, yytext);}
[\%]                    {return setValue(linnum, mod, yytext);}
[\<]                    {return setValue(linnum, lt, yytext);}
[\>]                    {return setValue(linnum, gt, yytext);}
"="                     {return setValue(linnum, equal, yytext);}
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
[ \t]                   ;
[\\][\*]                ; 
[\'][^\'][\']            {return setValue(linnum,CHARCONST, yytext);}
\"([^\"]*|[\\.]*)\"     {return setValue(linnum, STRINGCONST, yytext);}
"//"[^\n]*              ;
[\n]                    {++linnum;} 
.                       ;

%%

int setValue(int linnum, int tokenClass, char * svalue) {

   yylval.token = (Token*)malloc(sizeof(Token));
   yylval.token->tokenClass = tokenClass;
   yylval.token->linnum = linnum;
   yylval.token->tokenstr = svalue;

   switch (tokenClass) {
   case NUMCONST: 
       yylval.token->numValue = atoi((char *)yytext);
       break;
   }

   return tokenClass;
}
