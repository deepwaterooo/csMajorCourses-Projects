* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  g0e.tm
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
* BEGIN function cat
 30:     ST  3,-1(1) 	Store return address 
* IfK:
* IfK: t->child[0] condition
 31:     LD  3,-2(1) 	Load variable x
 32:     ST  3,-3(1) 	Save left side 
 33:    LDC  3,0(6) 	Load constant 
 34:     LD  4,-3(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op > 
 36:    LDC  3,1(6) 	True case 
 37:    JLT  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* RETURN
 40:     LD  3,-2(1) 	Load variable x
 41:     ST  3,-3(1) 	Save left side 
 42:     LD  3,-2(1) 	Load variable x
 43:     LD  4,-3(1) 	Load left into ac1 
 44:    ADD  3,4,3 	Op + 
 45:    LDA  2,0(3) 	Copy result to rt register 
 46:     LD  3,-1(1) 	Load return address 
 47:     LD  1,0(1) 	Adjust fp 
 48:    LDA  7,0(3) 	Return 
 39:    JEQ  3,10(7) 	if: jmp to else 
* IfK: t->child[2] else part
 50:     LD  3,-2(1) 	Load variable x
 51:     ST  3,-3(1) 	Save left side 
 52:     LD  3,-2(1) 	Load variable x
 53:     LD  4,-3(1) 	Load left into ac1 
 54:    MUL  3,4,3 	Op * 
 49:    LDA  7,5(7) 	jmp to end 
* ENDIF
* Add standard closing in case there is no return statement
 55:    LDC  2,0(6) 	Set return value to 0 
 56:     LD  3,-1(1) 	Load return address 
 57:     LD  1,0(1) 	Adjust fp 
 58:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function main
 59:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 60:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 61:     ST  1,-4(1) 	Store old frame in ghost frame 
 62:    LDC  3,88(6) 	Load constant 
 63:     ST  3,-6(1) 	Store parameter 
 64:    LDA  1,-4(1) 	Load address of new frame 
 65:    LDA  3,1(7) 	Return address in ac 
 66:    LDA  7,-37(7) 	CALL cat
 67:    LDA  3,0(2) 	Save the result in ac 
 68:     ST  3,-4(1) 	Store parameter 
 69:    LDA  1,-2(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-66(7) 	CALL output
 72:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 73:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 74:     ST  1,-4(1) 	Store old frame in ghost frame 
 75:    LDC  3,17(6) 	Load constant 
 76:    LDC  4,0(6) 	Load 0 
 77:    SUB  3,4,3 	Op unary - 
 78:     ST  3,-6(1) 	Store parameter 
 79:    LDA  1,-4(1) 	Load address of new frame 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-52(7) 	CALL cat
 82:    LDA  3,0(2) 	Save the result in ac 
 83:     ST  3,-4(1) 	Store parameter 
 84:    LDA  1,-2(1) 	Load address of new frame 
 85:    LDA  3,1(7) 	Return address in ac 
 86:    LDA  7,-81(7) 	CALL output
 87:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 88:    LDC  2,0(6) 	Set return value to 0 
 89:     LD  3,-1(1) 	Load return address 
 90:     LD  1,0(1) 	Adjust fp 
 91:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,91(7) 	Jump to init 
* BEGIN Init
 92:     LD  0,0(0) 	Set the global pointer 
 93:    LDA  1,0(0) 	set first frame at end of globals 
 94:     ST  1,0(1) 	store old fp (point to self) 
 95:    LDA  3,1(7) 	Return address in ac 
 96:    LDA  7,-38(7) 	Jump to main 
 97:   HALT  0,0,0 	DONE! 
* END Init
