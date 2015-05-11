* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  pi.tm
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
 31:    LDC  3,0(6) 	load size of array a
 32:     ST  3,-10(1) 	save size of array a
* EXPRESSION STMT
 33:    LDC  3,100(6) 	Load constant 
 34:     ST  3,0(1) 	Store variable N
* EXPRESSION STMT
 35:     LD  3,0(1) 	Load variable N
 36:     ST  3,-11(1) 	Save left side 
 37:    LDC  3,10(6) 	Load constant 
 38:     LD  4,-11(1) 	Load left into ac1 
 39:    MUL  3,4,3 	Op * 
 40:     ST  3,-11(1) 	Save left side 
 41:    LDC  3,3(6) 	Load constant 
 42:     LD  4,-11(1) 	Load left into ac1 
 43:    DIV  3,4,3 	Op / 
 44:     ST  3,-2(1) 	Store variable LEN
* EXPRESSION STMT
 45:    LDC  3,0(6) 	Load constant 
 46:     ST  3,-4(1) 	Store variable j
* WHILE
 47:     LD  3,-4(1) 	Load variable j
 48:     ST  3,-11(1) 	Save left side 
 49:     LD  3,-2(1) 	Load variable LEN
 50:     LD  4,-11(1) 	Load left into ac1 
 51:    SUB  4,4,3 	Op < 
 52:    LDC  3,1(6) 	True case 
 53:    JLT  4,1(7) 	Jump if true 
 54:    LDC  3,0(6) 	False case 
 55:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 57:     LD  3,-4(1) 	Load variable j
 58:     ST  3,-11(1) 	Save index 
 59:    LDC  3,2(6) 	Load constant 
 60:     ST  3,-11(1) 	Store variable a
* EXPRESSION STMT
* END compound statement
 61:    LDA  7,-15(7) 	go to beginning of loop 
 56:    LDA  7,5(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 62:    LDC  3,0(6) 	Load constant 
 63:     ST  3,-8(1) 	Store variable nines
* EXPRESSION STMT
 64:    LDC  3,0(6) 	Load constant 
 65:     ST  3,-9(1) 	Store variable predigit
* EXPRESSION STMT
 66:    LDC  3,0(6) 	Load constant 
 67:     ST  3,-4(1) 	Store variable j
* WHILE
 68:     LD  3,-4(1) 	Load variable j
 69:     ST  3,-12(1) 	Save left side 
 70:     LD  3,0(1) 	Load variable N
 71:     LD  4,-12(1) 	Load left into ac1 
 72:    SUB  4,4,3 	Op < 
 73:    LDC  3,1(6) 	True case 
 74:    JLT  4,1(7) 	Jump if true 
 75:    LDC  3,0(6) 	False case 
 76:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 78:    LDC  3,0(6) 	Load constant 
 79:     ST  3,-6(1) 	Store variable q
* EXPRESSION STMT
 80:     LD  3,-2(1) 	Load variable LEN
 81:     ST  3,-3(1) 	Store variable i
* WHILE
 82:     LD  3,-3(1) 	Load variable i
 83:     ST  3,-12(1) 	Save left side 
 84:    LDC  3,0(6) 	Load constant 
 85:     LD  4,-12(1) 	Load left into ac1 
 86:    SUB  4,4,3 	Op > 
 87:    LDC  3,1(6) 	True case 
 88:    JLT  4,1(7) 	Jump if true 
 89:    LDC  3,0(6) 	False case 
 90:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 92:    LDC  3,10(6) 	Load constant 
 93:     ST  3,-12(1) 	Save left side 
 94:     LD  3,-3(1) 	Load variable i
 95:     ST  3,-13(1) 	Save left side 
 96:    LDC  3,1(6) 	Load constant 
 97:     LD  4,-13(1) 	Load left into ac1 
 98:    SUB  3,4,3 	Op - 
 99:     ST  3,-13(1) 	Save index 
100:     LD  4,-13(1) 	Load left into ac1 
101:    MUL  3,4,3 	Op * 
102:     ST  3,-13(1) 	Save left side 
103:     LD  3,-6(1) 	Load variable q
104:     ST  3,-14(1) 	Save left side 
105:     LD  3,-3(1) 	Load variable i
106:     LD  4,-14(1) 	Load left into ac1 
107:    MUL  3,4,3 	Op * 
108:     LD  4,-13(1) 	Load left into ac1 
109:    ADD  3,4,3 	Op + 
110:     ST  3,-7(1) 	Store variable x
* EXPRESSION STMT
111:     LD  3,-3(1) 	Load variable i
112:     ST  3,-13(1) 	Save left side 
113:    LDC  3,1(6) 	Load constant 
114:     LD  4,-13(1) 	Load left into ac1 
115:    SUB  3,4,3 	Op - 
116:     ST  3,-13(1) 	Save index 
117:     LD  3,-7(1) 	Load variable x
118:     ST  3,-14(1) 	Save left side 
119:    LDC  3,2(6) 	Load constant 
120:     ST  3,-15(1) 	Save left side 
121:     LD  3,-3(1) 	Load variable i
122:     LD  4,-15(1) 	Load left into ac1 
123:    MUL  3,4,3 	Op * 
124:     ST  3,-15(1) 	Save left side 
125:    LDC  3,1(6) 	Load constant 
126:     LD  4,-15(1) 	Load left into ac1 
127:    SUB  3,4,3 	Op - 
128:     LD  4,-14(1) 	Load left into ac1 
129:     ST  3,-11(1) 	Store variable a
* EXPRESSION STMT
130:     LD  3,-7(1) 	Load variable x
131:     ST  3,-14(1) 	Save left side 
132:    LDC  3,2(6) 	Load constant 
133:     ST  3,-15(1) 	Save left side 
134:     LD  3,-3(1) 	Load variable i
135:     LD  4,-15(1) 	Load left into ac1 
136:    MUL  3,4,3 	Op * 
137:     ST  3,-15(1) 	Save left side 
138:    LDC  3,1(6) 	Load constant 
139:     LD  4,-15(1) 	Load left into ac1 
140:    SUB  3,4,3 	Op - 
141:     LD  4,-14(1) 	Load left into ac1 
142:    DIV  3,4,3 	Op / 
143:     ST  3,-6(1) 	Store variable q
* EXPRESSION STMT
144:    LDC  3,1(6) 	Load constant 
145:     ST  3,-3(1) 	Store variable i
* END compound statement
146:    LDA  7,-65(7) 	go to beginning of loop 
 91:    LDA  7,55(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
147:    LDC  3,0(6) 	Load constant 
148:     ST  3,-14(1) 	Save index 
149:     LD  3,-6(1) 	Load variable q
150:     ST  3,-15(1) 	Save left side 
151:    LDC  3,10(6) 	Load constant 
152:     LD  4,-15(1) 	Load left into ac1 
153:     ST  3,-11(1) 	Store variable a
* EXPRESSION STMT
154:     LD  3,-6(1) 	Load variable q
155:     ST  3,-15(1) 	Save left side 
156:    LDC  3,10(6) 	Load constant 
157:     LD  4,-15(1) 	Load left into ac1 
158:    DIV  3,4,3 	Op / 
159:     ST  3,-6(1) 	Store variable q
* IfK:
* IfK: t->child[0] condition
160:     LD  3,-6(1) 	Load variable q
161:     ST  3,-15(1) 	Save left side 
162:    LDC  3,9(6) 	Load constant 
163:     LD  4,-15(1) 	Load left into ac1 
164:    SUB  4,4,3 	Op == 
165:    LDC  3,1(6) 	True case 
166:    JEQ  4,1(7) 	Jump if true 
167:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* BEGIN compound statement
* EXPRESSION STMT
169:     ST  3,-8(1) 	Store variable nines
* END compound statement
168:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
* BEGIN compound statement
* IfK:
* IfK: t->child[0] condition
171:     LD  3,-6(1) 	Load variable q
172:     ST  3,-15(1) 	Save left side 
173:    LDC  3,10(6) 	Load constant 
174:     LD  4,-15(1) 	Load left into ac1 
175:    SUB  4,4,3 	Op == 
176:    LDC  3,1(6) 	True case 
177:    JEQ  4,1(7) 	Jump if true 
178:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* BEGIN compound statement
* EXPRESSION STMT
180:     ST  1,-15(1) 	Store old frame in ghost frame 
181:     LD  3,-9(1) 	Load variable predigit
182:     ST  3,-17(1) 	Save left side 
183:    LDC  3,1(6) 	Load constant 
184:     LD  4,-17(1) 	Load left into ac1 
185:    ADD  3,4,3 	Op + 
186:     ST  3,-17(1) 	Store parameter 
187:    LDA  1,-15(1) 	Load address of new frame 
188:    LDA  3,1(7) 	Return address in ac 
189:    LDA  7,-184(7) 	CALL output
190:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
191:     ST  1,-15(1) 	Store old frame in ghost frame 
192:    LDA  1,-15(1) 	Load address of new frame 
193:    LDA  3,1(7) 	Return address in ac 
194:    LDA  7,-170(7) 	CALL outnl
195:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
196:    LDC  3,0(6) 	Load constant 
197:     ST  3,-9(1) 	Store variable predigit
* WHILE
198:     LD  3,-8(1) 	Load variable nines
199:     ST  3,-15(1) 	Save left side 
200:    LDC  3,0(6) 	Load constant 
201:     LD  4,-15(1) 	Load left into ac1 
202:    SUB  4,4,3 	Op > 
203:    LDC  3,1(6) 	True case 
204:    JLT  4,1(7) 	Jump if true 
205:    LDC  3,0(6) 	False case 
206:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
208:     ST  1,-15(1) 	Store old frame in ghost frame 
209:    LDC  3,0(6) 	Load constant 
210:     ST  3,-17(1) 	Store parameter 
211:    LDA  1,-15(1) 	Load address of new frame 
212:    LDA  3,1(7) 	Return address in ac 
213:    LDA  7,-208(7) 	CALL output
214:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
215:     ST  1,-15(1) 	Store old frame in ghost frame 
216:    LDA  1,-15(1) 	Load address of new frame 
217:    LDA  3,1(7) 	Return address in ac 
218:    LDA  7,-194(7) 	CALL outnl
219:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
220:     LD  3,-8(1) 	load lhs variable nines
221:    LDA  3,-1(3) 	decrement value of nines
222:     ST  3,-8(1) 	Store variable nines
* END compound statement
223:    LDA  7,-26(7) 	go to beginning of loop 
207:    LDA  7,16(7) 	No more loop 
* ENDWHILE
* END compound statement
179:    JEQ  3,45(7) 	if: jmp to else 
* IfK: t->child[2] else part
* BEGIN compound statement
* EXPRESSION STMT
225:     ST  1,-15(1) 	Store old frame in ghost frame 
226:     LD  3,0(1) 	Load variable predigit
227:     ST  3,-17(1) 	Store parameter 
228:    LDA  1,-15(1) 	Load address of new frame 
229:    LDA  3,1(7) 	Return address in ac 
230:    LDA  7,-225(7) 	CALL output
231:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
232:     ST  1,-15(1) 	Store old frame in ghost frame 
233:    LDA  1,-15(1) 	Load address of new frame 
234:    LDA  3,1(7) 	Return address in ac 
235:    LDA  7,-211(7) 	CALL outnl
236:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
237:     LD  3,0(1) 	Load variable q
238:     ST  3,0(1) 	Store variable predigit
* WHILE
239:     LD  3,0(1) 	Load variable nines
240:     ST  3,-15(1) 	Save left side 
241:    LDC  3,0(6) 	Load constant 
242:     LD  4,-15(1) 	Load left into ac1 
243:    SUB  4,4,3 	Op > 
244:    LDC  3,1(6) 	True case 
245:    JLT  4,1(7) 	Jump if true 
246:    LDC  3,0(6) 	False case 
247:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
249:     ST  1,-15(1) 	Store old frame in ghost frame 
250:    LDC  3,9(6) 	Load constant 
251:     ST  3,-17(1) 	Store parameter 
252:    LDA  1,-15(1) 	Load address of new frame 
253:    LDA  3,1(7) 	Return address in ac 
254:    LDA  7,-249(7) 	CALL output
255:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
256:     ST  1,-15(1) 	Store old frame in ghost frame 
257:    LDA  1,-15(1) 	Load address of new frame 
258:    LDA  3,1(7) 	Return address in ac 
259:    LDA  7,-235(7) 	CALL outnl
260:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
261:     LD  3,0(1) 	load lhs variable nines
262:    LDA  3,-1(3) 	decrement value of nines
263:     ST  3,0(1) 	Store variable nines
* END compound statement
264:    LDA  7,-26(7) 	go to beginning of loop 
248:    LDA  7,16(7) 	No more loop 
* ENDWHILE
* END compound statement
224:    LDA  7,40(7) 	jmp to end 
* ENDIF
* END compound statement
170:    LDA  7,94(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
265:     ST  3,-4(1) 	Store variable j
* END compound statement
266:    LDA  7,-199(7) 	go to beginning of loop 
 77:    LDA  7,189(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
267:     ST  1,-15(1) 	Store old frame in ghost frame 
268:     LD  3,-9(1) 	Load variable predigit
269:     ST  3,-17(1) 	Store parameter 
270:    LDA  1,-15(1) 	Load address of new frame 
271:    LDA  3,1(7) 	Return address in ac 
272:    LDA  7,-267(7) 	CALL output
273:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
274:     ST  1,-15(1) 	Store old frame in ghost frame 
275:    LDA  1,-15(1) 	Load address of new frame 
276:    LDA  3,1(7) 	Return address in ac 
277:    LDA  7,-253(7) 	CALL outnl
278:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
279:    LDC  2,0(6) 	Set return value to 0 
280:     LD  3,-1(1) 	Load return address 
281:     LD  1,0(1) 	Adjust fp 
282:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,282(7) 	Jump to init 
* BEGIN Init
283:     LD  0,0(0) 	Set the global pointer 
284:    LDA  1,0(0) 	set first frame at end of globals 
285:     ST  1,0(1) 	store old fp (point to self) 
286:    LDA  3,1(7) 	Return address in ac 
287:    LDA  7,-258(7) 	Jump to main 
288:   HALT  0,0,0 	DONE! 
* END Init
