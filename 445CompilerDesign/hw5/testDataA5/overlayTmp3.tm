* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  overlayTmp3.c-
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
* IF
 41:    LDC  3,1(6) 	Load constant 
 42:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
 44:    LDC  3,111(6) 	Load constant 
 45:     ST  3,-3(1) 	Store variable z
* BEGIN compound statement
* EXPRESSION STMT
 46:    LDC  3,222(6) 	Load constant 
 47:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
 48:    LDC  3,666(6) 	Load constant 
 49:     ST  3,-6(1) 	Save left side 
 50:     ST  1,-7(1) 	Store old fp in ghost frame 
 51:     LD  3,-4(1) 	Load variable x
 52:     ST  3,-9(1) 	Store parameter 
 53:    LDA  1,-7(1) 	Load address of new frame 
 54:    LDA  3,1(7) 	Return address in ac 
 55:    LDA  7,-26(7) 	CALL dog
 56:    LDA  3,0(2) 	Save the result in ac 
 57:     LD  4,-6(1) 	Load left into ac1 
 58:    ADD  3,4,3 	Op + 
 59:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
 60:     ST  1,-6(1) 	Store old fp in ghost frame 
 61:     LD  3,-4(1) 	Load variable x
 62:     ST  3,-8(1) 	Store parameter 
 63:    LDA  1,-6(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-60(7) 	CALL output
 66:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 67:     ST  1,-6(1) 	Store old fp in ghost frame 
 68:    LDA  1,-6(1) 	Load address of new frame 
 69:    LDA  3,1(7) 	Return address in ac 
 70:    LDA  7,-46(7) 	CALL outnl
 71:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* BEGIN compound statement
* EXPRESSION STMT
 72:    LDC  3,333(6) 	Load constant 
 73:     ST  3,-5(1) 	Store variable y
* EXPRESSION STMT
 74:    LDC  3,666(6) 	Load constant 
 75:     ST  3,-6(1) 	Save left side 
 76:     ST  1,-7(1) 	Store old fp in ghost frame 
 77:     LD  3,-5(1) 	Load variable y
 78:     ST  3,-9(1) 	Store parameter 
 79:    LDA  1,-7(1) 	Load address of new frame 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-52(7) 	CALL dog
 82:    LDA  3,0(2) 	Save the result in ac 
 83:     LD  4,-6(1) 	Load left into ac1 
 84:    ADD  3,4,3 	Op + 
 85:     ST  3,-5(1) 	Store variable y
* EXPRESSION STMT
 86:     ST  1,-6(1) 	Store old fp in ghost frame 
 87:     LD  3,-5(1) 	Load variable y
 88:     ST  3,-8(1) 	Store parameter 
 89:    LDA  1,-6(1) 	Load address of new frame 
 90:    LDA  3,1(7) 	Return address in ac 
 91:    LDA  7,-86(7) 	CALL output
 92:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 93:     ST  1,-6(1) 	Store old fp in ghost frame 
 94:    LDA  1,-6(1) 	Load address of new frame 
 95:    LDA  3,1(7) 	Return address in ac 
 96:    LDA  7,-72(7) 	CALL outnl
 97:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* EXPRESSION STMT
 98:    LDC  3,666(6) 	Load constant 
 99:     ST  3,-6(1) 	Save left side 
100:     ST  1,-7(1) 	Store old fp in ghost frame 
101:     LD  3,-3(1) 	Load variable z
102:     ST  3,-9(1) 	Store parameter 
103:    LDA  1,-7(1) 	Load address of new frame 
104:    LDA  3,1(7) 	Return address in ac 
105:    LDA  7,-76(7) 	CALL dog
106:    LDA  3,0(2) 	Save the result in ac 
107:     LD  4,-6(1) 	Load left into ac1 
108:    ADD  3,4,3 	Op + 
109:     ST  3,-3(1) 	Store variable z
* EXPRESSION STMT
110:     ST  1,-6(1) 	Store old fp in ghost frame 
111:     LD  3,-3(1) 	Load variable z
112:     ST  3,-8(1) 	Store parameter 
113:    LDA  1,-6(1) 	Load address of new frame 
114:    LDA  3,1(7) 	Return address in ac 
115:    LDA  7,-110(7) 	CALL output
116:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
117:     ST  1,-6(1) 	Store old fp in ghost frame 
118:    LDA  1,-6(1) 	Load address of new frame 
119:    LDA  3,1(7) 	Return address in ac 
120:    LDA  7,-96(7) 	CALL outnl
121:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
 43:    LDA  7,78(7) 	Jump around the THEN 
* ENDIF
* Add standard closing in case there is no return statement
122:    LDC  2,0(6) 	Set return value to 0 
123:     LD  3,-1(1) 	Load return address 
124:     LD  1,0(1) 	Adjust fp 
125:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,125(7) 	Jump to init 
* BEGIN Init
126:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
127:    LDA  1,0(0) 	set first frame at end of globals 
128:     ST  1,0(1) 	store old fp (point to self) 
129:    LDA  3,1(7) 	Return address in ac 
130:    LDA  7,-91(7) 	Jump to main 
131:   HALT  0,0,0 	DONE! 
* END Init
