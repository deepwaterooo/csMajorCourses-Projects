struct symrec
{
  char * name;         /*name of symbol*/
  struct symrec *next; /*link field*/
};
typedef struct symrec symrec;

symrec *sym_table = (symrec *)0;
symrec *putsym();
symrec *getsym();

symrec* putsym ( char *sym_name) /*Í·²åÈë*/
{
  symrec *ptr;
  ptr = (symrec *)malloc(sizeof(symrec));
  ptr -> name =(char *)malloc(strlen(stm_name)+1);
  strcpy(ptr->name,sym_name);
  ptr->next = (struct symrec *)sym_table;
  sym_table = ptr;
  return ptr;
}

symrec *getsym ( char *sym_name)
{
  symrec *ptr;
  for ( ptr=sym_table; ptr!=(symrec *)0; ptr = (symrec *)ptr->next )
    if(strcmp(ptr->name,sym_name)==0)
      return ptr;
  return 0;
}
