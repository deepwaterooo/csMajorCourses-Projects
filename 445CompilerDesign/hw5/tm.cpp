======================================================================
 TM 2.7 - A virtual machine for CS445
    plus
 A Description of the Execution Environment for C-

Nov 3, 2010  Robert Heckendorn
======================================================================


DATA LAYOUT
-----------

8 registers:  0-7 
 register 7 is the program counter and is denoted PC below 
 All registers are initialized to 0.

iMem instruction memory
  each memory location contains both an instruction and a comment.  The
     comment is very useful in debugging!
  iMem is initialized to Halt instructions and the comment: "* initially empty"

dMem data memory
 dMem[0] is initialized with the address of the last element in dMem.
 The rest of dMem is zeroed. 

REGISTER ONLY INSTRUCTIONS  (RO instructions)
--------------------------------------------
HALT           stop execution (all registers ignored)

IN r           reg[r] <- input integer value of register r from stdin
OUT r          reg[r] -> output integer value of register r to stdout
INB r          reg[r] <- input boolean value of register r from stdin
OUTB r         reg[r] -> output boolean value of register r to stdout
OUTNL                    output a newline to stdout

ADD r, s, t    reg[r] = reg[s] + reg[t]
SUB r, s, t    reg[r] = reg[s] - reg[t]
MUL r, s, t    reg[r] = reg[s] * reg[t]
DIV r, s, t    reg[r] = reg[s] / reg[t]

REGISTER TO MEMORY INSTRUCTIONS  (RM instructions)
--------------------------------------------
LDC r, d(x)    reg[r] = d                    (immediate; x ignored)
LDA r, d(s)    reg[r] = d + reg[s]           (direct)
LD  r, d(s)    reg[r] = dMem[d + reg[s]]     (indirect)

ST  r, d(s)    dMem[d + reg[s]] = reg[r]

JLT r, d(s)    if reg[r]<0 reg[PC] = d + reg[s]
JLE r, d(s)    if reg[r]<=0 reg[PC] = d + reg[s] 
JEQ r, d(s)    if reg[r]==0 reg[PC] = d + reg[s] 
JNE r, d(s)    if reg[r]!=0 reg[PC] = d + reg[s]
JGE r, d(s)    if reg[r]>=0 reg[PC] = d + reg[s]
JGT r, d(s)    if reg[r]>0 reg[PC] = d + reg[s]


SOME TM IDIOMS
--------------

1. reg[r]++:

  LDA r, 1(r)

2. reg[r] = reg[r] + d: 
 
  LDA r, d(r)

3. reg[r] = reg[s]

  LDA r, 0(s)

4. goto reg[r] + d
 
  LDA 7, d(r)

5. goto relative to pc  (d is number of instructions skipped)

  LDA 7, d(7)

6. NOOP:

  LDA r, 0(r)

7. save address of following command for return in reg[r] 

  LDA r, 1(7)



TM EXECUTION
------------

This is how execution actually works: 
    pc <- reg[7]
    test pc in range
    reg[7] <- pc+1
    inst <- fetch(pc)
    exec(inst)

Notice that at the head of the execution loop above reg[7] points
to the instruction BEFORE the one about to be executed.  Then
the first thing the loop will do is increment the PC.  During
an instruction execution the PC points at the instruction executing.

So LDA 7, 0(7)   does nothing but because it leaves pointer at next instr
So LDA 7, -1(7) is infinite loop


TM COMMANDS (v2.4) 
------------------
Commands are:
 a(bortLimit <<n>> Maximum number of instructions between halts (default=5000).
 b(reakpoint <<n>> Set a breakpoint for instr n.  No n means clear breakpoints.
 c(lear            Reset simulator for new execution of program
 d(Mem <b <n>>     Print n dMem locations starting at b 
                    (n can be negative to count up, defaults to last values used)
 e(xecStats        Print execution statistics since last load or clear
 g(o               Execute TM instructions until HALT
 h(elp             Cause this list of commands to be printed
 i(Mem <b <n>>     Print n iMem locations starting at b
 l(oad filename    Load filename into memory (default is last file)
 n(ext             Print the next command that will be executed
 p(rint            Toggle printing of total instructions executed ('go' only)
 q(uit             Terminate the simulation
 r(egs             Print the contents of the registers
 s(tep <n>         Execute n (default 1) TM instructions
 t(race            Toggle instruction trace
 u(nprompt)        Unprompted for script input
 x(it              Terminate the simulation
 = <r> <n>         Set register number r to value n (e.g. set the pc)
 (empty line)      does a step like the s command
Also a # character placed after input will cause TM to halt
  after processing the IN or INB commands (e.g. 34#  or f# )  That way you
  can step after input without setting a breakpoint


INSTRUCTION INPUT
-----------------
Instructions are input via the the load command.
There commands look like:

address: cmd r,s,t comment

or

address: cmd r,d(s) comment

or 

* comment

For example:

 39:    ADD  3,4,3 	op + 
* Add standard closing in case there is no return statement
 65:    LDC  2,0(6) 	Set return value to 0 
 66:     LD  3,-1(1) 	Load return address 
 67:     LD  1,0(1) 	Adjust fp 
 68:    LDA  7,0(3) 	Return 


======================================================================
 A Description of the Execution Environment for C-
======================================================================

THE TM REGISTERS 
----------------
These are the assigned registers for our virtual machine.  Only register
7 is actually configured by the "hardware" to be what it is defined below.
The rest is whatever we have made it to be.

0 - global pointer (points to the frame for global variables)
1 - the local frame pointer (initially right after the globals)
2 - return value from a function (set at end of function call)
3,4,5,6 - accumulators
7 - the program counter or pc (used by TM)


======================================================================
 Memory Layout
======================================================================



THE STACK LAYOUT
----------------

This is how the globals, frames and heap (which we don't have)
are laid out:

           +---------------------------------------+  high addresses
globals -> |  globals                              |
           |                                       |
           +---------------------------------------+
frame 1 -> |  locals                               |
           |                                       |
           +---------------------------------------+
           |  temps                                |
           +---------------------------------------+
frame 2 -> |  locals                               |
           |                                       |
           +---------------------------------------+
           |  temps                                |
           +---------------------------------------+
reg 1  --> |  locals                               |
           |                                       |
           +---------------------------------------+
           |  temps                                |
           +---------------------------------------+
           |                                       |
           |            free space                 |
           |                                       |
                            .
                            .
                            .
           |                                       |
           |    (heap would go here)               |
           +---------------------------------------+  0 (low addresses)

IMPORTANT: note that the stack GROWS DOWN in memory addressing.  This
copies the books implementation.


        
THE FRAME LAYOUT
----------------

Frames for procedures are laid out as follows:

        +---------------------------------------+
reg1 -> | old frame pointer (old reg1)          |  loc
        +---------------------------------------+
        | add of instr to execute upon return   |  loc-1
        +---------------------------------------+
        | parm 1                                |  loc-2
        +---------------------------------------+
        | parm 2                                |  loc-3
        +---------------------------------------+
        | parm 3                                |  loc-4
        +---------------------------------------+
        | local var 1                           |  loc-5
        +---------------------------------------+
        | local var 2                           |  loc-6
        +---------------------------------------+
        | local var 3                           |  loc-7
        +---------------------------------------+
        | temp var 1                            |  loc-8
        +---------------------------------------+
        | temp var 2                            |  loc-9
        +---------------------------------------+

* the first two values (old frame pointer, return addr) allow us
to recover our place in iMem and dMem when we return from this call.
* parms are parameters for the function.
* locals are locals in the function both defined at the beginning
of the procedure and in compound statements inside the procedure.
Note that we can save space by overlaying nonconcurrent compound
statement scopes.
* temps are used to stretch the meager number of registers we have.
For example in doing (3+4)*(5+6)+7 we may need more temps than we have.

======================================================================
 Some Bits of Code to Generate
======================================================================

GENERATING CODE
---------------

COMPILE TIME VARIABLES

These are variables you might use when computing where things go in
memory.

goffset - the global offset is the relative offset of the next
available space in the global space

foffset - the frame offset is the relative offset of the next
available space in the stack.

toffset - the temp offset is the offset from the frame offset of the
next available temp variable.  This can be done with just the
foffset but I like the clarity of having it.

offset = foffset+toffset and is the current size of the frame

IMPORTANT: that THESE VALUES WILL BE NEGATIVE since memory is growing
downward to lower addresses in this implementation.


PROLOG CODE
-----------

This is the code that is called at the beginning of the program.  When
the machine begins to run your code it will start at adress 0.  The
instruction we put there is one that jumps to the end of the code
where the initialization code is placed.  This is generated after all
the compiled code is created.  That way we know everything we need
initialize and then we emit the initialization code.

The initialization code sets up registers 0 and 1 and jumps to main.
And returning from main halts the program.  Note that the global array
initialization assumes that an array named z of size 20 appears in
this program.

  0:    LDA  7,63(7)    Jump to init  <-- this is backpatched in at the end

* BEGIN Init
 64:     LD  0,0(0)     Set the global pointer 
* BEGIN init of global array sizes 
 65:    LDC  3,20(6)    load size of array z
 66:     ST  3,0(0)     save size of array z
* END init of global array sizes
 67:    LDA  1,-21(0)   set first frame at end of globals 
 68:     ST  1,0(1)     store old fp (point to self) 
 69:    LDA  3,1(7)     Return address in ac 
 70:    LDA  7,-19(7)   Jump to main 
 71:   HALT  0,0,0      DONE! 
* END Init


CALLING SEQUENCE (caller)  [version 1]
-------------------------
At this point:
reg1 points to the old frame
off in compiler offset to first available space on stack
     relative to the beginning of the frame
foffset in compiler offset to first available parameter
     relative to top of stack


* figure where the new local frame will go
LDA 3, off(1)   * where is top of stack

* load the first parameter
LD  4, var1(1)  * load in third temp
ST  4, foffset(3)  * store in parameter space (foffset++)

* load the second parameter
LD  4, var2(1)     * load in third temp
ST  4, foffset(3)  * store in parameter space 

* begin call
ST  1, 0(3)        * store old fp in ghost frame
LDA 1, 0(3)        * move the fp to the new frame 
LDA 3, 1(7)        * compute the return address at (skip 1 ahead)
LDA 7, func(7)     * call func
* return to here 

At this point:
reg1 points to the new frame (top of old local stack)
reg2 has the return value from the function
reg3 contains return address in code space
reg7 points to the next instruction to execute



CALLING SEQUENCE (caller)  [version 2]
-------------------------
At this point:
reg1 points to the old frame
off in compiler offset to first available space on stack
     relative to the beginning of the frame
foffset in compiler offset to first available parameter
     relative to the beginning of the frame

ST  1, off(1)   * save old frame pointer at first part of new frame

* load the first parameter
LD  4, var1(1)  * load in third temp
ST  4, foffset(1)  * store in parameter space (foffset++)

* load the second parameter
LD  4, var2(1)  * load in third temp
ST  4, foffset(1)  * store in parameter space 

* begin call
LDA 1, off(1)   * move the fp to the new frame 
LDA 3, 1(7)     * compute the return address at (skip 1 ahead)
LDA 7, func(7)  * call func
* return to here 

At this point:
reg1 points to the new frame (top of old local stack)
reg2 has the return value from the function
reg3 contains return address in code space
reg7 points to the next instruction to execute



CALLING SEQUENCE (callee's prolog)
----------------------------------
It is the callee's responsibility to save the return address.  An
optimization is to not do this if you can preserve reg3 throughout the
call.

ST  3, -1(1)    * save return addr in current frame
 
 
RETURN
------

* save return value
LDA 2, 0(x)   * load the function return (reg2) with the answer from regx 

* begin return
LD  3, -1(1)  * recover old pc 
LD  1, 0(1)   * pop the frame 
LDA 7, 0(3)   * jump to old pc
 


LOAD CONSTANT
-------------
LCD 3, const(0)


RHS LOCAL VAR SCALAR
-------------------- 
LD  3, var(1) 


RHS GLOBAL VAR SCALAR
-------------------- 
LD  3, var(0) 


LHS LOCAL VAR SCALAR
--------------------
LDA 3, var(1)


RHS LOCAL ARRAY
---------------
LDA 3, var(1)    * array base 
SUB 3, 4         * index off of the base (note: stack grows down)
LD  3, 0(3)      * access the element


LHS LOCAL ARRAY
---------------
LDA 3, var(1)    * array base
SUB 3, 4         * index off of the base
ST  x, 0(3)      * store in array


======================================================================
 EXAMPLE 1: A Simple C- Program Compiled
======================================================================

THE CODE
--------

# C-F07
int dog(int x)
{
	int y;
	int z;

	y = x*111+222;
	z = y;

	return z;
}

void main()
{
	dog(666);
}



THE OBJECT CODE
---------------

* C- compiler version C-F07
* Author: Robert B. Heckendorn
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  z.c-
* Nov 29, 2007
* BEGIN function input
  1:     ST  3,-1(1)    Store return address 
  2:     IN  2,2,2      Grab int input 
  3:     LD  3,-1(1)    Load return address 
  4:     LD  1,0(1)     Adjust fp 
  5:    LDA  7,0(3)     Return 
* END of function input
* BEGIN function output
  6:     ST  3,-1(1)    Store return address 
  7:     LD  3,-2(1)    Load parameter 
  8:    OUT  3,3,3      Output integer 
  9:    LDC  2,0(6)     Set return to 0 
 10:     LD  3,-1(1)    Load return address 
 11:     LD  1,0(1)     Adjust fp 
 12:    LDA  7,0(3)     Return 
* END of function output
* BEGIN function inputb
 13:     ST  3,-1(1)    Store return address 
 14:    INB  2,2,2      Grab bool input 
 15:     LD  3,-1(1)    Load return address 
 16:     LD  1,0(1)     Adjust fp 
 17:    LDA  7,0(3)     Return 
* END of function inputb
* BEGIN function outputb
 18:     ST  3,-1(1)    Store return address 
 19:     LD  3,-2(1)    Load parameter 
 20:   OUTB  3,3,3      Output bool 
 21:    LDC  2,0(6)     Set return to 0 
 22:     LD  3,-1(1)    Load return address 
 23:     LD  1,0(1)     Adjust fp 
 24:    LDA  7,0(3)     Return 
* END of function outputb
* BEGIN function outnl
 25:     ST  3,-1(1)    Store return address 
 26:  OUTNL  3,3,3      Output a newline 
 27:     LD  3,-1(1)    Load return address 
 28:     LD  1,0(1)     Adjust fp 
 29:    LDA  7,0(3)     Return 
* END of function outnl
* BEGIN function dog
 30:     ST  3,-1(1)    Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:     LD  3,-2(1)    Load variable x
 32:     ST  3,-5(1)    Save left side 
 33:    LDC  3,111(6)   Load constant 
 34:     LD  4,-5(1)    Load left into ac1 
 35:    MUL  3,4,3      Op * 
 36:     ST  3,-5(1)    Save left side 
 37:    LDC  3,222(6)   Load constant 
 38:     LD  4,-5(1)    Load left into ac1 
 39:    ADD  3,4,3      Op + 
 40:     ST  3,-3(1)    Store variable y
* EXPRESSION STMT
 41:     LD  3,-3(1)    Load variable y
 42:     ST  3,-4(1)    Store variable z
* RETURN
 43:     LD  3,-4(1)    Load variable z
 44:    LDA  2,0(3)     Copy result to rt register 
 45:     LD  3,-1(1)    Load return address 
 46:     LD  1,0(1)     Adjust fp 
 47:    LDA  7,0(3)     Return 
* END compound statement
* Add standard closing in case there is no return statement
 48:    LDC  2,0(6)     Set return value to 0 
 49:     LD  3,-1(1)    Load return address 
 50:     LD  1,0(1)     Adjust fp 
 51:    LDA  7,0(3)     Return 
* END of function dog
* BEGIN function main
 52:     ST  3,-1(1)    Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 53:     ST  1,-2(1)    Store old fp in ghost frame 
 54:    LDC  3,666(6)   Load constant 
 55:     ST  3,-4(1)    Store parameter 
 56:    LDA  1,-2(1)    Load address of new frame 
 57:    LDA  3,1(7)     Return address in ac 
 58:    LDA  7,-29(7)   call dog
 59:    LDA  3,0(2)     Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 60:    LDC  2,0(6)     Set return value to 0 
 61:     LD  3,-1(1)    Load return address 
 62:     LD  1,0(1)     Adjust fp 
 63:    LDA  7,0(3)     Return 
* END of function main
  0:    LDA  7,63(7)    Jump to init 
* BEGIN Init
 64:     LD  0,0(0)     Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 65:    LDA  1,0(0)     set first frame at end of globals 
 66:     ST  1,0(1)     store old fp (point to self) 
 67:    LDA  3,1(7)     Return address in ac 
 68:    LDA  7,-17(7)   Jump to main 
 69:   HALT  0,0,0      DONE! 
* END Init


======================================================================
 EXAMPLE 2: A Simple C- Program Compiled
======================================================================

THE CODE
--------
# C-F07
# A program to perform Euclid's
#   Algorithm to compute gcd of two numbers you give.

int gcd(int u, v)
{
    if (v == 0) return u;
    else return gcd(v, u - u/v*v);
}

void main()
{
    int x, y;

    x = input();
    y = input();
    output(gcd(x, y));
}



THE OBJECT CODE
---------------

* C- compiler version C-F07
* Author: Robert B. Heckendorn
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  z.c-
* Nov 29, 2007
* BEGIN function input
  1:     ST  3,-1(1)    Store return address 
  2:     IN  2,2,2      Grab int input 
  3:     LD  3,-1(1)    Load return address 
  4:     LD  1,0(1)     Adjust fp 
  5:    LDA  7,0(3)     Return 
* END of function input
* BEGIN function output
  6:     ST  3,-1(1)    Store return address 
  7:     LD  3,-2(1)    Load parameter 
  8:    OUT  3,3,3      Output integer 
  9:    LDC  2,0(6)     Set return to 0 
 10:     LD  3,-1(1)    Load return address 
 11:     LD  1,0(1)     Adjust fp 
 12:    LDA  7,0(3)     Return 
* END of function output
* BEGIN function inputb
 13:     ST  3,-1(1)    Store return address 
 14:    INB  2,2,2      Grab bool input 
 15:     LD  3,-1(1)    Load return address 
 16:     LD  1,0(1)     Adjust fp 
 17:    LDA  7,0(3)     Return 
* END of function inputb
* BEGIN function outputb
 18:     ST  3,-1(1)    Store return address 
 19:     LD  3,-2(1)    Load parameter 
 20:   OUTB  3,3,3      Output bool 
 21:    LDC  2,0(6)     Set return to 0 
 22:     LD  3,-1(1)    Load return address 
 23:     LD  1,0(1)     Adjust fp 
 24:    LDA  7,0(3)     Return 
* END of function outputb
* BEGIN function outnl
 25:     ST  3,-1(1)    Store return address 
 26:  OUTNL  3,3,3      Output a newline 
 27:     LD  3,-1(1)    Load return address 
 28:     LD  1,0(1)     Adjust fp 
 29:    LDA  7,0(3)     Return 
* END of function outnl
* BEGIN function gcd
 30:     ST  3,-1(1)    Store return address. 
* BEGIN compound statement
* IF
 31:     LD  3,-3(1)    Load variable v
 32:     ST  3,-4(1)    Save left side 
 33:    LDC  3,0(6)     Load constant 
 34:     LD  4,-4(1)    Load left into ac1 
 35:    SUB  4,4,3      Op == 
 36:    LDC  3,1(6)     True case 
 37:    JEQ  4,1(7)     Jump if true 
 38:    LDC  3,0(6)     False case 
 39:    LDC  4,1(6)     Load constant 1 
 40:    SUB  3,3,4      If cond check 
 41:    JGE  3,1(7)     Jump to then part 
* THEN
* RETURN
 43:     LD  3,-2(1)    Load variable u
 44:    LDA  2,0(3)     Copy result to rt register 
 45:     LD  3,-1(1)    Load return address 
 46:     LD  1,0(1)     Adjust fp 
 47:    LDA  7,0(3)     Return 
* ELSE
 42:    LDA  7,6(7)     Jump around the THEN 
* RETURN
 49:     ST  1,-4(1)    Store old fp in ghost frame 
 50:     LD  3,-3(1)    Load variable v
 51:     ST  3,-6(1)    Store parameter 
 52:     LD  3,-2(1)    Load variable u
 53:     ST  3,-7(1)    Save left side 
 54:     LD  3,-2(1)    Load variable u
 55:     ST  3,-8(1)    Save left side 
 56:     LD  3,-3(1)    Load variable v
 57:     LD  4,-8(1)    Load left into ac1 
 58:    DIV  3,4,3      Op / 
 59:     ST  3,-8(1)    Save left side 
 60:     LD  3,-3(1)    Load variable v
 61:     LD  4,-8(1)    Load left into ac1 
 62:    MUL  3,4,3      Op * 
 63:     LD  4,-7(1)    Load left into ac1 
 64:    SUB  3,4,3      Op - 
 65:     ST  3,-7(1)    Store parameter 
 66:    LDA  1,-4(1)    Load address of new frame 
 67:    LDA  3,1(7)     Return address in ac 
 68:    LDA  7,-39(7)   call gcd
 69:    LDA  3,0(2)     Save the result in ac 
 70:    LDA  2,0(3)     Copy result to rt register 
 71:     LD  3,-1(1)    Load return address 
 72:     LD  1,0(1)     Adjust fp 
 73:    LDA  7,0(3)     Return 
 48:    LDA  7,25(7)    Jump around the ELSE 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
 74:    LDC  2,0(6)     Set return value to 0 
 75:     LD  3,-1(1)    Load return address 
 76:     LD  1,0(1)     Adjust fp 
 77:    LDA  7,0(3)     Return 
* END of function gcd
* BEGIN function main
 78:     ST  3,-1(1)    Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 79:     ST  1,-4(1)    Store old fp in ghost frame 
 80:    LDA  1,-4(1)    Load address of new frame 
 81:    LDA  3,1(7)     Return address in ac 
 82:    LDA  7,-82(7)   call input
 83:    LDA  3,0(2)     Save the result in ac 
 84:     ST  3,-2(1)    Store variable x
* EXPRESSION STMT
 85:     ST  1,-4(1)    Store old fp in ghost frame 
 86:    LDA  1,-4(1)    Load address of new frame 
 87:    LDA  3,1(7)     Return address in ac 
 88:    LDA  7,-88(7)   call input
 89:    LDA  3,0(2)     Save the result in ac 
 90:     ST  3,-3(1)    Store variable y
* EXPRESSION STMT
 91:     ST  1,-4(1)    Store old fp in ghost frame 
 92:     ST  1,-6(1)    Store old fp in ghost frame 
 93:     LD  3,-2(1)    Load variable x
 94:     ST  3,-8(1)    Store parameter 
 95:     LD  3,-3(1)    Load variable y
 96:     ST  3,-9(1)    Store parameter 
 97:    LDA  1,-6(1)    Load address of new frame 
 98:    LDA  3,1(7)     Return address in ac 
 99:    LDA  7,-70(7)   call gcd
100:    LDA  3,0(2)     Save the result in ac 
101:     ST  3,-6(1)    Store parameter 
102:    LDA  1,-4(1)    Load address of new frame 
103:    LDA  3,1(7)     Return address in ac 
104:    LDA  7,-99(7)   call output
105:    LDA  3,0(2)     Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
106:    LDC  2,0(6)     Set return value to 0 
107:     LD  3,-1(1)    Load return address 
108:     LD  1,0(1)     Adjust fp 
109:    LDA  7,0(3)     Return 
* END of function main
  0:    LDA  7,109(7)   Jump to init 
* BEGIN Init
110:     LD  0,0(0)     Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
111:    LDA  1,0(0)     set first frame at end of globals 
112:     ST  1,0(1)     store old fp (point to self) 
113:    LDA  3,1(7)     Return address in ac 
114:    LDA  7,-37(7)   Jump to main 
115:   HALT  0,0,0      DONE! 
* END Init
