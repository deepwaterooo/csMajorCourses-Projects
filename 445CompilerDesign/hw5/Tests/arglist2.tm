* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  arglist2.tm
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
* BEGIN function kate
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* RETURN
 31:    LDC  3,666(6) 	Load constant 
 32:    LDA  2,0(3) 	Copy result to rt register 
 33:     LD  3,-1(1) 	Load return address 
 34:     LD  1,0(1) 	Adjust fp 
 35:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 36:    LDC  2,0(6) 	Set return value to 0 
 37:     LD  3,-1(1) 	Load return address 
 38:     LD  1,0(1) 	Adjust fp 
 39:    LDA  7,0(3) 	Return 
* END function kate
* BEGIN function matty
 40:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 41:    LDC  3,0(6) 	load size of array inta
 42:     ST  3,1(1) 	save size of array inta
 43:    LDC  3,0(6) 	load size of array boola
 44:     ST  3,-2(1) 	save size of array boola
* EXPRESSION STMT
 45:     ST  1,-3(1) 	Store old frame in ghost frame 
 46:    LDC  3,101(6) 	Load constant 
 47:     ST  3,-5(1) 	Store parameter 
 48:    LDA  1,-3(1) 	Load address of new frame 
 49:    LDA  3,1(7) 	Return address in ac 
 50:    LDA  7,-21(7) 	CALL kate
 51:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 52:     ST  1,-3(1) 	Store old frame in ghost frame 
 53:    LDC  3,101(6) 	Load constant 
 54:     ST  3,-5(1) 	Store parameter 
 55:    LDC  3,1(6) 	Load constant 
 56:     ST  3,-6(1) 	Store parameter 
 57:    LDA  1,-3(1) 	Load address of new frame 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-30(7) 	CALL kate
 60:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 61:     ST  1,-3(1) 	Store old frame in ghost frame 
 62:    LDC  3,101(6) 	Load constant 
 63:     ST  3,-5(1) 	Store parameter 
 64:    LDC  3,1(6) 	Load constant 
 65:     ST  3,-6(1) 	Store parameter 
 66:     LD  3,0(1) 	Load variable inta
 67:     ST  3,-7(1) 	Store parameter 
 68:    LDA  1,-3(1) 	Load address of new frame 
 69:    LDA  3,1(7) 	Return address in ac 
 70:    LDA  7,-41(7) 	CALL kate
 71:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 72:     ST  1,-3(1) 	Store old frame in ghost frame 
 73:    LDC  3,101(6) 	Load constant 
 74:     ST  3,-5(1) 	Store parameter 
 75:    LDC  3,1(6) 	Load constant 
 76:     ST  3,-6(1) 	Store parameter 
 77:     LD  3,0(1) 	Load variable inta
 78:     ST  3,-7(1) 	Store parameter 
 79:     LD  3,-3(1) 	Load variable boola
 80:     ST  3,-8(1) 	Store parameter 
 81:    LDA  1,-3(1) 	Load address of new frame 
 82:    LDA  3,1(7) 	Return address in ac 
 83:    LDA  7,-54(7) 	CALL kate
 84:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 85:     ST  1,-3(1) 	Store old frame in ghost frame 
 86:    LDC  3,101(6) 	Load constant 
 87:     ST  3,-5(1) 	Store parameter 
 88:    LDC  3,1(6) 	Load constant 
 89:     ST  3,-6(1) 	Store parameter 
 90:     LD  3,0(1) 	Load variable inta
 91:     ST  3,-7(1) 	Store parameter 
 92:     LD  3,-3(1) 	Load variable boola
 93:     ST  3,-8(1) 	Store parameter 
 94:    LDC  3,107(6) 	Load constant 
 95:     ST  3,-9(1) 	Store parameter 
 96:    LDA  1,-3(1) 	Load address of new frame 
 97:    LDA  3,1(7) 	Return address in ac 
 98:    LDA  7,-69(7) 	CALL kate
 99:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
100:     ST  1,-3(1) 	Store old frame in ghost frame 
101:    LDC  3,101(6) 	Load constant 
102:     ST  3,-5(1) 	Store parameter 
103:    LDC  3,1(6) 	Load constant 
104:     ST  3,-6(1) 	Store parameter 
105:     LD  3,0(1) 	Load variable inta
106:     ST  3,-7(1) 	Store parameter 
107:     LD  3,-3(1) 	Load variable boola
108:     ST  3,-8(1) 	Store parameter 
109:    LDC  3,107(6) 	Load constant 
110:     ST  3,-9(1) 	Store parameter 
111:    LDC  3,109(6) 	Load constant 
112:     ST  3,-10(1) 	Store parameter 
113:    LDA  1,-3(1) 	Load address of new frame 
114:    LDA  3,1(7) 	Return address in ac 
115:    LDA  7,-86(7) 	CALL kate
116:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
117:     ST  1,-3(1) 	Store old frame in ghost frame 
118:    LDC  3,1(6) 	Load constant 
119:     ST  3,-5(1) 	Store parameter 
120:     LD  3,0(1) 	Load variable inta
121:     ST  3,-6(1) 	Store parameter 
122:     LD  3,-3(1) 	Load variable boola
123:     ST  3,-7(1) 	Store parameter 
124:    LDC  3,101(6) 	Load constant 
125:     ST  3,-8(1) 	Store parameter 
126:    LDA  1,-3(1) 	Load address of new frame 
127:    LDA  3,1(7) 	Return address in ac 
128:    LDA  7,-99(7) 	CALL kate
129:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
130:     ST  1,-3(1) 	Store old frame in ghost frame 
131:     LD  3,0(1) 	Load variable inta
132:     ST  3,-5(1) 	Store parameter 
133:     LD  3,-3(1) 	Load variable boola
134:     ST  3,-6(1) 	Store parameter 
135:    LDC  3,101(6) 	Load constant 
136:     ST  3,-7(1) 	Store parameter 
137:    LDC  3,1(6) 	Load constant 
138:     ST  3,-8(1) 	Store parameter 
139:    LDA  1,-3(1) 	Load address of new frame 
140:    LDA  3,1(7) 	Return address in ac 
141:    LDA  7,-112(7) 	CALL kate
142:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
143:     ST  1,-3(1) 	Store old frame in ghost frame 
144:     LD  3,-3(1) 	Load variable boola
145:     ST  3,-5(1) 	Store parameter 
146:    LDC  3,101(6) 	Load constant 
147:     ST  3,-6(1) 	Store parameter 
148:    LDC  3,1(6) 	Load constant 
149:     ST  3,-7(1) 	Store parameter 
150:     LD  3,0(1) 	Load variable inta
151:     ST  3,-8(1) 	Store parameter 
152:    LDA  1,-3(1) 	Load address of new frame 
153:    LDA  3,1(7) 	Return address in ac 
154:    LDA  7,-125(7) 	CALL kate
155:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
156:     ST  1,-3(1) 	Store old frame in ghost frame 
157:    LDC  3,101(6) 	Load constant 
158:     ST  3,-5(1) 	Store parameter 
159:    LDC  3,1(6) 	Load constant 
160:     ST  3,-6(1) 	Store parameter 
161:     LD  3,0(1) 	Load variable inta
162:     ST  3,-7(1) 	Store parameter 
163:     LD  3,-3(1) 	Load variable boola
164:     ST  3,-8(1) 	Store parameter 
165:    LDA  1,-3(1) 	Load address of new frame 
166:    LDA  3,1(7) 	Return address in ac 
167:    LDA  7,-138(7) 	CALL kate
168:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
169:     ST  1,-3(1) 	Store old frame in ghost frame 
170:    LDC  3,101(6) 	Load constant 
171:     ST  3,-5(1) 	Save left side 
172:    LDC  3,1(6) 	Load constant 
173:     LD  4,-5(1) 	Load left into ac1 
174:    ADD  3,4,3 	Op + 
175:    LDC  3,1(6) 	Load constant 
176:     ST  3,-5(1) 	Store parameter 
177:    LDC  3,1(6) 	Load constant 
178:     ST  3,-6(1) 	Store parameter 
179:     LD  3,0(1) 	Load variable inta
180:     ST  3,-7(1) 	Store parameter 
181:     LD  3,-3(1) 	Load variable boola
182:     ST  3,-8(1) 	Store parameter 
183:    LDA  1,-3(1) 	Load address of new frame 
184:  