* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  io.tm
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
 31:     ST  1,-3(1) 	Store old frame in ghost frame 
 32:    LDC  3,777(6) 	Load constant 
 33:     ST  3,-5(1) 	Store parameter 
 34:    LDA  1,-3(1) 	Load address of new frame 
 35:    LDA  3,1(7) 	Return address in ac 
 36:    LDA  7,-31(7) 	CALL output
 37:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 38:     ST  1,-3(1) 	Store old frame in ghost frame 
 39:    LDC  3,0(6) 	Load constant 
 40:     ST  3,-5(1) 	Store parameter 
 41:    LDA  1,-3(1) 	Load address of new frame 
 42:    LDA  3,1(7) 	Return address in ac 
 43:    LDA  7,-26(7) 	CALL outputb
 44:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 45:     ST  1,-3(1) 	Store old frame in ghost frame 
 46:    LDA  1,-3(1) 	Load address of new frame 
 47:    LDA  3,1(7) 	Return address in ac 
 48:    LDA  7,-24(7) 	CALL outnl
 49:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 50:    LDC  3,666(6) 	Load constant 
 51:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 52:     ST  1,-3(1) 	Store old frame in ghost frame 
 53:     LD  3,0(1) 	Load variable x
 54:     ST  3,-5(1) 	Store parameter 
 55:    LDA  1,-3(1) 	Load address of new frame 
 56:    LDA  3,1(7) 	Return address in ac 
 57:    LDA  7,-52(7) 	CALL output
 58:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 59:     ST  1,-3(1) 	Store old frame in ghost frame 
 60:    LDA  1,-3(1) 	Load address of new frame 
 61:    LDA  3,1(7) 	Return address in ac 
 62:    LDA  7,-38(7) 	CALL outnl
 63:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 64:     ST  1,-3(1) 	Store old frame in ghost frame 
 65:     LD  3,0(1) 	Load variable x
 66:    LDC  4,0(6) 	Load 0 
 67:    SUB  3,4,3 	Op unary - 
 68:     ST  3,-5(1) 	Store parameter 
 69:    LDA  1,-3(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-66(7) 	CALL output
 72:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 73:     ST  1,-3(1) 	Store old frame in ghost frame 
 74:    LDC  3,1(6) 	Load constant 
 75:    LDC  4,0(6) 	Load 0 
 76:    SUB  3,4,3 	Op unary - 
 77:     ST  3,-5(1) 	Save left side 
 78:     LD  3,0(1) 	Load variable x
 79:     LD  4,-5(1) 	Load left into ac1 
 80:    MUL  3,4,3 	Op * 
 81:     ST  3,-5(1) 	Store parameter 
 82:    LDA  1,-3(1) 	Load address of new frame 
 83:    LDA  3,1(7) 	Return address in ac 
 84:    LDA  7,-79(7) 	CALL output
 85:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 86:     ST  1,-3(1) 	Store old frame in ghost frame 
 87:    LDA  1,-3(1) 	Load address of new frame 
 88:    LDA  3,1(7) 	Return address in ac 
 89:    LDA  7,-65(7) 	CALL outnl
 90:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 91:     ST  1,-3(1) 	Store old frame in ghost frame 
 92:    LDC  3,111(6) 	Load constant 
 93:     ST  3,-5(1) 	Save left side 
 94:    LDC  3,222(6) 	Load constant 
 95:     LD  4,-5(1) 	Load left into ac1 
 96:    ADD  3,4,3 	Op + 
 97:     ST  3,-5(1) 	Save left side 
 98:    LDC  3,333(6) 	Load constant 
 99:     LD  4,-5(1) 	Load left into ac1 
100:    ADD  3,4,3 	Op + 
101:     ST  3,-5(1) 	Store parameter 
102:    LDA  1,-3(1) 	Load address of new frame 
103:    LDA  3,1(7) 	Return address in ac 
104:    LDA  7,-99(7) 	CALL output
105:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
106:     ST  1,-3(1) 	Store old frame in ghost frame 
107:    LDC  3,3(6) 	Load constant 
108:     ST  3,-5(1) 	Save left side 
109:    LDC  3,6(6) 	Load constant 
110:     LD  4,-5(1) 	Load left into ac1 
111:    MUL  3,4,3 	Op * 
112:     ST  3,-5(1) 	Save left side 
113:    LDC  3,6(6) 	Load constant 
114:     ST  3,-6(1) 	Save left side 
115:    LDC  3,6(6) 	Load constant 
116:     LD  4,-6(1) 	Load left into ac1 
117:    MUL  3,4,3 	Op * 
118:     ST  3,-6(1) 	Save left side 
119:    LDC  3,1(6) 	Load constant 
120:     LD  4,-6(1) 	Load left into ac1 
121:    ADD  3,4,3 	Op + 
122:     LD  4,-5(1) 	Load left into ac1 
123:    MUL  3,4,3 	Op * 
124:     ST  3,-5(1) 	Store parameter 
125:    LDA  1,-3(1) 	Load address of new frame 
126:    LDA  3,1(7) 	Return address in ac 
127:    LDA  7,-122(7) 	CALL output
128:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
129:     ST  1,-3(1) 	Store old frame in ghost frame 
130:    LDA  1,-3(1) 	Load address of new frame 
131:    LDA  3,1(7) 	Return address in ac 
132:    LDA  7,-108(7) 	CALL outnl
133:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
* EXPRESSION STMT
134:     ST  1,-3(1) 	Store old frame in ghost frame 
135:    LDA  1,-3(1) 	Load address of new frame 
136:    LDA  3,1(7) 	Return address in ac 
137:    LDA  7,-137(7) 	CALL input
138:    LDA  3,0(2) 	Save the result in ac 
139:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
140:     ST  1,-3(1) 	Store old frame in ghost frame 
141:     LD  3,0(1) 	Load variable x
142:     ST  3,-5(1) 	Store parameter 
143:    LDA  1,-3(1) 	Load address of new frame 
144:    LDA  3,1(7) 	Return address in ac 
145:    LDA  7,-140(7) 	CALL output
146:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
147:     ST  1,-3(1) 	Store old frame in ghost frame 
148:    LDA  1,-3(1) 	Load address of new frame 
149:    LDA  3,1(7) 	Return address in ac 
150:    LDA  7,-126(7) 	CALL outnl
151:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
* EXPRESSION STMT
152:     ST  1,-3(1) 	Store old frame in ghost frame 
153:    LDA  1,-3(1) 	Load address of new frame 
154:    LDA  3,1(7) 	Return address in ac 
155:    LDA  7,-143(7) 	CALL inputb
156:    LDA  3,0(2) 	Save the result in ac 
157:     ST  3,-2(1) 	Store variable b
* EXPRESSION STMT
158:     ST  1,-3(1) 	Store old frame in ghost frame 
159:     LD  3,-2(1) 	Load variable b
160:     ST  3,-5(1) 	Store parameter 
161:    LDA  1,-3(1) 	Load address of new frame 
162:    LDA  3,1(7) 	Return address in ac 
163:    LDA  7,-146(7) 	CALL outputb
164:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
165:     ST  1,-3(1) 	Store old frame in ghost frame 
166:    LDA  1,-3(1) 	Load address of new frame 
167:    LDA  3,1(7) 	Return address in ac 
168:    LDA  7,-144(7) 	CALL outnl
169:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
170:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
171:     ST  1,-5(1) 	Store old frame in ghost frame 
172:    LDA  1,-5(1) 	Load address of new frame 
173:    LDA  3,1(7) 	Return address in ac 
174:    LDA  7,-174(7) 	CALL input
175:    LDA  3,0(2) 	Save the result in ac 
176:     ST  3,-5(1) 	Save left side 
* EXPRESSION STMT
177:     ST  1,-6(1) 	Store old frame in ghost frame 
178:    LDA  1,-6(1) 	Load address of new frame 
179:    LDA  3,1(7) 	Return address in ac 
180:    LDA  7,-180(7) 	CALL input
181:    LDA  3,0(2) 	Save the result in ac 
182:     LD  4,-5(1) 	Load left into ac1 
183:    MUL  3,4,3 	Op * 
184:     ST  3,-5(1) 	Store parameter 
185:    LDA  1,-3(1) 	Load address of new frame 
186:    LDA  3,1(7) 	Return address in ac 
187:    LDA  7,-182(7) 	CALL output
188:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
189:     ST  1,-3(1) 	Store old frame in ghost frame 
190:    LDA  1,-3(1) 	Load address of new frame 
191:    LDA  3,1(7) 	Return address in ac 
192:    LDA  7,-168(7) 	CALL outnl
193:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
194:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
195:     ST  1,-5(1) 	Store old frame in ghost frame 
196:    LDA  1,-5(1) 	Load address of new frame 
197:    LDA  3,1(7) 	Return address in ac 
198:    LDA  7,-186(7) 	CALL inputb
199:    LDA  3,0(2) 	Save the result in ac 
200:     ST  3,-5(1) 	Save left side 
* EXPRESSION STMT
201:     ST  1,-6(1) 	Store old frame in ghost frame 
202:    LDA  1,-6(1) 	Load address of new frame 
203:    LDA  3,1(7) 	Return address in ac 
204:    LDA  7,-192(7) 	CALL inputb
205:    LDA  3,0(2) 	Save the result in ac 
206:     LD  4,-5(1) 	Load left into ac1 
207:    JEQ  3,1(7) 	Op AND 
208:    LDA  3,0(4) 	 
209:     ST  3,-5(1) 	Store parameter 
210:    LDA  1,-3(1) 	Load address of new frame 
211:    LDA  3,1(7) 	Return address in ac 
212:    LDA  7,-195(7) 	CALL outputb
213:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
214:     ST  1,-3(1) 	Store old frame in ghost frame 
215:    LDA  1,-3(1) 	Load address of new frame 
216:    LDA  3,1(7) 	Return address in ac 
217:    LDA  7,-193(7) 	CALL outnl
218:    LDA  3,0(2) 	Save the result in ac 
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
