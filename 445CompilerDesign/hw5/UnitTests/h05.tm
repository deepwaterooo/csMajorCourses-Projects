* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  h05.tm
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
* BEGIN compound statement
* EXPRESSION STMT
 31:     ST  1,-3(1) 	Store old frame in ghost frame 
 32:    LDC  3,3(6) 	Load constant 
 33:     ST  3,-5(1) 	Save index 
 34:     ST  3,-6(1) 	Store parameter 
 35:    LDA  1,-3(1) 	Load address of new frame 
 36:    LDA  3,1(7) 	Return address in ac 
 37:    LDA  7,-32(7) 	CALL output
 38:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 39:     ST  1,-3(1) 	Store old frame in ghost frame 
 40:    LDA  1,-3(1) 	Load address of new frame 
 41:    LDA  3,1(7) 	Return address in ac 
 42:    LDA  7,-18(7) 	CALL outnl
 43:    LDA  3,0(2) 	Save the result in ac 
* IfK:
* IfK: t->child[0] condition
 44:    LDC  3,3(6) 	Load constant 
 45:     ST  3,-3(1) 	Save index 
 46:     ST  3,-4(1) 	Save left side 
 47:    LDC  3,0(6) 	Load constant 
 48:     LD  4,-4(1) 	Load left into ac1 
 49:    SUB  4,4,3 	Op > 
 50:    LDC  3,1(6) 	True case 
 51:    JLT  4,1(7) 	Jump if true 
 52:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* BEGIN compound statement
* EXPRESSION STMT
 54:    LDC  3,3(6) 	Load constant 
 55:     ST  3,-4(1) 	Save index 
 56:    LDC  3,1(6) 	Load constant 
 57:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 58:     ST  1,-5(1) 	Store old frame in ghost frame 
 59:     LD  3,-2(1) 	Load variable x
 60:     ST  3,-7(1) 	Store parameter 
 61:    LDA  1,-5(1) 	Load address of new frame 
 62:    LDA  3,1(7) 	Return address in ac 
 63:    LDA  7,-34(7) 	CALL cat
 64:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
 53:    JEQ  3,12(7) 	if: jmp to else 
* IfK: t->child[2] else part
 65:    LDA  7,0(7) 	jmp to end 
* ENDIF
* RETURN
 66:    LDA  2,0(3) 	Copy result to rt register 
 67:     LD  3,-1(1) 	Load return address 
 68:     LD  1,0(1) 	Adjust fp 
 69:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 70:    LDC  2,0(6) 	Set return value to 0 
 71:     LD  3,-1(1) 	Load return address 
 72:     LD  1,0(1) 	Adjust fp 
 73:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function main
 74:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 75:    LDC  3,3(6) 	Load constant 
 76:     ST  3,-2(1) 	Save index 
 77:    LDC  3,12(6) 	Load constant 
 78:     ST  3,-1(1) 	Store variable x
* EXPRESSION STMT
 79:     ST  1,-3(1) 	Store old frame in ghost frame 
 80:     LD  3,-1(1) 	Load variable x
 81:     ST  3,-5(1) 	Store parameter 
 82:    LDA  1,-3(1) 	Load address of new frame 
 83:    LDA  3,1(7) 	Return address in ac 
 84:    LDA  7,-55(7) 	CALL cat
 85:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 86:    LDC  2,0(6) 	Set return value to 0 
 87:     LD  3,-1(1) 	Load return address 
 88:     LD  1,0(1) 	Adjust fp 
 89:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,89(7) 	Jump to init 
* BEGIN Init
 90:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
 91:    LDC  3,0(6) 	load size of array x
 92:     ST  3,-1(0) 	save size of array x
* END init of global array sizes
 93:    LDA  1,-1(0) 	set first frame at end of globals 
 94:     ST  1,0(1) 	store old fp (point to self) 
 95:    LDA  3,1(7) 	Return address in ac 
 96:    LDA  7,-23(7) 	Jump to main 
 97:   HALT  0,0,0 	DONE! 
* END Init
