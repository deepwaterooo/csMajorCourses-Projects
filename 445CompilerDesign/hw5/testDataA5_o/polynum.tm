* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  polynum.tm
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
 31:    LDC  3,1(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable i
* EXPRESSION STMT
 33:    LDC  3,1(6) 	Load constant 
 34:     ST  3,-8(1) 	Store variable min
* WHILE
 35:     LD  3,-2(1) 	Load variable i
 36:     ST  3,-11(1) 	Save left side 
 37:    LDC  3,2000(6) 	Load constant 
 38:     LD  4,-11(1) 	Load left into ac1 
 39:    SUB  3,4,3 	Op < 
 40:    JLT  3,2(7) 	br if true 
 41:    LDC  3,0(3) 	false case 
 42:    LDA  7,1(7) 	unconditional jmp 
 43:    LDC  3,1(3) 	true case 
 44:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 46:    LDC  3,2(6) 	Load constant 
 47:     ST  3,-3(1) 	Store variable m
* EXPRESSION STMT
 48:     LD  3,-3(1) 	Load variable m
 49:     ST  3,-11(1) 	Save left side 
 50:     LD  3,-3(1) 	Load variable m
 51:     ST  3,-12(1) 	Save left side 
 52:    LDC  3,1(6) 	Load constant 
 53:     LD  4,-12(1) 	Load left into ac1 
 54:    ADD  3,4,3 	Op + 
 55:     LD  4,-11(1) 	Load left into ac1 
 56:    MUL  3,4,3 	Op * 
 57:     ST  3,-11(1) 	Save left side 
 58:    LDC  3,2(6) 	Load constant 
 59:     LD  4,-11(1) 	Load left into ac1 
 60:    DIV  3,4,3 	Op / 
 61:     ST  3,-6(1) 	Store variable tm
* EXPRESSION STMT
 62:     LD  3,-2(1) 	Load variable i
 63:     ST  3,-11(1) 	Save left side 
 64:     LD  3,-3(1) 	Load variable m
 65:     ST  3,-12(1) 	Save left side 
 66:    LDC  3,1(6) 	Load constant 
 67:     LD  4,-12(1) 	Load left into ac1 
 68:    ADD  3,4,3 	Op + 
 69:     LD  4,-11(1) 	Load left into ac1 
 70:    SUB  3,4,3 	Op - 
 71:     ST  3,-5(1) 	Store variable x
* EXPRESSION STMT
 72:     LD  3,-5(1) 	Load variable x
 73:     ST  3,-11(1) 	Save left side 
 74:     LD  3,-6(1) 	Load variable tm
 75:     LD  4,-11(1) 	Load left into ac1 
 76:    DIV  3,4,3 	Op / 
 77:     ST  3,-4(1) 	Store variable t
* EXPRESSION STMT
 78:    LDC  3,0(6) 	Load constant 
 79:     ST  3,-7(1) 	Store variable num
* WHILE
 80:     LD  3,-4(1) 	Load variable t
 81:     ST  3,-11(1) 	Save left side 
 82:    LDC  3,0(6) 	Load constant 
 83:     LD  4,-11(1) 	Load left into ac1 
 84:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
 86:     LD  3,-4(1) 	Load variable t
 87:     ST  3,-11(1) 	Save left side 
 88:     LD  3,-6(1) 	Load variable tm
 89:     LD  4,-11(1) 	Load left into ac1 
 90:    MUL  3,4,3 	Op * 
 91:     ST  3,-11(1) 	Save left side 
 92:     LD  3,-5(1) 	Load variable x
 93:     LD  4,-11(1) 	Load left into ac1 
 94:    SUB  3,4,3 	Op == 
 95:    JEQ  3,2(7) 	br if true 
 96:    LDC  3,0(3) 	false case 
 97:    LDA  7,1(7) 	unconditional jmp 
 98:    LDC  3,1(3) 	true case 
* EXPRESSION STMT
100:     LD  3,-7(1) 	Load variable num
101:     ST  3,-11(1) 	Save left side 
102:    LDC  3,1(6) 	Load constant 
103:     LD  4,-11(1) 	Load left into ac1 
104:    ADD  3,4,3 	Op + 
105:     ST  3,-7(1) 	Store variable num
 99:    JEQ  3,7(7) 	if: jmp to else 
106:    LDA  7,0(7) 	jmp to end 
* EXPRESSION STMT
107:     LD  3,-3(1) 	Load variable m
108:     ST  3,-11(1) 	Save left side 
109:    LDC  3,1(6) 	Load constant 
110:     LD  4,-11(1) 	Load left into ac1 
111:    ADD  3,4,3 	Op + 
112:     ST  3,-3(1) 	Store variable m
* EXPRESSION STMT
113:     LD  3,-3(1) 	Load variable m
114:     ST  3,-11(1) 	Save left side 
115:    LDC  3,1(6) 	Load constant 
116:     LD  4,-11(1) 	Load left into ac1 
117:    ADD  3,4,3 	Op + 
118:     ST  3,-9(1) 	Store variable a
* EXPRESSION STMT
119:     LD  3,-3(1) 	Load variable m
120:     ST  3,-11(1) 	Save left side 
121:     LD  3,-3(1) 	Load variable m
122:     ST  3,-12(1) 	Save left side 
123:    LDC  3,1(6) 	Load constant 
124:     LD  4,-12(1) 	Load left into ac1 
125:    ADD  3,4,3 	Op + 
126:     LD  4,-11(1) 	Load left into ac1 
127:    MUL  3,4,3 	Op * 
128:     ST  3,-10(1) 	Store variable b
* EXPRESSION STMT
129:     LD  3,-3(1) 	Load variable m
130:     ST  3,-11(1) 	Save left side 
131:     LD  3,-3(1) 	Load variable m
132:     ST  3,-12(1) 	Save left side 
133:    LDC  3,1(6) 	Load constant 
134:     LD  4,-12(1) 	Load left into ac1 
135:    ADD  3,4,3 	Op + 
136:     LD  4,-11(1) 	Load left into ac1 
137:    MUL  3,4,3 	Op * 
138:     ST  3,-11(1) 	Save left side 
139:    LDC  3,1(6) 	Load constant 
140:     ST  3,-12(1) 	Save left side 
141:    LDC  3,1(6) 	Load constant 
142:     LD  4,-12(1) 	Load left into ac1 
143:    ADD  3,4,3 	Op + 
144:     LD  4,-11(1) 	Load left into ac1 
145:    DIV  3,4,3 	Op / 
146:     ST  3,-6(1) 	Store variable tm
* EXPRESSION STMT
147:     LD  3,-2(1) 	Load variable i
148:     ST  3,-11(1) 	Save left side 
149:     LD  3,-3(1) 	Load variable m
150:     ST  3,-12(1) 	Save left side 
151:    LDC  3,1(6) 	Load constant 
152:     LD  4,-12(1) 	Load left into ac1 
153:    ADD  3,4,3 	Op + 
154:     LD  4,-11(1) 	Load left into ac1 
155:    SUB  3,4,3 	Op - 
156:     ST  3,-11(1) 	Save left side 
157:    LDC  3,0(6) 	Load constant 
158:     LD  4,-11(1) 	Load left into ac1 
159:    ADD  3,4,3 	Op + 
160:     ST  3,-5(1) 	Store variable x
* EXPRESSION STMT
161:     LD  3,-5(1) 	Load variable x
162:     ST  3,-11(1) 	Save left side 
163:     LD  3,-6(1) 	Load variable tm
164:     LD  4,-11(1) 	Load left into ac1 
165:    DIV  3,4,3 	Op / 
166:     ST  3,-11(1) 	Save left side 
167:    LDC  3,1(6) 	Load constant 
168:     LD  4,-11(1) 	Load left into ac1 
169:    MUL  3,4,3 	Op * 
170:     ST  3,-4(1) 	Store variable t
* END compound statement
171:    LDA  7,-87(7) 	go to beginning of loop 
 85:    LDA  7,86(7) 	No more loop 
* end WHILE
172:     LD  3,-7(1) 	Load variable num
173:     ST  3,-11(1) 	Save left side 
174:     LD  3,-8(1) 	Load variable min
175:     LD  4,-11(1) 	Load left into ac1 
* BEGIN compound statement
* EXPRESSION STMT
177:     ST  1,-11(1) 	Store old frame in ghost frame 
178:     LD  3,-7(1) 	Load variable num
179:     ST  3,-13(1) 	Store parameter 
180:    LDA  1,-11(1) 	Load address of new frame 
181:    LDA  3,1(7) 	Return address in ac 
182:    LDA  7,-177(7) 	CALL output
183:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
184:     ST  1,-11(1) 	Store old frame in ghost frame 
185:     LD  3,-2(1) 	Load variable i
186:     ST  3,-13(1) 	Store parameter 
187:    LDA  1,-11(1) 	Load address of new frame 
188:    LDA  3,1(7) 	Return address in ac 
189:    LDA  7,-184(7) 	CALL output
190:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
191:     ST  1,-11(1) 	Store old frame in ghost frame 
192:    LDC  3,11111111(6) 	Load constant 
193:     ST  3,-13(1) 	Store parameter 
194:    LDA  1,-11(1) 	Load address of new frame 
195:    LDA  3,1(7) 	Return address in ac 
196:    LDA  7,-191(7) 	CALL output
197:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
198:     LD  3,-7(1) 	Load variable num
199:     ST  3,-11(1) 	Save left side 
200:    LDC  3,1(6) 	Load constant 
201:     LD  4,-11(1) 	Load left into ac1 
202:    ADD  3,4,3 	Op + 
203:     ST  3,-8(1) 	Store variable min
* END compound statement
176:    JEQ  3,28(7) 	if: jmp to else 
204:    LDA  7,0(7) 	jmp to end 
* EXPRESSION STMT
205:     LD  3,-2(1) 	Load variable i
206:     ST  3,-11(1) 	Save left side 
207:    LDC  3,1(6) 	Load constant 
208:     LD  4,-11(1) 	Load left into ac1 
209:    ADD  3,4,3 	Op + 
210:     ST  3,-2(1) 	Store variable i
* END compound statement
211:    LDA  7,-167(7) 	go to beginning of loop 
 45:    LDA  7,166(7) 	No more loop 
* end WHILE
* RETURN
212:    LDC  3,0(6) 	Load constant 
213:    LDA  2,0(3) 	Copy result to rt register 
214:     LD  3,-1(1) 	Load return address 
215:     LD  1,0(1) 	Adjust fp 
216:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
217:    LDC  2,0(6) 	Set return value to 0 
218:     LD  3,-1(1) 	Load return address 
219:     LD  1,0(1) 	Adjust fp 
220:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,220(7) 	Jump to init 
* BEGIN Init
221:     LD  0,0(0) 	Set the global pointer 
222:    LDA  1,0(0) 	set first frame at end of globals 
223:     ST  1,0(1) 	store old fp (point to self) 
224:    LDA  3,1(7) 	Return address in ac 
225:    LDA  7,-196(7) 	Jump to main 
226:   HALT  0,0,0 	DONE! 
* END Init
