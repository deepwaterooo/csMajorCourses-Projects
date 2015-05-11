* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  permlist.c-
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
* BEGIN function put
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,1(6) 	Load constant 
 32:     LD  4,-2(1) 	Load address of base of array p
 33:    SUB  3,4,3 	Compute offset of value 
 34:     LD  3,0(3) 	Load the value 
 35:     ST  3,-4(1) 	Store variable sum
* EXPRESSION STMT
 36:    LDC  3,2(6) 	Load constant 
 37:     ST  3,-3(1) 	Store variable j
* WHILE
 38:     LD  3,-3(1) 	Load variable j
 39:     ST  3,-5(1) 	Save left side 
 40:     LD  3,0(0) 	Load variable n
 41:     LD  4,-5(1) 	Load left into ac1 
 42:    SUB  4,4,3 	Op <= 
 43:    LDC  3,1(6) 	True case 
 44:    JLE  4,1(7) 	Jump if true 
 45:    LDC  3,0(6) 	False case 
 46:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 48:     LD  3,-4(1) 	Load variable sum
 49:     ST  3,-5(1) 	Save left side 
 50:    LDC  3,10(6) 	Load constant 
 51:     LD  4,-5(1) 	Load left into ac1 
 52:    MUL  3,4,3 	Op * 
 53:     ST  3,-5(1) 	Save left side 
 54:     LD  3,-3(1) 	Load variable j
 55:     LD  4,-2(1) 	Load address of base of array p
 56:    SUB  3,4,3 	Compute offset of value 
 57:     LD  3,0(3) 	Load the value 
 58:     LD  4,-5(1) 	Load left into ac1 
 59:    ADD  3,4,3 	Op + 
 60:     ST  3,-4(1) 	Store variable sum
* EXPRESSION STMT
 61:     LD  3,-3(1) 	Load variable j
 62:     ST  3,-5(1) 	Save left side 
 63:    LDC  3,1(6) 	Load constant 
 64:     LD  4,-5(1) 	Load left into ac1 
 65:    ADD  3,4,3 	Op + 
 66:     ST  3,-3(1) 	Store variable j
* END compound statement
 67:    LDA  7,-30(7) 	go to beginning of loop 
 47:    LDA  7,20(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 68:     ST  1,-5(1) 	Store old fp in ghost frame 
 69:     LD  3,-4(1) 	Load variable sum
 70:     ST  3,-7(1) 	Store parameter 
 71:    LDA  1,-5(1) 	Load address of new frame 
 72:    LDA  3,1(7) 	Return address in ac 
 73:    LDA  7,-68(7) 	CALL output
 74:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 75:     ST  1,-5(1) 	Store old fp in ghost frame 
 76:    LDA  1,-5(1) 	Load address of new frame 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-54(7) 	CALL outnl
 79:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 80:    LDC  2,0(6) 	Set return value to 0 
 81:     LD  3,-1(1) 	Load return address 
 82:     LD  1,0(1) 	Adjust fp 
 83:    LDA  7,0(3) 	Return 
* END of function put
* BEGIN function main
 84:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 85:    LDC  3,20(6) 	load size of array p
 86:     ST  3,-2(1) 	save size of array p
* EXPRESSION STMT
 87:     ST  1,-28(1) 	Store old fp in ghost frame 
 88:    LDA  1,-28(1) 	Load address of new frame 
 89:    LDA  3,1(7) 	Return address in ac 
 90:    LDA  7,-90(7) 	CALL input
 91:    LDA  3,0(2) 	Save the result in ac 
 92:     ST  3,0(0) 	Store variable n
* EXPRESSION STMT
 93:    LDC  3,0(6) 	Load constant 
 94:     ST  3,-24(1) 	Store variable j
* WHILE
 95:     LD  3,-24(1) 	Load variable j
 96:     ST  3,-28(1) 	Save left side 
 97:     LD  3,0(0) 	Load variable n
 98:     LD  4,-28(1) 	Load left into ac1 
 99:    SUB  4,4,3 	Op <= 
100:    LDC  3,1(6) 	True case 
101:    JLE  4,1(7) 	Jump if true 
102:    LDC  3,0(6) 	False case 
103:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
105:     LD  3,-24(1) 	Load variable j
106:     ST  3,-28(1) 	Save index 
107:     LD  3,-24(1) 	Load variable j
108:     LD  4,-28(1) 	Restore index 
109:    LDA  5,-3(1) 	Load address of base of array p
110:    SUB  5,5,4 	Compute offset of value 
111:     ST  3,0(5) 	Store variable p
* EXPRESSION STMT
112:     LD  3,-24(1) 	Load variable j
113:     ST  3,-28(1) 	Save left side 
114:    LDC  3,1(6) 	Load constant 
115:     LD  4,-28(1) 	Load left into ac1 
116:    ADD  3,4,3 	Op + 
117:     ST  3,-24(1) 	Store variable j
* END compound statement
118:    LDA  7,-24(7) 	go to beginning of loop 
104:    LDA  7,14(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
119:    LDC  3,1(6) 	Load constant 
120:     ST  3,-23(1) 	Store variable i
* WHILE
121:     LD  3,-23(1) 	Load variable i
122:     ST  3,-28(1) 	Save left side 
123:    LDC  3,0(6) 	Load constant 
124:     LD  4,-28(1) 	Load left into ac1 
125:    SUB  4,4,3 	Op > 
126:    LDC  3,1(6) 	True case 
127:    JGT  4,1(7) 	Jump if true 
128:    LDC  3,0(6) 	False case 
129:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
131:     ST  1,-28(1) 	Store old fp in ghost frame 
132:    LDA  3,-3(1) 	Load address of base of array p
133:     ST  3,-30(1) 	Store parameter 
134:    LDA  1,-28(1) 	Load address of new frame 
135:    LDA  3,1(7) 	Return address in ac 
136:    LDA  7,-107(7) 	CALL put
137:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
138:     LD  3,0(0) 	Load variable n
139:     ST  3,-28(1) 	Save left side 
140:    LDC  3,1(6) 	Load constant 
141:     LD  4,-28(1) 	Load left into ac1 
142:    SUB  3,4,3 	Op - 
143:     ST  3,-23(1) 	Store variable i
* WHILE
144:     LD  3,-23(1) 	Load variable i
145:    LDA  4,-3(1) 	Load address of base of array p
146:    SUB  3,4,3 	Compute offset of value 
147:     LD  3,0(3) 	Load the value 
148:     ST  3,-28(1) 	Save left side 
149:     LD  3,-23(1) 	Load variable i
150:     ST  3,-29(1) 	Save left side 
151:    LDC  3,1(6) 	Load constant 
152:     LD  4,-29(1) 	Load left into ac1 
153:    ADD  3,4,3 	Op + 
154:    LDA  4,-3(1) 	Load address of base of array p
155:    SUB  3,4,3 	Compute offset of value 
156:     LD  3,0(3) 	Load the value 
157:     LD  4,-28(1) 	Load left into ac1 
158:    SUB  4,4,3 	Op > 
159:    LDC  3,1(6) 	True case 
160:    JGT  4,1(7) 	Jump if true 
161:    LDC  3,0(6) 	False case 
162:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
164:     LD  3,-23(1) 	Load variable i
165:     ST  3,-28(1) 	Save left side 
166:    LDC  3,1(6) 	Load constant 
167:     LD  4,-28(1) 	Load left into ac1 
168:    SUB  3,4,3 	Op - 
169:     ST  3,-23(1) 	Store variable i
170:    LDA  7,-27(7) 	go to beginning of loop 
163:    LDA  7,7(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
171:     LD  3,0(0) 	Load variable n
172:     ST  3,-24(1) 	Store variable j
* WHILE
173:     LD  3,-23(1) 	Load variable i
174:    LDA  4,-3(1) 	Load address of base of array p
175:    SUB  3,4,3 	Compute offset of value 
176:     LD  3,0(3) 	Load the value 
177:     ST  3,-28(1) 	Save left side 
178:     LD  3,-24(1) 	Load variable j
179:    LDA  4,-3(1) 	Load address of base of array p
180:    SUB  3,4,3 	Compute offset of value 
181:     LD  3,0(3) 	Load the value 
182:     LD  4,-28(1) 	Load left into ac1 
183:    SUB  4,4,3 	Op > 
184:    LDC  3,1(6) 	True case 
185:    JGT  4,1(7) 	Jump if true 
186:    LDC  3,0(6) 	False case 
187:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
189:     LD  3,-24(1) 	Load variable j
190:     ST  3,-28(1) 	Save left side 
191:    LDC  3,1(6) 	Load constant 
192:     LD  4,-28(1) 	Load left into ac1 
193:    SUB  3,4,3 	Op - 
194:     ST  3,-24(1) 	Store variable j
195:    LDA  7,-23(7) 	go to beginning of loop 
188:    LDA  7,7(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
196:     LD  3,-23(1) 	Load variable i
197:    LDA  4,-3(1) 	Load address of base of array p
198:    SUB  3,4,3 	Compute offset of value 
199:     LD  3,0(3) 	Load the value 
200:     ST  3,-27(1) 	Store variable tmp
* EXPRESSION STMT
201:     LD  3,-23(1) 	Load variable i
202:     ST  3,-28(1) 	Save index 
203:     LD  3,-24(1) 	Load variable j
204:    LDA  4,-3(1) 	Load address of base of array p
205:    SUB  3,4,3 	Compute offset of value 
206:     LD  3,0(3) 	Load the value 
207:     LD  4,-28(1) 	Restore index 
208:    LDA  5,-3(1) 	Load address of base of array p
209:    SUB  5,5,4 	Compute offset of value 
210:     ST  3,0(5) 	Store variable p
* EXPRESSION STMT
211:     LD  3,-24(1) 	Load variable j
212:     ST  3,-28(1) 	Save index 
213:     LD  3,-27(1) 	Load variable tmp
214:     LD  4,-28(1) 	Restore index 
215:    LDA  5,-3(1) 	Load address of base of array p
216:    SUB  5,5,4 	Compute offset of value 
217:     ST  3,0(5) 	Store variable p
* EXPRESSION STMT
218:     LD  3,0(0) 	Load variable n
219:     ST  3,-25(1) 	Store variable r
* EXPRESSION STMT
220:     LD  3,-23(1) 	Load variable i
221:     ST  3,-28(1) 	Save left side 
222:    LDC  3,1(6) 	Load constant 
223:     LD  4,-28(1) 	Load left into ac1 
224:    ADD  3,4,3 	Op + 
225:     ST  3,-26(1) 	Store variable s
* WHILE
226:     LD  3,-25(1) 	Load variable r
227:     ST  3,-28(1) 	Save left side 
228:     LD  3,-26(1) 	Load variable s
229:     LD  4,-28(1) 	Load left into ac1 
230:    SUB  4,4,3 	Op > 
231:    LDC  3,1(6) 	True case 
232:    JGT  4,1(7) 	Jump if true 
233:    LDC  3,0(6) 	False case 
234:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
236:     LD  3,-25(1) 	Load variable r
237:    LDA  4,-3(1) 	Load address of base of array p
238:    SUB  3,4,3 	Compute offset of value 
239:     LD  3,0(3) 	Load the value 
240:     ST  3,-27(1) 	Store variable tmp
* EXPRESSION STMT
241:     LD  3,-25(1) 	Load variable r
242:     ST  3,-28(1) 	Save index 
243:     LD  3,-26(1) 	Load variable s
244:    LDA  4,-3(1) 	Load address of base of array p
245:    SUB  3,4,3 	Compute offset of value 
246:     LD  3,0(3) 	Load the value 
247:     LD  4,-28(1) 	Restore index 
248:    LDA  5,-3(1) 	Load address of base of array p
249:    SUB  5,5,4 	Compute offset of value 
250:     ST  3,0(5) 	Store variable p
* EXPRESSION STMT
251:     LD  3,-26(1) 	Load variable s
252:     ST  3,-28(1) 	Save index 
253:     LD  3,-27(1) 	Load variable tmp
254:     LD  4,-28(1) 	Restore index 
255:    LDA  5,-3(1) 	Load address of base of array p
256:    SUB  5,5,4 	Compute offset of value 
257:     ST  3,0(5) 	Store variable p
* EXPRESSION STMT
258:     LD  3,-25(1) 	Load variable r
259:     ST  3,-28(1) 	Save left side 
260:    LDC  3,1(6) 	Load constant 
261:     LD  4,-28(1) 	Load left into ac1 
262:    SUB  3,4,3 	Op - 
263:     ST  3,-25(1) 	Store variable r
* EXPRESSION STMT
264:     LD  3,-26(1) 	Load variable s
265:     ST  3,-28(1) 	Save left side 
266:    LDC  3,1(6) 	Load constant 
267:     LD  4,-28(1) 	Load left into ac1 
268:    ADD  3,4,3 	Op + 
269:     ST  3,-26(1) 	Store variable s
* END compound statement
270:    LDA  7,-45(7) 	go to beginning of loop 
235:    LDA  7,35(7) 	No more loop 
* ENDWHILE
* END compound statement
271:    LDA  7,-151(7) 	go to beginning of loop 
130:    LDA  7,141(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
272:    LDC  2,0(6) 	Set return value to 0 
273:     LD  3,-1(1) 	Load return address 
274:     LD  1,0(1) 	Adjust fp 
275:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,275(7) 	Jump to init 
* BEGIN Init
276:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
277:    LDA  1,-1(0) 	set first frame at end of globals 
278:     ST  1,0(1) 	store old fp (point to self) 
279:    LDA  3,1(7) 	Return address in ac 
280:    LDA  7,-197(7) 	Jump to main 
281:   HALT  0,0,0 	DONE! 
* END Init
