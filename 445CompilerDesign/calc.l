%{ 
#include <stdlib.h>
#include "calc.tab.h"

%}

%option yylineno
 
%%
[Tt] {yylval.lvalue = 1; return T; }
[Ff] {yylval.lvalue = 0; return F; }
\"[^\"]*\" {yylval.svalue = strdup(yytext); return STRING; }
"or" { return OR; }
"and" { return AND; }
"xor" { return XOR; }
"not" { return NOT; }
"implies"   { return IMPLIES; }
"quit" { return QUIT; }
"exit" { return QUIT; }

[a-z]  {yylval.varindex = yytext[0] - 'a'; return NAME; }
[ \t]  ;
\n   { return yytext[0]; }
.    { return yytext[0]; }
%%
