* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  h02.tm
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
 32:     LD  3,-2(1) 	Load variable x
 33:     ST  3,-5(1) 	Store parameter 
 34:    LDA  1,-3(1) 	Load address of new frame 
 35:    LDA  3,1(7) 	Return address in ac 
 36:    LDA  7,-31(7) 	CALL output
 37:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 38:     ST  1,-3(1) 	Store old frame in ghost frame 
 39:    LDA  1,-3(1) 	Load address of new frame 
 40:    LDA  3,1(7) 	Return address in ac 
 41:    LDA  7,-17(7) 	CALL outnl
 42:    LDA  3,0(2) 	Save the result in ac 
* IfK:
* IfK: t->child[0] condition
 43:     LD  3,-2(1) 	Load variable x
 44:     ST  3,-3(1) 	Save left side 
 45:    LDC  3,0(6) 	Load constant 
 46:     LD  4,-3(1) 	Load left into ac1 
 47:    SUB  4,4,3 	Op > 
 48:    LDC  3,1(6) 	True case 
 49:    JLT  4,1(7) 	Jump if true 
 50:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
 52:     ST  1,-3(1) 	Store old frame in ghost frame 
 53:     LD  3,-2(1) 	Load variable x
 54:     ST  3,-5(1) 	Save left side 
 55:    LDC  3,1(6) 	Load constant 
 56:     LD  4,-5(1) 	Load left into ac1 
 57:    SUB  3,4,3 	Op - 
 58:     ST  3,-5(1) 	Store parameter 
 59:    LDA  1,-3(1) 	Load address of new frame 
 60:    LDA  3,1(7) 	Return address in ac 
 61:    LDA  7,-32(7) 	CALL cat
 62:    LDA  3,0(2) 	Save the result in ac 
 51:    JEQ  3,12(7) 	if: jmp to else 
* IfK: t->child[2] else part
 63:    LDA  7,0(7) 	jmp to end 
* ENDIF
* RETURN
 64:    LDA  2,0(3) 	Copy result to rt register 
 65:     LD  3,-1(1) 	Load return address 
 66:     LD  1,0(1) 	Adjust fp 
 67:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 68:    LDC  2,0(6) 	Set return value to 0 
 69:     LD  3,-1(1) 	Load return address 
 70:     LD  1,0(1) 	Adjust fp 
 71:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function main
 72:     ST  3,-1(1) 	Store return address 
* EXPRESSION STMT
 73:     ST  1,-2(1) 	Store old frame in ghost frame 
 74:    LDC  3,10(6) 	Load constant 
 75:     ST  3,-4(1) 	Store parameter 
 76:    LDA  1,-2(1) 	Load address of new frame 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-49(7) 	CALL cat
 79:    LDA  3,0(2) 	Save the result in ac 
* Add standard closing in case there is no return statement
 80:    LDC  2,0(6) 	Set return value to 0 
 81:     LD  3,-1(1) 	Load return address 
 82:     LD  1,0(1) 	Adjust fp 
 83:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,83(7) 	Jump to init 
* BEGIN Init
 84:     LD  0,0(0) 	Set the global pointer 
 85:    LDA  1,0(0) 	set first frame at end of globals 
 86:     ST  1,0(1) 	store old fp (point to self) 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-17(7) 	Jump to main 
 89:   HALT  0,0,0 	DONE! 
* END Init
