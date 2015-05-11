* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  inc.c-
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
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 31:    LDC  3,1(6) 	load size of array z
 32:     ST  3,-3(1) 	save size of array z
* EXPRESSION STMT
 33:     ST  1,-6(1) 	Store old fp in ghost frame 
 34:    LDC  3,0(6) 	Load constant 
 35:     LD  5,-2(1) 	Load address of base of array y
 36:    SUB  5,5,3 	Compute offset of value 
 37:     LD  3,0(5) 	load lhs variable y
 38:    LDA  3,1(3) 	increment value of y
 39:     ST  3,0(5) 	Store variable y
 40:     ST  3,-8(1) 	Store parameter 
 41:    LDA  1,-6(1) 	Load address of new frame 
 42:    LDA  3,1(7) 	Return address in ac 
 43:    LDA  7,-38(7) 	CALL output
 44:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 45:     ST  1,-6(1) 	Store old fp in ghost frame 
 46:    LDC  3,0(6) 	Load constant 
 47:     LD  4,-2(1) 	Load address of base of array y
 48:    SUB  3,4,3 	Compute offset of value 
 49:     LD  3,0(3) 	Load the value 
 50:     ST  3,-8(1) 	Store parameter 
 51:    LDA  1,-6(1) 	Load address of new frame 
 52:    LDA  3,1(7) 	Return address in ac 
 53:    LDA  7,-48(7) 	CALL output
 54:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 55:    LDC  3,777(6) 	Load constant 
 56:     ST  3,-5(1) 	Store variable w
* EXPRESSION STMT
 57:    LDC  3,0(6) 	Load constant 
 58:     ST  3,-6(1) 	Save index 
 59:    LDC  3,888(6) 	Load constant 
 60:     LD  4,-6(1) 	Restore index 
 61:    LDA  5,-4(1) 	Load address of base of array z
 62:    SUB  5,5,4 	Compute offset of value 
 63:     ST  3,0(5) 	Store variable z
* EXPRESSION STMT
 64:     ST  1,-6(1) 	Store old fp in ghost frame 
 65:     LD  3,-5(1) 	load lhs variable w
 66:    LDA  3,1(3) 	increment value of w
 67:     ST  3,-5(1) 	Store variable w
 68:     ST  3,-8(1) 	Store parameter 
 69:    LDA  1,-6(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-66(7) 	CALL output
 72:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 73:     ST  1,-6(1) 	Store old fp in ghost frame 
 74:     LD  3,-5(1) 	Load variable w
 75:     ST  3,-8(1) 	Store parameter 
 76:    LDA  1,-6(1) 	Load address of new frame 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-73(7) 	CALL output
 79:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 80:     ST  1,-6(1) 	Store old fp in ghost frame 
 81:    LDC  3,0(6) 	Load constant 
 82:    LDA  5,-4(1) 	Load address of base of array z
 83:    SUB  5,5,3 	Compute offset of value 
 84:     LD  3,0(5) 	load lhs variable z
 85:    LDA  3,1(3) 	increment value of z
 86:     ST  3,0(5) 	Store variable z
 87:     ST  3,-8(1) 	Store parameter 
 88:    LDA  1,-6(1) 	Load address of new frame 
 89:    LDA  3,1(7) 	Return address in ac 
 90:    LDA  7,-85(7) 	CALL output
 91:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 92:     ST  1,-6(1) 	Store old fp in ghost frame 
 93:    LDC  3,0(6) 	Load constant 
 94:    LDA  4,-4(1) 	Load address of base of array z
 95:    SUB  3,4,3 	Compute offset of value 
 96:     LD  3,0(3) 	Load the value 
 97:     ST  3,-8(1) 	Store parameter 
 98:    LDA  1,-6(1) 	Load address of new frame 
 99:    LDA  3,1(7) 	Return address in ac 
100:    LDA  7,-95(7) 	CALL output
101:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
102:    LDC  2,0(6) 	Set return value to 0 
103:     LD  3,-1(1) 	Load return address 
104:     LD  1,0(1) 	Adjust fp 
105:    LDA  7,0(3) 	Return 
* END of function cat
* BEGIN function main
106:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
107:    LDC  3,1(6) 	load size of array x
108:     ST  3,-2(1) 	save size of array x
* EXPRESSION STMT
109:    LDC  3,0(6) 	Load constant 
110:     ST  3,-4(1) 	Save index 
111:    LDC  3,666(6) 	Load constant 
112:     LD  4,-4(1) 	Restore index 
113:    LDA  5,-3(1) 	Load address of base of array x
114:    SUB  5,5,4 	Compute offset of value 
115:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
116:     ST  1,-4(1) 	Store old fp in ghost frame 
117:    LDA  3,-3(1) 	Load address of base of array x
118:     ST  3,-6(1) 	Store parameter 
119:    LDA  1,-4(1) 	Load address of new frame 
120:    LDA  3,1(7) 	Return address in ac 
121:    LDA  7,-92(7) 	CALL cat
122:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
123:     ST  1,-4(1) 	Store old fp in ghost frame 
124:    LDC  3,0(6) 	Load constant 
125:    LDA  4,-3(1) 	Load address of base of array x
126:    SUB  3,4,3 	Compute offset of value 
127:     LD  3,0(3) 	Load the value 
128:     ST  3,-6(1) 	Store parameter 
129:    LDA  1,-4(1) 	Load address of new frame 
130:    LDA  3,1(7) 	Return address in ac 
131:    LDA  7,-126(7) 	CALL output
132:    LDA  3,0(2) 	Save the result in ac 
* RETURN
133:    LDC  3,0(6) 	Load constant 
134:    LDA  2,0(3) 	Copy result to rt register 
135:     LD  3,-1(1) 	Load return address 
136:     LD  1,0(1) 	Adjust fp 
137:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
138:    LDC  2,0(6) 	Set return value to 0 
139:     LD  3,-1(1) 	Load return address 
140:     LD  1,0(1) 	Adjust fp 
141:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,141(7) 	Jump to init 
* BEGIN Init
142:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
143:    LDA  1,0(0) 	set first frame at end of globals 
144:     ST  1,0(1) 	store old fp (point to self) 
145:    LDA  3,1(7) 	Return address in ac 
146:    LDA  7,-41(7) 	Jump to main 
147:   HALT  0,0,0 	DONE! 
* END Init
