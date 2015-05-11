* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  h07.tm
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
* BEGIN function fib
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
 45:    LDC  3,2(6) 	Load constant 
 46:     LD  4,-3(1) 	Load left into ac1 
 47:    SUB  4,4,3 	Op < 
 48:    LDC  3,1(6) 	True case 
 49:    JLT  4,1(7) 	Jump if true 
 50:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* RETURN
 52:    LDC  3,1(6) 	Load constant 
 53:    LDA  2,0(3) 	Copy result to rt register 
 54:     LD  3,-1(1) 	Load return address 
 55:     LD  1,0(1) 	Adjust fp 
 56:    LDA  7,0(3) 	Return 
 51:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
 57:    LDA  7,0(7) 	jmp to end 
* ENDIF
* RETURN
* EXPRESSION STMT
 58:     ST  1,-3(1) 	Store old frame in ghost frame 
 59:     LD  3,-2(1) 	Load variable x
 60:     ST  3,-5(1) 	Save left side 
 61:    LDC  3,1(6) 	Load constant 
 62:     LD  4,-5(1) 	Load left into ac1 
 63:    SUB  3,4,3 	Op - 
 64:     ST  3,-5(1) 	Store parameter 
 65:    LDA  1,-3(1) 	Load address of new frame 
 66:    LDA  3,1(7) 	Return address in ac 
 67:    LDA  7,-38(7) 	CALL fib
 68:    LDA  3,0(2) 	Save the result in ac 
 69:     ST  3,-3(1) 	Save left side 
* EXPRESSION STMT
 70:     ST  1,-4(1) 	Store old frame in ghost frame 
 71:     LD  3,-2(1) 	Load variable x
 72:     ST  3,-6(1) 	Save left side 
 73:    LDC  3,2(6) 	Load constant 
 74:     LD  4,-6(1) 	Load left into ac1 
 75:    SUB  3,4,3 	Op - 
 76:     ST  3,-6(1) 	Store parameter 
 77:    LDA  1,-4(1) 	Load address of new frame 
 78:    LDA  3,1(7) 	Return address in ac 
 79:    LDA  7,-50(7) 	CALL fib
 80:    LDA  3,0(2) 	Save the result in ac 
 81:     LD  4,-3(1) 	Load left into ac1 
 82:    ADD  3,4,3 	Op + 
 83:    LDA  2,0(3) 	Copy result to rt register 
 84:     LD  3,-1(1) 	Load return address 
 85:     LD  1,0(1) 	Adjust fp 
 86:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 87:    LDC  2,0(6) 	Set return value to 0 
 88:     LD  3,-1(1) 	Load return address 
 89:     LD  1,0(1) 	Adjust fp 
 90:    LDA  7,0(3) 	Return 
* END function fib
* BEGIN function main
 91:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 92:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 93:     ST  1,-4(1) 	Store old frame in ghost frame 
 94:    LDC  3,6(6) 	Load constant 
 95:     ST  3,-6(1) 	Store parameter 
 96:    LDA  1,-4(1) 	Load address of new frame 
 97:    LDA  3,1(7) 	Return address in ac 
 98:    LDA  7,-69(7) 	CALL fib
 99:    LDA  3,0(2) 	Save the result in ac 
100:     ST  3,-4(1) 	Store parameter 
101:    LDA  1,-2(1) 	Load address of new frame 
102:    LDA  3,1(7) 	Return address in ac 
103:    LDA  7,-98(7) 	CALL output
104:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
105:     ST  1,-2(1) 	Store old frame in ghost frame 
106:    LDA  1,-2(1) 	Load address of new frame 
107:    LDA  3,1(7) 	Return address in ac 
108:    LDA  7,-84(7) 	CALL outnl
109:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
110:    LDC  2,0(6) 	Set return value to 0 
111:     LD  3,-1(1) 	Load return address 
112:     LD  1,0(1) 	Adjust fp 
113:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,113(7) 	Jump to init 
* BEGIN Init
114:     LD  0,0(0) 	Set the global pointer 
115:    LDA  1,0(0) 	set first frame at end of globals 
116:     ST  1,0(1) 	store old fp (point to self) 
117:    LDA  3,1(7) 	Return address in ac 
118:    LDA  7,-28(7) 	Jump to main 
119:   HALT  0,0,0 	DONE! 
* END Init
