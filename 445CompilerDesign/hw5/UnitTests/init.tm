* C- compiler version C-F13
* Built: Dec 3, 2013
* Author: Robert B. Heckendorn
* File compiled:  init.c-
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
* BEGIN function inputc
 25:     ST  3,-1(1) 	Store return address 
 26:    INC  2,2,2 	Grab char input 
 27:     LD  3,-1(1) 	Load return address 
 28:     LD  1,0(1) 	Adjust fp 
 29:    LDA  7,0(3) 	Return 
* END of function inputc
* BEGIN function outputc
 30:     ST  3,-1(1) 	Store return address 
 31:     LD  3,-2(1) 	Load parameter 
 32:   OUTC  3,3,3 	Output char 
 33:    LDC  2,0(6) 	Set return to 0 
 34:     LD  3,-1(1) 	Load return address 
 35:     LD  1,0(1) 	Adjust fp 
 36:    LDA  7,0(3) 	Return 
* END of function outputc
* BEGIN function outnl
 37:     ST  3,-1(1) 	Store return address 
 38:  OUTNL  3,3,3 	Output a newline 
 39:     LD  3,-1(1) 	Load return address 
 40:     LD  1,0(1) 	Adjust fp 
 41:    LDA  7,0(3) 	Return 
* END of function outnl
* BEGIN function main
 42:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 43:    LDC  3,666(6) 	Load constant 
 44:     ST  3,-2(1) 	Store variable i
 45:    LDC  3,97(6) 	Load constant 
 46:     ST  3,-3(1) 	Store variable y
 47:    LDC  3,10(6) 	load size of array b
 48:     ST  3,-4(1) 	save size of array b
 49:    LDC  3,331367072(6) 	Load constant 
 50:     ST  3,-5(1) 	Store variable b
 51:    LDC  3,10(6) 	load size of array x
 52:     ST  3,-15(1) 	save size of array x
 53:    LDC  3,331367904(6) 	Load constant 
 54:     LD  3,1(3) 	Load array size 
 55:     ST  3,-26(1) 	Store variable j
 56:    LDC  3,4(6) 	Load constant 
 57:     ST  3,-86(1) 	Save left side 
 58:    LDC  3,5(6) 	Load constant 
 59:     LD  4,-86(1) 	Load left into ac1 
 60:    MUL  3,4,3 	Op * 
 61:     ST  3,-86(1) 	Save left side 
 62:    LDC  3,3(6) 	Load constant 
 63:     LD  4,-86(1) 	Load left into ac1 
 64:    ADD  3,4,3 	Op + 
 65:     ST  3,-27(1) 	Store variable k
 66:    LDC  3,46(6) 	Load constant 
 67:    LDC  4,0(6) 	Load 0 
 68:    SUB  3,4,3 	Op unary - 
 69:     ST  3,-28(1) 	Store variable l
 70:    LDC  3,1(6) 	Load constant 
 71:     ST  3,-29(1) 	Store variable ba
 72:    LDC  3,1(6) 	Load constant 
 73:     ST  3,-86(1) 	Save left side 
 74:    LDC  3,0(6) 	Load constant 
 75:    LDC  4,1(6) 	Load 1 
 76:    SUB  3,4,3 	Op NOT 
 77:     LD  4,-86(1) 	Load left into ac1 
 78:    JEQ  3,1(7) 	Op AND 
 79:    LDA  3,0(4) 	 
 80:     ST  3,-30(1) 	Store variable bb
 81:    LDC  3,5(6) 	Load constant 
 82:     ST  3,-86(1) 	Save left side 
 83:    LDC  3,4(6) 	Load constant 
 84:     LD  4,-86(1) 	Load left into ac1 
 85:    SUB  4,4,3 	Op > 
 86:    LDC  3,1(6) 	True case 
 87:    JGT  4,1(7) 	Jump if true 
 88:    LDC  3,0(6) 	False case 
 89:     ST  3,-31(1) 	Store variable bc
 90:    LDC  3,97(6) 	Load constant 
 91:     ST  3,-32(1) 	Store variable ca
* EXPRESSION STMT
 92:    LDC  3,1(6) 	Load constant 
 93:     ST  3,-86(1) 	Save index 
 94:    LDC  3,111(6) 	Load constant 
 95:     LD  4,-86(1) 	Restore index 
 96:    LDA  5,-16(1) 	Load address of base of array x
 97:    SUB  5,5,4 	Compute offset of value 
 98:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 99:    LDA  3,-5(1) 	Load address of base of array b
100:     LD  3,1(3) 	Load array size 
101:     ST  3,0(0) 	Store variable a
* EXPRESSION STMT
102:    LDC  3,331373120(6) 	Load constant 
103:     LD  3,1(3) 	Load array size 
104:     ST  3,0(0) 	Store variable a
* BEGIN compound statement
105:    LDC  3,30(6) 	load size of array z
106:     ST  3,-55(1) 	save size of array z
* EXPRESSION STMT
107:    LDC  3,3(6) 	Load constant 
108:     ST  3,-86(1) 	Save index 
109:    LDC  3,333(6) 	Load constant 
110:     LD  4,-86(1) 	Restore index 
111:    LDA  5,-56(1) 	Load address of base of array z
112:    SUB  5,5,4 	Compute offset of value 
113:     ST  3,0(5) 	Store variable z
* END compound statement
* EXPRESSION STMT
*                       Begin call to  output
114:     ST  1,-86(1) 	Store old fp in ghost frame 
*                       Load param 1
115:    LDC  3,666(6) 	Load constant 
116:     ST  3,-88(1) 	Store parameter 
*                       Jump to output
117:    LDA  1,-86(1) 	Load address of new frame 
118:    LDA  3,1(7) 	Return address in ac 
119:    LDA  7,-114(7) 	CALL output
120:    LDA  3,0(2) 	Save the result in ac 
*                       End call to output
* END compound statement
* Add standard closing in case there is no return statement
121:    LDC  2,0(6) 	Set return value to 0 
122:     LD  3,-1(1) 	Load return address 
123:     LD  1,0(1) 	Adjust fp 
124:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,124(7) 	Jump to init [backpatch] 
* BEGIN Init
125:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of globals
126:    LDC  3,666(6) 	Load constant 
127:     ST  3,0(0) 	Store variable a-1
* END init of globals
128:    LDA  1,-1(0) 	set first frame at end of globals 
129:     ST  1,0(1) 	store old fp (point to self) 
130:    LDA  3,1(7) 	Return address in ac 
131:    LDA  7,-90(7) 	Jump to main 
132:   HALT  0,0,0 	DONE! 
* END Init
