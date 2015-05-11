* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  factor.c-
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
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
 31:     LD  3,-2(1) 	Load variable x
 32:     ST  3,-5(1) 	Save left side 
 33:    LDC  3,1(6) 	Load constant 
 34:     LD  4,-5(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op == 
 36:    LDC  3,1(6) 	True case 
 37:    JEQ  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
 39:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
 41:    LDC  3,1(6) 	Load constant 
 42:    LDA  2,0(3) 	Copy result to rt register 
 43:     LD  3,-1(1) 	Load return address 
 44:     LD  1,0(1) 	Adjust fp 
 45:    LDA  7,0(3) 	Return 
 40:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
 46:     LD  3,-2(1) 	Load variable x
 47:     ST  3,-5(1) 	Save left side 
 48:    LDC  3,2(6) 	Load constant 
 49:     LD  4,-5(1) 	Load left into ac1 
 50:    DIV  3,4,3 	Op / 
 51:     ST  3,-3(1) 	Store variable guess
* EXPRESSION STMT
 52:     LD  3,-2(1) 	Load variable x
 53:     ST  3,-5(1) 	Save left side 
 54:     LD  3,-3(1) 	Load variable guess
 55:     LD  4,-5(1) 	Load left into ac1 
 56:    DIV  3,4,3 	Op / 
 57:     ST  3,-5(1) 	Save left side 
 58:     LD  3,-3(1) 	Load variable guess
 59:     LD  4,-5(1) 	Load left into ac1 
 60:    ADD  3,4,3 	Op + 
 61:     ST  3,-5(1) 	Save left side 
 62:    LDC  3,2(6) 	Load constant 
 63:     LD  4,-5(1) 	Load left into ac1 
 64:    DIV  3,4,3 	Op / 
 65:     ST  3,-4(1) 	Store variable newguess
* WHILE
 66:     LD  3,-3(1) 	Load variable guess
 67:     ST  3,-5(1) 	Save left side 
 68:     LD  3,-4(1) 	Load variable newguess
 69:     LD  4,-5(1) 	Load left into ac1 
 70:    SUB  3,4,3 	Op - 
 71:     ST  3,-5(1) 	Save left side 
 72:    LDC  3,1(6) 	Load constant 
 73:     LD  4,-5(1) 	Load left into ac1 
 74:    SUB  4,4,3 	Op > 
 75:    LDC  3,1(6) 	True case 
 76:    JGT  4,1(7) 	Jump if true 
 77:    LDC  3,0(6) 	False case 
 78:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 80:     LD  3,-4(1) 	Load variable newguess
 81:     ST  3,-3(1) 	Store variable guess
* EXPRESSION STMT
 82:     LD  3,-2(1) 	Load variable x
 83:     ST  3,-5(1) 	Save left side 
 84:     LD  3,-3(1) 	Load variable guess
 85:     LD  4,-5(1) 	Load left into ac1 
 86:    DIV  3,4,3 	Op / 
 87:     ST  3,-5(1) 	Save left side 
 88:     LD  3,-3(1) 	Load variable guess
 89:     LD  4,-5(1) 	Load left into ac1 
 90:    ADD  3,4,3 	Op + 
 91:     ST  3,-5(1) 	Save left side 
 92:    LDC  3,2(6) 	Load constant 
 93:     LD  4,-5(1) 	Load left into ac1 
 94:    DIV  3,4,3 	Op / 
 95:     ST  3,-4(1) 	Store variable newguess
* END compound statement
 96:    LDA  7,-31(7) 	go to beginning of loop 
 79:    LDA  7,17(7) 	No more loop 
* ENDWHILE
* IF
 97:     LD  3,-4(1) 	Load variable newguess
 98:     ST  3,-5(1) 	Save left side 
 99:     LD  3,-4(1) 	Load variable newguess
100:     LD  4,-5(1) 	Load left into ac1 
101:    MUL  3,4,3 	Op * 
102:     ST  3,-5(1) 	Save left side 
103:     LD  3,-2(1) 	Load variable x
104:     LD  4,-5(1) 	Load left into ac1 
105:    SUB  4,4,3 	Op > 
106:    LDC  3,1(6) 	True case 
107:    JGT  4,1(7) 	Jump if true 
108:    LDC  3,0(6) 	False case 
109:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
111:     LD  3,-4(1) 	Load variable newguess
112:     ST  3,-5(1) 	Save left side 
113:    LDC  3,1(6) 	Load constant 
114:     LD  4,-5(1) 	Load left into ac1 
115:    SUB  3,4,3 	Op - 
116:     ST  3,-4(1) 	Store variable newguess
110:    LDA  7,6(7) 	Jump around the THEN 
* ENDIF
* RETURN
117:     LD  3,-4(1) 	Load variable newguess
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
* END of function sqrt
* BEGIN function main
126:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* WHILE
127:     ST  1,-5(1) 	Store old fp in ghost frame 
128:    LDA  1,-5(1) 	Load address of new frame 
129:    LDA  3,1(7) 	Return address in ac 
130:    LDA  7,-130(7) 	CALL input
131:    LDA  3,0(2) 	Save the result in ac 
132:     ST  3,-2(1) 	Store variable n
133:     ST  3,-5(1) 	Save left side 
134:    LDC  3,1(6) 	Load constant 
135:     LD  4,-5(1) 	Load left into ac1 
136:    SUB  4,4,3 	Op > 
137:    LDC  3,1(6) 	True case 
138:    JGT  4,1(7) 	Jump if true 
139:    LDC  3,0(6) 	False case 
140:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
142:     ST  1,-5(1) 	Store old fp in ghost frame 
143:     LD  3,-2(1) 	Load variable n
144:     ST  3,-7(1) 	Store parameter 
145:    LDA  1,-5(1) 	Load address of new frame 
146:    LDA  3,1(7) 	Return address in ac 
147:    LDA  7,-118(7) 	CALL sqrt
148:    LDA  3,0(2) 	Save the result in ac 
149:     ST  3,-4(1) 	Store variable limit
* WHILE
150:     LD  3,-2(1) 	Load variable n
151:     ST  3,-5(1) 	Save left side 
152:    LDC  3,2(6) 	Load constant 
153:     LD  4,-5(1) 	Load left into ac1 
154:    DIV  5,4,3 	Op % 
155:    MUL  5,5,3 	 
156:    SUB  3,4,5 	 
157:     ST  3,-5(1) 	Save left side 
158:    LDC  3,0(6) 	Load constant 
159:     LD  4,-5(1) 	Load left into ac1 
160:    SUB  4,4,3 	Op == 
161:    LDC  3,1(6) 	True case 
162:    JEQ  4,1(7) 	Jump if true 
163:    LDC  3,0(6) 	False case 
164:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
166:     ST  1,-5(1) 	Store old fp in ghost frame 
167:    LDC  3,2(6) 	Load constant 
168:     ST  3,-7(1) 	Store parameter 
169:    LDA  1,-5(1) 	Load address of new frame 
170:    LDA  3,1(7) 	Return address in ac 
171:    LDA  7,-166(7) 	CALL output
172:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
173:     LD  3,-2(1) 	Load variable n
174:     ST  3,-5(1) 	Save left side 
175:    LDC  3,2(6) 	Load constant 
176:     LD  4,-5(1) 	Load left into ac1 
177:    DIV  3,4,3 	Op / 
178:     ST  3,-2(1) 	Store variable n
* END compound statement
179:    LDA  7,-30(7) 	go to beginning of loop 
165:    LDA  7,14(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
180:    LDC  3,3(6) 	Load constant 
181:     ST  3,-3(1) 	Store variable i
* WHILE
182:     LD  3,-3(1) 	Load variable i
183:     ST  3,-5(1) 	Save left side 
184:     LD  3,-4(1) 	Load variable limit
185:     LD  4,-5(1) 	Load left into ac1 
186:    SUB  4,4,3 	Op <= 
187:    LDC  3,1(6) 	True case 
188:    JLE  4,1(7) 	Jump if true 
189:    LDC  3,0(6) 	False case 
190:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* WHILE
192:     LD  3,-2(1) 	Load variable n
193:     ST  3,-5(1) 	Save left side 
194:     LD  3,-3(1) 	Load variable i
195:     LD  4,-5(1) 	Load left into ac1 
196:    DIV  5,4,3 	Op % 
197:    MUL  5,5,3 	 
198:    SUB  3,4,5 	 
199:     ST  3,-5(1) 	Save left side 
200:    LDC  3,0(6) 	Load constant 
201:     LD  4,-5(1) 	Load left into ac1 
202:    SUB  4,4,3 	Op == 
203:    LDC  3,1(6) 	True case 
204:    JEQ  4,1(7) 	Jump if true 
205:    LDC  3,0(6) 	False case 
206:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
208:     ST  1,-5(1) 	Store old fp in ghost frame 
209:     LD  3,-3(1) 	Load variable i
210:     ST  3,-7(1) 	Store parameter 
211:    LDA  1,-5(1) 	Load address of new frame 
212:    LDA  3,1(7) 	Return address in ac 
213:    LDA  7,-208(7) 	CALL output
214:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
215:     LD  3,-2(1) 	Load variable n
216:     ST  3,-5(1) 	Save left side 
217:     LD  3,-3(1) 	Load variable i
218:     LD  4,-5(1) 	Load left into ac1 
219:    DIV  3,4,3 	Op / 
220:     ST  3,-2(1) 	Store variable n
* EXPRESSION STMT
221:     ST  1,-5(1) 	Store old fp in ghost frame 
222:     LD  3,-2(1) 	Load variable n
223:     ST  3,-7(1) 	Store parameter 
224:    LDA  1,-5(1) 	Load address of new frame 
225:    LDA  3,1(7) 	Return address in ac 
226:    LDA  7,-197(7) 	CALL sqrt
227:    LDA  3,0(2) 	Save the result in ac 
228:     ST  3,-4(1) 	Store variable limit
* END compound statement
229:    LDA  7,-38(7) 	go to beginning of loop 
207:    LDA  7,22(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
230:     LD  3,-3(1) 	Load variable i
231:     ST  3,-5(1) 	Save left side 
232:    LDC  3,2(6) 	Load constant 
233:     LD  4,-5(1) 	Load left into ac1 
234:    ADD  3,4,3 	Op + 
235:     ST  3,-3(1) 	Store variable i
* END compound statement
236:    LDA  7,-55(7) 	go to beginning of loop 
191:    LDA  7,45(7) 	No more loop 
* ENDWHILE
* IF
237:     LD  3,-2(1) 	Load variable n
238:     ST  3,-5(1) 	Save left side 
239:    LDC  3,1(6) 	Load constant 
240:     LD  4,-5(1) 	Load left into ac1 
241:    SUB  4,4,3 	Op > 
242:    LDC  3,1(6) 	True case 
243:    JGT  4,1(7) 	Jump if true 
244:    LDC  3,0(6) 	False case 
245:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
247:     ST  1,-5(1) 	Store old fp in ghost frame 
248:     LD  3,-2(1) 	Load variable n
249:     ST  3,-7(1) 	Store parameter 
250:    LDA  1,-5(1) 	Load address of new frame 
251:    LDA  3,1(7) 	Return address in ac 
252:    LDA  7,-247(7) 	CALL output
253:    LDA  3,0(2) 	Save the result in ac 
246:    LDA  7,7(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
254:     ST  1,-5(1) 	Store old fp in ghost frame 
255:    LDA  1,-5(1) 	Load address of new frame 
256:    LDA  3,1(7) 	Return address in ac 
257:    LDA  7,-233(7) 	CALL outnl
258:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
259:    LDA  7,-133(7) 	go to beginning of loop 
141:    LDA  7,118(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
260:    LDC  2,0(6) 	Set return value to 0 
261:     LD  3,-1(1) 	Load return address 
262:     LD  1,0(1) 	Adjust fp 
263:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,263(7) 	Jump to init 
* BEGIN Init
264:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
265:    LDA  1,0(0) 	set first frame at end of globals 
266:     ST  1,0(1) 	store old fp (point to self) 
267:    LDA  3,1(7) 	Return address in ac 
268:    LDA  7,-143(7) 	Jump to main 
269:   HALT  0,0,0 	DONE! 
* END Init
