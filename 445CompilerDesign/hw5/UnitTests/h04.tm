* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  h04.tm
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
 56:    LDC  3,3(6) 	Load constant 
 57:     ST  3,-5(1) 	Save index 
 58:     ST  3,-6(1) 	Save left side 
 59:    LDC  3,1(6) 	Load constant 
 60:     LD  4,-6(1) 	Load left into ac1 
 61:    SUB  3,4,3 	Op - 
 62:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 63:     ST  1,-6(1) 	Store old frame in ghost frame 
 64:     LD  3,-2(1) 	Load variable x
 65:     ST  3,-8(1) 	Store parameter 
 66:    LDA  1,-6(1) 	Load address of new frame 
 67:    LDA  3,1(7) 	Return address in ac 
 68:    LDA  7,-39(7) 	CALL cat
 69:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
 53:    JEQ  3,17(7) 	if: jmp to else 
* IfK: t->child[2] else part
 70:    LDA  7,0(7) 	jmp to end 
* ENDIF
* RETURN
 71:    LDA  2,0(3) 	Copy result to rt register 
 72:     LD  3,-1(1) 	Load return address 
 73:     LD  1,0(1) 	Adjust fp 
 74:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 75:    LDC  2,0(6) 	Set return value to 0 
 76:     LD  3,-1(1) 	Load return address 
 77:     LD  1,0(1) 	Adjust fp 
 78:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function main
 79:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 80:    LDC  3,3(6) 	Load constant 
 81:     ST  3,-2(1) 	Save index 
 82:    LDC  3,12(6) 	Load constant 
 83:     ST  3,-1(1) 	Store variable x
* EXPRESSION STMT
 84:     ST  1,-3(1) 	Store old frame in ghost frame 
 85:     LD  3,-1(1) 	Load variable x
 86:     ST  3,-5(1) 	Store parameter 
 87:    LDA  1,-3(1) 	Load address of new frame 
 88:    LDA  3,1(7) 	Return address in ac 
 89:    LDA  7,-60(7) 	CALL cat
 90:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 91:    LDC  2,0(6) 	Set return value to 0 
 92:     LD  3,-1(1) 	Load return address 
 93:     LD  1,0(1) 	Adjust fp 
 94:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,94(7) 	Jump to init 
* BEGIN Init
 95:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
 96:    LDC  3,0(6) 	load size of array x
 97:     ST  3,-1(0) 	save size of array x
* END init of global array sizes
 98:    LDA  1,-1(0) 	set first frame at end of globals 
 99:     ST  1,0(1) 	store old fp (point to self) 
100:    LDA  3,1(7) 	Return address in ac 
101:    LDA  7,-23(7) 	Jump to main 
102:   HALT  0,0,0 	DONE! 
* END Init
