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
 32:     ST  3,0(1) 	Store variable i
* EXPRESSION STMT
 33:    LDC  3,1(6) 	Load constant 
 34:     ST  3,-7(1) 	Store variable min
* WHILE
 35:     LD  3,0(1) 	Load variable i
 36:     ST  3,-10(1) 	Save left side 
 37:    LDC  3,2000(6) 	Load constant 
 38:     LD  4,-10(1) 	Load left into ac1 
 39:    SUB  4,4,3 	Op < 
 40:    LDC  3,1(6) 	True case 
 41:    JLT  4,1(7) 	Jump if true 
 42:    LDC  3,0(6) 	False case 
 43:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 45:    LDC  3,2(6) 	Load constant 
 46:     ST  3,-2(1) 	Store variable m
* EXPRESSION STMT
 47:     LD  3,-2(1) 	Load variable m
 48:     ST  3,-10(1) 	Save left side 
 49:     LD  3,-2(1) 	Load variable m
 50:     ST  3,-11(1) 	Save left side 
 51:    LDC  3,1(6) 	Load constant 
 52:     LD  4,-11(1) 	Load left into ac1 
 53:    ADD  3,4,3 	Op + 
 54:     LD  4,-10(1) 	Load left into ac1 
 55:    MUL  3,4,3 	Op * 
 56:     ST  3,-10(1) 	Save left side 
 57:    LDC  3,2(6) 	Load constant 
 58:     LD  4,-10(1) 	Load left into ac1 
 59:    DIV  3,4,3 	Op / 
 60:     ST  3,-5(1) 	Store variable tm
* EXPRESSION STMT
 61:     LD  3,0(1) 	Load variable i
 62:     ST  3,-10(1) 	Save left side 
 63:     LD  3,-2(1) 	Load variable m
 64:     ST  3,-11(1) 	Save left side 
 65:    LDC  3,1(6) 	Load constant 
 66:     LD  4,-11(1) 	Load left into ac1 
 67:    ADD  3,4,3 	Op + 
 68:     LD  4,-10(1) 	Load left into ac1 
 69:    SUB  3,4,3 	Op - 
 70:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
 71:     LD  3,-4(1) 	Load variable x
 72:     ST  3,-10(1) 	Save left side 
 73:     LD  3,-5(1) 	Load variable tm
 74:     LD  4,-10(1) 	Load left into ac1 
 75:    DIV  3,4,3 	Op / 
 76:     ST  3,-3(1) 	Store variable t
* EXPRESSION STMT
 77:    LDC  3,0(6) 	Load constant 
 78:     ST  3,-6(1) 	Store variable num
* WHILE
 79:     LD  3,-3(1) 	Load variable t
 80:     ST  3,-10(1) 	Save left side 
 81:    LDC  3,0(6) 	Load constant 
 82:     LD  4,-10(1) 	Load left into ac1 
 83:    SUB  4,4,3 	Op > 
 84:    LDC  3,1(6) 	True case 
 85:    JLT  4,1(7) 	Jump if true 
 86:    LDC  3,0(6) 	False case 
 87:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IfK:
* IfK: t->child[0] condition
 89:     LD  3,-3(1) 	Load variable t
 90:     ST  3,-10(1) 	Save left side 
 91:     LD  3,-5(1) 	Load variable tm
 92:     LD  4,-10(1) 	Load left into ac1 
 93:    MUL  3,4,3 	Op * 
 94:     ST  3,-10(1) 	Save left side 
 95:     LD  3,-4(1) 	Load variable x
 96:     LD  4,-10(1) 	Load left into ac1 
 97:    SUB  4,4,3 	Op == 
 98:    LDC  3,1(6) 	True case 
 99:    JEQ  4,1(7) 	Jump if true 
100:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
102:     LD  3,-6(1) 	Load variable num
103:     ST  3,-10(1) 	Save left side 
104:    LDC  3,1(6) 	Load constant 
105:     LD  4,-10(1) 	Load left into ac1 
106:    ADD  3,4,3 	Op + 
107:     ST  3,-6(1) 	Store variable num
101:    JEQ  3,7(7) 	if: jmp to else 
* IfK: t->child[2] else part
108:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
109:     LD  3,-2(1) 	Load variable m
110:     ST  3,-10(1) 	Save left side 
111:    LDC  3,1(6) 	Load constant 
112:     LD  4,-10(1) 	Load left into ac1 
113:    ADD  3,4,3 	Op + 
114:     ST  3,-2(1) 	Store variable m
* EXPRESSION STMT
115:     LD  3,-2(1) 	Load variable m
116:     ST  3,-10(1) 	Save left side 
117:    LDC  3,1(6) 	Load constant 
118:     LD  4,-10(1) 	Load left into ac1 
119:    ADD  3,4,3 	Op + 
120:     ST  3,-8(1) 	Store variable a
* EXPRESSION STMT
121:     LD  3,-2(1) 	Load variable m
122:     ST  3,-10(1) 	Save left side 
123:     LD  3,-2(1) 	Load variable m
124:     ST  3,-11(1) 	Save left side 
125:    LDC  3,1(6) 	Load constant 
126:     LD  4,-11(1) 	Load left into ac1 
127:    ADD  3,4,3 	Op + 
128:     LD  4,-10(1) 	Load left into ac1 
129:    MUL  3,4,3 	Op * 
130:     ST  3,-9(1) 	Store variable b
* EXPRESSION STMT
131:     LD  3,-2(1) 	Load variable m
132:     ST  3,-10(1) 	Save left side 
133:     LD  3,-2(1) 	Load variable m
134:     ST  3,-11(1) 	Save left side 
135:    LDC  3,1(6) 	Load constant 
136:     LD  4,-11(1) 	Load left into ac1 
137:    ADD  3,4,3 	Op + 
138:     LD  4,-10(1) 	Load left into ac1 
139:    MUL  3,4,3 	Op * 
140:     ST  3,-10(1) 	Save left side 
141:    LDC  3,1(6) 	Load constant 
142:     ST  3,-11(1) 	Save left side 
143:    LDC  3,1(6) 	Load constant 
144:     LD  4,-11(1) 	Load left into ac1 
145:    ADD  3,4,3 	Op + 
146:     LD  4,-10(1) 	Load left into ac1 
147:    DIV  3,4,3 	Op / 
148:     ST  3,-5(1) 	Store variable tm
* EXPRESSION STMT
149:     LD  3,0(1) 	Load variable i
150:     ST  3,-10(1) 	Save left side 
151:     LD  3,-2(1) 	Load variable m
152:     ST  3,-11(1) 	Save left side 
153:    LDC  3,1(6) 	Load constant 
154:     LD  4,-11(1) 	Load left into ac1 
155:    ADD  3,4,3 	Op + 
156:     LD  4,-10(1) 	Load left into ac1 
157:    SUB  3,4,3 	Op - 
158:     ST  3,-10(1) 	Save left side 
159:    LDC  3,0(6) 	Load constant 
160:     LD  4,-10(1) 	Load left into ac1 
161:    ADD  3,4,3 	Op + 
162:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
163:     LD  3,-4(1) 	Load variable x
164:     ST  3,-10(1) 	Save left side 
165:     LD  3,-5(1) 	Load variable tm
166:     LD  4,-10(1) 	Load left into ac1 
167:    DIV  3,4,3 	Op / 
168:     ST  3,-10(1) 	Save left side 
169:    LDC  3,1(6) 	Load constant 
170:     LD  4,-10(1) 	Load left into ac1 
171:    MUL  3,4,3 	Op * 
172:     ST  3,-3(1) 	Store variable t
* END compound statement
173:    LDA  7,-95(7) 	go to beginning of loop 
 88:    LDA  7,85(7) 	No more loop 
* ENDWHILE
* IfK:
* IfK: t->child[0] condition
174:     LD  3,-6(1) 	Load variable num
175:     ST  3,-10(1) 	Save left side 
176:     LD  3,-7(1) 	Load variable min
177:     LD  4,-10(1) 	Load left into ac1 
* IfK: t->child[1] then part
* BEGIN compound statement
* EXPRESSION STMT
179:     ST  1,-10(1) 	Store old frame in ghost frame 
180:     LD  3,-6(1) 	Load variable num
181:     ST  3,-12(1) 	Store parameter 
182:    LDA  1,-10(1) 	Load address of new frame 
183:    LDA  3,1(7) 	Return address in ac 
184:    LDA  7,-179(7) 	CALL output
185:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
186:     ST  1,-10(1) 	Store old frame in ghost frame 
187:     LD  3,0(1) 	Load variable i
188:     ST  3,-12(1) 	Store parameter 
189:    LDA  1,-10(1) 	Load address of new frame 
190:    LDA  3,1(7) 	Return address in ac 
191:    LDA  7,-186(7) 	CALL output
192:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
193:     ST  1,-10(1) 	Store old frame in ghost frame 
194:    LDC  3,11111111(6) 	Load constant 
195:     ST  3,-12(1) 	Store parameter 
196:    LDA  1,-10(1) 	Load address of new frame 
197:    LDA  3,1(7) 	Return address in ac 
198:    LDA  7,-193(7) 	CALL output
199:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
200:     LD  3,-6(1) 	Load variable num
201:     ST  3,-10(1) 	Save left side 
202:    LDC  3,1(6) 	Load constant 
203:     LD  4,-10(1) 	Load left into ac1 
204:    ADD  3,4,3 	Op + 
205:     ST  3,-7(1) 	Store variable min
* END compound statement
178:    JEQ  3,28(7) 	if: jmp to else 
* IfK: t->child[2] else part
206:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
207:     LD  3,0(1) 	Load variable i
208:     ST  3,-10(1) 	Save left side 
209:    LDC  3,1(6) 	Load constant 
210:     LD  4,-10(1) 	Load left into ac1 
211:    ADD  3,4,3 	Op + 
212:     ST  3,0(1) 	Store variable i
* END compound statement
213:    LDA  7,-179(7) 	go to beginning of loop 
 44:    LDA  7,169(7) 	No more loop 
* ENDWHILE
* RETURN
214:    LDC  3,0(6) 	Load constant 
215:    LDA  2,0(3) 	Copy result to rt register 
216:     LD  3,-1(1) 	Load return address 
217:     LD  1,0(1) 	Adjust fp 
218:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
219:    LDC  2,0(6) 	Set return value to 0 
220:     LD  3,-1(1) 	Load return address 
221:     LD  1,0(1) 	Adjust fp 
222:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,222(7) 	Jump to init 
* BEGIN Init
223:     LD  0,0(0) 	Set the global pointer 
224:    LDA  1,0(0) 	set first frame at end of globals 
225:     ST  1,0(1) 	store old fp (point to self) 
226:    LDA  3,1(7) 	Return address in ac 
227:    LDA  7,-198(7) 	Jump to main 
228:   HALT  0,0,0 	DONE! 
* END Init
