%{
#include <stdlib.h> /*For malloc in symbol table*/
#include <string.h> /*For strcmp in symbol table*/
#include <stdio.h> /*For error message */
#include "ST.h"  /* The Symbol Table Module */
#define YYDEBUG 1 /*For debugging */

install ( char *sym_name)
{
  symrec *s;
  s = getsym (sym_name);
  if (s==0)
    s = putsym (sym_name);
  else{errors++;
    printf ( "%s is already defined/n",sym_name);
  }
 }

context_check( char *sym_name)
{
  if ( getsym( sym_name ) == 0)
    printf( "%s is an undeclared identifier/n",sym_name);
}

%}

Parser declarations

%%

Grammar rules and actions

%%

C subroutines
