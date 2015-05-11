* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  sort.c-
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
* BEGIN function minloc
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:     LD  3,-3(1) 	Load variable low
 32:     ST  3,-7(1) 	Store variable k
* EXPRESSION STMT
 33:     LD  3,-3(1) 	Load variable low
 34:     LD  4,-2(1) 	Load address of base of array a
 35:    SUB  3,4,3 	Compute offset of value 
 36:     LD  3,0(3) 	Load the value 
 37:     ST  3,-6(1) 	Store variable x
* EXPRESSION STMT
 38:     LD  3,-3(1) 	Load variable low
 39:     ST  3,-8(1) 	Save left side 
 40:    LDC  3,1(6) 	Load constant 
 41:     LD  4,-8(1) 	Load left into ac1 
 42:    ADD  3,4,3 	Op + 
 43:     ST  3,-5(1) 	Store variable i
* WHILE
 44:     LD  3,-5(1) 	Load variable i
 45:     ST  3,-8(1) 	Save left side 
 46:     LD  3,-4(1) 	Load variable high
 47:     LD  4,-8(1) 	Load left into ac1 
 48:    SUB  4,4,3 	Op < 
 49:    LDC  3,1(6) 	True case 
 50:    JLT  4,1(7) 	Jump if true 
 51:    LDC  3,0(6) 	False case 
 52:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
 54:     LD  3,-5(1) 	Load variable i
 55:     LD  4,-2(1) 	Load address of base of array a
 56:    SUB  3,4,3 	Compute offset of value 
 57:     LD  3,0(3) 	Load the value 
 58:     ST  3,-8(1) 	Save left side 
 59:     LD  3,-6(1) 	Load variable x
 60:     LD  4,-8(1) 	Load left into ac1 
 61:    SUB  4,4,3 	Op < 
 62:    LDC  3,1(6) 	True case 
 63:    JLT  4,1(7) 	Jump if true 
 64:    LDC  3,0(6) 	False case 
 65:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
 67:     LD  3,-5(1) 	Load variable i
 68:     LD  4,-2(1) 	Load address of base of array a
 69:    SUB  3,4,3 	Compute offset of value 
 70:     LD  3,0(3) 	Load the value 
 71:     ST  3,-6(1) 	Store variable x
* EXPRESSION STMT
 72:     LD  3,-5(1) 	Load variable i
 73:     ST  3,-7(1) 	Store variable k
* END compound statement
 66:    LDA  7,7(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
 74:     LD  3,-5(1) 	load lhs variable i
 75:    LDA  3,1(3) 	increment value of i
 76:     ST  3,-5(1) 	Store variable i
* END compound statement
 77:    LDA  7,-34(7) 	go to beginning of loop 
 53:    LDA  7,24(7) 	No more loop 
* ENDWHILE
* RETURN
 78:     LD  3,-7(1) 	Load variable k
 79:    LDA  2,0(3) 	Copy result to rt register 
 80:     LD  3,-1(1) 	Load return address 
 81:     LD  1,0(1) 	Adjust fp 
 82:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 83:    LDC  2,0(6) 	Set return value to 0 
 84:     LD  3,-1(1) 	Load return address 
 85:     LD  1,0(1) 	Adjust fp 
 86:    LDA  7,0(3) 	Return 
* END of function minloc
* BEGIN function sort
 87:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 88:     LD  3,-3(1) 	Load variable low
 89:     ST  3,-5(1) 	Store variable i
* WHILE
 90:     LD  3,-5(1) 	Load variable i
 91:     ST  3,-8(1) 	Save left side 
 92:     LD  3,-4(1) 	Load variable high
 93:     ST  3,-9(1) 	Save left side 
 94:    LDC  3,1(6) 	Load constant 
 95:     LD  4,-9(1) 	Load left into ac1 
 96:    SUB  3,4,3 	Op - 
 97:     LD  4,-8(1) 	Load left into ac1 
 98:    SUB  4,4,3 	Op < 
 99:    LDC  3,1(6) 	True case 
100:    JLT  4,1(7) 	Jump if true 
101:    LDC  3,0(6) 	False case 
102:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
104:     ST  1,-8(1) 	Store old fp in ghost frame 
105:     LD  3,-2(1) 	Load address of base of array a
106:     ST  3,-10(1) 	Store parameter 
107:     LD  3,-5(1) 	Load variable i
108:     ST  3,-11(1) 	Store parameter 
109:     LD  3,-4(1) 	Load variable high
110:     ST  3,-12(1) 	Store parameter 
111:    LDA  1,-8(1) 	Load address of new frame 
112:    LDA  3,1(7) 	Return address in ac 
113:    LDA  7,-84(7) 	CALL minloc
114:    LDA  3,0(2) 	Save the result in ac 
115:     ST  3,-6(1) 	Store variable k
* EXPRESSION STMT
116:     LD  3,-6(1) 	Load variable k
117:     LD  4,-2(1) 	Load address of base of array a
118:    SUB  3,4,3 	Compute offset of value 
119:     LD  3,0(3) 	Load the value 
120:     ST  3,-7(1) 	Store variable t
* EXPRESSION STMT
121:     LD  3,-6(1) 	Load variable k
122:     ST  3,-8(1) 	Save index 
123:     LD  3,-5(1) 	Load variable i
124:     LD  4,-2(1) 	Load address of base of array a
125:    SUB  3,4,3 	Compute offset of value 
126:     LD  3,0(3) 	Load the value 
127:     LD  4,-8(1) 	Restore index 
128:     LD  5,-2(1) 	Load address of base of array a
129:    SUB  5,5,4 	Compute offset of value 
130:     ST  3,0(5) 	Store variable a
* EXPRESSION STMT
131:     LD  3,-5(1) 	Load variable i
132:     ST  3,-8(1) 	Save index 
133:     LD  3,-7(1) 	Load variable t
134:     LD  4,-8(1) 	Restore index 
135:     LD  5,-2(1) 	Load address of base of array a
136:    SUB  5,5,4 	Compute offset of value 
137:     ST  3,0(5) 	Store variable a
* EXPRESSION STMT
138:     LD  3,-5(1) 	load lhs variable i
139:    LDA  3,1(3) 	increment value of i
140:     ST  3,-5(1) 	Store variable i
* END compound statement
141:    LDA  7,-52(7) 	go to beginning of loop 
103:    LDA  7,38(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
142:    LDC  2,0(6) 	Set return value to 0 
143:     LD  3,-1(1) 	Load return address 
144:     LD  1,0(1) 	Adjust fp 
145:    LDA  7,0(3) 	Return 
* END of function sort
* BEGIN function main
146:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
147:    LDC  3,0(6) 	Load constant 
148:     ST  3,-2(1) 	Store variable i
* WHILE
149:     LD  3,-2(1) 	Load variable i
150:     ST  3,-3(1) 	Save left side 
151:    LDC  3,10(6) 	Load constant 
152:     LD  4,-3(1) 	Load left into ac1 
153:    SUB  4,4,3 	Op < 
154:    LDC  3,1(6) 	True case 
155:    JLT  4,1(7) 	Jump if true 
156:    LDC  3,0(6) 	False case 
157:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
159:     LD  3,-2(1) 	Load variable i
160:     ST  3,-3(1) 	Save index 
161:     ST  1,-4(1) 	Store old fp in ghost frame 
162:    LDA  1,-4(1) 	Load address of new frame 
163:    LDA  3,1(7) 	Return address in ac 
164:    LDA  7,-164(7) 	CALL input
165:    LDA  3,0(2) 	Save the result in ac 
166:     LD  4,-3(1) 	Restore index 
167:    LDA  5,-1(0) 	Load address of base of array x
168:    SUB  5,5,4 	Compute offset of value 
169:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
170:     LD  3,-2(1) 	load lhs variable i
171:    LDA  3,1(3) 	increment value of i
172:     ST  3,-2(1) 	Store variable i
* END compound statement
173:    LDA  7,-25(7) 	go to beginning of loop 
158:    LDA  7,15(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
174:     ST  1,-3(1) 	Store old fp in ghost frame 
175:    LDA  3,-1(0) 	Load address of base of array x
176:     ST  3,-5(1) 	Store parameter 
177:    LDC  3,0(6) 	Load constant 
178:     ST  3,-6(1) 	Store parameter 
179:    LDC  3,10(6) 	Load constant 
180:     ST  3,-7(1) 	Store parameter 
181:    LDA  1,-3(1) 	Load address of new frame 
182:    LDA  3,1(7) 	Return address in ac 
183:    LDA  7,-97(7) 	CALL sort
184:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
185:    LDC  3,0(6) 	Load constant 
186:     ST  3,-2(1) 	Store variable i
* WHILE
187:     LD  3,-2(1) 	Load variable i
188:     ST  3,-3(1) 	Save left side 
189:    LDC  3,10(6) 	Load constant 
190:     LD  4,-3(1) 	Load left into ac1 
191:    SUB  4,4,3 	Op < 
192:    LDC  3,1(6) 	True case 
193:    JLT  4,1(7) 	Jump if true 
194:    LDC  3,0(6) 	False case 
195:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
197:     ST  1,-3(1) 	Store old fp in ghost frame 
198:     LD  3,-2(1) 	Load variable i
199:    LDA  4,-1(0) 	Load address of base of array x
200:    SUB  3,4,3 	Compute offset of value 
201:     LD  3,0(3) 	Load the value 
202:     ST  3,-5(1) 	Store parameter 
203:    LDA  1,-3(1) 	Load address of new frame 
204:    LDA  3,1(7) 	Return address in ac 
205:    LDA  7,-200(7) 	CALL output
206:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
207:     LD  3,-2(1) 	load lhs variable i
208:    LDA  3,1(3) 	increment value of i
209:     ST  3,-2(1) 	Store variable i
* END compound statement
210:    LDA  7,-24(7) 	go to beginning of loop 
196:    LDA  7,14(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
211:    LDC  2,0(6) 	Set return value to 0 
212:     LD  3,-1(1) 	Load return address 
213:     LD  1,0(1) 	Adjust fp 
214:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,214(7) 	Jump to init 
* BEGIN Init
215:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
216:    LDC  3,10(6) 	load size of array x
217:     ST  3,0(0) 	save size of array x
* END init of global array sizes
218:    LDA  1,-11(0) 	set first frame at end of globals 
219:     ST  1,0(1) 	store old fp (point to self) 
220:    LDA  3,1(7) 	Return address in ac 
221:    LDA  7,-76(7) 	Jump to main 
222:   HALT  0,0,0 	DONE! 
* END Init
