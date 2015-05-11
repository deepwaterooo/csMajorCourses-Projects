* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  exp2.tm
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
* BEGIN function main
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,11(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 33:    LDC  3,12(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 35:    LDC  3,13(6) 	Load constant 
 36:     ST  3,-1(1) 	Store variable g
* EXPRESSION STMT
 37:    LDC  3,3(6) 	Load constant 
 38:     ST  3,-5(1) 	Save left side 
 39:    LDC  3,4(6) 	Load constant 
 40:     ST  3,-6(1) 	Save left side 
 41:     LD  3,-2(1) 	Load variable x
 42:     LD  4,-6(1) 	Load left into ac1 
 43:    MUL  3,4,3 	Op * 
 44:     LD  4,-5(1) 	Load left into ac1 
 45:    ADD  3,4,3 	Op + 
 46:     ST  3,-5(1) 	Save left side 
 47:     LD  3,-2(1) 	Load variable y
 48:     ST  3,-6(1) 	Save left side 
 49:    LDC  3,7(6) 	Load constant 
 50:     LD  4,-6(1) 	Load left into ac1 
 51:    MUL  3,4,3 	Op * 
 52:     LD  4,-5(1) 	Load left into ac1 
 53:    ADD  3,4,3 	Op + 
 54:     ST  3,-5(1) 	Save left side 
 55:     LD  3,-2(1) 	Load variable x
 56:     ST  3,-6(1) 	Save left side 
 57:     LD  3,-2(1) 	Load variable y
 58:     ST  3,-7(1) 	Save left side 
 59:     LD  3,-1(1) 	Load variable g
 60:     LD  4,-7(1) 	Load left into ac1 
 61:    ADD  3,4,3 	Op + 
 62:     LD  4,-6(1) 	Load left into ac1 
 63:    MUL  3,4,3 	Op * 
 64:     LD  4,-5(1) 	Load left into ac1 
 65:    ADD  3,4,3 	Op + 
 66:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 67:    LDC  3,3(6) 	Load constant 
 68:     ST  3,-5(1) 	Save left side 
 69:    LDC  3,4(6) 	Load constant 
 70:     ST  3,-6(1) 	Save left side 
 71:     LD  3,-2(1) 	Load variable x
 72:     LD  4,-6(1) 	Load left into ac1 
 73:    DIV  3,4,3 	Op / 
 74:     LD  4,-5(1) 	Load left into ac1 
 75:    SUB  3,4,3 	Op - 
 76:     ST  3,-5(1) 	Save left side 
 77:     LD  3,-2(1) 	Load variable y
 78:     ST  3,-6(1) 	Save left side 
 79:    LDC  3,7(6) 	Load constant 
 80:     LD  4,-6(1) 	Load left into ac1 
 81:    DIV  3,4,3 	Op / 
 82:     LD  4,-5(1) 	Load left into ac1 
 83:    SUB  3,4,3 	Op - 
 84:     ST  3,-5(1) 	Save left side 
 85:     LD  3,-2(1) 	Load variable x
 86:     ST  3,-6(1) 	Save left side 
 87:     LD  3,-2(1) 	Load variable y
 88:     ST  3,-7(1) 	Save left side 
 89:     LD  3,-1(1) 	Load variable g
 90:     LD  4,-7(1) 	Load left into ac1 
 91:    SUB  3,4,3 	Op - 
 92:     LD  4,-6(1) 	Load left into ac1 
 93:    DIV  3,4,3 	Op / 
 94:     LD  4,-5(1) 	Load left into ac1 
 95:    SUB  3,4,3 	Op - 
 96:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 97:    LDC  3,3(6) 	Load constant 
 98:     ST  3,-5(1) 	Save left side 
 99:    LDC  3,4(6) 	Load constant 
100:     LD  4,-5(1) 	Load left into ac1 
101:     ST  3,-5(1) 	Save left side 
102:     LD  3,-2(1) 	Load variable x
103:     LD  4,-5(1) 	Load left into ac1 
104:    DIV  3,4,3 	Op / 
105:     ST  3,-5(1) 	Save left side 
106:     LD  3,-2(1) 	Load variable y
107:     ST  3,-6(1) 	Save left side 
108:    LDC  3,7(6) 	Load constant 
109:     LD  4,-6(1) 	Load left into ac1 
110:    DIV  3,4,3 	Op / 
111:     ST  3,-6(1) 	Save left side 
112:     LD  3,-2(1) 	Load variable x
113:     LD  4,-6(1) 	Load left into ac1 
114:     LD  4,-5(1) 	Load left into ac1 
115:     ST  3,-5(1) 	Save left side 
116:     LD  3,-2(1) 	Load variable y
117:     ST  3,-6(1) 	Save left side 
118:     LD  3,-1(1) 	Load variable g
119:     LD  4,-6(1) 	Load left into ac1 
120:     LD  4,-5(1) 	Load left into ac1 
121:    DIV  3,4,3 	Op / 
122:     ST  3,-2(1) 	Store variable x
* END compound statement
* BEGIN compound statement
123:    LDC  3,0(6) 	load size of array z
124:     ST  3,-4(1) 	save size of array z
* EXPRESSION STMT
125:    LDC  3,1(6) 	Load constant 
126:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
127:    LDC  3,0(6) 	Load constant 
128:     ST  3,-3(1) 	Store variable y
* EXPRESSION STMT
129:    LDC  3,1(6) 	Load constant 
130:     ST  3,-5(1) 	Save left side 
131:    LDC  3,0(6) 	Load constant 
132:     ST  3,-6(1) 	Save left side 
133:     LD  3,-4(1) 	Load variable x
134:     LD  4,-6(1) 	Load left into ac1 
135:    JEQ  3,1(7) 	Op AND 
136:    LDA  3,0(4) 	 
137:     LD  4,-5(1) 	Load left into ac1 
138:     ST  3,-5(1) 	Save left side 
139:     LD  3,-3(1) 	Load variable y
140:     ST  3,-6(1) 	Save left side 
141:    LDC  3,7(6) 	Load constant 
142:     LD  4,-6(1) 	Load left into ac1 
143:    JEQ  3,1(7) 	Op AND 
144:    LDA  3,0(4) 	 
145:     LD  4,-5(1) 	Load left into ac1 
146:     ST  3,-5(1) 	Save left side 
147:     LD  3,-4(1) 	Load variable x
148:     ST  3,-6(1) 	Save left side 
149:     LD  3,-3(1) 	Load variable y
150:     ST  3,-7(1) 	Save left side 
151:     LD  3,-1(1) 	Load variable g
152:     LD  4,-7(1) 	Load left into ac1 
153:     LD  4,-6(1) 	Load left into ac1 
154:    JEQ  3,1(7) 	Op AND 
155:    LDA  3,0(4) 	 
156:     LD  4,-5(1) 	Load left into ac1 
157:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
158:    LDC  3,1(6) 	Load constant 
159:     ST  3,-5(1) 	Save left side 
160:     LD  3,-4(1) 	Load variable x
161:     LD  4,-5(1) 	Load left into ac1 
162:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
163:    LDC  3,1(6) 	Load constant 
164:     ST  3,-5(1) 	Save index 
165:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
166:    LDC  3,1(6) 	Load constant 
167:     ST  3,-6(1) 	Save index 
168:     LD  3,-4(1) 	Load variable x
169:     ST  3,-5(1) 	Store variable z
* EXPRESSION STMT
170:    LDC  3,1(6) 	Load constant 
171:     ST  3,-7(1) 	Save index 
172:    LDC  3,2(6) 	Load constant 
173:    LDA  4,-5(1) 	Load address of base of array z
174:    SUB  3,4,3 	Compute offset of value 
175:     LD  3,0(3) 	Load the value 
176:     LD  4,-7(1) 	Restore index 
177:    LDA  5,-5(1) 	Load address of base of array z
178:    SUB  5,5,4 	Compute offset of value 
179:     ST  3,0(5) 	Store variable z
* EXPRESSION STMT
180:    LDC  3,1(6) 	Load constant 
181:     ST  3,-7(1) 	Save index 
182:    LDC  3,2(6) 	Load constant 
183:     ST  3,-8(1) 	Save index 
184:     ST  3,-9(1) 	Save left side 
185:    LDC  3,3(6) 	Load constant 
186:     ST  3,-10(1) 	Save index 
187:     LD  4,-10(1) 	Load left into ac1 
188:    ADD  3,4,3 	Op + 
189:     ST  3,-5(1) 	Store variable z
* END compound statement
* BEGIN compound statement
190:    LDC  3,0(6) 	load size of array z
191:     ST  3,-5(1) 	save size of array z
* EXPRESSION STMT
192:    LDC  3,1(6) 	Load constant 
193:     ST  3,-10(1) 	Save index 
194:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
195:    LDC  3,1(6) 	Load constant 
196:     ST  3,-11(1) 	Save index 
197:     LD  3,0(1) 	Load variable x
198:     ST  3,-6(1) 	Store variable z
* EXPRESSION STMT
199:    LDC  3,1(6) 	Load constant 
200:     ST  3,-12(1) 	Save index 
201:    LDC  3,2(6) 	Load constant 
202:    LDA  4,-6(0) 	Load address of base of array z
203:    SUB  3,4,3 	Compute offset of value 
204:     LD  3,0(3) 	Load the value 
205:     LD  4,-12(1) 	Restore index 
206:    LDA  5,-6(0) 	Load address of base of array z
207:    SUB  5,5,4 	Compute offset of value 
208:     ST  3,0(5) 	Store variable z
* EXPRESSION STMT
209:    LDC  3,1(6) 	Load constant 
210:     ST  3,-12(1) 	Save index 
211:    LDC  3,2(6) 	Load constant 
212:     ST  3,-13(1) 	Save index 
213:     ST  3,-14(1) 	Save left side 
214:    LDC  3,3(6) 	Load constant 
215:     ST  3,-15(1) 	Save index 
216:     LD  4,-15(1) 	Load left into ac1 
217:    ADD  3,4,3 	Op + 
218:     ST  3,-6(1) 	Store variable z
* EXPRESSION STMT
219:    LDC  3,1(6) 	Load constant 
220:     ST  3,-15(1) 	Save index 
221:     ST  3,-16(1) 	Save left side 
222:    LDC  3,2(6) 	Load constant 
223:     ST  3,-17(1) 	Save index 
224:     ST  3,-18(1) 	Save left side 
225:    LDC  3,0(6) 	Load constant 
226:     ST  3,-19(1) 	Save index 
227:     LD  4,-19(1) 	Load left into ac1 
228:    MUL  3,4,3 	Op * 
229:     LD  4,-18(1) 	Load left into ac1 
230:    ADD  3,4,3 	Op + 
231:     ST  3,-18(1) 	Save left side 
232:    LDC  3,3(6) 	Load constant 
233:     ST  3,-19(1) 	Save index 
234:     ST  3,-20(1) 	Save left side 
235:    LDC  3,7(6) 	Load constant 
236:     LD  4,-20(1) 	Load left into ac1 
237:    MUL  3,4,3 	Op * 
238:     LD  4,-19(1) 	Load left into ac1 
239:    ADD  3,4,3 	Op + 
240:     ST  3,-19(1) 	Save left side 
241:     LD  3,0(1) 	Load variable x
242:     ST  3,-20(1) 	Save left side 
243:    LDC  3,4(6) 	Load constant 
244:     ST  3,-21(1) 	Save index 
245:     ST  3,-22(1) 	Save left side 
246:     LD  3,-1(1) 	Load variable g
247:     LD  4,-22(1) 	Load left into ac1 
248:    ADD  3,4,3 	Op + 
249:     LD  4,-21(1) 	Load left into ac1 
250:    MUL  3,4,3 	Op * 
251:     LD  4,-20(1) 	Load left into ac1 
252:    ADD  3,4,3 	Op + 
253:     ST  3,0(1) 	Store variable x
* END compound statement
* EXPRESSION STMT
* EXPRESSION STMT
* EXPRESSION STMT
254:    LDC  3,3(6) 	Load constant 
255:     ST  3,-1(1) 	Store variable g
256:     ST  3,-1(1) 	Store variable g
257:     ST  3,-1(1) 	Store variable g
* END compound statement
* Add standard closing in case there is no return statement
258:    LDC  2,0(6) 	Set return value to 0 
259:     LD  3,-1(1) 	Load return address 
260:     LD  1,0(1) 	Adjust fp 
261:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,261(7) 	Jump to init 
* BEGIN Init
262:     LD  0,0(0) 	Set the global pointer 
263:    LDA  1,-1(0) 	set first frame at end of globals 
264:     ST  1,0(1) 	store old fp (point to self) 
265:    LDA  3,1(7) 	Return address in ac 
266:    LDA  7,-237(7) 	Jump to main 
267:   HALT  0,0,0 	DONE! 
* END Init
