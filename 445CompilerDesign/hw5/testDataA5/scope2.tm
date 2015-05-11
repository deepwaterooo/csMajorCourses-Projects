* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  scope2.c-
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
* BEGIN function ant
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,4(6) 	Load constant 
 32:     ST  3,-4(1) 	Store variable b
* EXPRESSION STMT
 33:    LDC  3,5(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 35:    LDC  3,6(6) 	Load constant 
 36:     ST  3,0(0) 	Store variable g
* BEGIN compound statement
* EXPRESSION STMT
 37:    LDC  3,6(6) 	Load constant 
 38:     ST  3,-3(1) 	Store variable a
* EXPRESSION STMT
 39:    LDC  3,7(6) 	Load constant 
 40:     ST  3,-6(1) 	Store variable b
* EXPRESSION STMT
 41:    LDC  3,8(6) 	Load constant 
 42:     ST  3,-5(1) 	Store variable c
* EXPRESSION STMT
 43:    LDC  3,9(6) 	Load constant 
 44:     ST  3,0(0) 	Store variable g
* EXPRESSION STMT
 45:    LDC  3,10(6) 	Load constant 
 46:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 47:     ST  1,-7(1) 	Store old fp in ghost frame 
 48:     LD  3,-3(1) 	Load variable a
 49:     ST  3,-9(1) 	Store parameter 
 50:    LDA  1,-7(1) 	Load address of new frame 
 51:    LDA  3,1(7) 	Return address in ac 
 52:    LDA  7,-47(7) 	CALL output
 53:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 54:     ST  1,-7(1) 	Store old fp in ghost frame 
 55:     LD  3,-6(1) 	Load variable b
 56:     ST  3,-9(1) 	Store parameter 
 57:    LDA  1,-7(1) 	Load address of new frame 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-54(7) 	CALL output
 60:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 61:     ST  1,-7(1) 	Store old fp in ghost frame 
 62:     LD  3,-5(1) 	Load variable c
 63:     ST  3,-9(1) 	Store parameter 
 64:    LDA  1,-7(1) 	Load address of new frame 
 65:    LDA  3,1(7) 	Return address in ac 
 66:    LDA  7,-61(7) 	CALL output
 67:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 68:     ST  1,-7(1) 	Store old fp in ghost frame 
 69:     LD  3,0(0) 	Load variable g
 70:     ST  3,-9(1) 	Store parameter 
 71:    LDA  1,-7(1) 	Load address of new frame 
 72:    LDA  3,1(7) 	Return address in ac 
 73:    LDA  7,-68(7) 	CALL output
 74:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 75:     ST  1,-7(1) 	Store old fp in ghost frame 
 76:     LD  3,-2(1) 	Load variable x
 77:     ST  3,-9(1) 	Store parameter 
 78:    LDA  1,-7(1) 	Load address of new frame 
 79:    LDA  3,1(7) 	Return address in ac 
 80:    LDA  7,-75(7) 	CALL output
 81:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 82:     ST  1,-7(1) 	Store old fp in ghost frame 
 83:    LDA  1,-7(1) 	Load address of new frame 
 84:    LDA  3,1(7) 	Return address in ac 
 85:    LDA  7,-61(7) 	CALL outnl
 86:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* EXPRESSION STMT
 87:     ST  1,-7(1) 	Store old fp in ghost frame 
 88:     LD  3,-3(1) 	Load variable a
 89:     ST  3,-9(1) 	Store parameter 
 90:    LDA  1,-7(1) 	Load address of new frame 
 91:    LDA  3,1(7) 	Return address in ac 
 92:    LDA  7,-87(7) 	CALL output
 93:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 94:     ST  1,-7(1) 	Store old fp in ghost frame 
 95:     LD  3,-4(1) 	Load variable b
 96:     ST  3,-9(1) 	Store parameter 
 97:    LDA  1,-7(1) 	Load address of new frame 
 98:    LDA  3,1(7) 	Return address in ac 
 99:    LDA  7,-94(7) 	CALL output
100:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
101:     ST  1,-7(1) 	Store old fp in ghost frame 
102:     LD  3,0(0) 	Load variable g
103:     ST  3,-9(1) 	Store parameter 
104:    LDA  1,-7(1) 	Load address of new frame 
105:    LDA  3,1(7) 	Return address in ac 
106:    LDA  7,-101(7) 	CALL output
107:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
108:     ST  1,-7(1) 	Store old fp in ghost frame 
109:     LD  3,-2(1) 	Load variable x
110:     ST  3,-9(1) 	Store parameter 
111:    LDA  1,-7(1) 	Load address of new frame 
112:    LDA  3,1(7) 	Return address in ac 
113:    LDA  7,-108(7) 	CALL output
114:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
115:     ST  1,-7(1) 	Store old fp in ghost frame 
116:    LDA  1,-7(1) 	Load address of new frame 
117:    LDA  3,1(7) 	Return address in ac 
118:    LDA  7,-94(7) 	CALL outnl
119:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
120:    LDC  3,11(6) 	Load constant 
121:     ST  3,-3(1) 	Store variable a
* EXPRESSION STMT
122:    LDC  3,12(6) 	Load constant 
123:     ST  3,-4(1) 	Store variable b
* EXPRESSION STMT
124:    LDC  3,14(6) 	Load constant 
125:     ST  3,-2(1) 	Store variable x
* BEGIN compound statement
* EXPRESSION STMT
126:    LDC  3,15(6) 	Load constant 
127:     ST  3,-2(1) 	Store variable x
* END compound statement
* EXPRESSION STMT
128:     ST  1,-7(1) 	Store old fp in ghost frame 
129:     LD  3,-3(1) 	Load variable a
130:     ST  3,-9(1) 	Store parameter 
131:    LDA  1,-7(1) 	Load address of new frame 
132:    LDA  3,1(7) 	Return address in ac 
133:    LDA  7,-128(7) 	CALL output
134:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
135:     ST  1,-7(1) 	Store old fp in ghost frame 
136:     LD  3,-4(1) 	Load variable b
137:     ST  3,-9(1) 	Store parameter 
138:    LDA  1,-7(1) 	Load address of new frame 
139:    LDA  3,1(7) 	Return address in ac 
140:    LDA  7,-135(7) 	CALL output
141:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
142:     ST  1,-7(1) 	Store old fp in ghost frame 
143:     LD  3,0(0) 	Load variable g
144:     ST  3,-9(1) 	Store parameter 
145:    LDA  1,-7(1) 	Load address of new frame 
146:    LDA  3,1(7) 	Return address in ac 
147:    LDA  7,-142(7) 	CALL output
148:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
149:     ST  1,-7(1) 	Store old fp in ghost frame 
150:     LD  3,-2(1) 	Load variable x
151:     ST  3,-9(1) 	Store parameter 
152:    LDA  1,-7(1) 	Load address of new frame 
153:    LDA  3,1(7) 	Return address in ac 
154:    LDA  7,-149(7) 	CALL output
155:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
156:     ST  1,-7(1) 	Store old fp in ghost frame 
157:    LDA  1,-7(1) 	Load address of new frame 
158:    LDA  3,1(7) 	Return address in ac 
159:    LDA  7,-135(7) 	CALL outnl
160:    LDA  3,0(2) 	Save the result in ac 
* RETURN
161:     LD  3,-3(1) 	Load variable a
162:     ST  3,-7(1) 	Save left side 
163:     LD  3,-4(1) 	Load variable b
164:     LD  4,-7(1) 	Load left into ac1 
165:    ADD  3,4,3 	Op + 
166:     ST  3,-7(1) 	Save left side 
167:     LD  3,0(0) 	Load variable g
168:     LD  4,-7(1) 	Load left into ac1 
169:    ADD  3,4,3 	Op + 
170:     ST  3,-7(1) 	Save left side 
171:     LD  3,-2(1) 	Load variable x
172:     LD  4,-7(1) 	Load left into ac1 
173:    ADD  3,4,3 	Op + 
174:    LDA  2,0(3) 	Copy result to rt register 
175:     LD  3,-1(1) 	Load return address 
176:     LD  1,0(1) 	Adjust fp 
177:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
178:    LDC  2,0(6) 	Set return value to 0 
179:     LD  3,-1(1) 	Load return address 
180:     LD  1,0(1) 	Adjust fp 
181:    LDA  7,0(3) 	Return 
* END of function ant
* BEGIN function main
182:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
183:    LDC  3,16(6) 	Load constant 
184:     ST  3,-2(1) 	Store variable a
* EXPRESSION STMT
185:    LDC  3,1(6) 	Load constant 
186:     ST  3,0(0) 	Store variable g
* EXPRESSION STMT
187:     ST  1,-3(1) 	Store old fp in ghost frame 
188:     ST  1,-5(1) 	Store old fp in ghost frame 
189:    LDC  3,2(6) 	Load constant 
190:     ST  3,-7(1) 	Store parameter 
191:    LDA  1,-5(1) 	Load address of new frame 
192:    LDA  3,1(7) 	Return address in ac 
193:    LDA  7,-164(7) 	CALL ant
194:    LDA  3,0(2) 	Save the result in ac 
195:     ST  3,-5(1) 	Store parameter 
196:    LDA  1,-3(1) 	Load address of new frame 
197:    LDA  3,1(7) 	Return address in ac 
198:    LDA  7,-193(7) 	CALL output
199:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
200:     ST  1,-3(1) 	Store old fp in ghost frame 
201:     LD  3,0(0) 	Load variable g
202:     ST  3,-5(1) 	Store parameter 
203:    LDA  1,-3(1) 	Load address of new frame 
204:    LDA  3,1(7) 	Return address in ac 
205:    LDA  7,-200(7) 	CALL output
206:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
207:     ST  1,-3(1) 	Store old fp in ghost frame 
208:     LD  3,-2(1) 	Load variable a
209:     ST  3,-5(1) 	Store parameter 
210:    LDA  1,-3(1) 	Load address of new frame 
211:    LDA  3,1(7) 	Return address in ac 
212:    LDA  7,-207(7) 	CALL output
213:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
214:     ST  1,-3(1) 	Store old fp in ghost frame 
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
* END of function main
  0:    LDA  7,222(7) 	Jump to init 
* BEGIN Init
223:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
224:    LDA  1,-1(0) 	set first frame at end of globals 
225:     ST  1,0(1) 	store old fp (point to self) 
226:    LDA  3,1(7) 	Return address in ac 
227:    LDA  7,-46(7) 	Jump to main 
228:   HALT  0,0,0 	DONE! 
* END Init
