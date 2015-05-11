* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  proc.tm
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
* BEGIN function square
 30:     ST  3,-1(1) 	Store return address 
* RETURN
 31:     LD  3,-2(1) 	Load variable x
 32:     ST  3,-3(1) 	Save left side 
 33:     LD  3,-2(1) 	Load variable x
 34:     LD  4,-3(1) 	Load left into ac1 
 35:    MUL  3,4,3 	Op * 
 36:    LDA  2,0(3) 	Copy result to rt register 
 37:     LD  3,-1(1) 	Load return address 
 38:     LD  1,0(1) 	Adjust fp 
 39:    LDA  7,0(3) 	Return 
* Add standard closing in case there is no return statement
 40:    LDC  2,0(6) 	Set return value to 0 
 41:     LD  3,-1(1) 	Load return address 
 42:     LD  1,0(1) 	Adjust fp 
 43:    LDA  7,0(3) 	Return 
* END function square
* BEGIN function max
 44:     ST  3,-1(1) 	Store return address 
* IfK:
* IfK: t->child[0] condition
 45:     LD  3,-2(1) 	Load variable x
 46:     ST  3,-4(1) 	Save left side 
 47:     LD  3,-3(1) 	Load variable y
 48:     LD  4,-4(1) 	Load left into ac1 
 49:    SUB  4,4,3 	Op > 
 50:    LDC  3,1(6) 	True case 
 51:    JLT  4,1(7) 	Jump if true 
 52:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* RETURN
 54:     LD  3,-2(1) 	Load variable x
 55:    LDA  2,0(3) 	Copy result to rt register 
 56:     LD  3,-1(1) 	Load return address 
 57:     LD  1,0(1) 	Adjust fp 
 58:    LDA  7,0(3) 	Return 
 53:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
* RETURN
 60:     LD  3,-3(1) 	Load variable y
 61:    LDA  2,0(3) 	Copy result to rt register 
 62:     LD  3,-1(1) 	Load return address 
 63:     LD  1,0(1) 	Adjust fp 
 64:    LDA  7,0(3) 	Return 
 59:    LDA  7,5(7) 	jmp to end 
* ENDIF
* Add standard closing in case there is no return statement
 65:    LDC  2,0(6) 	Set return value to 0 
 66:     LD  3,-1(1) 	Load return address 
 67:     LD  1,0(1) 	Adjust fp 
 68:    LDA  7,0(3) 	Return 
* END function max
* BEGIN function main
 69:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 70:     ST  1,-5(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 71:     ST  1,-7(1) 	Store old frame in ghost frame 
 72:    LDC  3,31(6) 	Load constant 
 73:     ST  3,-9(1) 	Store parameter 
 74:    LDA  1,-7(1) 	Load address of new frame 
 75:    LDA  3,1(7) 	Return address in ac 
 76:    LDA  7,-47(7) 	CALL square
 77:    LDA  3,0(2) 	Save the result in ac 
 78:     ST  3,-7(1) 	Store parameter 
 79:    LDA  1,-5(1) 	Load address of new frame 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-76(7) 	CALL output
 82:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 83:     ST  1,-5(1) 	Store old frame in ghost frame 
 84:    LDA  1,-5(1) 	Load address of new frame 
 85:    LDA  3,1(7) 	Return addre