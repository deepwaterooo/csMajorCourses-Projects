//
//  TM Code emitting utilities
//  implementation for the TINY compiler
//  Compiler Construction: Principles and Practice
//  Kenneth C. Louden
//  Modified slightly by Jorge L. Williams
//  Modified Apr 11, 2004 Robert Heckendorn
//
//  The two comment string forms of the calls allow you to easily
//  compose a comment from text and a symbol name for example.  This
//  code is compilable in plain C.  C++ people may want to change the
//  interface but this code will work for both users.
//

#include <stdio.h>
#include <stdlib.h>
//#include "globals.h"
#include "emitCode.h"

extern FILE * code; 

//  TM location number for current instruction emission
static int emitLoc = 0;


//  Highest TM location emitted so far
//   For use in conjunction with emitSkip,
//   emitBackup, and emitRestore
static int highEmitLoc = 0;


//  Procedure emitComment prints a comment line 
// with comment c in the code file
// 
void emitComment(char *c)
{
    if (TraceCode) fprintf(code, "* %s\n", c);
}


//  Procedure emitComment prints a comment line 
// with comment c in the code file
// 
void emitCommentLine(char *c, int lineno)
{
    if (TraceCode) fprintf(code, "* %s at line %d\n", c, lineno);
}


//  Procedure emitComment prints a comment line 
// with a comment that is the concatenation of c and d
// 
void emitComment2(char *c, char *cc)
{
  if (TraceCode) {fprintf(code, "* %s %s\n", c, cc); }
}


//  Procedure emitComment prints a comment line 
// with a comment that is the concatenation of c and d
// 
void emitComment2Line(char *c, char *cc, int lineno)
{
    if (TraceCode) fprintf(code, "* %s %s at line %d\n", c, cc, lineno);
}



// emitRO emits a register-only TM instruction
// op = the opcode
// r = target register
// s = 1st source register
// t = 2nd source register
// c = a comment to be printed if TraceCode is TRUE
// 
void emitRO2(char *op, int r, int s, int t, char *c, char *cc)
{
    fprintf(code, "%3d:  %5s  %d,%d,%d ", emitLoc++, op, r, s, t);
    if (TraceCode) fprintf(code, "\t%s %s", c, cc);
    fprintf(code, "\n");
    if (highEmitLoc<emitLoc) highEmitLoc = emitLoc;
}

void emitRO(char *op, int r, int s, int t, char *c)
{
    emitRO2(op, r, s, t, c, "");
}



// emitRM emits a register-to-memory TM instruction
// op = the opcode
// r = target register
// d = the offset
// s = the base register
// c = a comment to be printed if TraceCode is TRUE
// 
void emitRM2(char *op, int r, int d, int s, char *c, char *cc)
{
    fprintf(code, "%3d:  %5s  %d,%d(%d) ", emitLoc++, op, r, d, s);
    if (TraceCode) fprintf(code, "\t%s %s", c, cc);
    fprintf(code, "\n");
    if (highEmitLoc<emitLoc) highEmitLoc = emitLoc;
}

void emitRM(char *op, int r, int d, int s, char *c)
{
    emitRM2(op, r, d, s, c, "");
}


// allow concatenation of two strings


// emitRMAbs converts an absolute reference to local relative
// to a pc-relative reference when emitting a
// register-to-memory TM instruction
// op = the opcode
// r = target register
// a = the absolute location in memory
// c = a comment to be printed if TraceCode is TRUE
// 
void emitRMAbs2(char *op, int r, int a, char *c, char *cc)
{
    fprintf(code, "%3d:  %5s  %d,%d(%d) ", emitLoc, op, r, a - (emitLoc + 1),
	    PC);
    emitLoc++;
    if (TraceCode) fprintf(code, "\t%s %s", c, cc);
    fprintf(code, "\n");
    if (highEmitLoc<emitLoc) highEmitLoc = emitLoc;
}


void emitRMAbs(char *op, int r, int a, char *c)
{
    emitRMAbs2(op, r, a, c, "");
}


// 
//  Backpatching Functions
// 

// emitSkip skips "howMany" code
// locations for later backpatch. It also
// returns the current code position
// 
int emitSkip(int howMany)
{
    int i = emitLoc;
    emitLoc += howMany;
    if (highEmitLoc<emitLoc) highEmitLoc = emitLoc;

    return i;
}


// emitBackup backs up to 
// loc = a previously skipped location
// 
void emitBackup(int loc)
{
    if (loc>highEmitLoc) emitComment("BUG in emitBackup");
    emitLoc = loc;
}


// emitRestore restores the current 
// code position to the highest previously
// unemitted position
// 
void emitRestore(void)
{
    emitLoc = highEmitLoc;
}

