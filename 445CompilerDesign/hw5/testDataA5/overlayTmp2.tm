* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  overlayTmp2.c-
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
* BEGIN function dog
 30:     ST  3,-1(1) 	Store return address. 
* RETURN
 31:     LD  3,-2(1) 	Load variable pig
 32:    LDA  2,0(3) 	Copy result to rt register 
 33:     LD  3,-1(1) 	Load return address 
 34:     LD  1,0(1) 	Adjust fp 
 35:    LDA  7,0(3) 	Return 
* Add standard closing in case there is no return statement
 36:    LDC  2,0(6) 	Set return value to 0 
 37:     LD  3,-1(1) 	Load return address 
 38:     LD  1,0(1) 	Adjust fp 
 39:    LDA  7,0(3) 	Return 
* END of function dog
* BEGIN function main
 40:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 41:    LDC  3,111(6) 	Load constant 
 42:     ST  3,-3(1) 	Store variable z
* BEGIN compound statement
* EXPRESSION STMT
 43:    LDC  3,222(6) 	Load constant 
 44:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
 45:    LDC  3,666(6) 	Load constant 
 46:     ST  3,-6(1) 	Save left side 
 47:     ST  1,-7(1) 	Store old fp in ghost frame 
 48:     LD  3,-4(1) 	Load variable x
 49:     ST  3,-9(1) 	Store parameter 
 50:    LDA  1,-7(1) 	Load address of new frame 
 51:    LDA  3,1(7) 	Return address in ac 
 52:    LDA  7,-23(7) 	CALL dog
 53:    LDA  3,0(2) 	Save the result in ac 
 54:     LD  4,-6(1) 	Load left into ac1 
 55:    ADD  3,4,3 	Op + 
 56:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
 57:     ST  1,-6(1) 	Store old fp in ghost frame 
 58:     LD  3,-4(1) 	Load variable x
 59:     ST  3,-8(1) 	Store parameter 
 60:    LDA  1,-6(1) 	Load address of new frame 
 61:    LDA  3,1(7) 	Return address in ac 
 62:    LDA  7,-57(7) 	CALL output
 63:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 64:     ST  1,-6(1) 	Store old fp in ghost frame 
 65:    LDA  1,-6(1) 	Load address of new frame 
 66:    LDA  3,1(7) 	Return address in ac 
 67:    LDA  7,-43(7) 	CALL outnl
 68:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* BEGIN compound statement
* EXPRESSION STMT
 69:    LDC  3,333(6) 	Load constant 
 70:     ST  3,-5(1) 	Store variable y
* EXPRESSION STMT
 71:    LDC  3,666(6) 	Load constant 
 72:     ST  3,-6(1) 	Save left side 
 73:     ST  1,-7(1) 	Store old fp in ghost frame 
 74:     LD  3,-5(1) 	Load variable y
 75:     ST  3,-9(1) 	Store parameter 
 76:    LDA  1,-7(1) 	Load address of new frame 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-49(7) 	CALL dog
 79:    LDA  3,0(2) 	Save the result in ac 
 80:     LD  4,-6(1) 	Load left into ac1 
 81:    ADD  3,4,3 	Op + 
 82:     ST  3,-5(1) 	Store variable y
* EXPRESSION STMT
 83:     ST  1,-6(1) 	Store old fp in ghost frame 
 84:     LD  3,-5(1) 	Load variable y
 85:     ST  3,-8(1) 	Store parameter 
 86:    LDA  1,-6(1) 	Load address of new frame 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-83(7) 	CALL output
 89:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 90:     ST  1,-6(1) 	Store old fp in ghost frame 
 91:    LDA  1,-6(1) 	Load address of new frame 
 92:    LDA  3,1(7) 	Return address in ac 
 93:    LDA  7,-69(7) 	CALL outnl
 94:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* EXPRESSION STMT
 95:    LDC  3,666(6) 	Load constant 
 96:     ST  3,-6(1) 	Save left side 
 97:     ST  1,-7(1) 	Store old fp in ghost frame 
 98:     LD  3,-3(1) 	Load variable z
 99:     ST  3,-9(1) 	Store parameter 
100:    LDA  1,-7(1) 	Load address of new frame 
101:    LDA  3,1(7) 	Return address in ac 
102:    LDA  7,-73(7) 	CALL dog
103:    LDA  3,0(2) 	Save the result in ac 
104:     LD  4,-6(1) 	Load left into ac1 
105:    ADD  3,4,3 	Op + 
106:     ST  3,-3(1) 	Store variable z
* EXPRESSION STMT
107:     ST  1,-6(1) 	Store old fp in ghost frame 
108:     LD  3,-3(1) 	Load variable z
109:     ST  3,-8(1) 	Store parameter 
110:    LDA  1,-6(1) 	Load address of new frame 
111:    LDA  3,1(7) 	Return address in ac 
112:    LDA  7,-107(7) 	CALL output
113:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
114:     ST  1,-6(1) 	Store old fp in ghost frame 
115:    LDA  1,-6(1) 	Load address of new frame 
116:    LDA  3,1(7) 	Return address in ac 
117:    LDA  7,-93(7) 	CALL outnl
118:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
119:    LDC  2,0(6) 	Set return value to 0 
120:     LD  3,-1(1) 	Load return address 
121:     LD  1,0(1) 	Adjust fp 
122:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,122(7) 	Jump to init 
* BEGIN Init
123:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
124:    LDA  1,0(0) 	set first frame at end of globals 
125:     ST  1,0(1) 	store old fp (point to self) 
126:    LDA  3,1(7) 	Return address in ac 
127:    LDA  7,-88(7) 	Jump to main 
128:   HALT  0,0,0 	DONE! 
* END Init
