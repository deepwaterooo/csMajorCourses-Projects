* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  if.tm
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
* BEGIN function main
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
* EXPRESSION STMT
 31:    LDC  3,23(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable j
 33:     ST  3,0(1) 	Store variable i
* IfK:
* IfK: t->child[0] condition
 34:     LD  3,0(1) 	Load variable i
 35:     ST  3,-3(1) 	Save left side 
 36:     LD  3,-2(1) 	Load variable j
 37:     LD  4,-3(1) 	Load left into ac1 
 38:    SUB  4,4,3 	Op > 
 39:    LDC  3,1(6) 	True case 
 40:    JLT  4,1(7) 	Jump if true 
 41:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
 43:    LDC  3,666(6) 	Load constant 
 44:     ST  3,0(1) 	Store variable i
 42:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
 45:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 46:     LD  3,-2(1) 	Load variable j
 47:     ST  3,-3(1) 	Save left side 
 48:     LD  3,0(1) 	Load variable i
 49:     LD  4,-3(1) 	Load left into ac1 
 50:    SUB  4,4,3 	Op == 
 51:    LDC  3,1(6) 	True case 
 52:    JEQ  4,1(7) 	Jump if true 
 53:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
 55:    LDC  3,666(6) 	Load constant 
 56:     ST  3,0(1) 	Store variable i
 54:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
 58:    LDC  3,777(6) 	Load constant 
 59:     ST  3,-2(1) 	Store variable j
 57:    LDA  7,2(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
 60:     ST  1,-3(1) 	Store old frame in ghost frame 
 61:     LD  3,0(1) 	Load variable i
 62:     ST  3,-5(1) 	Store parameter 
 63:    LDA  1,-3(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-60(7) 	CALL output
 66:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 67:     ST  1,-3(1) 	Store old frame in ghost frame 
 68:     LD  3,-2(1) 	Load variable j
 69:     ST  3,-5(1) 	Store parameter 
 70:    LDA  1,-3(1) 	Load address of new frame 
 71:    LDA  3,1(7) 	Return address in ac 
 72:    LDA  7,-67(7) 	CALL output
 73:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 74:     ST  1,-3(1) 	Store old frame in ghost frame 
 75:    LDA  1,-3(1) 	Load address of new frame 
 76:    LDA  3,1(7) 	Return address in ac 
 77:    LDA  7,-53(7) 	CALL outnl
 78:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 79:    LDC  2,0(6) 	Set return value to 0 
 80:     LD  3,-1(1) 	Load return address 
 81:     LD  1,0(1) 	Adjust fp 
 82:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,82(7) 	Jump to init 
* BEGIN Init
 83:     LD  0,0(0) 	Set the global pointer 
 84:    LDA  1,0(0) 	set first frame at end of globals 
 85:     ST  1,0(1) 	store old fp (point to self) 
 86:    LDA  3,1(7) 	Return address in ac 
 87:    LDA  7,-58(7) 	Jump to main 
 88:   HALT  0,0,0 	DONE! 
* END Init
