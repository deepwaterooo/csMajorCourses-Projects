#ifndef _UTIL_H_
#define _UTIL_H_

extern int linnum;

TreeNode* newDeclNode (DeclKind);
TreeNode* newStmtNode (StmtKind);
TreeNode* newExpNode (ExpKind);
char * copyString( char * s);
char* getType(int x);
void printTree( TreeNode * );

#endif

