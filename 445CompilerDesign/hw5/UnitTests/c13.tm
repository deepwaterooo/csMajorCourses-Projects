* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  c13.tm
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
 31:    LDC  3,0(6) 	load size of array x
 32:     ST  3,1(1) 	save size of array x
* EXPRESSION STMT
 33:    LDC  3,5(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable z
* EXPRESSION STMT
 35:     LD  3,-2(1) 	Load variable z
 36:     ST  3,-3(1) 	Save index 
 37:    LDC  3,73(6) 	Load constant 
 38:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 39:     ST  1,-4(1) 	Store old frame in ghost frame 
 40:     LD  3,-2(1) 	Load variable z
 41:     ST  3,-6(1) 	Save index 
 42:     ST  3,-7(1) 	Store parameter 
 43:    LDA  1,-4(1) 	Load address of new frame 
 44:    LDA  3,1(7) 	Return address in ac 
 45:    LDA  7,-40(7) 	CALL output
 46:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 47:     ST  1,-4(1) 	Store old frame in ghost frame 
 48:    LDA  1,-4(1) 	Load address of new frame 
 49:    LDA  3,1(7) 	Return address in ac 
 50:    LDA  7,-26(7) 	CALL outnl
 51:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 52:    LDC  3,5(6) 	Load constant 
 53:     ST  3,-2(1) 	Store variable z
* EXPRESSION STMT
 54:     LD  3,-2(1) 	Load variable z
 55:     ST  3,-4(1) 	Save index 
 56:    LDC  3,17(6) 	Load constant 
 57:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 58:    LDC  3,17(6) 	Load constant 
 59:     ST  3,-2(1) 	Store variable z
* EXPRESSION STMT
 60:     LD  3,-2(1) 	Load variable z
 61:     ST  3,-5(1) 	Save index 
 62:    LDC  3,5(6) 	Load constant 
 63:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 64:     ST  1,-6(1) 	Store old frame in ghost frame 
 65:     LD  3,-2(1) 	Load variable z
 66:     ST  3,-8(1) 	Save index 
 67:     ST  3,-9(1) 	Store parameter 
 68:    LDA  1,-6(1) 	Load address of new frame 
 69:    LDA  3,1(7) 	Return address in ac 
 70:    LDA  7,-65(7) 	CALL output
 71:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 72:     ST  1,-6(1) 	Store old frame in ghost frame 
 73:    LDA  1,-6(1) 	Load address of new frame 
 74:    LDA  3,1(7) 	Return address in ac 
 75:    LDA  7,-51(7) 	CALL outnl
 76:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 77:     ST  1,-6(1) 	Store old frame in ghost frame 
 78:     LD  3,-2(1) 	Load variable z
 79:     ST  3,-8(1) 	Save index 
 80:     ST  3,-9(1) 	Save index 
 81:     ST  3,-10(1) 	Store parameter 
 82:    LDA  1,-6(1) 	Load address of new frame 
 83:    LDA  3,1(7) 	Return address in ac 
 84:    LDA  7,-79(7) 	CALL output
 85:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 86:     ST  1,-6(1) 	Store old frame in ghost frame 
 87:    LDA  1,-6(1) 	Load address of new frame 
 88:    LDA  3,1(7) 	Return address in ac 
 89:    LDA  7,-65(7) 	CALL outnl
 90:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 91:     ST  1,-6(1) 	Store old frame in ghost frame 
 92:     LD  3,-2(1) 	Load variable z
 93:     ST  3,-8(1) 	Save index 
 94:     ST  3,-9(1) 	Save index 
 95:     ST  3,-10(1) 	Save index 
 96:     ST  3,-11(1) 	Store parameter 
 97:    LDA  1,-6(1) 	Load address of new frame 
 98:    LDA  3,1(7) 	Return address in ac 
 99:    LDA  7,-94(7) 	CALL output
100:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
101:     ST  1,-6(1) 	Store old frame in ghost frame 
102:    LDA  1,-6(1) 	Load address of new frame 
103:    LDA  3,1(7) 	Return address in ac 
104:    LDA  7,-80(7) 	CALL outnl
105:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
106:     ST  1,-6(1) 	Store old frame in ghost frame 
107:     LD  3,-2(1) 	Load variable z
108:     ST  3,-8(1) 	Save index 
109:     ST  3,-9(1) 	Save index 
110:     ST  3,-10(1) 	Save index 
111:     ST  3,-11(1) 	Save index 
112:     ST  3,-12(1) 	Store parameter 
113:    LDA  1,-6(1) 	Load address of new frame 
114:    LDA  3,1(7) 	Return address in ac 
115:    LDA  7,-110(7) 	CALL output
116:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
117:     ST  1,-6(1) 	Store old frame in ghost frame 
118:    LDA  1,-6(1) 	Load address of new frame 
119:    LDA  3,1(7) 	Return address in ac 
120:    LDA  7,-96(7) 	CALL outnl
121:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
122:     ST  1,-6(1) 	Store old frame in ghost frame 
123:     LD  3,-2(1) 	Load variable z
124:     ST  3,-8(1) 	Save index 
125:     ST  3,-9(1) 	Save index 
126:     ST  3,-10(1) 	Save index 
127:     ST  3,-11(1) 	Save index 
128:     ST  3,-12(1) 	Save index 
129:     ST  3,-13(1) 	Store parameter 
130:    LDA  1,-6(1) 	Load address of new frame 
131:    LDA  3,1(7) 	Return address in ac 
132:    LDA  7,-127(7) 	CALL output
133:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
134:     ST  1,-6(1) 	Store old frame in ghost frame 
135:    LDA  1,-6(1) 	Load address of new frame 
136:    LDA  3,1(7) 	Return address in ac 
137:    LDA  7,-113(7) 	CALL outnl
138:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
139:     ST  1,-6(1) 	Store old frame in ghost frame 
140:     LD  3,-2(1) 	Load variable z
141:     ST  3,-8(1) 	Save index 
142:     ST  3,-9(1) 	Save index 
143:     ST  3,-10(1) 	Save index 
144:     ST  3,-11(1) 	Save index 
145:     ST  3,-12(1) 	Save index 
146:     ST  3,-13(1) 	Save index 
147:     ST  3,-14(1) 	Store parameter 
148:    LDA  1,-6(1) 	Load address of new frame 
149:    LDA  3,1(7) 	Return address in ac 
150:    LDA  7,-145(7) 	CALL output
151:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
152:     ST  1,-6(1) 	Store old frame in ghost frame 
153:    LDA  1,-6(1) 	Load address of new frame 
154:    LDA  3,1(7) 	Return address in ac 
155:    LDA  7,-131(7) 	CALL outnl
156:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
157:     ST  1,-6(1) 	Store old frame in ghost frame 
158:     LD  3,-2(1) 	Load variable z
159:     ST  3,-8(1) 	Save index 
160:     ST  3,-9(1) 	Save index 
161:     ST  3,-10(1) 	Save index 
162:     ST  3,-11(1) 	Save index 
163:     ST  3,-12(1) 	Save index 
164:     ST  3,-13(1) 	Save index 
165:     ST  3,-14(1) 	Save index 
166:     ST  3,-15(1) 	Store parameter 
167:    LDA  1,-6(1) 	Load address of new frame 
168:    LDA  3,1(7) 	Return address in ac 
169:    LDA  7,-164(7) 	CALL output
170:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
171:     ST  1,-6(1) 	Store old frame in ghost frame 
172:    LDA  1,-6(1) 	Load address of new frame 
173:    LDA  3,1(7) 	Return address in ac 
174:    LDA  7,-150(7) 	CALL outnl
175:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
176:     ST  1,-6(1) 	Store old frame in ghost frame 
177:     LD  3,-2(1) 	Load variable z
178:     ST  3,-8(1) 	Save index 
179:     ST  3,-9(1) 	Save index 
180:     ST  3,-10(1) 	Save index 
181:     ST  3,-11(1) 	Save index 
182:     ST  3,-12(1) 	Save index 
183:     ST  3,-13(1) 	Save index 
184:     ST  3,-14(1) 	Save index 
185:     ST  3,-15(1) 	Save index 
186:     ST  3,-16(1) 	Store parameter 
187:    LDA  1,-6(1) 	Load address of new frame 
188:    LDA  3,1(7) 	Return address in ac 
189:    LDA  7,-184(7) 	CALL output
190:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
191:     ST  1,-6(1) 	Store old frame in ghost frame 
192:    LDA  1,-6(1) 	Load address of new frame 
193:    LDA  3,1(7) 	Return address in ac 
194:    LDA  7,-170(7) 	CALL outnl
195:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
196:     ST  1,-6(1) 	Store old frame in ghost frame 
197:     LD  3,-2(1) 	Load variable z
198:     ST  3,-8(1) 	Save index 
199:     ST  3,-9(1) 	Save index 
200:     ST  3,-10(1) 	Save index 
201:     ST  3,-11(1) 	Save index 
202:     ST  3,-12(1) 	Save index 
203:     ST  3,-13(1) 	Save index 
204:     ST  3,-14(1) 	Save index 
205:     ST  3,-15(1) 	Save index 
206:     ST  3,-16(1) 	Save index 
207:     ST  3,-17(1) 	Store parameter 
208:    LDA  1,-6(1) 	Load address of new frame 
209:    LDA  3,1(7) 	Return address in ac 
210:    LDA  7,-205(7) 	CALL output
211:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
212:     ST  1,-6(1) 	Store old frame in ghost frame 
213:    LDA  1,-6(1) 	Load address of new frame 
214:    LDA  3,1(7) 	Return address in ac 
215:    LDA  7,-191(7) 	CALL outnl
216:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
217:     ST  1,-6(1) 	Store old frame in ghost frame 
218:     LD  3,-2(1) 	Load variable z
219:     ST  3,-8(1) 	Save index 
220:     ST  3,-9(1) 	Save index 
221:     ST  3,-10(1) 	Save index 
222:     ST  3,-11(1) 	Save index 
223:     ST  3,-12(1) 	Save index 
224:     ST  3,-13(1) 	Save index 
225:     ST  3,-14(1) 	Save index 
226:     ST  3,-15(1) 	Save index 
227:     ST  3,-16(1) 	Save index 
228:     ST  3,-17(1) 	Save index 
229:     ST  3,-18(1) 	Store parameter 
230:    LDA  1,-6(1) 	Load address of new frame 
231:    LDA  3,1(7) 	Return address in ac 
232:    LDA  7,-227(7) 	CALL output
233:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
234:     ST  1,-6(1) 	Store old frame in ghost frame 
235:    LDA  1,-6(1) 	Load address of new frame 
236:    LDA  3,1(7) 	Return address in ac 
237:    LDA  7,-213(7) 	CALL outnl
238:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
239:    LDC  2,0(6) 	Set return value to 0 
240:     LD  3,-1(1) 	Load return address 
241:     LD  1,0(1) 	Adjust fp 
242:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,242(7) 	Jump to init 
* BEGIN Init
243:     LD  0,0(0) 	Set the global pointer 
244:    LDA  1,0(0) 	set first frame at end of globals 
245:     ST  1,0(1) 	store old fp (point to self) 
246:    LDA  3,1(7) 	Return address in ac 
247:    LDA  7,-218(7) 	Jump to main 
248:   HALT  0,0,0 	DONE! 
* END Init
