* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  factor.tm
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
* BEGIN function sqrt
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* IfK:
* IfK: t->child[0] condition
 31:     LD  3,-2(1) 	Load variable x
 32:     ST  3,-4(1) 	Save left side 
 33:    LDC  3,1(6) 	Load constant 
 34:     LD  4,-4(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op == 
 36:    LDC  3,1(6) 	True case 
 37:    JEQ  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* RETURN
 40:    LDC  3,1(6) 	Load constant 
 41:    LDA  2,0(3) 	Copy result to rt register 
 42:     LD  3,-1(1) 	Load return address 
 43:     LD  1,0(1) 	Adjust fp 
 44:    LDA  7,0(3) 	Return 
 39:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
 45:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
 46:     LD  3,-2(1) 	Load variable x
 47:     ST  3,-4(1) 	Save left side 
 48:    LDC  3,2(6) 	Load constant 
 49:     LD  4,-4(1) 	Load left into ac1 
 50:    DIV  3,4,3 	Op / 
 51:     ST  3,0(1) 	Store variable guess
* EXPRESSION STMT
 52:     LD  3,-2(1) 	Load variable x
 53:     ST  3,-4(1) 	Save left side 
 54:     LD  3,0(1) 	Load variable guess
 55:     LD  4,-4(1) 	Load left into ac1 
 56:    DIV  3,4,3 	Op / 
 57:     ST  3,-4(1) 	Save left side 
 58:     LD  3,0(1) 	Load variable guess
 59:     LD  4,-4(1) 	Load left into ac1 
 60:    ADD  3,4,3 	Op + 
 61:     ST  3,-4(1) 	Save left side 
 62:    LDC  3,2(6) 	Load constant 
 63:     LD  4,-4(1) 	Load left into ac1 
 64:    DIV  3,4,3 	Op / 
 65:     ST  3,-3(1) 	Store variable newguess
* WHILE
 66:     LD  3,0(1) 	Load variable guess
 67:     ST  3,-4(1) 	Save left side 
 68:     LD  3,-3(1) 	Load variable newguess
 69:     LD  4,-4(1) 	Load left into ac1 
 70:    SUB  3,4,3 	Op - 
 71:     ST  3,-4(1) 	Save left side 
 72:    LDC  3,1(6) 	Load constant 
 73:     LD  4,-4(1) 	Load left into ac1 
 74:    SUB  4,4,3 	Op > 
 75:    LDC  3,1(6) 	True case 
 76:    JLT  4,1(7) 	Jump if true 
 77:    LDC  3,0(6) 	False case 
 78:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 80:     LD  3,-3(1) 	Load variable newguess
 81:     ST  3,0(1) 	Store variable guess
* EXPRESSION STMT
 82:     LD  3,-2(1) 	Load variable x
 83:     ST  3,-4(1) 	Save left side 
 84:     LD  3,0(1) 	Load variable guess
 85:     LD  4,-4(1) 	Load left into ac1 
 86:    DIV  3,4,3 	Op / 
 87:     ST  3,-4(1) 	Save left side 
 88:     LD  3,0(1) 	Load variable guess
 89:     LD  4,-4(1) 	Load left into ac1 
 90:    ADD  3,4,3 	Op + 
 91:     ST  3,-4(1) 	Save left side 
 92:    LDC  3,2(6) 	Load constant 
 93:     LD  4,-4(1) 	Load left into ac1 
 94:    DIV  3,4,3 	Op / 
 95:     ST  3,-3(1) 	Store variable newguess
* END compound statement
 96:    LDA  7,-31(7) 	go to beginning of loop 
 79:    LDA  7,17(7) 	No more loop 
* ENDWHILE
* IfK:
* IfK: t->child[0] condition
 97:     LD  3,-3(1) 	Load variable newguess
 98:     ST  3,-4(1) 	Save left side 
 99:     LD  3,-3(1) 	Load variable newguess
100:     LD  4,-4(1) 	Load left into ac1 
101:    MUL  3,4,3 	Op * 
102:     ST  3,-4(1) 	Save left side 
103:     LD  3,-2(1) 	Load variable x
104:     LD  4,-4(1) 	Load left into ac1 
105:    SUB  4,4,3 	Op > 
106:    LDC  3,1(6) 	True case 
107:    JLT  4,1(7) 	Jump if true 
108:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
110:     LD  3,-3(1) 	Load variable newguess
111:     ST  3,-4(1) 	Save left side 
112:    LDC  3,1(6) 	Load constant 
113:     LD  4,-4(1) 	Load left into ac1 
114:    SUB  3,4,3 	Op - 
115:     ST  3,-3(1) 	Store variable newguess
109:    JEQ  3,7(7) 	if: jmp to else 
* IfK: t->child[2] else part
116:    LDA  7,0(7) 	jmp to end 
* ENDIF
* RETURN
117:     LD  3,-3(1) 	Load variable newguess
118:    LDA  2,0(3) 	Copy result to rt register 
119:     LD  3,-1(1) 	Load return address 
120:     LD  1,0(1) 	Adjust fp 
121:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
122:    LDC  2,0(6) 	Set return value to 0 
123:     LD  3,-1(1) 	Load return address 
124:     LD  1,0(1) 	Adjust fp 
125:    LDA  7,0(3) 	Return 
* END function sqrt
* BEGIN function main
126:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* WHILE
* EXPRESSION STMT
* EXPRESSION STMT
127:     ST  1,-3(1) 	Store old frame in ghost frame 
128:    LDA  1,-3(1) 	Load address of new frame 
129:    LDA  3,1(7) 	Return address in ac 
130:    LDA  7,-130(7) 	CALL input
131:    LDA  3,0(2) 	Save the result in ac 
132:     ST  3,-2(1) 	Store variable n
133:     ST  3,-3(1) 	Save left side 
134:    LDC  3,1(6) 	Load constant 
135:     LD  4,-3(1) 	Load left into ac1 
136:    SUB  4,4,3 	Op > 
137:    LDC  3,1(6) 	True case 
138:    JLT  4,1(7) 	Jump if true 
139:    LDC  3,0(6) 	False case 
140:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
* EXPRESSION STMT
142:     ST  1,-3(1) 	Store old frame in ghost frame 
143:     LD  3,-2(1) 	Load variable n
144:     ST  3,-5(1) 	Store parameter 
145:    LDA  1,-3(1) 	Load address of new frame 
146:    LDA  3,1(7) 	Return address in ac 
147:    LDA  7,-118(7) 	CALL sqrt
148:    LDA  3,0(2) 	Save the result in ac 
149:     ST  3,-4(1) 	Store variable limit
* WHILE
150:     LD  3,-2(1) 	Load variable n
151:     ST  3,-3(1) 	Save left side 
152:    LDC  3,2(6) 	Load constant 
153:     LD  4,-3(1) 	Load left into ac1 
154:     ST  3,-3(1) 	Save left side 
155:    LDC  3,0(6) 	Load constant 
156:     LD  4,-3(1) 	Load left into ac1 
157:    SUB  4,4,3 	Op == 
158:    LDC  3,1(6) 	True case 
159:    JEQ  4,1(7) 	Jump if true 
160:    LDC  3,0(6) 	False case 
161:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
163:     ST  1,-3(1) 	Store old frame in ghost frame 
164:    LDC  3,2(6) 	Load constant 
165:     ST  3,-5(1) 	Store parameter 
166:    LDA  1,-3(1) 	Load address of new frame 
167:    LDA  3,1(7) 	Return address in ac 
168:    LDA  7,-163(7) 	CALL output
169:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
170:     LD  3,-2(1) 	Load variable n
171:     ST  3,-3(1) 	Save left side 
172:    LDC  3,2(6) 	Load constant 
173:     LD  4,-3(1) 	Load left into ac1 
174:    DIV  3,4,3 	Op / 
175:     ST  3,-2(1) 	Store variable n
* END compound statement
176:    LDA  7,-27(7) 	go to beginning of loop 
162:    LDA  7,14(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
177:    LDC  3,3(6) 	Load constant 
178:     ST  3,-2(1) 	Store variable i
* WHILE
179:     LD  3,-2(1) 	Load variable i
180:     ST  3,-3(1) 	Save left side 
181:     LD  3,-4(1) 	Load variable limit
182:     LD  4,-3(1) 	Load left into ac1 
183:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* WHILE
185:     LD  3,-2(1) 	Load variable n
186:     ST  3,-3(1) 	Save left side 
187:     LD  3,-2(1) 	Load variable i
188:     LD  4,-3(1) 	Load left into ac1 
189:     ST  3,-3(1) 	Save left side 
190:    LDC  3,0(6) 	Load constant 
191:     LD  4,-3(1) 	Load left into ac1 
192:    SUB  4,4,3 	Op == 
193:    LDC  3,1(6) 	True case 
194:    JEQ  4,1(7) 	Jump if true 
195:    LDC  3,0(6) 	False case 
196:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
198:     ST  1,-3(1) 	Store old frame in ghost frame 
199:     LD  3,-2(1) 	Load variable i
200:     ST  3,-5(1) 	Store parameter 
201:    LDA  1,-3(1) 	Load address of new frame 
202:    LDA  3,1(7) 	Return address in ac 
203:    LDA  7,-198(7) 	CALL output
204:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
205:     LD  3,-2(1) 	Load variable n
206:     ST  3,-3(1) 	Save left side 
207:     LD  3,-2(1) 	Load variable i
208:     LD  4,-3(1) 	Load left into ac1 
209:    DIV  3,4,3 	Op / 
210:     ST  3,-2(1) 	Store variable n
* EXPRESSION STMT
* EXPRESSION STMT
211:     ST  1,-3(1) 	Store old frame in ghost frame 
212:     LD  3,-2(1) 	Load variable n
213:     ST  3,-5(1) 	Store parameter 
214:    LDA  1,-3(1) 	Load address of new frame 
215:    LDA  3,1(7) 	Return address in ac 
216:    LDA  7,-187(7) 	CALL sqrt
217:    LDA  3,0(2) 	Save the result in ac 
218:     ST  3,-4(1) 	Store variable limit
* END compound statement
219:    LDA  7,-35(7) 	go to beginning of loop 
197:    LDA  7,22(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
220:     LD  3,-2(1) 	Load variable i
221:     ST  3,-3(1) 	Save left side 
222:    LDC  3,2(6) 	Load constant 
223:     LD  4,-3(1) 	Load left into ac1 
224:    ADD  3,4,3 	Op + 
225:     ST  3,-2(1) 	Store variable i
* END compound statement
226:    LDA  7,-48(7) 	go to beginning of loop 
197:    LDA  7,29(7) 	No more loop 
* ENDWHILE
* IfK:
* IfK: t->child[0] condition
227:     LD  3,-2(1) 	Load variable n
228:     ST  3,-3(1) 	Save left side 
229:    LDC  3,1(6) 	Load constant 
230:     LD  4,-3(1) 	Load left into ac1 
231:    SUB  4,4,3 	Op > 
232:    LDC  3,1(6) 	True case 
233:    JLT  4,1(7) 	Jump if true 
234:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
236:     ST  1,-3(1) 	Store old frame in ghost frame 
237:     LD  3,-2(1) 	Load variable n
238:     ST  3,-5(1) 	Store parameter 
239:    LDA  1,-3(1) 	Load address of new frame 
240:    LDA  3,1(7) 	Return address in ac 
241:    LDA  7,-236(7) 	CALL output
242:    LDA  3,0(2) 	Save the result in ac 
235:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
243:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
244:     ST  1,-3(1) 	Store old frame in ghost frame 
245:    LDA  1,-3(1) 	Load address of new frame 
246:    LDA  3,1(7) 	Return address in ac 
247:    LDA  7,-223(7) 	CALL outnl
248:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
249:    LDA  7,-123(7) 	go to beginning of loop 
184:    LDA  7,65(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
250:    LDC  2,0(6) 	Set return value to 0 
251:     LD  3,-1(1) 	Load return address 
252:     LD  1,0(1) 	Adjust fp 
253:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,253(7) 	Jump to init 
* BEGIN Init
254:     LD  0,0(0) 	Set the global pointer 
255:    LDA  1,0(0) 	set first frame at end of globals 
256:     ST  1,0(1) 	store old fp (point to self) 
257:    LDA  3,1(7) 	Return address in ac 
258:    LDA  7,-133(7) 	Jump to main 
259:   HALT  0,0,0 	DONE! 
* END Init
