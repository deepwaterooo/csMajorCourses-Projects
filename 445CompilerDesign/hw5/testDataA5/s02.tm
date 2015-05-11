* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  s02.c-
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
* BEGIN function toad
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* END compound statement
* Add standard closing in case there is no return statement
 31:    LDC  2,0(6) 	Set return value to 0 
 32:     LD  3,-1(1) 	Load return address 
 33:     LD  1,0(1) 	Adjust fp 
 34:    LDA  7,0(3) 	Return 
* END of function toad
* BEGIN function load
 35:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* END compound statement
* Add standard closing in case there is no return statement
 36:    LDC  2,0(6) 	Set return value to 0 
 37:     LD  3,-1(1) 	Load return address 
 38:     LD  1,0(1) 	Adjust fp 
 39:    LDA  7,0(3) 	Return 
* END of function load
* BEGIN function sum
 40:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
 41:     LD  3,-2(1) 	Load variable init
 42:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 44:    LDC  3,0(6) 	Load constant 
 45:     ST  3,-104(0) 	Store variable runningSum
 43:    LDA  7,2(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
 46:     LD  3,-3(1) 	Load variable x
 47:     LD  4,-104(0) 	load lhs variable runningSum
 48:    ADD  3,4,3 	op += 
 49:     ST  3,-104(0) 	Store variable runningSum
* RETURN
 50:     LD  3,-104(0) 	Load variable runningSum
 51:    LDA  2,0(3) 	Copy result to rt register 
 52:     LD  3,-1(1) 	Load return address 
 53:     LD  1,0(1) 	Adjust fp 
 54:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 55:    LDC  2,0(6) 	Set return value to 0 
 56:     LD  3,-1(1) 	Load return address 
 57:     LD  1,0(1) 	Adjust fp 
 58:    LDA  7,0(3) 	Return 
* END of function sum
* BEGIN function main
 59:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 60:    LDC  3,7000(6) 	Load constant 
 61:     ST  3,-2(0) 	Store variable runningSum
* EXPRESSION STMT
 62:     ST  1,-2(1) 	Store old fp in ghost frame 
 63:     LD  3,-2(0) 	Load variable runningSum
 64:     ST  3,-4(1) 	Store parameter 
 65:    LDA  1,-2(1) 	Load address of new frame 
 66:    LDA  3,1(7) 	Return address in ac 
 67:    LDA  7,-62(7) 	CALL output
 68:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 69:     ST  1,-2(1) 	Store old fp in ghost frame 
 70:    LDC  3,1(6) 	Load constant 
 71:     ST  3,-4(1) 	Store parameter 
 72:    LDC  3,666(6) 	Load constant 
 73:     ST  3,-5(1) 	Store parameter 
 74:    LDA  1,-2(1) 	Load address of new frame 
 75:    LDA  3,1(7) 	Return address in ac 
 76:    LDA  7,-37(7) 	CALL sum
 77:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 78:     ST  1,-2(1) 	Store old fp in ghost frame 
 79:    LDC  3,0(6) 	Load constant 
 80:     ST  3,-4(1) 	Store parameter 
 81:    LDC  3,3(6) 	Load constant 
 82:     ST  3,-5(1) 	Store parameter 
 83:    LDA  1,-2(1) 	Load address of new frame 
 84:    LDA  3,1(7) 	Return address in ac 
 85:    LDA  7,-46(7) 	CALL sum
 86:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 87:     ST  1,-2(1) 	Store old fp in ghost frame 
 88:    LDC  3,0(6) 	Load constant 
 89:     ST  3,-4(1) 	Store parameter 
 90:    LDC  3,3(6) 	Load constant 
 91:     ST  3,-5(1) 	Store parameter 
 92:    LDA  1,-2(1) 	Load address of new frame 
 93:    LDA  3,1(7) 	Return address in ac 
 94:    LDA  7,-55(7) 	CALL sum
 95:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 96:     ST  1,-2(1) 	Store old fp in ghost frame 
 97:    LDC  3,0(6) 	Load constant 
 98:     ST  3,-4(1) 	Store parameter 
 99:    LDC  3,3(6) 	Load constant 
100:     ST  3,-5(1) 	Store parameter 
101:    LDA  1,-2(1) 	Load address of new frame 
102:    LDA  3,1(7) 	Return address in ac 
103:    LDA  7,-64(7) 	CALL sum
104:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
105:     ST  1,-2(1) 	Store old fp in ghost frame 
106:     ST  1,-4(1) 	Store old fp in ghost frame 
107:    LDC  3,0(6) 	Load constant 
108:     ST  3,-6(1) 	Store parameter 
109:    LDC  3,0(6) 	Load constant 
110:     ST  3,-7(1) 	Store parameter 
111:    LDA  1,-4(1) 	Load address of new frame 
112:    LDA  3,1(7) 	Return address in ac 
113:    LDA  7,-74(7) 	CALL sum
114:    LDA  3,0(2) 	Save the result in ac 
115:     ST  3,-4(1) 	Store parameter 
116:    LDA  1,-2(1) 	Load address of new frame 
117:    LDA  3,1(7) 	Return address in ac 
118:    LDA  7,-113(7) 	CALL output
119:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
120:     ST  1,-2(1) 	Store old fp in ghost frame 
121:     LD  3,-2(0) 	Load variable runningSum
122:     ST  3,-4(1) 	Store parameter 
123:    LDA  1,-2(1) 	Load address of new frame 
124:    LDA  3,1(7) 	Return address in ac 
125:    LDA  7,-120(7) 	CALL output
126:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
127:    LDC  2,0(6) 	Set return value to 0 
128:     LD  3,-1(1) 	Load return address 
129:     LD  1,0(1) 	Adjust fp 
130:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,130(7) 	Jump to init 
* BEGIN Init
131:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
132:    LDC  3,100(6) 	load size of array x
133:     ST  3,-3(0) 	save size of array x
* END init of global array sizes
134:    LDA  1,-105(0) 	set first frame at end of globals 
135:     ST  1,0(1) 	store old fp (point to self) 
136:    LDA  3,1(7) 	Return address in ac 
137:    LDA  7,-79(7) 	Jump to main 
138:   HALT  0,0,0 	DONE! 
* END Init
