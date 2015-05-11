* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  assign1.c-
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
* BEGIN function main
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,111(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 33:     ST  1,-6(1) 	Store old fp in ghost frame 
 34:     LD  3,-2(1) 	Load variable x
 35:     ST  3,-8(1) 	Store parameter 
 36:    LDA  1,-6(1) 	Load address of new frame 
 37:    LDA  3,1(7) 	Return address in ac 
 38:    LDA  7,-33(7) 	CALL output
 39:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 40:    LDC  3,222(6) 	Load constant 
 41:     ST  3,-3(1) 	Store variable y
* EXPRESSION STMT
 42:     ST  1,-6(1) 	Store old fp in ghost frame 
 43:     LD  3,-3(1) 	Load variable y
 44:     ST  3,-8(1) 	Store parameter 
 45:    LDA  1,-6(1) 	Load address of new frame 
 46:    LDA  3,1(7) 	Return address in ac 
 47:    LDA  7,-42(7) 	CALL output
 48:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 49:    LDC  3,1(6) 	Load constant 
 50:     ST  3,-4(1) 	Store variable a
* EXPRESSION STMT
 51:     ST  1,-6(1) 	Store old fp in ghost frame 
 52:     LD  3,-4(1) 	Load variable a
 53:     ST  3,-8(1) 	Store parameter 
 54:    LDA  1,-6(1) 	Load address of new frame 
 55:    LDA  3,1(7) 	Return address in ac 
 56:    LDA  7,-39(7) 	CALL outputb
 57:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 58:    LDC  3,0(6) 	Load constant 
 59:     ST  3,-5(1) 	Store variable b
* EXPRESSION STMT
 60:     ST  1,-6(1) 	Store old fp in ghost frame 
 61:     LD  3,-5(1) 	Load variable b
 62:     ST  3,-8(1) 	Store parameter 
 63:    LDA  1,-6(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-48(7) 	CALL outputb
 66:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 67:     ST  1,-6(1) 	Store old fp in ghost frame 
 68:    LDA  1,-6(1) 	Load address of new frame 
 69:    LDA  3,1(7) 	Return address in ac 
 70:    LDA  7,-46(7) 	CALL outnl
 71:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 72:    LDC  3,333(6) 	Load constant 
 73:     ST  3,0(0) 	Store variable gx
* EXPRESSION STMT
 74:     ST  1,-6(1) 	Store old fp in ghost frame 
 75:     LD  3,0(0) 	Load variable gx
 76:     ST  3,-8(1) 	Store parameter 
 77:    LDA  1,-6(1) 	Load address of new frame 
 78:    LDA  3,1(7) 	Return address in ac 
 79:    LDA  7,-74(7) 	CALL output
 80:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 81:    LDC  3,444(6) 	Load constant 
 82:     ST  3,-1(0) 	Store variable gy
* EXPRESSION STMT
 83:     ST  1,-6(1) 	Store old fp in ghost frame 
 84:     LD  3,-1(0) 	Load variable gy
 85:     ST  3,-8(1) 	Store parameter 
 86:    LDA  1,-6(1) 	Load address of new frame 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-83(7) 	CALL output
 89:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 90:    LDC  3,0(6) 	Load constant 
 91:     ST  3,-2(0) 	Store variable ga
* EXPRESSION STMT
 92:     ST  1,-6(1) 	Store old fp in ghost frame 
 93:     LD  3,-2(0) 	Load variable ga
 94:     ST  3,-8(1) 	Store parameter 
 95:    LDA  1,-6(1) 	Load address of new frame 
 96:    LDA  3,1(7) 	Return address in ac 
 97:    LDA  7,-80(7) 	CALL outputb
 98:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 99:    LDC  3,1(6) 	Load constant 
100:     ST  3,-3(0) 	Store variable gb
* EXPRESSION STMT
101:     ST  1,-6(1) 	Store old fp in ghost frame 
102:     LD  3,-3(0) 	Load variable gb
103:     ST  3,-8(1) 	Store parameter 
104:    LDA  1,-6(1) 	Load address of new frame 
105:    LDA  3,1(7) 	Return address in ac 
106:    LDA  7,-89(7) 	CALL outputb
107:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
108:     ST  1,-6(1) 	Store old fp in ghost frame 
109:    LDA  1,-6(1) 	Load address of new frame 
110:    LDA  3,1(7) 	Return address in ac 
111:    LDA  7,-87(7) 	CALL outnl
112:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
113:     LD  3,-3(1) 	Load variable y
114:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
115:     ST  1,-6(1) 	Store old fp in ghost frame 
116:     LD  3,-2(1) 	Load variable x
117:     ST  3,-8(1) 	Store parameter 
118:    LDA  1,-6(1) 	Load address of new frame 
119:    LDA  3,1(7) 	Return address in ac 
120:    LDA  7,-115(7) 	CALL output
121:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
122:     LD  3,-5(1) 	Load variable b
123:     ST  3,-4(1) 	Store variable a
* EXPRESSION STMT
124:     ST  1,-6(1) 	Store old fp in ghost frame 
125:     LD  3,-4(1) 	Load variable a
126:     ST  3,-8(1) 	Store parameter 
127:    LDA  1,-6(1) 	Load address of new frame 
128:    LDA  3,1(7) 	Return address in ac 
129:    LDA  7,-112(7) 	CALL outputb
130:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
131:     ST  1,-6(1) 	Store old fp in ghost frame 
132:    LDA  1,-6(1) 	Load address of new frame 
133:    LDA  3,1(7) 	Return address in ac 
134:    LDA  7,-110(7) 	CALL outnl
135:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
136:     LD  3,-1(0) 	Load variable gy
137:     ST  3,0(0) 	Store variable gx
* EXPRESSION STMT
138:     ST  1,-6(1) 	Store old fp in ghost frame 
139:     LD  3,0(0) 	Load variable gx
140:     ST  3,-8(1) 	Store parameter 
141:    LDA  1,-6(1) 	Load address of new frame 
142:    LDA  3,1(7) 	Return address in ac 
143:    LDA  7,-138(7) 	CALL output
144:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
145:     LD  3,-3(0) 	Load variable gb
146:     ST  3,-2(0) 	Store variable ga
* EXPRESSION STMT
147:     ST  1,-6(1) 	Store old fp in ghost frame 
148:     LD  3,-2(0) 	Load variable ga
149:     ST  3,-8(1) 	Store parameter 
150:    LDA  1,-6(1) 	Load address of new frame 
151:    LDA  3,1(7) 	Return address in ac 
152:    LDA  7,-135(7) 	CALL outputb
153:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
154:     ST  1,-6(1) 	Store old fp in ghost frame 
155:    LDA  1,-6(1) 	Load address of new frame 
156:    LDA  3,1(7) 	Return address in ac 
157:    LDA  7,-133(7) 	CALL outnl
158:    LDA  3,0(2) 	Save the result in ac 
* RETURN
159:    LDA  2,0(3) 	Copy result to rt register 
160:     LD  3,-1(1) 	Load return address 
161:     LD  1,0(1) 	Adjust fp 
162:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
163:    LDC  2,0(6) 	Set return value to 0 
164:     LD  3,-1(1) 	Load return address 
165:     LD  1,0(1) 	Adjust fp 
166:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,166(7) 	Jump to init 
* BEGIN Init
167:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
168:    LDA  1,-4(0) 	set first frame at end of globals 
169:     ST  1,0(1) 	store old fp (point to self) 
170:    LDA  3,1(7) 	Return address in ac 
171:    LDA  7,-142(7) 	Jump to main 
172:   HALT  0,0,0 	DONE! 
* END Init
