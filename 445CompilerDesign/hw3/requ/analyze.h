/****************************************************/ 
/* File: analyze.h                                  */ 
/* Semantic analyzer interface for c- compiler      */ 
/* Compiler Construction: Principles and Practice   */ 
/****************************************************/ 

#ifndef _ANALYZE_H_ 
#define _ANALYZE_H_ 
 
// Function buildSymtab constructs the symbol table by preorder traversal of the syntax tree 
void buildSymtab( TreeNode* ); 
 
// Procedure typeCheck performs type checking by a postorder syntax tree traversal 
void typeCheck( void*); 
 
#endif 
