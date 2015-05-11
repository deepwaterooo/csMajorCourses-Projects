* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  arraysize.c-
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
* BEGIN function ford
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 31:    LDC  3,13(6) 	load size of array y
 32:     ST  3,-4(1) 	save size of array y
* EXPRESSION STMT
 33:    LDC  3,0(6) 	Load constant 
 34:     ST  3,-18(1) 	Save index 
 35:    LDC  3,666(6) 	Load constant 
 36:     LD  4,-18(1) 	Restore index 
 37:    LDA  5,-5(1) 	Load address of base of array y
 38:    SUB  5,5,4 	Compute offset of value 
 39:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 40:    LDC  3,0(6) 	Load constant 
 41:     ST  3,-18(1) 	Save index 
 42:    LDC  3,888(6) 	Load constant 
 43:     LD  4,-18(1) 	Restore index 
 44:    LDA  5,-1(0) 	Load address of base of array g
 45:    SUB  5,5,4 	Compute offset of value 
 46:     ST  3,0(5) 	Store variable g
* EXPRESSION STMT
 47:     ST  1,-18(1) 	Store old fp in ghost frame 
 48:    LDC  3,0(6) 	Load constant 
 49:     LD  4,-2(1) 	Load address of base of array x
 50:    SUB  3,4,3 	Compute offset of value 
 51:     LD  3,0(3) 	Load the value 
 52:     ST  3,-20(1) 	Store parameter 
 53:    LDA  1,-18(1) 	Load address of new frame 
 54:    LDA  3,1(7) 	Return address in ac 
 55:    LDA  7,-50(7) 	CALL output
 56:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 57:     ST  1,-18(1) 	Store old fp in ghost frame 
 58:     LD  3,-2(1) 	Load address of base of array x
 59:     LD  3,1(3) 	Load array size 
 60:     ST  3,-20(1) 	Store parameter 
 61:    LDA  1,-18(1) 	Load address of new frame 
 62:    LDA  3,1(7) 	Return address in ac 
 63:    LDA  7,-58(7) 	CALL output
 64:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 65:     ST  1,-18(1) 	Store old fp in ghost frame 
 66:    LDC  3,0(6) 	Load constant 
 67:    LDA  4,-1(0) 	Load address of base of array g
 68:    SUB  3,4,3 	Compute offset of value 
 69:     LD  3,0(3) 	Load the value 
 70:     ST  3,-20(1) 	Store parameter 
 71:    LDA  1,-18(1) 	Load address of new frame 
 72:    LDA  3,1(7) 	Return address in ac 
 73:    LDA  7,-68(7) 	CALL output
 74:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 75:     ST  1,-18(1) 	Store old fp in ghost frame 
 76:    LDC  3,1(6) 	Load constant 
 77:    LDC  4,0(6) 	Load 0 
 78:    SUB  3,4,3 	Op unary - 
 79:    LDA  4,-1(0) 	Load address of base of array g
 80:    SUB  3,4,3 	Compute offset of value 
 81:     LD  3,0(3) 	Load the value 
 82:     ST  3,-20(1) 	Store parameter 
 83:    LDA  1,-18(1) 	Load address of new frame 
 84:    LDA  3,1(7) 	Return address in ac 
 85:    LDA  7,-80(7) 	CALL output
 86:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 87:     ST  1,-18(1) 	Store old fp in ghost frame 
 88:    LDA  1,-18(1) 	Load address of new frame 
 89:    LDA  3,1(7) 	Return address in ac 
 90:    LDA  7,-66(7) 	CALL outnl
 91:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 92:     ST  1,-18(1) 	Store old fp in ghost frame 
 93:    LDC  3,0(6) 	Load constant 
 94:    LDA  4,-5(1) 	Load address of base of array y
 95:    SUB  3,4,3 	Compute offset of value 
 96:     LD  3,0(3) 	Load the value 
 97:     ST  3,-20(1) 	Store parameter 
 98:    LDA  1,-18(1) 	Load address of new frame 
 99:    LDA  3,1(7) 	Return address in ac 
100:    LDA  7,-95(7) 	CALL output
101:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
102:     ST  1,-18(1) 	Store old fp in ghost frame 
103:    LDA  3,-5(1) 	Load address of base of array y
104:     LD  3,1(3) 	Load array size 
105:     ST  3,-20(1) 	Store parameter 
106:    LDA  1,-18(1) 	Load address of new frame 
107:    LDA  3,1(7) 	Return address in ac 
108:    LDA  7,-103(7) 	CALL output
109:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
110:     ST  1,-18(1) 	Store old fp in ghost frame 
111:    LDA  1,-18(1) 	Load address of new frame 
112:    LDA  3,1(7) 	Return address in ac 
113:    LDA  7,-89(7) 	CALL outnl
114:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
115:    LDC  2,0(6) 	Set return value to 0 
116:     LD  3,-1(1) 	Load return address 
117:     LD  1,0(1) 	Adjust fp 
118:    LDA  7,0(3) 	Return 
* END of function ford
* BEGIN function main
119:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
120:    LDC  3,11(6) 	load size of array m
121:     ST  3,-2(1) 	save size of array m
* EXPRESSION STMT
122:    LDC  3,0(6) 	Load constant 
123:     ST  3,-14(1) 	Save index 
124:    LDC  3,777(6) 	Load constant 
125:     LD  4,-14(1) 	Restore index 
126:    LDA  5,-3(1) 	Load address of base of array m
127:    SUB  5,5,4 	Compute offset of value 
128:     ST  3,0(5) 	Store variable m
* EXPRESSION STMT
129:     ST  1,-14(1) 	Store old fp in ghost frame 
130:    LDC  3,0(6) 	Load constant 
131:    LDA  4,-3(1) 	Load address of base of array m
132:    SUB  3,4,3 	Compute offset of value 
133:     LD  3,0(3) 	Load the value 
134:     ST  3,-16(1) 	Store parameter 
135:    LDA  1,-14(1) 	Load address of new frame 
136:    LDA  3,1(7) 	Return address in ac 
137:    LDA  7,-132(7) 	CALL output
138:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
139:     ST  1,-14(1) 	Store old fp in ghost frame 
140:    LDA  3,-3(1) 	Load address of base of array m
141:     LD  3,1(3) 	Load array size 
142:     ST  3,-16(1) 	Store parameter 
143:    LDA  1,-14(1) 	Load address of new frame 
144:    LDA  3,1(7) 	Return address in ac 
145:    LDA  7,-140(7) 	CALL output
146:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
147:     ST  1,-14(1) 	Store old fp in ghost frame 
148:    LDC  3,0(6) 	Load constant 
149:    LDA  4,-1(0) 	Load address of base of array g
150:    SUB  3,4,3 	Compute offset of value 
151:     LD  3,0(3) 	Load the value 
152:     ST  3,-16(1) 	Store parameter 
153:    LDA  1,-14(1) 	Load address of new frame 
154:    LDA  3,1(7) 	Return address in ac 
155:    LDA  7,-150(7) 	CALL output
156:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
157:     ST  1,-14(1) 	Store old fp in ghost frame 
158:    LDA  3,-1(0) 	Load address of base of array g
159:     LD  3,1(3) 	Load array size 
160:     ST  3,-16(1) 	Store parameter 
161:    LDA  1,-14(1) 	Load address of new frame 
162:    LDA  3,1(7) 	Return address in ac 
163:    LDA  7,-158(7) 	CALL output
164:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
165:     ST  1,-14(1) 	Store old fp in ghost frame 
166:    LDA  1,-14(1) 	Load address of new frame 
167:    LDA  3,1(7) 	Return address in ac 
168:    LDA  7,-144(7) 	CALL outnl
169:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
170:     ST  1,-14(1) 	Store old fp in ghost frame 
171:    LDA  3,-3(1) 	Load address of base of array m
172:     ST  3,-16(1) 	Store parameter 
173:    LDA  1,-14(1) 	Load address of new frame 
174:    LDA  3,1(7) 	Return address in ac 
175:    LDA  7,-146(7) 	CALL ford
176:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
177:     ST  1,-14(1) 	Store old fp in ghost frame 
178:    LDA  3,-1(0) 	Load address of base of array g
179:     ST  3,-16(1) 	Store parameter 
180:    LDA  1,-14(1) 	Load address of new frame 
181:    LDA  3,1(7) 	Return address in ac 
182:    LDA  7,-153(7) 	CALL ford
183:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
184:     ST  1,-14(1) 	Store old fp in ghost frame 
185:    LDA  3,-3(1) 	Load address of base of array m
186:     LD  3,1(3) 	Load array size 
187:     ST  3,-16(1) 	Save left side 
188:    LDA  3,-1(0) 	Load address of base of array g
189:     LD  3,1(3) 	Load array size 
190:     LD  4,-16(1) 	Load left into ac1 
191:    MUL  3,4,3 	Op * 
192:     ST  3,-16(1) 	Store parameter 
193:    LDA  1,-14(1) 	Load address of new frame 
194:    LDA  3,1(7) 	Return address in ac 
195:    LDA  7,-190(7) 	CALL output
196:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
197:     ST  1,-14(1) 	Store old fp in ghost frame 
198:    LDA  1,-14(1) 	Load address of new frame 
199:    LDA  3,1(7) 	Return address in ac 
200:    LDA  7,-176(7) 	CALL outnl
201:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
202:    LDC  2,0(6) 	Set return value to 0 
203:     LD  3,-1(1) 	Load return address 
204:     LD  1,0(1) 	Adjust fp 
205:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,205(7) 	Jump to init 
* BEGIN Init
206:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
207:    LDC  3,12(6) 	load size of array g
208:     ST  3,0(0) 	save size of array g
209:    LDC  3,23(6) 	load size of array h
210:     ST  3,-13(0) 	save size of array h
* END init of global array sizes
211:    LDA  1,-37(0) 	set first frame at end of globals 
212:     ST  1,0(1) 	store old fp (point to self) 
213:    LDA  3,1(7) 	Return address in ac 
214:    LDA  7,-96(7) 	Jump to main 
215:   HALT  0,0,0 	DONE! 
* END Init
