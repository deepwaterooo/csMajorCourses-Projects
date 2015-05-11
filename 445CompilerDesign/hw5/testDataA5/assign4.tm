* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  assign4.c-
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
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,111(6) 	Load constant 
 32:     LD  4,-2(1) 	load lhs variable x
 33:    ADD  3,4,3 	op += 
 34:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 35:     ST  1,-4(1) 	Store old fp in ghost frame 
 36:     LD  3,-2(1) 	Load variable x
 37:     ST  3,-6(1) 	Store parameter 
 38:    LDA  1,-4(1) 	Load address of new frame 
 39:    LDA  3,1(7) 	Return address in ac 
 40:    LDA  7,-35(7) 	CALL output
 41:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 42:    LDC  3,222(6) 	Load constant 
 43:     LD  4,-3(1) 	load lhs variable y
 44:    ADD  3,4,3 	op += 
 45:     ST  3,-3(1) 	Store variable y
* EXPRESSION STMT
 46:     ST  1,-4(1) 	Store old fp in ghost frame 
 47:     LD  3,-3(1) 	Load variable y
 48:     ST  3,-6(1) 	Store parameter 
 49:    LDA  1,-4(1) 	Load address of new frame 
 50:    LDA  3,1(7) 	Return address in ac 
 51:    LDA  7,-46(7) 	CALL output
 52:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 53:     ST  1,-4(1) 	Store old fp in ghost frame 
 54:    LDA  1,-4(1) 	Load address of new frame 
 55:    LDA  3,1(7) 	Return address in ac 
 56:    LDA  7,-32(7) 	CALL outnl
 57:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 58:    LDC  3,333(6) 	Load constant 
 59:     LD  4,0(0) 	load lhs variable gx
 60:    ADD  3,4,3 	op += 
 61:     ST  3,0(0) 	Store variable gx
* EXPRESSION STMT
 62:     ST  1,-4(1) 	Store old fp in ghost frame 
 63:     LD  3,0(0) 	Load variable gx
 64:     ST  3,-6(1) 	Store parameter 
 65:    LDA  1,-4(1) 	Load address of new frame 
 66:    LDA  3,1(7) 	Return address in ac 
 67:    LDA  7,-62(7) 	CALL output
 68:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 69:    LDC  3,444(6) 	Load constant 
 70:     LD  4,-1(0) 	load lhs variable gy
 71:    ADD  3,4,3 	op += 
 72:     ST  3,-1(0) 	Store variable gy
* EXPRESSION STMT
 73:     ST  1,-4(1) 	Store old fp in ghost frame 
 74:     LD  3,-1(0) 	Load variable gy
 75:     ST  3,-6(1) 	Store parameter 
 76:    LDA  1,-4(1) 	Load address of new frame 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-73(7) 	CALL output
 79:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 80:     ST  1,-4(1) 	Store old fp in ghost frame 
 81:    LDA  1,-4(1) 	Load address of new frame 
 82:    LDA  3,1(7) 	Return address in ac 
 83:    LDA  7,-59(7) 	CALL outnl
 84:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 85:     LD  3,-3(1) 	Load variable y
 86:     LD  4,-2(1) 	load lhs variable x
 87:    ADD  3,4,3 	op += 
 88:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 89:     ST  1,-4(1) 	Store old fp in ghost frame 
 90:     LD  3,-2(1) 	Load variable x
 91:     ST  3,-6(1) 	Store parameter 
 92:    LDA  1,-4(1) 	Load address of new frame 
 93:    LDA  3,1(7) 	Return address in ac 
 94:    LDA  7,-89(7) 	CALL output
 95:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 96:     ST  1,-4(1) 	Store old fp in ghost frame 
 97:    LDA  1,-4(1) 	Load address of new frame 
 98:    LDA  3,1(7) 	Return address in ac 
 99:    LDA  7,-75(7) 	CALL outnl
100:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
101:     LD  3,-1(0) 	Load variable gy
102:     LD  4,0(0) 	load lhs variable gx
103:    ADD  3,4,3 	op += 
104:     ST  3,0(0) 	Store variable gx
* EXPRESSION STMT
105:     ST  1,-4(1) 	Store old fp in ghost frame 
106:     LD  3,0(0) 	Load variable gx
107:     ST  3,-6(1) 	Store parameter 
108:    LDA  1,-4(1) 	Load address of new frame 
109:    LDA  3,1(7) 	Return address in ac 
110:    LDA  7,-105(7) 	CALL output
111:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
112:     ST  1,-4(1) 	Store old fp in ghost frame 
113:    LDA  1,-4(1) 	Load address of new frame 
114:    LDA  3,1(7) 	Return address in ac 
115:    LDA  7,-91(7) 	CALL outnl
116:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
117:    LDC  3,111(6) 	Load constant 
118:     LD  4,-2(1) 	load lhs variable x
119:    SUB  3,4,3 	op -= 
120:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
121:     ST  1,-4(1) 	Store old fp in ghost frame 
122:     LD  3,-2(1) 	Load variable x
123:     ST  3,-6(1) 	Store parameter 
124:    LDA  1,-4(1) 	Load address of new frame 
125:    LDA  3,1(7) 	Return address in ac 
126:    LDA  7,-121(7) 	CALL output
127:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
128:    LDC  3,222(6) 	Load constant 
129:     LD  4,-3(1) 	load lhs variable y
130:    SUB  3,4,3 	op -= 
131:     ST  3,-3(1) 	Store variable y
* EXPRESSION STMT
132:     ST  1,-4(1) 	Store old fp in ghost frame 
133:     LD  3,-3(1) 	Load variable y
134:     ST  3,-6(1) 	Store parameter 
135:    LDA  1,-4(1) 	Load address of new frame 
136:    LDA  3,1(7) 	Return address in ac 
137:    LDA  7,-132(7) 	CALL output
138:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
139:     ST  1,-4(1) 	Store old fp in ghost frame 
140:    LDA  1,-4(1) 	Load address of new frame 
141:    LDA  3,1(7) 	Return address in ac 
142:    LDA  7,-118(7) 	CALL outnl
143:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
144:    LDC  3,333(6) 	Load constant 
145:     LD  4,0(0) 	load lhs variable gx
146:    SUB  3,4,3 	op -= 
147:     ST  3,0(0) 	Store variable gx
* EXPRESSION STMT
148:     ST  1,-4(1) 	Store old fp in ghost frame 
149:     LD  3,0(0) 	Load variable gx
150:     ST  3,-6(1) 	Store parameter 
151:    LDA  1,-4(1) 	Load address of new frame 
152:    LDA  3,1(7) 	Return address in ac 
153:    LDA  7,-148(7) 	CALL output
154:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
155:    LDC  3,444(6) 	Load constant 
156:     LD  4,-1(0) 	load lhs variable gy
157:    SUB  3,4,3 	op -= 
158:     ST  3,-1(0) 	Store variable gy
* EXPRESSION STMT
159:     ST  1,-4(1) 	Store old fp in ghost frame 
160:     LD  3,-1(0) 	Load variable gy
161:     ST  3,-6(1) 	Store parameter 
162:    LDA  1,-4(1) 	Load address of new frame 
163:    LDA  3,1(7) 	Return address in ac 
164:    LDA  7,-159(7) 	CALL output
165:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
166:     ST  1,-4(1) 	Store old fp in ghost frame 
167:    LDA  1,-4(1) 	Load address of new frame 
168:    LDA  3,1(7) 	Return address in ac 
169:    LDA  7,-145(7) 	CALL outnl
170:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
171:     LD  3,-3(1) 	Load variable y
172:     LD  4,-2(1) 	load lhs variable x
173:    SUB  3,4,3 	op -= 
174:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
175:     ST  1,-4(1) 	Store old fp in ghost frame 
176:     LD  3,-2(1) 	Load variable x
177:     ST  3,-6(1) 	Store parameter 
178:    LDA  1,-4(1) 	Load address of new frame 
179:    LDA  3,1(7) 	Return address in ac 
180:    LDA  7,-175(7) 	CALL output
181:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
182:     ST  1,-4(1) 	Store old fp in ghost frame 
183:    LDA  1,-4(1) 	Load address of new frame 
184:    LDA  3,1(7) 	Return address in ac 
185:    LDA  7,-161(7) 	CALL outnl
186:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
187:     LD  3,-1(0) 	Load variable gy
188:     LD  4,0(0) 	load lhs variable gx
189:    SUB  3,4,3 	op -= 
190:     ST  3,0(0) 	Store variable gx
* EXPRESSION STMT
191:     ST  1,-4(1) 	Store old fp in ghost frame 
192:     LD  3,0(0) 	Load variable gx
193:     ST  3,-6(1) 	Store parameter 
194:    LDA  1,-4(1) 	Load address of new frame 
195:    LDA  3,1(7) 	Return address in ac 
196:    LDA  7,-191(7) 	CALL output
197:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
198:     ST  1,-4(1) 	Store old fp in ghost frame 
199:    LDA  1,-4(1) 	Load address of new frame 
200:    LDA  3,1(7) 	Return address in ac 
201:    LDA  7,-177(7) 	CALL outnl
202:    LDA  3,0(2) 	Save the result in ac 
* RETURN
203:    LDA  2,0(3) 	Copy result to rt register 
204:     LD  3,-1(1) 	Load return address 
205:     LD  1,0(1) 	Adjust fp 
206:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
207:    LDC  2,0(6) 	Set return value to 0 
208:     LD  3,-1(1) 	Load return address 
209:     LD  1,0(1) 	Adjust fp 
210:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,210(7) 	Jump to init 
* BEGIN Init
211:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
212:    LDA  1,-2(0) 	set first frame at end of globals 
213:     ST  1,0(1) 	store old fp (point to self) 
214:    LDA  3,1(7) 	Return address in ac 
215:    LDA  7,-186(7) 	Jump to main 
216:   HALT  0,0,0 	DONE! 
* END Init
