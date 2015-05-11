* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  permlist.tm
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
* BEGIN function put
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,1(6) 	Load constant 
 32:     ST  3,-4(1) 	Save index 
 33:     ST  3,-3(1) 	Store variable sum
* EXPRESSION STMT
 34:    LDC  3,2(6) 	Load constant 
 35:     ST  3,-2(1) 	Store variable j
* WHILE
 36:     LD  3,-2(1) 	Load variable j
 37:     ST  3,-5(1) 	Save left side 
 38:     LD  3,-1(1) 	Load variable n
 39:     LD  4,-5(1) 	Load left into ac1 
 40:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 42:     LD  3,-3(1) 	Load variable sum
 43:     ST  3,-5(1) 	Save left side 
 44:    LDC  3,10(6) 	Load constant 
 45:     LD  4,-5(1) 	Load left into ac1 
 46:    MUL  3,4,3 	Op * 
 47:     ST  3,-5(1) 	Save left side 
 48:     LD  3,-2(1) 	Load variable j
 49:     ST  3,-6(1) 	Save index 
 50:     LD  4,-6(1) 	Load left into ac1 
 51:    ADD  3,4,3 	Op + 
 52:     ST  3,-3(1) 	Store variable sum
* EXPRESSION STMT
 53:     LD  3,-2(1) 	Load variable j
 54:     ST  3,-6(1) 	Save left side 
 55:    LDC  3,1(6) 	Load constant 
 56:     LD  4,-6(1) 	Load left into ac1 
 57:    ADD  3,4,3 	Op + 
 58:     ST  3,-2(1) 	Store variable j
* END compound statement
 59:    LDA  7,-24(7) 	go to beginning of loop 
 41:    LDA  7,18(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 60:     ST  1,-6(1) 	Store old frame in ghost frame 
 61:     LD  3,-3(1) 	Load variable sum
 62:     ST  3,-8(1) 	Store parameter 
 63:    LDA  1,-6(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-60(7) 	CALL output
 66:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 67:     ST  1,-6(1) 	Store old frame in ghost frame 
 68:    LDA  1,-6(1) 	Load address of new frame 
 69:    LDA  3,1(7) 	Return address in ac 
 70:    LDA  7,-46(7) 	CALL outnl
 71:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 72:    LDC  2,0(6) 	Set return value to 0 
 73:     LD  3,-1(1) 	Load return address 
 74:     LD  1,0(1) 	Adjust fp 
 75:    LDA  7,0(3) 	Return 
* END function put
* BEGIN function main
 76:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 77:    LDC  3,0(6) 	load size of array p
 78:     ST  3,-3(1) 	save size of array p
* EXPRESSION STMT
* EXPRESSION STMT
 79:     ST  1,-6(1) 	Store old frame in ghost frame 
 80:    LDA  1,-6(1) 	Load address of new frame 
 81:    LDA  3,1(7) 	Return address in ac 
 82:    LDA  7,-82(7) 	CALL input
 83:    LDA  3,0(2) 	Save the result in ac 
 84:     ST  3,-1(1) 	Store variable n
* EXPRESSION STMT
 85:    LDC  3,0(6) 	Load constant 
 86:     ST  3,-3(1) 	Store variable j
* WHILE
 87:     LD  3,-3(1) 	Load variable j
 88:     ST  3,-6(1) 	Save left side 
 89:     LD  3,-1(1) 	Load variable n
 90:     LD  4,-6(1) 	Load left into ac1 
 91:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 93:     LD  3,-3(1) 	Load variable j
 94:     ST  3,-6(1) 	Save index 
 95:     LD  3,-3(1) 	Load variable j
 96:     ST  3,-4(1) 	Store variable p
* EXPRESSION STMT
 97:     LD  3,-3(1) 	Load variable j
 98:     ST  3,-7(1) 	Save left side 
 99:    LDC  3,1(6) 	Load constant 
100:     LD  4,-7(1) 	Load left into ac1 
101:    ADD  3,4,3 	Op + 
102:     ST  3,-3(1) 	Store variable j
* END compound statement
103:    LDA  7,-17(7) 	go to beginning of loop 
 92:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
104:    LDC  3,1(6) 	Load constant 
105:     ST  3,-2(1) 	Store variable i
* WHILE
106:     LD  3,-2(1) 	Load variable i
107:     ST  3,-7(1) 	Save left side 
108:    LDC  3,0(6) 	Load constant 
109:     LD  4,-7(1) 	Load left into ac1 
110:    SUB  4,4,3 	Op > 
111:    LDC  3,1(6) 	True case 
112:    JLT  4,1(7) 	Jump if true 
113:    LDC  3,0(6) 	False case 
114:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
116:     ST  1,-7(1) 	Store old frame in ghost frame 
117:     LD  3,-4(1) 	Load variable p
118:     ST  3,-9(1) 	Store parameter 
119:    LDA  1,-7(1) 	Load address of new frame 
120:    LDA  3,1(7) 	Return address in ac 
121:    LDA  7,-92(7) 	CALL put
122:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
123:     LD  3,-1(1) 	Load variable n
124:     ST  3,-7(1) 	Save left side 
125:    LDC  3,1(6) 	Load constant 
126:     LD  4,-7(1) 	Load left into ac1 
127:    SUB  3,4,3 	Op - 
128:     ST  3,-2(1) 	Store variable i
* WHILE
129:     LD  3,-2(1) 	Load variable i
130:     ST  3,-7(1) 	Save index 
131:     ST  3,-8(1) 	Save left side 
132:     LD  3,-2(1) 	Load variable i
133:     ST  3,-9(1) 	Save left side 
134:    LDC  3,1(6) 	Load constant 
135:     LD  4,-9(1) 	Load left into ac1 
136:    ADD  3,4,3 	Op + 
137:     ST  3,-9(1) 	Save index 
138:     LD  4,-9(1) 	Load left into ac1 
139:    SUB  4,4,3 	Op > 
140:    LDC  3,1(6) 	True case 
141:    JLT  4,1(7) 	Jump if true 
142:    LDC  3,0(6) 	False case 
143:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
145:     LD  3,-2(1) 	Load variable i
146:     ST  3,-9(1) 	Save left side 
147:    LDC  3,1(6) 	Load constant 
148:     LD  4,-9(1) 	Load left into ac1 
149:    SUB  3,4,3 	Op - 
150:     ST  3,-2(1) 	Store variable i
151:    LDA  7,-23(7) 	go to beginning of loop 
144:    LDA  7,7(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
152:     LD  3,-1(1) 	Load variable n
153:     ST  3,-3(1) 	Store variable j
* WHILE
154:     LD  3,-2(1) 	Load variable i
155:     ST  3,-9(1) 	Save index 
156:     ST  3,-10(1) 	Save left side 
157:     LD  3,-3(1) 	Load variable j
158:     ST  3,-11(1) 	Save index 
159:     LD  4,-11(1) 	Load left into ac1 
160:    SUB  4,4,3 	Op > 
161:    LDC  3,1(6) 	True case 
162:    JLT  4,1(7) 	Jump if true 
163:    LDC  3,0(6) 	False case 
164:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
166:     LD  3,-3(1) 	Load variable j
167:     ST  3,-11(1) 	Save left side 
168:    LDC  3,1(6) 	Load constant 
169:     LD  4,-11(1) 	Load left into ac1 
170:    SUB  3,4,3 	Op - 
171:     ST  3,-3(1) 	Store variable j
172:    LDA  7,-19(7) 	go to beginning of loop 
165:    LDA  7,7(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
173:     LD  3,-2(1) 	Load variable i
174:     ST  3,-11(1) 	Save index 
175:     ST  3,-5(1) 	Store variable tmp
* EXPRESSION STMT
176:     LD  3,-2(1) 	Load variable i
177:     ST  3,-12(1) 	Save index 
178:     LD  3,-3(1) 	Load variable j
179:    LDA  4,-4(0) 	Load address of base of array p
180:    SUB  3,4,3 	Compute offset of value 
181:     LD  3,0(3) 	Load the value 
182:     LD  4,-12(1) 	Restore index 
183:    LDA  5,-4(0) 	Load address of base of array p
184:    SUB  5,5,4 	Compute offset of value 
185:     ST  3,0(5) 	Store variable p
* EXPRESSION STMT
186:     LD  3,-3(1) 	Load variable j
187:     ST  3,-12(1) 	Save index 
188:     LD  3,-5(1) 	Load variable tmp
189:     ST  3,-4(1) 	Store variable p
* EXPRESSION STMT
190:     LD  3,-1(1) 	Load variable n
191:     ST  3,-5(1) 	Store variable r
* EXPRESSION STMT
192:     LD  3,-2(1) 	Load variable i
193:     ST  3,-13(1) 	Save left side 
194:    LDC  3,1(6) 	Load constant 
195:     LD  4,-13(1) 	Load left into ac1 
196:    ADD  3,4,3 	Op + 
197:     ST  3,-4(1) 	Store variable s
* WHILE
198:     LD  3,-5(1) 	Load variable r
199:     ST  3,-13(1) 	Save left side 
200:     LD  3,-4(1) 	Load variable s
201:     LD  4,-13(1) 	Load left into ac1 
202:    SUB  4,4,3 	Op > 
203:    LDC  3,1(6) 	True case 
204:    JLT  4,1(7) 	Jump if true 
205:    LDC  3,0(6) 	False case 
206:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
208:     LD  3,-5(1) 	Load variable r
209:     ST  3,-13(1) 	Save index 
210:     ST  3,-5(1) 	Store variable tmp
* EXPRESSION STMT
211:     LD  3,-5(1) 	Load variable r
212:     ST  3,-14(1) 	Save index 
213:     LD  3,-4(1) 	Load variable s
214:    LDA  4,-4(0) 	Load address of base of array p
215:    SUB  3,4,3 	Compute offset of value 
216:     LD  3,0(3) 	Load the value 
217:     LD  4,-14(1) 	Restore index 
218:    LDA  5,-4(0) 	Load address of base of array p
219:    SUB  5,5,4 	Compute offset of value 
220:     ST  3,0(5) 	Store variable p
* EXPRESSION STMT
221:     LD  3,-4(1) 	Load variable s
222:     ST  3,-14(1) 	Save index 
223:     LD  3,-5(1) 	Load variable tmp
224:     ST  3,-4(1) 	Store variable p
* EXPRESSION STMT
225:     LD  3,-5(1) 	Load variable r
226:     ST  3,-15(1) 	Save left side 
227:    LDC  3,1(6) 	Load constant 
228:     LD  4,-15(1) 	Load left into ac1 
229:    SUB  3,4,3 	Op - 
230:     ST  3,-5(1) 	Store variable r
* EXPRESSION STMT
231:     LD  3,-4(1) 	Load variable s
232:     ST  3,-15(1) 	Save left side 
233:    LDC  3,1(6) 	Load constant 
234:     LD  4,-15(1) 	Load left into ac1 
235:    ADD  3,4,3 	Op + 
236:     ST  3,-4(1) 	Store variable s
* END compound statement
237:    LDA  7,-40(7) 	go to beginning of loop 
207:    LDA  7,30(7) 	No more loop 
* ENDWHILE
* END compound statement
238:    LDA  7,-133(7) 	go to beginning of loop 
115:    LDA  7,123(7) 	No more loop 
* ENDWHILE
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
244:    LDA  1,-1(0) 	set first frame at end of globals 
245:     ST  1,0(1) 	store old fp (point to self) 
246:    LDA  3,1(7) 	Return address in ac 
247:    LDA  7,-172(7) 	Jump to main 
248:   HALT  0,0,0 	DONE! 
* END Init
