* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  whiletest.tm
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
* IfK:
* IfK: t->child[0] condition
 31:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
 33:    LDC  3,0(6) 	Load constant 
 32:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
 34:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 35:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
 37:    LDC  3,0(6) 	Load constant 
 36:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
 39:    LDC  3,0(6) 	Load constant 
 38:    LDA  7,1(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 40:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
 42:    LDC  3,0(6) 	Load constant 
 41:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
* IfK:
* IfK: t->child[0] condition
 44:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
 46:    LDC  3,0(6) 	Load constant 
 45:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
 47:    LDA  7,0(7) 	jmp to end 
* ENDIF
 43:    LDA  7,4(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 48:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
 50:    LDC  3,0(6) 	Load constant 
 49:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
* IfK:
* IfK: t->child[0] condition
 52:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
 54:    LDC  3,0(6) 	Load constant 
 53:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
 56:    LDC  3,0(6) 	Load constant 
 55:    LDA  7,1(7) 	jmp to end 
* ENDIF
 51:    LDA  7,5(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 57:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
 59:    LDC  3,0(6) 	Load constant 
 58:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
* IfK:
* IfK: t->child[0] condition
 61:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
 63:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
 65:    LDC  3,0(6) 	Load constant 
 64:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
 66:    LDA  7,0(7) 	jmp to end 
* ENDIF
 62:    JEQ  3,5(7) 	if: jmp to else 
* IfK: t->child[2] else part
 67:    LDA  7,0(7) 	jmp to end 
* ENDIF
 60:    LDA  7,7(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 68:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
 70:    LDC  3,0(6) 	Load constant 
 69:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
* IfK:
* IfK: t->child[0] condition
 72:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
 74:    LDC  3,0(6) 	Load constant 
 75:    JGT  3,1(7) 	Jump to while part 
* DO
 77:    LDC  3,0(6) 	Load constant 
 78:    LDA  7,-5(7) 	go to beginning of loop 
 76:    LDA  7,2(7) 	No more loop 
* ENDWHILE
 73:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
 79:    LDA  7,0(7) 	jmp to end 
* ENDIF
 71:    LDA  7,8(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 80:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
 82:    LDC  3,0(6) 	Load constant 
 81:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
* WHILE
 84:    LDC  3,0(6) 	Load constant 
 85:    JGT  3,1(7) 	Jump to while part 
* DO
 87:    LDC  3,0(6) 	Load constant 
 88:    LDA  7,-5(7) 	go to beginning of loop 
 86:    LDA  7,2(7) 	No more loop 
* ENDWHILE
 83:    LDA  7,5(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 89:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
 91:    LDC  3,0(6) 	Load constant 
 90:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
* WHILE
 93:    LDC  3,0(6) 	Load constant 
 94:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
 96:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
 98:    LDC  3,0(6) 	Load constant 
 97:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
 99:    LDA  7,0(7) 	jmp to end 
* ENDIF
100:    LDA  7,-8(7) 	go to beginning of loop 
 95:    LDA  7,5(7) 	No more loop 
* ENDWHILE
 92:    LDA  7,8(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
101:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
103:    LDC  3,0(6) 	Load constant 
102:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
* WHILE
105:    LDC  3,0(6) 	Load constant 
106:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
108:    LDC  3,0(6) 	Load constant 
109:    JGT  3,1(7) 	Jump to while part 
* DO
111:    LDC  3,0(6) 	Load constant 
112:    LDA  7,-5(7) 	go to beginning of loop 
110:    LDA  7,2(7) 	No more loop 
* ENDWHILE
113:    LDA  7,-9(7) 	go to beginning of loop 
107:    LDA  7,6(7) 	No more loop 
* ENDWHILE
104:    LDA  7,9(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
114:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
116:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
118:    LDC  3,0(6) 	Load constant 
117:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
119:    LDA  7,0(7) 	jmp to end 
* ENDIF
115:    JEQ  3,5(7) 	if: jmp to else 
* IfK: t->child[2] else part
120:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
121:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
123:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
125:    LDC  3,0(6) 	Load constant 
124:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
127:    LDC  3,0(6) 	Load constant 
126:    LDA  7,1(7) 	jmp to end 
* ENDIF
122:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
128:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
129:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
131:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
133:    LDC  3,0(6) 	Load constant 
132:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
135:    LDC  3,0(6) 	Load constant 
134:    LDA  7,1(7) 	jmp to end 
* ENDIF
130:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
137:    LDC  3,0(6) 	Load constant 
136:    LDA  7,1(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
138:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
140:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
142:    LDC  3,0(6) 	Load constant 
141:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
* IfK:
* IfK: t->child[0] condition
144:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
146:    LDC  3,0(6) 	Load constant 
145:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
147:    LDA  7,0(7) 	jmp to end 
* ENDIF
143:    LDA  7,4(7) 	jmp to end 
* ENDIF
139:    JEQ  3,9(7) 	if: jmp to else 
* IfK: t->child[2] else part
148:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
149:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
151:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
153:    LDC  3,0(6) 	Load constant 
152:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
* WHILE
155:    LDC  3,0(6) 	Load constant 
156:    JGT  3,1(7) 	Jump to while part 
* DO
158:    LDC  3,0(6) 	Load constant 
159:    LDA  7,-5(7) 	go to beginning of loop 
157:    LDA  7,2(7) 	No more loop 
* ENDWHILE
154:    LDA  7,5(7) 	jmp to end 
* ENDIF
150:    JEQ  3,10(7) 	if: jmp to else 
* IfK: t->child[2] else part
160:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
161:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
163:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
165:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
167:    LDC  3,0(6) 	Load constant 
166:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
168:    LDA  7,0(7) 	jmp to end 
* ENDIF
164:    JEQ  3,5(7) 	if: jmp to else 
* IfK: t->child[2] else part
169:    LDA  7,0(7) 	jmp to end 
* ENDIF
162:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
170:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
171:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
173:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
175:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
177:    LDC  3,0(6) 	Load constant 
176:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
179:    LDC  3,0(6) 	Load constant 
178:    LDA  7,1(7) 	jmp to end 
* ENDIF
174:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
180:    LDA  7,0(7) 	jmp to end 
* ENDIF
172:    JEQ  3,9(7) 	if: jmp to else 
* IfK: t->child[2] else part
181:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
182:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
184:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
186:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
188:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
190:    LDC  3,0(6) 	Load constant 
189:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
191:    LDA  7,0(7) 	jmp to end 
* ENDIF
187:    JEQ  3,5(7) 	if: jmp to else 
* IfK: t->child[2] else part
192:    LDA  7,0(7) 	jmp to end 
* ENDIF
185:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
193:    LDA  7,0(7) 	jmp to end 
* ENDIF
183:    JEQ  3,11(7) 	if: jmp to else 
* IfK: t->child[2] else part
194:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
195:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
197:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
199:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
201:    LDC  3,0(6) 	Load constant 
202:    JGT  3,1(7) 	Jump to while part 
* DO
204:    LDC  3,0(6) 	Load constant 
205:    LDA  7,-5(7) 	go to beginning of loop 
203:    LDA  7,2(7) 	No more loop 
* ENDWHILE
200:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
206:    LDA  7,0(7) 	jmp to end 
* ENDIF
198:    JEQ  3,9(7) 	if: jmp to else 
* IfK: t->child[2] else part
207:    LDA  7,0(7) 	jmp to end 
* ENDIF
196:    JEQ  3,12(7) 	if: jmp to else 
* IfK: t->child[2] else part
208:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
209:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
211:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
213:    LDC  3,0(6) 	Load constant 
214:    JGT  3,1(7) 	Jump to while part 
* DO
216:    LDC  3,0(6) 	Load constant 
217:    LDA  7,-5(7) 	go to beginning of loop 
215:    LDA  7,2(7) 	No more loop 
* ENDWHILE
212:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
218:    LDA  7,0(7) 	jmp to end 
* ENDIF
210:    JEQ  3,9(7) 	if: jmp to else 
* IfK: t->child[2] else part
219:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
220:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
222:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
224:    LDC  3,0(6) 	Load constant 
225:    JGT  3,1(7) 	Jump to while part 
* DO
227:    LDC  3,0(6) 	Load constant 
228:    LDA  7,-5(7) 	go to beginning of loop 
226:    LDA  7,2(7) 	No more loop 
* ENDWHILE
223:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
230:    LDC  3,0(6) 	Load constant 
229:    LDA  7,1(7) 	jmp to end 
* ENDIF
221:    JEQ  3,10(7) 	if: jmp to else 
* IfK: t->child[2] else part
231:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
232:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
234:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
236:    LDC  3,0(6) 	Load constant 
237:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
239:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
241:    LDC  3,0(6) 	Load constant 
240:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
242:    LDA  7,0(7) 	jmp to end 
* ENDIF
243:    LDA  7,-8(7) 	go to beginning of loop 
238:    LDA  7,5(7) 	No more loop 
* ENDWHILE
235:    JEQ  3,9(7) 	if: jmp to else 
* IfK: t->child[2] else part
244:    LDA  7,0(7) 	jmp to end 
* ENDIF
233:    JEQ  3,12(7) 	if: jmp to else 
* IfK: t->child[2] else part
245:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
246:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
248:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
250:    LDC  3,0(6) 	Load constant 
251:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
253:    LDC  3,0(6) 	Load constant 
254:    JGT  3,1(7) 	Jump to while part 
* DO
256:    LDC  3,0(6) 	Load constant 
257:    LDA  7,-5(7) 	go to beginning of loop 
255:    LDA  7,2(7) 	No more loop 
* ENDWHILE
258:    LDA  7,-9(7) 	go to beginning of loop 
252:    LDA  7,6(7) 	No more loop 
* ENDWHILE
249:    JEQ  3,10(7) 	if: jmp to else 
* IfK: t->child[2] else part
259:    LDA  7,0(7) 	jmp to end 
* ENDIF
247:    JEQ  3,13(7) 	if: jmp to else 
* IfK: t->child[2] else part
260:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
261:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
263:    LDC  3,0(6) 	Load constant 
264:    JGT  3,1(7) 	Jump to while part 
* DO
266:    LDC  3,0(6) 	Load constant 
267:    LDA  7,-5(7) 	go to beginning of loop 
265:    LDA  7,2(7) 	No more loop 
* ENDWHILE
262:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
268:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
269:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
271:    LDC  3,0(6) 	Load constant 
272:    JGT  3,1(7) 	Jump to while part 
* DO
274:    LDC  3,0(6) 	Load constant 
275:    LDA  7,-5(7) 	go to beginning of loop 
273:    LDA  7,2(7) 	No more loop 
* ENDWHILE
270:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
277:    LDC  3,0(6) 	Load constant 
276:    LDA  7,1(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
278:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
280:    LDC  3,0(6) 	Load constant 
281:    JGT  3,1(7) 	Jump to while part 
* DO
283:    LDC  3,0(6) 	Load constant 
284:    LDA  7,-5(7) 	go to beginning of loop 
282:    LDA  7,2(7) 	No more loop 
* ENDWHILE
279:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
* IfK:
* IfK: t->child[0] condition
286:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
288:    LDC  3,0(6) 	Load constant 
287:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
289:    LDA  7,0(7) 	jmp to end 
* ENDIF
285:    LDA  7,4(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
290:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
292:    LDC  3,0(6) 	Load constant 
293:    JGT  3,1(7) 	Jump to while part 
* DO
295:    LDC  3,0(6) 	Load constant 
296:    LDA  7,-5(7) 	go to beginning of loop 
294:    LDA  7,2(7) 	No more loop 
* ENDWHILE
291:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
* WHILE
298:    LDC  3,0(6) 	Load constant 
299:    JGT  3,1(7) 	Jump to while part 
* DO
301:    LDC  3,0(6) 	Load constant 
302:    LDA  7,-5(7) 	go to beginning of loop 
300:    LDA  7,2(7) 	No more loop 
* ENDWHILE
297:    LDA  7,5(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
303:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
305:    LDC  3,0(6) 	Load constant 
306:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
308:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
310:    LDC  3,0(6) 	Load constant 
309:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
311:    LDA  7,0(7) 	jmp to end 
* ENDIF
312:    LDA  7,-8(7) 	go to beginning of loop 
307:    LDA  7,5(7) 	No more loop 
* ENDWHILE
304:    JEQ  3,9(7) 	if: jmp to else 
* IfK: t->child[2] else part
313:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
314:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
316:    LDC  3,0(6) 	Load constant 
317:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
319:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
321:    LDC  3,0(6) 	Load constant 
320:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
323:    LDC  3,0(6) 	Load constant 
322:    LDA  7,1(7) 	jmp to end 
* ENDIF
324:    LDA  7,-9(7) 	go to beginning of loop 
318:    LDA  7,6(7) 	No more loop 
* ENDWHILE
315:    JEQ  3,10(7) 	if: jmp to else 
* IfK: t->child[2] else part
325:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
326:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
328:    LDC  3,0(6) 	Load constant 
329:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
331:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
333:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
335:    LDC  3,0(6) 	Load constant 
334:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
336:    LDA  7,0(7) 	jmp to end 
* ENDIF
332:    JEQ  3,5(7) 	if: jmp to else 
* IfK: t->child[2] else part
337:    LDA  7,0(7) 	jmp to end 
* ENDIF
338:    LDA  7,-11(7) 	go to beginning of loop 
330:    LDA  7,8(7) 	No more loop 
* ENDWHILE
327:    JEQ  3,12(7) 	if: jmp to else 
* IfK: t->child[2] else part
339:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
340:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
342:    LDC  3,0(6) 	Load constant 
343:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
345:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
347:    LDC  3,0(6) 	Load constant 
348:    JGT  3,1(7) 	Jump to while part 
* DO
350:    LDC  3,0(6) 	Load constant 
351:    LDA  7,-5(7) 	go to beginning of loop 
349:    LDA  7,2(7) 	No more loop 
* ENDWHILE
346:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
352:    LDA  7,0(7) 	jmp to end 
* ENDIF
353:    LDA  7,-12(7) 	go to beginning of loop 
344:    LDA  7,9(7) 	No more loop 
* ENDWHILE
341:    JEQ  3,13(7) 	if: jmp to else 
* IfK: t->child[2] else part
354:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
355:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
357:    LDC  3,0(6) 	Load constant 
358:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
360:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
362:    LDC  3,0(6) 	Load constant 
363:    JGT  3,1(7) 	Jump to while part 
* DO
365:    LDC  3,0(6) 	Load constant 
366:    LDA  7,-5(7) 	go to beginning of loop 
364:    LDA  7,2(7) 	No more loop 
* ENDWHILE
361:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
368:    LDC  3,0(6) 	Load constant 
367:    LDA  7,1(7) 	jmp to end 
* ENDIF
369:    LDA  7,-13(7) 	go to beginning of loop 
359:    LDA  7,10(7) 	No more loop 
* ENDWHILE
356:    JEQ  3,14(7) 	if: jmp to else 
* IfK: t->child[2] else part
370:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
371:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
373:    LDC  3,0(6) 	Load constant 
374:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
376:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
378:    LDC  3,0(6) 	Load constant 
379:    JGT  3,1(7) 	Jump to while part 
* DO
381:    LDC  3,0(6) 	Load constant 
382:    LDA  7,-5(7) 	go to beginning of loop 
380:    LDA  7,2(7) 	No more loop 
* ENDWHILE
377:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
384:    LDC  3,0(6) 	Load constant 
383:    LDA  7,1(7) 	jmp to end 
* ENDIF
385:    LDA  7,-13(7) 	go to beginning of loop 
375:    LDA  7,10(7) 	No more loop 
* ENDWHILE
372:    JEQ  3,14(7) 	if: jmp to else 
* IfK: t->child[2] else part
387:    LDC  3,0(6) 	Load constant 
386:    LDA  7,1(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
388:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
390:    LDC  3,0(6) 	Load constant 
391:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
393:    LDC  3,0(6) 	Load constant 
394:    JGT  3,1(7) 	Jump to while part 
* DO
396:    LDC  3,0(6) 	Load constant 
397:    LDA  7,-5(7) 	go to beginning of loop 
395:    LDA  7,2(7) 	No more loop 
* ENDWHILE
398:    LDA  7,-9(7) 	go to beginning of loop 
392:    LDA  7,6(7) 	No more loop 
* ENDWHILE
389:    JEQ  3,10(7) 	if: jmp to else 
* IfK: t->child[2] else part
399:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
400:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
402:    LDC  3,0(6) 	Load constant 
403:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
405:    LDC  3,0(6) 	Load constant 
406:    JGT  3,1(7) 	Jump to while part 
* DO
408:    LDC  3,0(6) 	Load constant 
409:    LDA  7,-5(7) 	go to beginning of loop 
407:    LDA  7,2(7) 	No more loop 
* ENDWHILE
410:    LDA  7,-9(7) 	go to beginning of loop 
404:    LDA  7,6(7) 	No more loop 
* ENDWHILE
401:    JEQ  3,10(7) 	if: jmp to else 
* IfK: t->child[2] else part
412:    LDC  3,0(6) 	Load constant 
411:    LDA  7,1(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
413:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
415:    LDC  3,0(6) 	Load constant 
416:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
418:    LDC  3,0(6) 	Load constant 
419:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
421:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
423:    LDC  3,0(6) 	Load constant 
422:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
424:    LDA  7,0(7) 	jmp to end 
* ENDIF
425:    LDA  7,-8(7) 	go to beginning of loop 
420:    LDA  7,5(7) 	No more loop 
* ENDWHILE
426:    LDA  7,-12(7) 	go to beginning of loop 
417:    LDA  7,9(7) 	No more loop 
* ENDWHILE
414:    JEQ  3,13(7) 	if: jmp to else 
* IfK: t->child[2] else part
427:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
428:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
430:    LDC  3,0(6) 	Load constant 
431:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
433:    LDC  3,0(6) 	Load constant 
434:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
436:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
438:    LDC  3,0(6) 	Load constant 
437:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
440:    LDC  3,0(6) 	Load constant 
439:    LDA  7,1(7) 	jmp to end 
* ENDIF
441:    LDA  7,-9(7) 	go to beginning of loop 
435:    LDA  7,6(7) 	No more loop 
* ENDWHILE
442:    LDA  7,-13(7) 	go to beginning of loop 
432:    LDA  7,10(7) 	No more loop 
* ENDWHILE
429:    JEQ  3,14(7) 	if: jmp to else 
* IfK: t->child[2] else part
443:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
444:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
446:    LDC  3,0(6) 	Load constant 
447:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
449:    LDC  3,0(6) 	Load constant 
450:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
452:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
454:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
456:    LDC  3,0(6) 	Load constant 
455:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
457:    LDA  7,0(7) 	jmp to end 
* ENDIF
453:    JEQ  3,5(7) 	if: jmp to else 
* IfK: t->child[2] else part
458:    LDA  7,0(7) 	jmp to end 
* ENDIF
459:    LDA  7,-11(7) 	go to beginning of loop 
451:    LDA  7,8(7) 	No more loop 
* ENDWHILE
460:    LDA  7,-15(7) 	go to beginning of loop 
448:    LDA  7,12(7) 	No more loop 
* ENDWHILE
445:    JEQ  3,16(7) 	if: jmp to else 
* IfK: t->child[2] else part
461:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
462:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
464:    LDC  3,0(6) 	Load constant 
465:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
467:    LDC  3,0(6) 	Load constant 
468:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
470:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
472:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
474:    LDC  3,0(6) 	Load constant 
473:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
476:    LDC  3,0(6) 	Load constant 
475:    LDA  7,1(7) 	jmp to end 
* ENDIF
471:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
477:    LDA  7,0(7) 	jmp to end 
* ENDIF
478:    LDA  7,-12(7) 	go to beginning of loop 
469:    LDA  7,9(7) 	No more loop 
* ENDWHILE
479:    LDA  7,-16(7) 	go to beginning of loop 
466:    LDA  7,13(7) 	No more loop 
* ENDWHILE
463:    JEQ  3,17(7) 	if: jmp to else 
* IfK: t->child[2] else part
480:    LDA  7,0(7) 	jmp to end 
* ENDIF
* WHILE
481:    LDC  3,0(6) 	Load constant 
482:    JGT  3,1(7) 	Jump to while part 
* DO
484:    LDC  3,0(6) 	Load constant 
485:    LDA  7,-5(7) 	go to beginning of loop 
483:    LDA  7,2(7) 	No more loop 
* ENDWHILE
* WHILE
486:    LDC  3,0(6) 	Load constant 
487:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
489:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
491:    LDC  3,0(6) 	Load constant 
490:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
492:    LDA  7,0(7) 	jmp to end 
* ENDIF
493:    LDA  7,-8(7) 	go to beginning of loop 
488:    LDA  7,5(7) 	No more loop 
* ENDWHILE
* WHILE
494:    LDC  3,0(6) 	Load constant 
495:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
497:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
499:    LDC  3,0(6) 	Load constant 
498:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
501:    LDC  3,0(6) 	Load constant 
500:    LDA  7,1(7) 	jmp to end 
* ENDIF
502:    LDA  7,-9(7) 	go to beginning of loop 
496:    LDA  7,6(7) 	No more loop 
* ENDWHILE
* WHILE
503:    LDC  3,0(6) 	Load constant 
504:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
506:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
508:    LDC  3,0(6) 	Load constant 
507:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
* IfK:
* IfK: t->child[0] condition
510:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
512:    LDC  3,0(6) 	Load constant 
511:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
513:    LDA  7,0(7) 	jmp to end 
* ENDIF
509:    LDA  7,4(7) 	jmp to end 
* ENDIF
514:    LDA  7,-12(7) 	go to beginning of loop 
505:    LDA  7,9(7) 	No more loop 
* ENDWHILE
* WHILE
515:    LDC  3,0(6) 	Load constant 
516:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
518:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
520:    LDC  3,0(6) 	Load constant 
519:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
* WHILE
522:    LDC  3,0(6) 	Load constant 
523:    JGT  3,1(7) 	Jump to while part 
* DO
525:    LDC  3,0(6) 	Load constant 
526:    LDA  7,-5(7) 	go to beginning of loop 
524:    LDA  7,2(7) 	No more loop 
* ENDWHILE
521:    LDA  7,5(7) 	jmp to end 
* ENDIF
527:    LDA  7,-13(7) 	go to beginning of loop 
517:    LDA  7,10(7) 	No more loop 
* ENDWHILE
* WHILE
528:    LDC  3,0(6) 	Load constant 
529:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
531:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
533:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
535:    LDC  3,0(6) 	Load constant 
534:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
536:    LDA  7,0(7) 	jmp to end 
* ENDIF
532:    JEQ  3,5(7) 	if: jmp to else 
* IfK: t->child[2] else part
537:    LDA  7,0(7) 	jmp to end 
* ENDIF
538:    LDA  7,-11(7) 	go to beginning of loop 
530:    LDA  7,8(7) 	No more loop 
* ENDWHILE
* WHILE
539:    LDC  3,0(6) 	Load constant 
540:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
542:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
544:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
546:    LDC  3,0(6) 	Load constant 
545:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
548:    LDC  3,0(6) 	Load constant 
547:    LDA  7,1(7) 	jmp to end 
* ENDIF
543:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
549:    LDA  7,0(7) 	jmp to end 
* ENDIF
550:    LDA  7,-12(7) 	go to beginning of loop 
541:    LDA  7,9(7) 	No more loop 
* ENDWHILE
* WHILE
551:    LDC  3,0(6) 	Load constant 
552:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
554:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
556:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
558:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
560:    LDC  3,0(6) 	Load constant 
559:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
561:    LDA  7,0(7) 	jmp to end 
* ENDIF
557:    JEQ  3,5(7) 	if: jmp to else 
* IfK: t->child[2] else part
562:    LDA  7,0(7) 	jmp to end 
* ENDIF
555:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
563:    LDA  7,0(7) 	jmp to end 
* ENDIF
564:    LDA  7,-14(7) 	go to beginning of loop 
553:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* WHILE
565:    LDC  3,0(6) 	Load constant 
566:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
568:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
570:    LDC  3,0(6) 	Load constant 
571:    JGT  3,1(7) 	Jump to while part 
* DO
573:    LDC  3,0(6) 	Load constant 
574:    LDA  7,-5(7) 	go to beginning of loop 
572:    LDA  7,2(7) 	No more loop 
* ENDWHILE
569:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
575:    LDA  7,0(7) 	jmp to end 
* ENDIF
576:    LDA  7,-12(7) 	go to beginning of loop 
567:    LDA  7,9(7) 	No more loop 
* ENDWHILE
* WHILE
577:    LDC  3,0(6) 	Load constant 
578:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
580:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
582:    LDC  3,0(6) 	Load constant 
583:    JGT  3,1(7) 	Jump to while part 
* DO
585:    LDC  3,0(6) 	Load constant 
586:    LDA  7,-5(7) 	go to beginning of loop 
584:    LDA  7,2(7) 	No more loop 
* ENDWHILE
581:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
588:    LDC  3,0(6) 	Load constant 
587:    LDA  7,1(7) 	jmp to end 
* ENDIF
589:    LDA  7,-13(7) 	go to beginning of loop 
579:    LDA  7,10(7) 	No more loop 
* ENDWHILE
* WHILE
590:    LDC  3,0(6) 	Load constant 
591:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
593:    LDC  3,0(6) 	Load constant 
594:    JGT  3,1(7) 	Jump to while part 
* DO
596:    LDC  3,0(6) 	Load constant 
597:    LDA  7,-5(7) 	go to beginning of loop 
595:    LDA  7,2(7) 	No more loop 
* ENDWHILE
598:    LDA  7,-9(7) 	go to beginning of loop 
592:    LDA  7,6(7) 	No more loop 
* ENDWHILE
* WHILE
599:    LDC  3,0(6) 	Load constant 
600:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
602:    LDC  3,0(6) 	Load constant 
603:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
605:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
607:    LDC  3,0(6) 	Load constant 
606:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
608:    LDA  7,0(7) 	jmp to end 
* ENDIF
609:    LDA  7,-8(7) 	go to beginning of loop 
604:    LDA  7,5(7) 	No more loop 
* ENDWHILE
610:    LDA  7,-12(7) 	go to beginning of loop 
601:    LDA  7,9(7) 	No more loop 
* ENDWHILE
* WHILE
611:    LDC  3,0(6) 	Load constant 
612:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
614:    LDC  3,0(6) 	Load constant 
615:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
617:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
619:    LDC  3,0(6) 	Load constant 
618:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
621:    LDC  3,0(6) 	Load constant 
620:    LDA  7,1(7) 	jmp to end 
* ENDIF
622:    LDA  7,-9(7) 	go to beginning of loop 
616:    LDA  7,6(7) 	No more loop 
* ENDWHILE
623:    LDA  7,-13(7) 	go to beginning of loop 
613:    LDA  7,10(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
624:    LDC  2,0(6) 	Set return value to 0 
625:     LD  3,-1(1) 	Load return address 
626:     LD  1,0(1) 	Adjust fp 
627:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,627(7) 	Jump to init 
* BEGIN Init
628:     LD  0,0(0) 	Set the global pointer 
629:    LDA  1,0(0) 	set first frame at end of globals 
630:     ST  1,0(1) 	store old fp (point to self) 
631:    LDA  3,1(7) 	Return address in ac 
632:    LDA  7,-603(7) 	Jump to main 
633:   HALT  0,0,0 	DONE! 
* END Init
