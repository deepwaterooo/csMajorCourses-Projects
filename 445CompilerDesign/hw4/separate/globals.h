/****************************************************/
/* File: globals.h                                  */
/* Global types and vars for TINY compiler          */
/* must come before other include files             */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#ifndef _GLOBALS_H_
#define _GLOBALS_H_

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include "c-.tab.h"

// Yacc/Bison version 
// Page 542
#ifndef YYPARSER
#include "c-.tab.h"

//ENDFILE is implicitly defined by Yacc/Bison, and not included in the tab.h file
#define ENDFILE 0
#endif
/*
#ifndef FALSE
#define FALSE 0
#endif

#ifndef TRUE
#define TRUE 1
#endif
*/

//#include <stdbool.h>
/* MAXRESERVED = the number of reserved words */
#define MAXRESERVED 8

/*typedef enum {
ENDFILE, QUIT, STATIC, INT, BOOL, CHAR, IF, ELSE, WHILE, FOREACH, IN, RETURN, BREAK, OR, AND, NOT, leftp, rightp, leftp2, rightp2, leftp3, rightp3, comma, colon, semicolon, plus, minus, multiply, divide, mod, lt, gt, equal, LEQ, GEQ, EQ, NEQ, PASSIGN, MASSIGN, INC, DEC, ID, NUMCONST, STRINGCONST, CHARCONST, TRUE, FALSE
} TokenType;*/

typedef int TokenType;
/*
extern FILE* source; /* source code text file 
extern FILE* listing; /* listing output text file 
extern FILE* code; /* code text file for TM simulator   */
extern int lineno; /* source line number for listing */

/**************************************************/
/***********   Syntax tree for parsing ************/
/**************************************************/
// page 505
typedef enum {DeclK, StmtK, ExpK} NodeKind; 
typedef enum {VarK, FuncK, ParamK} DeclKind;
typedef enum {IfK, WhileK, ForEachK, CompoundK, ReturnK, BreakK} StmtKind;
typedef enum {OpK, ConstantK, IdK, AssignK, CallK} ExpKind;
//typedef enum {Void, Interger, Boolean, Character, Undefined} ExpType;

#define MAXCHILDREN 3
typedef struct treeNode {
  struct treeNode *child[MAXCHILDREN];   // children of the node
  struct treeNode *sibling;              // siblings for the node
  int linnum;                       // linenum relevant to this node
  NodeKind nodekind;     // type of node
  union {                            // subtype of type 
    DeclKind decl;             // used when DeclK
    StmtKind stmt;           // used when StmtK
    ExpKind exp;               // used when ExpK
  } kind;
  union {                           // relevant data to type -> attr
    TokenType op;           // type of token (same as in bison)  
    int val;                         // used when an NUMCONST
    char *name;               // used when IdK
  } attr;                                 
  char *string;              // used when a STRINGCONST
  ExpType expType;      // used when ExpK for type checking
  bool isStatic;               // is staticly allocated?
  bool isArray;                // is this an array
  bool isConstant;         // can this expression be precomputed?
} TreeNode;


/**************************************************/
/***********   Flags for tracing       ************/
/**************************************************/
/* EchoSource = TRUE causes the source program to
 * be echoed to the listing file with line numbers
 * during parsing

extern int EchoSource;

/* TraceScan = TRUE causes token information to be
 * printed to the listing file as each token is
 * recognized by the scanner
extern int TraceScan;

/* TraceParse = TRUE causes the syntax tree to be
 * printed to the listing file in linearized form
 * (using indents for children)
extern int TraceParse;

/* TraceAnalyze = TRUE causes symbol table inserts
 * and lookups to be reported to the listing file
extern int TraceAnalyze;

/* TraceCode = TRUE causes comments to be written
 * to the TM code file as code is generated
extern int TraceCode;

/* Error = TRUE prevents further passes if an error occurs 
extern int Error; 

*/
#endif
