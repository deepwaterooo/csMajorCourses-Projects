* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  def.tm
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
* BEGIN function show
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 31:     ST  1,-4(1) 	Store old frame in ghost frame 
 32:     LD  3,-3(1) 	Load variable n
 33:     ST  3,-6(1) 	Save index 
 34:     ST  3,-7(1) 	Store parameter 
 35:    LDA  1,-4(1) 	Load address of new frame 
 36:    LDA  3,1(7) 	Return address in ac 
 37:    LDA  7,-32(7) 	CALL output
 38:    LDA  3,0(2) 	Save the result in ac 
* RETURN
 39:     LD  3,-3(1) 	Load variable n
 40:     ST  3,-4(1) 	Save index 
 41:    LDA  2,0(3) 	Copy result to rt register 
 42:     LD  3,-1(1) 	Load return address 
 43:     LD  1,0(1) 	Adjust fp 
 44:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 45:    LDC  2,0(6) 	Set return value to 0 
 46:     LD  3,-1(1) 	Load return address 
 47:     LD  1,0(1) 	Adjust fp 
 48:    LDA  7,0(3) 	Return 
* END function show
* BEGIN function main
 49:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 50:    LDC  3,0(6) 	load size of array a
 51:     ST  3,0(1) 	save size of array a
* EXPRESSION STMT
 52:    LDC  3,1(6) 	Load constant 
 53:     ST  3,-2(1) 	Save index 
 54:    LDC  3,666(6) 	Load constant 
 55:     ST  3,-1(1) 	Store variable g
* EXPRESSION STMT
 56:    LDC  3,1(6) 	Load constant 
 57:     ST  3,-3(1) 	Save index 
 58:    LDC  3,777(6) 	Load constant 
 59:     ST  3,-1(1) 	Store variable a
* EXPRESSION STMT
 60:     ST  1,-4(1) 	Store old frame in ghost frame 
 61:    LDC  3,1(6) 	Load constant 
 62:     ST  3,-6(1) 	Save index 
 63:     ST  3,-7(1) 	Store parameter 
 64:    LDA  1,-4(1) 	Load address of new frame 
 65:    LDA  3,1(7) 	Return address in ac 
 66:    LDA  7,-61(7) 	CALL output
 67:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 68:     ST  1,-4(1) 	Store old frame in ghost frame 
 69:    LDC  3,1(6) 	Load constant 
 70:     ST  3,-6(1) 	Save index 
 71:     ST  3,-7(1) 	Store parameter 
 72:    LDA  1,-4(1) 	Load address of new frame 
 73:    LDA  3,1(7) 	Return address in ac 
 74:    LDA  7,-69(7) 	CALL output
 75:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 76:     ST  1,-4(1) 	Store old frame in ghost frame 
 77:    LDA  1,-4(1) 	Load address of new frame 
 78:    LDA  3,1(7) 	Return address in ac 
 79:    LDA  7,-55(7) 	CALL outnl
 80:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 81:     ST  1,-4(1) 	Store old frame in ghost frame 
 82:     LD  3,-1(1) 	Load variable a
 83:     ST  3,-6(1) 	Store parameter 
 84:    LDC  3,1(6) 	Load constant 
 85:     ST  3,-7(1) 	Store parameter 
 86:    LDA  1,-4(1) 	Load address of new frame 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-59(7) 	CALL show
 89:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 90:     ST  1,-4(1) 	Store old frame in ghost frame 
 91:     LD  3,-1(1) 	Load variable g
 92:     ST  3,-6(1) 	Store parameter 
 93:    LDC  3,1(6) 	Load constant 
 94:     ST  3,-7(1) 	Store parameter 
 95:    LDA  1,-4(1) 	Load address of new frame 
 96:    LDA  3,1(7) 	Return address in ac 
 97:    LDA  7,-68(7) 	CALL show
 98:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 99:     ST  1,-4(1) 	Store old frame in ghost frame 
100:    LDA  1,-4(1) 	Load address of new frame 
101:    LDA  3,1(7) 	Return address in ac 
102:    LDA  7,-78(7) 	CALL outnl
103:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
104:     ST  1,-4(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
105:     ST  1,-6(1) 	Store old frame in ghost frame 
106:     LD  3,-1(1) 	Load variable a
107:     ST  3,-8(1) 	Store parameter 
108:    LDC  3,1(6) 	Load constant 
109:     ST  3,-9(1) 	Store parameter 
110:    LDA  1,-6(1) 	Load address of new frame 
111:    LDA  3,1(7) 	Return address in ac 
112:    LDA  7,-83(7) 	CALL show
113:    LDA  3,0(2) 	Save the result in ac 
114:     ST  3,-6(1) 	Store parameter 
115:    LDA  1,-4(1) 	Load address of new frame 
116:    LDA  3,1(7) 	Return address in ac 
117:    LDA  7,-112(7) 	CALL output
118:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
119:     ST  1,-4(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
120:     ST  1,-6(1) 	Store old frame in ghost frame 
121:     LD  3,-1(1) 	Load variable g
122:     ST  3,-8(1) 	Store parameter 
123:    LDC  3,1(6) 	Load constant 
124:     ST  3,-9(1) 	Store parameter 
125:    LDA  1,-6(1) 	Load address of new frame 
126:    LDA  3,1(7) 	Return address in ac 
127:    LDA  7,-98(7) 	CALL show
128:    LDA  3,0(2) 	Save the result in ac 
129:     ST  3,-6(1) 	Store parameter 
130:    LDA  1,-4(1) 	Load address of new frame 
131:    LDA  3,1(7) 	Return address in ac 
132:    LDA  7,-127(7) 	CALL output
133:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
134:     ST  1,-4(1) 	Store old frame in ghost frame 
135:    LDA  1,-4(1) 	Load address of new frame 
136:    LDA  3,1(7) 	Return address in ac 
137:    LDA  7,-113(7) 	CALL outnl
138:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
139:    LDC  3,1(6) 	Load constant 
140:     ST  3,-4(1) 	Save index 
141:    LDC  3,4(6) 	Load constant 
142:     ST  3,-1(1) 	Store variable g
* EXPRESSION STMT
143:    LDC  3,1(6) 	Load constant 
144:     ST  3,-5(1) 	Save index 
145:    LDC  3,3(6) 	Load constant 
146:     ST  3,-1(1) 	Store variable a
* EXPRESSION STMT
147:     ST  1,-6(1) 	Store old frame in ghost frame 
148:    LDC  3,1(6) 	Load constant 
149:     ST  3,-8(1) 	Save index 
150:     ST  3,-9(1) 	Store parameter 
151:    LDA  1,-6(1) 	Load address of new frame 
152:    LDA  3,1(7) 	Return address in ac 
153:    LDA  7,-148(7) 	CALL output
154:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
155:     ST  1,-6(1) 	Store old frame in ghost frame 
156:    LDC  3,1(6) 	Load constant 
157:     ST  3,-8(1) 	Save index 
158:     ST  3,-9(1) 	Store parameter 
159:    LDA  1,-6(1) 	Load address of new frame 
160:    LDA  3,1(7) 	Return address in ac 
161:    LDA  7,-156(7) 	CALL output
162:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
163:     ST  1,-6(1) 	Store old frame in ghost frame 
164:    LDA  1,-6(1) 	Load address of new frame 
165:    LDA  3,1(7) 	Return address in ac 
166:    LDA  7,-142(7) 	CALL outnl
167:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
168:     ST  1,-6(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
169:    LDC  3,1(6) 	Load constant 
170:     ST  3,-8(1) 	Save index 
171:    LDC  3,100(6) 	Load constant 
172:     ST  3,-1(1) 	Store variable a
173:     ST  3,-9(1) 	Store parameter 
174:    LDA  1,-6(1) 	Load address of new frame 
175:    LDA  3,1(7) 	Return address in ac 
176:    LDA  7,-171(7) 	CALL output
177:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
178:     ST  1,-6(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
179:    LDC  3,1(6) 	Load constant 
180:     ST  3,-8(1) 	Save index 
181:    LDC  3,100(6) 	Load constant 
182:     ST  3,-1(1) 	Store variable g
183:     ST  3,-9(1) 	Store parameter 
184:    LDA  1,-6(1) 	Load address of new frame 
185:    LDA  3,1(7) 	Return address in ac 
186:    LDA  7,-181(7) 	CALL output
187:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
188:     ST  1,-6(1) 	Store old frame in ghost frame 
189:    LDA  1,-6(1) 	Load address of new frame 
190:    LDA  3,1(7) 	Return address in ac 
191:    LDA  7,-167(7) 	CALL outnl
192:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
193:    LDC  2,0(6) 	Set return value to 0 
194:     LD  3,-1(1) 	Load return address 
195:     LD  1,0(1) 	Adjust fp 
196:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,196(7) 	Jump to init 
* BEGIN Init
197:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
198:    LDC  3,0(6) 	load size of array g
199:     ST  3,-1(0) 	save size of array g
* END init of global array sizes
200:    LDA  1,-1(0) 	set first frame at end of globals 
201:     ST  1,0(1) 	store old fp (point to self) 
202:    LDA  3,1(7) 	Return address in ac 
203:    LDA  7,-155(7) 	Jump to main 
204:   HALT  0,0,0 	DONE! 
* END Init
