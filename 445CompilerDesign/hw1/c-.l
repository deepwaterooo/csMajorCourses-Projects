%{

#include <string.h>  
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "scanType.h"
#include "c.tab.h" 

static int linnum = 1

%}

void setValue(int linnum, int tokenClass, char * svalue)
   yylval.tokenData = new TokenData;

   yylval.tokenData->tokenClass = tokenClass;
   yylval.tokenData->linnum = linnum;
   yylval.tokenData->tokenstr = svalue;

   switch(tokenClass){
      case NUMCONST:
         yylval.tokenData->numvalue = atol(svalue);  /* convert string to long integer */
      case ID:
         yylval.tokenData->Idvalue = svalue - 'a';
    }
}

%%

"quit"                  {return setValue(linnum, QUIT, yytext);}
"static"                {return stat;}
"int"                   {return intc;}
"bool"                  {return bool;}
"char"                  {return charc;}
"if"                    {return ifc;}
"else"                  {return elsec;}
"while"                 {return whilec;}
"foreach"               {return foreach;}
"in"                    {return in;}
"return"                {return returnc;}
"break"                 {return breakc;}
"or"                    {return or;}
"and"                   {return and;}
"not"                   {return not;}
"true"                  {return truec;}
"false"                 {return falsec;}
"void"                  {return voidc;}

"{"                     {return '{';}
"}"                     {return '}';}
"("                     {return '(';}
")"                     {return ')';}
","                     {return ',';}
":"                     {return ':';}
";"                     {return ';';}
"+"                     {return '+';}
"-"                     {return '-';}
"*"                     {return '*';}
"/"                     {return '/';}
"%"                     {return '%';}
"<"                     {return '<';}
">"                     {return '>';}
"="                     {return '=';}

[(<=)]                  {return lteq;}
[(>=)]                  {return gteq;}
[(==)]                  {return equ;}
[(!=)]                  {return nequ;}
[(+=)]                  {return pleq;}
[(-=)]                  {return mieq;}

[a-zA-Z][0-9a-zA-Z_]*   {return setValue(linnum, ID, yytext);}
[0-9]+                  {return setValue(linnum, NUMCONST, yytext);}
[\t]                    ;
[\\][\*]                ;  /*{return setValue(linnum, yytext, yytext);}*/
[\'][^'][\']            {return setValue(linnum, CHARCONST, yytext);}
[\\\"]0+[^\\]*[\\][\\]+[^\\]*[\\\"] {return setValue(linnum, STRINGCONST, yytext);}

[ \n]                   {linnum++;}
"//"[^\n]*[\n]          ; 

%%
