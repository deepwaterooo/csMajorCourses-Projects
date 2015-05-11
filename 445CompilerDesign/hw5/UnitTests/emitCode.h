#ifndef EMIT_CODE_H__
#define EMIT_CODE_H__

//  Special register defines for optional use in calling the 
//  routines below.

#define GP   0	//  The global pointer
#define FP   1	//  The local frame pointer
#define RT   2	//  Return value
#define AC   3  //  Accumulator
#define AC1  4  //  Accumulator
#define AC2  5  //  Accumulator
#define AC3  6  //  Accumulator
#define PC   7	//  The program counter

//  No comment please...

#define NO_COMMENT ""


//  We always trace the code
#define TraceCode   1

//  The following functions were borrowed from Tiny compiler code generator
void emitComment(char *c);
void emitCommentLine(char *c, int lineno);
void emitComment2(char *c, char *cc);
void emitComment2Line(char *c, char *cc, int lineno);

void emitRO2(char *op, int r, int s, int t, char *c, char *cc);
void emitRO(char *op, int r, int s, int t, char *c);

void emitRM2(char *op, int r, int d, int s, char *c, char *cc);
void emitRM(char *op, int r, int d, int s, char *c);

void emitRMAbs2(char *op, int r, int a, char *c, char *cc);
void emitRMAbs(char *op, int r, int a, char *c);

int emitSkip(int howMany);
void emitBackup(int loc);
void emitRestore(void);

#endif






