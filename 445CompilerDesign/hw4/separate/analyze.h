/****************************************************/ 
/* File: analyze.h                                  */ 
/* Semantic analyzer interface for c- compiler      */ 
/* Compiler Construction: Principles and Practice   */ 
/****************************************************/ 

#ifndef _ANALYZE_H_ 
#define _ANALYZE_H_ 
 
#include "globals.h"
#include "util.h"
#include "symtab.h"

int i = 0;
int cmpi = 0;
int funci = 0;
int ifi = 0;
int whilei = 0;
int opi = 0;
int assigni = 0;
bool ReturnFlag = false;
bool LoopFlag = false;
bool WhileFlag = false;
bool ForEachFlag = false;
int depthcnt = 0;

extern int numError; 
extern int numWarnings; 

// Function buildSymtab constructs the symbol table by preorder traversal of the syntax tree 
void insertCheckNode( TreeNode * t);
 
#endif 
