* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  e01.tm
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
* EXPRESSION STMT
 33:     ST  1,-2(1) 	Store old frame in ghost frame 
 34:    LDC  3,13(6) 	Load constant 
 35:     ST  3,-4(1) 	Store parameter 
 36:    LDA  1,-2(1) 	Load address of new frame 
 37:    LDA  3,1(7) 	Return address in ac 
 38:    LDA  7,-33(7) 	CALL output
 39:    LDA  3,0(2) 	Save the result in ac 
 32:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
 40:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
 41:     ST  1,-2(1) 	Store old frame in ghost frame 
 42:    LDC  3,23(6) 	Load constant 
 43:     ST  3,-4(1) 	Store parameter 
 44:    LDA  1,-2(1) 	Load address of new frame 
 45:    LDA  3,1(7) 	Return address in ac 
 46:    LDA  7,-41(7) 	CALL output
 47:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 48:    LDC  3,0(6) 	Load constant 
 49:     ST  3,0(1) 	Store variable x
* IfK:
* IfK: t->child[0] condition
 50:     LD  3,0(1) 	Load variable x
* IfK: t->child[1] then part
* EXPRESSION STMT
 52:     ST  1,-2(1) 	Store old frame in ghost frame 
 53:    LDC  3,44(6) 	Load constant 
 54:     ST  3,-4(1) 	Store parameter 
 55:    LDA  1,-2(1) 	Load address of new frame 
 56:    LDA  3,1(7) 	Return address in ac 
 57:    LDA  7,-52(7) 	CALL output
 58:    LDA  3,0(2) 	Save the result in ac 
 51:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
 59:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 60:     LD  3,0(1) 	Load variable x
* IfK: t->child[1] then part
* EXPRESSION STMT
 62:     ST  1,-2(1) 	Store old frame in ghost frame 
 63:    LDC  3,55(6) 	Load constant 
 64:     ST  3,-4(1) 	Store parameter 
 65:    LDA  1,-2(1) 	Load address of new frame 
 66:    LDA  3,1(7) 	Return address in ac 
 67:    LDA  7,-62(7) 	CALL output
 68:    LDA  3,0(2) 	Save the result in ac 
 61:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
 69:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 70:    LDC  3,3(6) 	Load constant 
 71:     ST  3,-2(1) 	Save left side 
 72:    LDC  3,1(6) 	Load constant 
 73:     LD  4,-2(1) 	Load left into ac1 
 74:    SUB  4,4,3 	Op > 
 75:    LDC  3,1(6) 	True case 
 76:    JLT  4,1(7) 	Jump if true 
 77:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
 79:     ST  1,-2(1) 	Store old frame in ghost frame 
 80:    LDC  3,987(6) 	Load constant 
 81:     ST  3,-4(1) 	Store parameter 
 82:    LDA  1,-2(1) 	Load address of new frame 
 83:    LDA  3,1(7) 	Return address in ac 
 84:    LDA  7,-79(7) 	CALL output
 85:    LDA  3,0(2) 	Save the result in ac 
 78:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
 86:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 87:    LDC  3,3(6) 	Load constant 
 88:     ST  3,-2(1) 	Save left side 
 89:    LDC  3,1(6) 	Load constant 
 90:     LD  4,-2(1) 	Load left into ac1 
 91:    SUB  4,4,3 	Op < 
 92:    LDC  3,1(6) 	True case 
 93:    JLT  4,1(7) 	Jump if true 
 94:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
 96:     ST  1,-2(1) 	Store old frame in ghost frame 
 97:    LDC  3,211(6) 	Load constant 
 98:     ST  3,-4(1) 	Store parameter 
 99:    LDA  1,-2(1) 	Load address of new frame 
100:    LDA  3,1(7) 	Return address in ac 
101:    LDA  7,-96(7) 	CALL output
102:    LDA  3,0(2) 	Save the result in ac 
 95:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
103:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
104:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* EXPRESSION STMT
106:     ST  1,-2(1) 	Store old frame in ghost frame 
107:    LDC  3,13(6) 	Load constant 
108:     ST  3,-4(1) 	Store parameter 
109:    LDA  1,-2(1) 	Load address of new frame 
110:    LDA  3,1(7) 	Return address in ac 
111:    LDA  7,-106(7) 	CALL output
112:    LDA  3,0(2) 	Save the result in ac 
105:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
114:     ST  1,-2(1) 	Store old frame in ghost frame 
115:    LDC  3,51(6) 	Load constant 
116:     ST  3,-4(1) 	Store parameter 
117:    LDA  1,-2(1) 	Load address of new frame 
118:    LDA  3,1(7) 	Return address in ac 
119:    LDA  7,-114(7) 	CALL output
120:    LDA  3,0(2) 	Save the result in ac 
113:    LDA  7,7(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
121:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* EXPRESSION STMT
123:     ST  1,-2(1) 	Store old frame in ghost frame 
124:    LDC  3,23(6) 	Load constant 
125:     ST  3,-4(1) 	Store parameter 
126:    LDA  1,-2(1) 	Load address of new frame 
127:    LDA  3,1(7) 	Return address in ac 
128:    LDA  7,-123(7) 	CALL output
129:    LDA  3,0(2) 	Save the result in ac 
122:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
131:     ST  1,-2(1) 	Store old frame in ghost frame 
132:    LDC  3,451(6) 	Load constant 
133:     ST  3,-4(1) 	Store parameter 
134:    LDA  1,-2(1) 	Load address of new frame 
135:    LDA  3,1(7) 	Return address in ac 
136:    LDA  7,-131(7) 	CALL output
137:    LDA  3,0(2) 	Save the result in ac 
130:    LDA  7,7(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
138:    LDC  3,0(6) 	Load constant 
139:     ST  3,0(1) 	Store variable x
* IfK:
* IfK: t->child[0] condition
140:     LD  3,0(1) 	Load variable x
* IfK: t->child[1] then part
* EXPRESSION STMT
142:     ST  1,-2(1) 	Store old frame in ghost frame 
143:    LDC  3,44(6) 	Load constant 
144:     ST  3,-4(1) 	Store parameter 
145:    LDA  1,-2(1) 	Load address of new frame 
146:    LDA  3,1(7) 	Return address in ac 
147:    LDA  7,-142(7) 	CALL output
148:    LDA  3,0(2) 	Save the result in ac 
141:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
150:     ST  1,-2(1) 	Store old frame in ghost frame 
151:    LDC  3,514(6) 	Load constant 
152:     ST  3,-4(1) 	Store parameter 
153:    LDA  1,-2(1) 	Load address of new frame 
154:    LDA  3,1(7) 	Return address in ac 
155:    LDA  7,-150(7) 	CALL output
156:    LDA  3,0(2) 	Save the result in ac 
149:    LDA  7,7(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
157:     LD  3,0(1) 	Load variable x
* IfK: t->child[1] then part
* EXPRESSION STMT
159:     ST  1,-2(1) 	Store old frame in ghost frame 
160:    LDC  3,55(6) 	Load constant 
161:     ST  3,-4(1) 	Store parameter 
162:    LDA  1,-2(1) 	Load address of new frame 
163:    LDA  3,1(7) 	Return address in ac 
164:    LDA  7,-159(7) 	CALL output
165:    LDA  3,0(2) 	Save the result in ac 
158:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
167:     ST  1,-2(1) 	Store old frame in ghost frame 
168:    LDC  3,1514(6) 	Load constant 
169:     ST  3,-4(1) 	Store parameter 
170:    LDA  1,-2(1) 	Load address of new frame 
171:    LDA  3,1(7) 	Return address in ac 
172:    LDA  7,-167(7) 	CALL output
173:    LDA  3,0(2) 	Save the result in ac 
166:    LDA  7,7(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
174:    LDC  3,3(6) 	Load constant 
175:     ST  3,-2(1) 	Save left side 
176:    LDC  3,1(6) 	Load constant 
177:     LD  4,-2(1) 	Load left into ac1 
178:    SUB  4,4,3 	Op > 
179:    LDC  3,1(6) 	True case 
180:    JLT  4,1(7) 	Jump if true 
181:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
183:     ST  1,-2(1) 	Store old frame in ghost frame 
184:    LDC  3,987(6) 	Load constant 
185:     ST  3,-4(1) 	Store parameter 
186:    LDA  1,-2(1) 	Load address of new frame 
187:    LDA  3,1(7) 	Return address in ac 
188:    LDA  7,-183(7) 	CALL output
189:    LDA  3,0(2) 	Save the result in ac 
182:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
191:     ST  1,-2(1) 	Store old frame in ghost frame 
192:    LDC  3,114(6) 	Load constant 
193:     ST  3,-4(1) 	Store parameter 
194:    LDA  1,-2(1) 	Load address of new frame 
195:    LDA  3,1(7) 	Return address in ac 
196:    LDA  7,-191(7) 	CALL output
197:    LDA  3,0(2) 	Save the result in ac 
190:    LDA  7,7(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
198:    LDC  3,3(6) 	Load constant 
199:     ST  3,-2(1) 	Save left side 
200:    LDC  3,1(6) 	Load constant 
201:     LD  4,-2(1) 	Load left into ac1 
202:    SUB  4,4,3 	Op < 
203:    LDC  3,1(6) 	True case 
204:    JLT  4,1(7) 	Jump if true 
205:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
207:     ST  1,-2(1) 	Store old frame in ghost frame 
208:    LDC  3,211(6) 	Load constant 
209:     ST  3,-4(1) 	Store parameter 
210:    LDA  1,-2(1) 	Load address of new frame 
211:    LDA  3,1(7) 	Return address in ac 
212:    LDA  7,-207(7) 	CALL output
213:    LDA  3,0(2) 	Save the result in ac 
206:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
215:     ST  1,-2(1) 	Store old frame in ghost frame 
216:    LDC  3,1614(6) 	Load constant 
217:     ST  3,-4(1) 	Store parameter 
218:    LDA  1,-2(1) 	Load address of new frame 
219:    LDA  3,1(7) 	Return address in ac 
220:    LDA  7,-215(7) 	CALL output
221:    LDA  3,0(2) 	Save the result in ac 
214:    LDA  7,7(7) 	jmp to end 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
222:    LDC  2,0(6) 	Set return value to 0 
223:     LD  3,-1(1) 	Load return address 
224:     LD  1,0(1) 	Adjust fp 
225:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,225(7) 	Jump to init 
* BEGIN Init
226:     LD  0,0(0) 	Set the global pointer 
227:    LDA  1,0(0) 	set first frame at end of globals 
228:     ST  1,0(1) 	store old fp (point to self) 
229:    LDA  3,1(7) 	Return address in ac 
230:    LDA  7,-201(7) 	Jump to main 
231:   HALT  0,0,0 	DONE! 
* END Init
