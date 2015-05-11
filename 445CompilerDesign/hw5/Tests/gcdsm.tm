* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  gcdsm.tm
* Nov 29, 2007
* BEGIN function input
  1:     ST  3,-1(1) 	Store return address 
  2:     IN  2,2,2 	Grab int input 
  3:     LD  3,-1(1) 	Load return address 
  4:     LD  1,0(1) 	Adjust fp 
  5:    LDA  7,0(3) 	Return 
* END of function input
* BEGIN function output
  6:     ST  3,-1(1) 	Store return address 
  7:     LD  3,-2(1) 	Load parameter 
  8:    OUT  3,3,3 	Output integer 
  9:    LDC  2,0(6) 	Set return to 0 
 10:     LD  3,-1(1) 	Load return address 
 11:     LD  1,0(1) 	Adjust fp 
 12:    LDA  7,0(3) 	Return 
* END of function output
* BEGIN function inputb
 13:     ST  3,-1(1) 	Store return address 
 14:    INB  2,2,2 	Grab bool input 
 15:     LD  3,-1(1) 	Load return address 
 16:     LD  1,0(1) 	Adjust fp 
 17:    LDA  7,0(3) 	Return 
* END of function inputb
* BEGIN function outputb
 18:     ST  3,-1(1) 	Store return address 
 19:     LD  3,-2(1) 	Load parameter 
 20:   OUTB  3,3,3 	Output bool 
 21:    LDC  2,0(6) 	Set return to 0 
 22:     LD  3,-1(1) 	Load return address 
 23:     LD  1,0(1) 	Adjust fp 
 24:    LDA  7,0(3) 	Return 
* END of function outputb
* BEGIN function outnl
 25:     ST  3,-1(1) 	Store return address 
 26:  OUTNL  3,3,3 	Output a newline 
 27:     LD  3,-1(1) 	Load return address 
 28:     LD  1,0(1) 	Adjust fp 
 29:    LDA  7,0(3) 	Return 
* END of function outnl
* BEGIN function gcd
 30:     ST  3,-1(1) 	Store return address 
* IfK:
* IfK: t->child[0] condition
 31:     LD  3,-3(1) 	Load variable v
 32:     ST  3,-4(1) 	Save left side 
 33:    LDC  3,0(6) 	Load constant 
 34:     LD  4,-4(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op == 
 36:    LDC  3,1(6) 	True case 
 37:    JEQ  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* RETURN
 40:     LD  3,-2(1) 	Load variable u
 41:    LDA  2,0(3) 	Copy result to rt register 
 42:     LD  3,-1(1) 	Load return address 
 43:     LD  1,0(1) 	Adjust fp 
 44:    LDA  7,0(3) 	Return 
 39:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
* RETURN
* EXPRESSION STMT
 46:     ST  1,-4(1) 	Store old frame in ghost frame 
 47:     LD  3,-3(1) 	Load variable v
 48:     ST  3,-6(1) 	Store parameter 
 49:     LD  3,-2(1) 	Load variable u
 50:     ST  3,-7(1) 	Save left side 
 51:     LD  3,-2(1) 	Load variable u
 52:     ST  3,-8(1) 	Save left side 
 53:     LD  3,-3(1) 	Load variable v
 54:     LD  4,-8(1) 	Load left into ac1 
 55:    DIV  3,4,3 	Op / 
 56:     ST  3,-8(1) 	Save left side 
 57:     LD  3,-3(1) 	Load variable v
 58:     LD  4,-8(1) 	Load left into ac1 
 59:    MUL  3,4,3 	Op * 
 60:     LD  4,-7(1) 	Load left into ac1 
 61:    SUB  3,4,3 	Op - 
 62:     ST  3,-7(1) 	Store parameter 
 63:    LDA  1,-4(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-36(7) 	CALL gcd
 66:    LDA  3,0(2) 	Save the result in ac 
 67:    LDA  2,0(3) 	Copy result to rt register 
 68:     LD  3,-1(1) 	Load return address 
 69:     LD  1,0(1) 	Adjust fp 
 70:    LDA  7,0(3) 	Return 
 45:    LDA  7,25(7) 	jmp to end 
* ENDIF
* Add standard closing in case there is no return statement
 71:    LDC  2,0(6) 	Set return value to 0 
 72:     LD  3,-1(1) 	Load return address 
 73:     LD  1,0(1) 	Adjust fp 
 74:    LDA  7,0(3) 	Return 
* END function gcd
* BEGIN function main
 75:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
* EXPRESSION STMT
 76:     ST  1,-3(1) 	Store old frame in ghost frame 
 77:    LDA  1,-3(1) 	Load address of new frame 
 78:    LDA  3,1(7) 	Return address in ac 
 79:    LDA  7,-79(7) 	CALL input
 80:    LDA  3,0(2) 	Save the result in ac 
 81:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
* EXPRESSION STMT
 82:     ST  1,-3(1) 	Store old frame in ghost frame 
 83:    LDA  1,-3(1) 	Load address of new frame 
 84:    LDA  3,1(7) 	Return address in ac 
 85:    LDA  7,-85(7) 	CALL input
 86:    LDA  3,0(2) 	Save the result in ac 
 87:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 88:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 89:     ST  1,-5(1) 	Store old frame in ghost frame 
 90:     LD  3,0(1) 	Load variable x
 91:     ST  3,-7(1) 	Store parameter 
 92:     LD  3,-2(1) 	Load variable y
 93:     ST  3,-8(1) 	Store parameter 
 94:    LDA  1,-5(1) 	Load address of new frame 
 95:    LDA  3,1(7) 	Return address in ac 
 96:    LDA  7,-67(7) 	CALL gcd
 97:    LDA  3,0(2) 	Save the result in ac 
 98:     ST  3,-5(1) 	Store parameter 
 99:    LDA  1,-3(1) 	Load address of new frame 
100:    LDA  3,1(7) 	Return address in ac 
101:    LDA  7,-96(7) 	CALL output
102:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
103:    LDC  2,0(6) 	Set return value to 0 
104:     LD  3,-1(1) 	Load return address 
105:     LD  1,0(1) 	Adjust fp 
106:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,106(7) 	Jump to init 
* BEGIN Init
107:     LD  0,0(0) 	Set the global pointer 
108:    LDA  1,0(0) 	set first frame at end of globals 
109:     ST  1,0(1) 	store old fp (point to self) 
110:    LDA  3,1(7) 	Return address in ac 
111:    LDA  7,-37(7) 	Jump to main 
112:   HALT  0,0,0 	DONE! 
* END Init
