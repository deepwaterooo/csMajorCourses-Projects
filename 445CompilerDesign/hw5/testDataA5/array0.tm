* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  array0.c-
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
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:     ST  1,-4(1) 	Store old fp in ghost frame 
 32:     LD  3,-3(1) 	Load variable n
 33:     LD  4,-2(1) 	Load address of base of array z
 34:    SUB  3,4,3 	Compute offset of value 
 35:     LD  3,0(3) 	Load the value 
 36:     ST  3,-6(1) 	Store parameter 
 37:    LDA  1,-4(1) 	Load address of new frame 
 38:    LDA  3,1(7) 	Return address in ac 
 39:    LDA  7,-34(7) 	CALL output
 40:    LDA  3,0(2) 	Save the result in ac 
* RETURN
 41:     LD  3,-3(1) 	Load variable n
 42:     LD  4,-2(1) 	Load address of base of array z
 43:    SUB  3,4,3 	Compute offset of value 
 44:     LD  3,0(3) 	Load the value 
 45:    LDA  2,0(3) 	Copy result to rt register 
 46:     LD  3,-1(1) 	Load return address 
 47:     LD  1,0(1) 	Adjust fp 
 48:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 49:    LDC  2,0(6) 	Set return value to 0 
 50:     LD  3,-1(1) 	Load return address 
 51:     LD  1,0(1) 	Adjust fp 
 52:    LDA  7,0(3) 	Return 
* END of function show
* BEGIN function main
 53:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 54:    LDC  3,4(6) 	load size of array a
 55:     ST  3,-2(1) 	save size of array a
* EXPRESSION STMT
 56:    LDC  3,1(6) 	Load constant 
 57:     ST  3,-7(1) 	Save index 
 58:    LDC  3,666(6) 	Load constant 
 59:     LD  4,-7(1) 	Restore index 
 60:    LDA  5,-1(0) 	Load address of base of array g
 61:    SUB  5,5,4 	Compute offset of value 
 62:     ST  3,0(5) 	Store variable g
* EXPRESSION STMT
 63:    LDC  3,1(6) 	Load constant 
 64:     ST  3,-7(1) 	Save index 
 65:    LDC  3,777(6) 	Load constant 
 66:     LD  4,-7(1) 	Restore index 
 67:    LDA  5,-3(1) 	Load address of base of array a
 68:    SUB  5,5,4 	Compute offset of value 
 69:     ST  3,0(5) 	Store variable a
* EXPRESSION STMT
 70:     ST  1,-7(1) 	Store old fp in ghost frame 
 71:    LDC  3,1(6) 	Load constant 
 72:    LDA  4,-3(1) 	Load address of base of array a
 73:    SUB  3,4,3 	Compute offset of value 
 74:     LD  3,0(3) 	Load the value 
 75:     ST  3,-9(1) 	Store parameter 
 76:    LDA  1,-7(1) 	Load address of new frame 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-73(7) 	CALL output
 79:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 80:     ST  1,-7(1) 	Store old fp in ghost frame 
 81:    LDC  3,1(6) 	Load constant 
 82:    LDA  4,-1(0) 	Load address of base of array g
 83:    SUB  3,4,3 	Compute offset of value 
 84:     LD  3,0(3) 	Load the value 
 85:     ST  3,-9(1) 	Store parameter 
 86:    LDA  1,-7(1) 	Load address of new frame 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-83(7) 	CALL output
 89:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 90:     ST  1,-7(1) 	Store old fp in ghost frame 
 91:    LDA  1,-7(1) 	Load address of new frame 
 92:    LDA  3,1(7) 	Return address in ac 
 93:    LDA  7,-69(7) 	CALL outnl
 94:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 95:     ST  1,-7(1) 	Store old fp in ghost frame 
 96:    LDA  3,-3(1) 	Load address of base of array a
 97:     ST  3,-9(1) 	Store parameter 
 98:    LDC  3,1(6) 	Load constant 
 99:     ST  3,-10(1) 	Store parameter 
100:    LDA  1,-7(1) 	Load address of new frame 
101:    LDA  3,1(7) 	Return address in ac 
102:    LDA  7,-73(7) 	CALL show
103:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
104:     ST  1,-7(1) 	Store old fp in ghost frame 
105:    LDA  3,-1(0) 	Load address of base of array g
106:     ST  3,-9(1) 	Store parameter 
107:    LDC  3,1(6) 	Load constant 
108:     ST  3,-10(1) 	Store parameter 
109:    LDA  1,-7(1) 	Load address of new frame 
110:    LDA  3,1(7) 	Return address in ac 
111:    LDA  7,-82(7) 	CALL show
112:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
113:     ST  1,-7(1) 	Store old fp in ghost frame 
114:    LDA  1,-7(1) 	Load address of new frame 
115:    LDA  3,1(7) 	Return address in ac 
116:    LDA  7,-92(7) 	CALL outnl
117:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
118:     ST  1,-7(1) 	Store old fp in ghost frame 
119:     ST  1,-9(1) 	Store old fp in ghost frame 
120:    LDA  3,-3(1) 	Load address of base of array a
121:     ST  3,-11(1) 	Store parameter 
122:    LDC  3,1(6) 	Load constant 
123:     ST  3,-12(1) 	Store parameter 
124:    LDA  1,-9(1) 	Load address of new frame 
125:    LDA  3,1(7) 	Return address in ac 
126:    LDA  7,-97(7) 	CALL show
127:    LDA  3,0(2) 	Save the result in ac 
128:     ST  3,-9(1) 	Store parameter 
129:    LDA  1,-7(1) 	Load address of new frame 
130:    LDA  3,1(7) 	Return address in ac 
131:    LDA  7,-126(7) 	CALL output
132:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
133:     ST  1,-7(1) 	Store old fp in ghost frame 
134:     ST  1,-9(1) 	Store old fp in ghost frame 
135:    LDA  3,-1(0) 	Load address of base of array g
136:     ST  3,-11(1) 	Store parameter 
137:    LDC  3,1(6) 	Load constant 
138:     ST  3,-12(1) 	Store parameter 
139:    LDA  1,-9(1) 	Load address of new frame 
140:    LDA  3,1(7) 	Return address in ac 
141:    LDA  7,-112(7) 	CALL show
142:    LDA  3,0(2) 	Save the result in ac 
143:     ST  3,-9(1) 	Store parameter 
144:    LDA  1,-7(1) 	Load address of new frame 
145:    LDA  3,1(7) 	Return address in ac 
146:    LDA  7,-141(7) 	CALL output
147:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
148:     ST  1,-7(1) 	Store old fp in ghost frame 
149:    LDA  1,-7(1) 	Load address of new frame 
150:    LDA  3,1(7) 	Return address in ac 
151:    LDA  7,-127(7) 	CALL outnl
152:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
153:    LDC  3,1(6) 	Load constant 
154:     ST  3,-7(1) 	Save index 
155:    LDC  3,4(6) 	Load constant 
156:     LD  4,-7(1) 	Restore index 
157:    LDA  5,-1(0) 	Load address of base of array g
158:    SUB  5,5,4 	Compute offset of value 
159:     LD  4,0(5) 	load lhs variable g
160:    ADD  3,4,3 	op += 
161:     ST  3,0(5) 	Store variable g
* EXPRESSION STMT
162:    LDC  3,1(6) 	Load constant 
163:     ST  3,-7(1) 	Save index 
164:    LDC  3,3(6) 	Load constant 
165:     LD  4,-7(1) 	Restore index 
166:    LDA  5,-3(1) 	Load address of base of array a
167:    SUB  5,5,4 	Compute offset of value 
168:     LD  4,0(5) 	load lhs variable a
169:    ADD  3,4,3 	op += 
170:     ST  3,0(5) 	Store variable a
* EXPRESSION STMT
171:     ST  1,-7(1) 	Store old fp in ghost frame 
172:    LDC  3,1(6) 	Load constant 
173:    LDA  4,-3(1) 	Load address of base of array a
174:    SUB  3,4,3 	Compute offset of value 
175:     LD  3,0(3) 	Load the value 
176:     ST  3,-9(1) 	Store parameter 
177:    LDA  1,-7(1) 	Load address of new frame 
178:    LDA  3,1(7) 	Return address in ac 
179:    LDA  7,-174(7) 	CALL output
180:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
181:     ST  1,-7(1) 	Store old fp in ghost frame 
182:    LDC  3,1(6) 	Load constant 
183:    LDA  4,-1(0) 	Load address of base of array g
184:    SUB  3,4,3 	Compute offset of value 
185:     LD  3,0(3) 	Load the value 
186:     ST  3,-9(1) 	Store parameter 
187:    LDA  1,-7(1) 	Load address of new frame 
188:    LDA  3,1(7) 	Return address in ac 
189:    LDA  7,-184(7) 	CALL output
190:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
191:     ST  1,-7(1) 	Store old fp in ghost frame 
192:    LDA  1,-7(1) 	Load address of new frame 
193:    LDA  3,1(7) 	Return address in ac 
194:    LDA  7,-170(7) 	CALL outnl
195:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
196:     ST  1,-7(1) 	Store old fp in ghost frame 
197:    LDC  3,1(6) 	Load constant 
198:     ST  3,-9(1) 	Save index 
199:    LDC  3,100(6) 	Load constant 
200:     LD  4,-9(1) 	Restore index 
201:    LDA  5,-3(1) 	Load address of base of array a
202:    SUB  5,5,4 	Compute offset of value 
203:     LD  4,0(5) 	load lhs variable a
204:    ADD  3,4,3 	op += 
205:     ST  3,0(5) 	Store variable a
206:     ST  3,-9(1) 	Store parameter 
207:    LDA  1,-7(1) 	Load address of new frame 
208:    LDA  3,1(7) 	Return address in ac 
209:    LDA  7,-204(7) 	CALL output
210:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
211:     ST  1,-7(1) 	Store old fp in ghost frame 
212:    LDC  3,1(6) 	Load constant 
213:     ST  3,-9(1) 	Save index 
214:    LDC  3,100(6) 	Load constant 
215:     LD  4,-9(1) 	Restore index 
216:    LDA  5,-1(0) 	Load address of base of array g
217:    SUB  5,5,4 	Compute offset of value 
218:     LD  4,0(5) 	load lhs variable g
219:    ADD  3,4,3 	op += 
220:     ST  3,0(5) 	Store variable g
221:     ST  3,-9(1) 	Store parameter 
222:    LDA  1,-7(1) 	Load address of new frame 
223:    LDA  3,1(7) 	Return address in ac 
224:    LDA  7,-219(7) 	CALL output
225:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
226:     ST  1,-7(1) 	Store old fp in ghost frame 
227:    LDA  1,-7(1) 	Load address of new frame 
228:    LDA  3,1(7) 	Return address in ac 
229:    LDA  7,-205(7) 	CALL outnl
230:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
231:    LDC  2,0(6) 	Set return value to 0 
232:     LD  3,-1(1) 	Load return address 
233:     LD  1,0(1) 	Adjust fp 
234:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,234(7) 	Jump to init 
* BEGIN Init
235:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
236:    LDC  3,4(6) 	load size of array g
237:     ST  3,0(0) 	save size of array g
* END init of global array sizes
238:    LDA  1,-5(0) 	set first frame at end of globals 
239:     ST  1,0(1) 	store old fp (point to self) 
240:    LDA  3,1(7) 	Return address in ac 
241:    LDA  7,-189(7) 	Jump to main 
242:   HALT  0,0,0 	DONE! 
* END Init
