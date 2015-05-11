#ifndef YYERROR_H
#define YYERROR_H

#include <string.h>
#include "symtab.h"
#include "mystrings.h"

void initYyerror();
void yyerror(const char *msg);

#endif
