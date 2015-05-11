//
//  TM Code emitting utilities
//  implementation for the TINY compiler
//  Compiler Construction: Principles and Practice
//  Kenneth C. Louden
//  Modified slightly by Jorge L. Williams
//  Modified Apr 11, 2004 Robert Heckendorn
//  Modified May 1, 2006 Jeremy Scott to use variable argument lists
//
// 
// This version of the emitcode takes a variable number of arguments for
// more flexible comment strings.
// 
// It can be called just like printf.  For example:
// 
// emitRO(<assembly command args>, "here is %s with %d arguments", 
//    "a format string", 2);
// 
// or
// 
// emitComment("BEGIN function %s declaration (offset %d, framesize %d, 
//    line %d)", node->id, node->offset, node->size, node->lineNumber);
// 
// There are #define macros to emulate the old emit*2 functions.
// 
// 
// 

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "emitcodeVarg.h"

extern FILE *code;


//  TM location number for current instruction emission
static int emitLoc = 0;


//  Highest TM location emitted so far
//   For use in conjunction with emitSkip,
//   emitBackup, and emitRestore
static int highEmitLoc = 0;


//  Procedure emitComment prints a comment line 
// with comment c in the code file

void emitComment(char *c, ...)
{
    if (TraceCode)
    	{
	    va_list args;
	    fprintf(code, "* ");
	    va_start(args, c);
	    vfprintf(code, c, args);
	    fprintf(code, "\n");
    	}
}


// emitRO emits a register-only TM instruction
// op = the opcode
// r = target register
// s = 1st source register
// t = 2nd source register
// c = a comment to be printed if TraceCode is TRUE
// 
void emitRO(char *op, int r, int s, int t, char *c, ...)
{
	
    fprintf(code, "%3d:  %5s  %d,%d,%d", emitLoc++, op, r, s, t);
    if (TraceCode)
    	{
	    va_list args;
	    va_start(args, c);
	    fprintf(code, "\t");
	    vfprintf(code, c, args);
		}
    fprintf(code, "\n");
    if (highEmitLoc<emitLoc) highEmitLoc = emitLoc;
}


// emitRM emits a register-to-memory TM instruction
// op = the opcode
// r = target register
// d = the offset
// s = the base register
// c = a comment to be printed if TraceCode is TRUE
// 
void emitRM(char *op, int r, int d, int s, char *c, ...)
{
    fprintf(code, "%3d:  %5s  %d,%d(%d) ", emitLoc++, op, r, d, s);
    if (TraceCode)
    	{
	    va_list args;
	    fprintf(code, "\t"),
	    va_start(args, c);
	    vfprintf(code, c, args);
    	}
    fprintf(code, "\n");
    if (highEmitLoc<emitLoc) highEmitLoc = emitLoc;
}


// emitRMAbs converts an absolute reference to local relative
// to a pc-relative reference when emitting a
// register-to-memory TM instruction
// op = the opcode
// r = target register
// a = the absolute location in memory
// c = a comment to be printed if TraceCode is TRUE
// 
void emitRMAbs(char *op, int r, int a, char *c, ...)
{
    fprintf(code, "%3d:  %5s  %d,%d(%d) ", emitLoc, op, r, a - (emitLoc + 1),
	    PC);
    emitLoc++;
    if (TraceCode)
    	{
	    va_list args;
	    fprintf(code, "\t"),
	    va_start(args, c);
	    vfprintf(code, c, args);
    	}
    fprintf(code, "\n");
    if (highEmitLoc<emitLoc) highEmitLoc = emitLoc;
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
