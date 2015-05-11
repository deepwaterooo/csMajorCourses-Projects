* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  array.tm
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
* BEGIN function get
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 31:     ST  1,-4(1) 	Store old frame in ghost frame 
 32:    LDC  3,0(6) 	Load constant 
 33:     ST  3,-6(1) 	Save index 
 34:     ST  3,-7(1) 	Store parameter 
 35:    LDA  1,-4(1) 	Load address of new frame 
 36:    LDA  3,1(7) 	Return address in ac 
 37:    LDA  7,-32(7) 	CALL output
 38:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 39:     ST  1,-4(1) 	Store old frame in ghost frame 
 40:    LDA  1,-4(1) 	Load address of new frame 
 41:    LDA  3,1(7) 	Return address in ac 
 42:    LDA  7,-18(7) 	CALL outnl
 43:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 44:    LDC  3,1(6) 	Load constant 
 45:     ST  3,-4(1) 	Save index 
 46:    LDC  3,666(6) 	Load constant 
 47:     ST  3,-2(1) 	Store variable x
* RETURN
 48:     LD  3,-3(1) 	Load variable i
 49:     ST  3,-5(1) 	Save index 
 50:    LDA  2,0(3) 	Copy result to rt register 
 51:     LD  3,-1(1) 	Load return address 
 52:     LD  1,0(1) 	Adjust fp 
 53:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 54:    LDC  2,0(6) 	Set return value to 0 
 55:     LD  3,-1(1) 	Load return address 
 56:     LD  1,0(1) 	Adjust fp 
 57:    LDA  7,0(3) 	Return 
* END function get
* BEGIN function main
 58:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 59:    LDC  3,0(6) 	load size of array x
 60:     ST  3,0(1) 	save size of array x
* EXPRESSION STMT
 61:    LDC  3,2(6) 	Load constant 
 62:     ST  3,-2(1) 	Store variable dog
* EXPRESSION STMT
 63:    LDC  3,0(6) 	Load constant 
 64:     ST  3,-3(1) 	Save index 
 65:    LDC  3,3(6) 	Load constant 
 66:     ST  3,-1(1) 	Store variable x
* EXPRESSION STMT
 67:     ST  1,-4(1) 	Store old frame in ghost frame 
 68:    LDC  3,0(6) 	Load constant 
 69:     ST  3,-6(1) 	Save index 
 70:     ST  3,-7(1) 	Store parameter 
 71:    LDA  1,-4(1) 	Load address of new frame 
 72:    LDA  3,1(7) 	Return address in ac 
 73:    LDA  7,-68(7) 	CALL output
 74:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 75:    LDC  3,1(6) 	Load constant 
 76:     ST  3,-4(1) 	Save index 
 77:    LDC  3,0(6) 	Load constant 
 78:    LDA  4,-1(0) 	Load address of base of array x
 79:    SUB  3,4,3 	Compute offset of value 
 80:     LD  3,0(3) 	Load the value 
 81:     LD  4,-4(1) 	Restore index 
 82:    LDA  5,-1(0) 	Load address of base of array x
 83:    SUB  5,5,4 	Compute offset of value 
 84:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 85:     ST  1,-4(1) 	Store old frame in ghost frame 
 86:    LDC  3,1(6) 	Load constant 
 87:     ST  3,-6(1) 	Save index 
 88:     ST  3,-7(1) 	Store parameter 
 89:    LDA  1,-4(1) 	Load address of new frame 
 90:    LDA  3,1(7) 	Return address in ac 
 91:    LDA  7,-86(7) 	CALL output
 92:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 93:    LDC  3,2(6) 	Load constant 
 94:     ST  3,-4(1) 	Save index 
 95:    LDC  3,1(6) 	Load constant 
 96:     ST  3,-5(1) 	Save index 
 97:     ST  3,-6(1) 	Save left side 
 98:    LDC  3,1(6) 	Load constant 
 99:     LD  4,-6(1) 	Load left into ac1 
100:    ADD  3,4,3 	Op + 
101:     ST  3,-1(1) 	Store variable x
* EXPRESSION STMT
102:     ST  1,-6(1) 	Store old frame in ghost frame 
103:    LDC  3,2(6) 	Load constant 
104:     ST  3,-8(1) 	Save index 
105:     ST  3,-9(1) 	Store parameter 
106:    LDA  1,-6(1) 	Load address of new frame 
107:    LDA  3,1(7) 	Return address in ac 
108:    LDA  7,-103(7) 	CALL output
109:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
110:     LD  3,-2(1) 	Load variable dog
111:     ST  3,-6(1) 	Save left side 
112:     LD  3,-2(1) 	Load variable dog
113:     LD  4,-6(1) 	Load left into ac1 
114:    ADD  3,4,3 	Op + 
115:     ST  3,-6(1) 	Save index 
116:    LDC  3,496(6) 	Load constant 
117:     ST  3,-1(1) 	Store variable x
* EXPRESSION STMT
118:     ST  1,-7(1) 	Store old frame in ghost frame 
119:    LDC  3,4(6) 	Load constant 
120:     ST  3,-9(1) 	Save index 
121:     ST  3,-10(1) 	Store parameter 
122:    LDA  1,-7(1) 	Load address of new frame 
123:    LDA  3,1(7) 	Return address in ac 
124:    LDA  7,-119(7) 	CALL output
125:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
126:     ST  1,-7(1) 	Store old frame in ghost frame 
127:    LDA  1,-7(1) 	Load address of new frame 
128:    LDA  3,1(7) 	Return address in ac 
129:    LDA  7,-105(7) 	CALL outnl
130:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
131:    LDC  3,2(6) 	Load constant 
132:     ST  3,-2(1) 	Store variable dog
* EXPRESSION STMT
133:    LDC  3,0(6) 	Load constant 
134:     ST  3,-7(1) 	Save index 
135:    LDC  3,3(6) 	Load constant 
136:     ST  3,-1(1) 	Store variable y
* EXPRESSION STMT
137:     ST  1,-8(1) 	Store old frame in ghost frame 
138:    LDC  3,0(6) 	Load constant 
139:     ST  3,-10(1) 	Save index 
140:     ST  3,-11(1) 	Store parameter 
141:    LDA  1,-8(1) 	Load address of new frame 
142:    LDA  3,1(7) 	Return address in ac 
143:    LDA  7,-138(7) 	CALL output
144:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
145:    LDC  3,1(6) 	Load constant 
146:     ST  3,-8(1) 	Save index 
147:    LDC  3,0(6) 	Load constant 
148:    LDA  4,-1(0) 	Load address of base of array y
149:    SUB  3,4,3 	Compute offset of value 
150:     LD  3,0(3) 	Load the value 
151:     LD  4,-8(1) 	Restore index 
152:    LDA  5,-1(0) 	Load address of base of array y
153:    SUB  5,5,4 	Compute offset of value 
154:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
155:     ST  1,-8(1) 	Store old frame in ghost frame 
156:    LDC  3,1(6) 	Load constant 
157:     ST  3,-10(1) 	Save index 
158:     ST  3,-11(1) 	Store parameter 
159:    LDA  1,-8(1) 	Load address of new frame 
160:    LDA  3,1(7) 	Return address in ac 
161:    LDA  7,-156(7) 	CALL output
162:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
163:    LDC  3,2(6) 	Load constant 
164:     ST  3,-8(1) 	Save index 
165:    LDC  3,1(6) 	Load constant 
166:     ST  3,-9(1) 	Save index 
167:     ST  3,-10(1) 	Save left side 
168:    LDC  3,311(6) 	Load constant 
169:     LD  4,-10(1) 	Load left into ac1 
170:    ADD  3,4,3 	Op + 
171:     ST  3,-1(1) 	Store variable y
* EXPRESSION STMT
172:     ST  1,-10(1) 	Store old frame in ghost frame 
173:    LDC  3,2(6) 	Load constant 
174:     ST  3,-12(1) 	Save index 
175:     ST  3,-13(1) 	Store parameter 
176:    LDA  1,-10(1) 	Load address of new frame 
177:    LDA  3,1(7) 	Return address in ac 
178:    LDA  7,-173(7) 	CALL output
179:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
180:     LD  3,-2(1) 	Load variable dog
181:     ST  3,-10(1) 	Save left side 
182:     LD  3,-2(1) 	Load variable dog
183:     LD  4,-10(1) 	Load left into ac1 
184:    ADD  3,4,3 	Op + 
185:     ST  3,-10(1) 	Save index 
186:    LDC  3,496(6) 	Load constant 
187:     ST  3,-1(1) 	Store variable y
* EXPRESSION STMT
188:     ST  1,-11(1) 	Store old frame in ghost frame 
189:    LDC  3,4(6) 	Load constant 
190:     ST  3,-13(1) 	Save index 
191:     ST  3,-14(1) 	Store parameter 
192:    LDA  1,-11(1) 	Load address of new frame 
193:    LDA  3,1(7) 	Return address in ac 
194:    LDA  7,-189(7) 	CALL output
195:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
196:     ST  1,-11(1) 	Store old frame in ghost frame 
197:    LDA  1,-11(1) 	Load address of new frame 
198:    LDA  3,1(7) 	Return address in ac 
199:    LDA  7,-175(7) 	CALL outnl
200:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
* EXPRESSION STMT
201:     ST  1,-11(1) 	Store old frame in ghost frame 
202:     LD  3,-1(1) 	Load variable y
203:     ST  3,-13(1) 	Store parameter 
204:    LDC  3,2(6) 	Load constant 
205:     ST  3,-14(1) 	Store parameter 
206:    LDA  1,-11(1) 	Load address of new frame 
207:    LDA  3,1(7) 	Return address in ac 
208:    LDA  7,-179(7) 	CALL get
209:    LDA  3,0(2) 	Save the result in ac 
210:     ST  3,-2(1) 	Store variable dog
* EXPRESSION STMT
211:     ST  1,-11(1) 	Store old frame in ghost frame 
212:     LD  3,-2(1) 	Load variable dog
213:     ST  3,-13(1) 	Store parameter 
214:    LDA  1,-11(1) 	Load address of new frame 
215:    LDA  3,1(7) 	Return address in ac 
216:    LDA  7,-211(7) 	CALL output
217:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
218:     ST  1,-11(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
219:     ST  1,-13(1) 	Store old frame in ghost frame 
220:     LD  3,-1(1) 	Load variable y
221:     ST  3,-15(1) 	Store parameter 
222:    LDC  3,2(6) 	Load constant 
223:     ST  3,-16(1) 	Store parameter 
224:    LDA  1,-13(1) 	Load address of new frame 
225:    LDA  3,1(7) 	Return address in ac 
226:    LDA  7,-197(7) 	CALL get
227:    LDA  3,0(2) 	Save the result in ac 
228:     ST  3,-13(1) 	Store parameter 
229:    LDA  1,-11(1) 	Load address of new frame 
230:    LDA  3,1(7) 	Return address in ac 
231:    LDA  7,-226(7) 	CALL output
232:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
233:     ST  1,-11(1) 	Store old frame in ghost frame 
234:    LDC  3,1(6) 	Load constant 
235:     ST  3,-13(1) 	Save index 
236:     ST  3,-14(1) 	Store parameter 
237:    LDA  1,-11(1) 	Load address of new frame 
238:    LDA  3,1(7) 	Return address in ac 
239:    LDA  7,-234(7) 	CALL output
240:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
241:     ST  1,-11(1) 	Store old frame in ghost frame 
242:    LDA  1,-11(1) 	Load address of new frame 
243:    LDA  3,1(7) 	Return address in ac 
244:    LDA  7,-220(7) 	CALL outnl
245:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
246:    LDC  2,0(6) 	Set return value to 0 
247:     LD  3,-1(1) 	Load return address 
248:     LD  1,0(1) 	Adjust fp 
249:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,249(7) 	Jump to init 
* BEGIN Init
250:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
251:    LDC  3,0(6) 	load size of array y
252:     ST  3,-1(0) 	save size of array y
* END init of global array sizes
253:    LDA  1,-1(0) 	set first frame at end of globals 
254:     ST  1,0(1) 	store old fp (point to self) 
255:    LDA  3,1(7) 	Return address in ac 
256:    LDA  7,-199(7) 	Jump to main 
257:   HALT  0,0,0 	DONE! 
* END Init
