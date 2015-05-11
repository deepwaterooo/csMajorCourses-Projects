* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  assign5.tm
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
* EXPRESSION STMT
 31:    LDC  3,333(6) 	Load constant 
 32:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 33:    LDC  3,444(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 35:    LDC  3,666(6) 	Load constant 
 36:     ST  3,-3(1) 	Store variable z
* EXPRESSION STMT
* EXPRESSION STMT
 37:     LD  3,-3(1) 	Load variable z
 38:     ST  3,-2(1) 	Store variable y
 39:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 40:     ST  1,-4(1) 	Store old frame in ghost frame 
 41:     LD  3,0(1) 	Load variable x
 42:     ST  3,-6(1) 	Store parameter 
 43:    LDA  1,-4(1) 	Load address of new frame 
 44:    LDA  3,1(7) 	Return address in ac 
 45:    LDA  7,-40(7) 	CALL output
 46:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 47:     ST  1,-4(1) 	Store old frame in ghost frame 
 48:     LD  3,-2(1) 	Load variable y
 49:     ST  3,-6(1) 	Store parameter 
 50:    LDA  1,-4(1) 	Load address of new frame 
 51:    LDA  3,1(7) 	Return address in ac 
 52:    LDA  7,-47(7) 	CALL output
 53:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 54:     ST  1,-4(1) 	Store old frame in ghost frame 
 55:     LD  3,-3(1) 	Load variable z
 56:     ST  3,-6(1) 	Store parameter 
 57:    LDA  1,-4(1) 	Load address of new frame 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-54(7) 	CALL output
 60:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 61:     ST  1,-4(1) 	Store old frame in ghost frame 
 62:    LDA  1,-4(1) 	Load address of new frame 
 63:    LDA  3,1(7) 	Return address in ac 
 64:    LDA  7,-40(7) 	CALL outnl
 65:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
* EXPRESSION STMT
 66:     LD  3,-3(1) 	Load variable z
 67:     ST  3,-2(1) 	Store variable y
 68:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 69:     ST  1,-4(1) 	Store old frame in ghost frame 
 70:     LD  3,0(1) 	Load variable x
 71:     ST  3,-6(1) 	Store parameter 
 72:    LDA  1,-4(1) 	Load address of new frame 
 73:    LDA  3,1(7) 	Return address in ac 
 74:    LDA  7,-69(7) 	CALL output
 75:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 76:     ST  1,-4(1) 	Store old frame in ghost frame 
 77:     LD  3,-2(1) 	Load variable y
 78:     ST  3,-6(1) 	Store parameter 
 79:    LDA  1,-4(1) 	Load address of new frame 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-76(7) 	CALL output
 82:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 83:     ST  1,-4(1) 	Store old frame in ghost frame 
 84:     LD  3,-3(1) 	Load variable z
 85:     ST  3,-6(1) 	Store parameter 
 86:    LDA  1,-4(1) 	Load address of new frame 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-83(7) 	CALL output
 89:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 90:     ST  1,-4(1) 	Store old frame in ghost frame 
 91:    LDA  1,-4(1) 	Load address of new frame 
 92:    LDA  3,1(7) 	Return address in ac 
 93:    LDA  7,-69(7) 	CALL outnl
 94:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
* EXPRESSION STMT
 95:     LD  3,-3(1) 	Load variable z
 96:     ST  3,-2(1) 	Store variable y
 97:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 98:     ST  1,-4(1) 	Store old frame in ghost frame 
 99:     LD  3,0(1) 	Load variable x
100:     ST  3,-6(1) 	Store parameter 
101:    LDA  1,-4(1) 	Load address of new frame 
102:    LDA  3,1(7) 	Return address in ac 
103:    LDA  7,-98(7) 	CALL output
104:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
105:     ST  1,-4(1) 	Store old frame in ghost frame 
106:     LD  3,-2(1) 	Load variable y
107:     ST  3,-6(1) 	Store parameter 
108:    LDA  1,-4(1) 	Load address of new frame 
109:    LDA  3,1(7) 	Return address in ac 
110:    LDA  7,-105(7) 	CALL output
111:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
112:     ST  1,-4(1) 	Store old frame in ghost frame 
113:     LD  3,-3(1) 	Load variable z
114:     ST  3,-6(1) 	Store parameter 
115:    LDA  1,-4(1) 	Load address of new frame 
116:    LDA  3,1(7) 	Return address in ac 
117:    LDA  7,-112(7) 	CALL output
118:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
119:     ST  1,-4(1) 	Store old frame in ghost frame 
120:    LDA  1,-4(1) 	Load address of new frame 
121:    LDA  3,1(7) 	Return address in ac 
122:    LDA  7,-98(7) 	CALL outnl
123:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
* EXPRESSION STMT
124:     LD  3,-3(1) 	Load variable z
125:     ST  3,-2(1) 	Store variable y
126:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
127:     ST  1,-4(1) 	Store old frame in ghost frame 
128:     LD  3,0(1) 	Load variable x
129:     ST  3,-6(1) 	Store parameter 
130:    LDA  1,-4(1) 	Load address of new frame 
131:    LDA  3,1(7) 	Return address in ac 
132:    LDA  7,-127(7) 	CALL output
133:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
134:     ST  1,-4(1) 	Store old frame in ghost frame 
135:     LD  3,-2(1) 	Load variable y
136:     ST  3,-6(1) 	Store parameter 
137:    LDA  1,-4(1) 	Load address of new frame 
138:    LDA  3,1(7) 	Return address in ac 
139:    LDA  7,-134(7) 	CALL output
140:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
141:     ST  1,-4(1) 	Store old frame in ghost frame 
142:     LD  3,-3(1) 	Load variable z
143:     ST  3,-6(1) 	Store parameter 
144:    LDA  1,-4(1) 	Load address of new frame 
145:    LDA  3,1(7) 	Return address in ac 
146:    LDA  7,-141(7) 	CALL output
147:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
148:     ST  1,-4(1) 	Store old frame in ghost frame 
149:    LDA  1,-4(1) 	Load address of new frame 
150:    LDA  3,1(7) 	Return address in ac 
151:    LDA  7,-127(7) 	CALL outnl
152:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
* EXPRESSION STMT
153:     LD  3,-3(1) 	Load variable z
154:     ST  3,-2(1) 	Store variable y
155:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
156:     ST  1,-4(1) 	Store old frame in ghost frame 
157:     LD  3,0(1) 	Load variable x
158:     ST  3,-6(1) 	Store parameter 
159:    LDA  1,-4(1) 	Load address of new frame 
160:    LDA  3,1(7) 	Return address in ac 
161:    LDA  7,-156(7) 	CALL output
162:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
163:     ST  1,-4(1) 	Store old frame in ghost frame 
164:     LD  3,-2(1) 	Load variable y
165:     ST  3,-6(1) 	Store parameter 
166:    LDA  1,-4(1) 	Load address of new frame 
167:    LDA  3,1(7) 	Return address in ac 
168:    LDA  7,-163(7) 	CALL output
169:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
170:     ST  1,-4(1) 	Store old frame in ghost frame 
171:     LD  3,-3(1) 	Load variable z
172:     ST  3,-6(1) 	Store parameter 
173:    LDA  1,-4(1) 	Load address of new frame 
174:    LDA  3,1(7) 	Return address in ac 
175:    LDA  7,-170(7) 	CALL output
176:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
177:     ST  1,-4(1) 	Store old frame in ghost frame 
178:    LDA  1,-4(1) 	Load address of new frame 
179:    LDA  3,1(7) 	Return address in ac 
180:    LDA  7,-156(7) 	CALL outnl
181:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
* EXPRESSION STMT
182:     LD  3,-3(1) 	Load variable z
183:     ST  3,-2(1) 	Store variable y
184:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
185:     ST  1,-4(1) 	Store old frame in ghost frame 
186:     LD  3,0(1) 	Load variable x
187:     ST  3,-6(1) 	Store parameter 
188:    LDA  1,-4(1) 	Load address of new frame 
189:    LDA  3,1(7) 	Return address in ac 
190:    LDA  7,-185(7) 	CALL output
191:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
192:     ST  1,-4(1) 	Store old frame in ghost frame 
193:     LD  3,-2(1) 	Load variable y
194:     ST  3,-6(1) 	Store parameter 
195:    LDA  1,-4(1) 	Load address of new frame 
196:    LDA  3,1(7) 	Return address in ac 
197:    LDA  7,-192(7) 	CALL output
198:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
199:     ST  1,-4(1) 	Store old frame in ghost frame 
200:     LD  3,-3(1) 	Load variable z
201:     ST  3,-6(1) 	Store parameter 
202:    LDA  1,-4(1) 	Load address of new frame 
203:    LDA  3,1(7) 	Return address in ac 
204:    LDA  7,-199(7) 	CALL output
205:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
206:     ST  1,-4(1) 	Store old frame in ghost frame 
207:    LDA  1,-4(1) 	Load address of new frame 
208:    LDA  3,1(7) 	Return address in ac 
209:    LDA  7,-185(7) 	CALL outnl
210:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
* EXPRESSION STMT
211:     LD  3,-3(1) 	Load variable z
212:     ST  3,-2(1) 	Store variable y
213:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
214:     ST  1,-4(1) 	Store old frame in ghost frame 
215:     LD  3,0(1) 	Load variable x
216:     ST  3,-6(1) 	Store parameter 
217:    LDA  1,-4(1) 	Load address of new frame 
218:    LDA  3,1(7) 	Return address in ac 
219:    LDA  7,-214(7) 	CALL output
220:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
221:     ST  1,-4(1) 	Store old frame in ghost frame 
222:     LD  3,-2(1) 	Load variable y
223:     ST  3,-6(1) 	Store parameter 
224:    LDA  1,-4(1) 	Load address of new frame 
225:    LDA  3,1(7) 	Return address in ac 
226:    LDA  7,-221(7) 	CALL output
227:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
228:     ST  1,-4(1) 	Store old frame in ghost frame 
229:     LD  3,-3(1) 	Load variable z
230:     ST  3,-6(1) 	Store parameter 
231:    LDA  1,-4(1) 	Load address of new frame 
232:    LDA  3,1(7) 	Return address in ac 
233:    LDA  7,-228(7) 	CALL output
234:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
235:     ST  1,-4(1) 	Store old frame in ghost frame 
236:    LDA  1,-4(1) 	Load address of new frame 
237:    LDA  3,1(7) 	Return address in ac 
238:    LDA  7,-214(7) 	CALL outnl
239:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
* EXPRESSION STMT
240:     LD  3,-3(1) 	Load variable z
241:     ST  3,-2(1) 	Store variable y
242:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
243:     ST  1,-4(1) 	Store old frame in ghost frame 
244:     LD  3,0(1) 	Load variable x
245:     ST  3,-6(1) 	Store parameter 
246:    LDA  1,-4(1) 	Load address of new frame 
247:    LDA  3,1(7) 	Return address in ac 
248:    LDA  7,-243(7) 	CALL output
249:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
250:     ST  1,-4(1) 	Store old frame in ghost frame 
251:     LD  3,-2(1) 	Load variable y
252:     ST  3,-6(1) 	Store parameter 
253:    LDA  1,-4(1) 	Load address of new frame 
254:    LDA  3,1(7) 	Return address in ac 
255:    LDA  7,-250(7) 	CALL output
256:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
257:     ST  1,-4(1) 	Store old frame in ghost frame 
258:     LD  3,-3(1) 	Load variable z
259:     ST  3,-6(1) 	Store parameter 
260:    LDA  1,-4(1) 	Load address of new frame 
261:    LDA  3,1(7) 	Return address in ac 
262:    LDA  7,-257(7) 	CALL output
263:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
264:     ST  1,-4(1) 	Store old frame in ghost frame 
265:    LDA  1,-4(1) 	Load address of new frame 
266:    LDA  3,1(7) 	Return address in ac 
267:    LDA  7,-243(7) 	CALL outnl
268:    LDA  3,0(2) 	Save the result in ac 
* RETURN
269:    LDA  2,0(3) 	Copy result to rt register 
270:     LD  3,-1(1) 	Load return address 
271:     LD  1,0(1) 	Adjust fp 
272:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
273:    LDC  2,0(6) 	Set return value to 0 
274:     LD  3,-1(1) 	Load return address 
275:     LD  1,0(1) 	Adjust fp 
276:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,276(7) 	Jump to init 
* BEGIN Init
277:     LD  0,0(0) 	Set the global pointer 
278:    LDA  1,0(0) 	set first frame at end of globals 
279:     ST  1,0(1) 	store old fp (point to self) 
280:    LDA  3,1(7) 	Return address in ac 
281:    LDA  7,-252(7) 	Jump to main 
282:   HALT  0,0,0 	DONE! 
* END Init
