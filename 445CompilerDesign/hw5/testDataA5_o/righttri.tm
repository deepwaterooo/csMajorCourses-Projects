* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  righttri.tm
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
 32:     ST  3,-2(1) 	Store variable a
* EXPRESSION STMT
 33:    LDC  3,1(6) 	Load constant 
 34:     ST  3,-4(1) 	Store variable aa
* EXPRESSION STMT
 35:    LDC  3,0(6) 	Load constant 
 36:     ST  3,-6(1) 	Store variable c
* WHILE
 37:     LD  3,-6(1) 	Load variable c
 38:     ST  3,-8(1) 	Save left side 
 39:    LDC  3,50(6) 	Load constant 
 40:     LD  4,-8(1) 	Load left into ac1 
 41:    SUB  3,4,3 	Op < 
 42:    JLT  3,2(7) 	br if true 
 43:    LDC  3,0(3) 	false case 
 44:    LDA  7,1(7) 	unconditional jmp 
 45:    LDC  3,1(3) 	true case 
 46:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
* EXPRESSION STMT
 48:    LDC  3,1(6) 	Load constant 
 49:     ST  3,-7(1) 	Store variable cc
 50:     ST  3,-6(1) 	Store variable c
* EXPRESSION STMT
 51:    LDC  3,1(6) 	Load constant 
 52:     ST  3,-3(1) 	Store variable b
* EXPRESSION STMT
 53:    LDC  3,1(6) 	Load constant 
 54:     ST  3,-5(1) 	Store variable bb
* WHILE
 55:     LD  3,-3(1) 	Load variable b
 56:     ST  3,-8(1) 	Save left side 
 57:     LD  3,-2(1) 	Load variable a
 58:     LD  4,-8(1) 	Load left into ac1 
 59:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
 61:     LD  3,-4(1) 	Load variable aa
 62:     ST  3,-8(1) 	Save left side 
 63:     LD  3,-5(1) 	Load variable bb
 64:     LD  4,-8(1) 	Load left into ac1 
 65:    ADD  3,4,3 	Op + 
 66:     ST  3,-8(1) 	Save left side 
 67:    LDC  3,2(6) 	Load constant 
 68:     LD  4,-8(1) 	Load left into ac1 
 69:    DIV  3,4,3 	Op / 
 70:     ST  3,-8(1) 	Save left side 
 71:    LDC  3,2(6) 	Load constant 
 72:     LD  4,-8(1) 	Load left into ac1 
 73:     ST  3,-8(1) 	Save left side 
 74:    LDC  3,0(6) 	Load constant 
 75:     LD  4,-8(1) 	Load left into ac1 
 76:    SUB  3,4,3 	Op == 
 77:    JEQ  3,2(7) 	br if true 
 78:    LDC  3,0(3) 	false case 
 79:    LDA  7,1(7) 	unconditional jmp 
 80:    LDC  3,1(3) 	true case 
* BEGIN compound statement
* WHILE
 82:     LD  3,-7(1) 	Load variable cc
 83:     ST  3,-8(1) 	Save left side 
 84:     LD  3,-4(1) 	Load variable aa
 85:     ST  3,-9(1) 	Save left side 
 86:     LD  3,-5(1) 	Load variable bb
 87:     LD  4,-9(1) 	Load left into ac1 
 88:    ADD  3,4,3 	Op + 
 89:     LD  4,-8(1) 	Load left into ac1 
 90:    SUB  3,4,3 	Op < 
 91:    JLT  3,2(7) 	br if true 
 92:    LDC  3,0(3) 	false case 
 93:    LDA  7,1(7) 	unconditional jmp 
 94:    LDC  3,1(3) 	true case 
 95:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 97:     LD  3,-6(1) 	Load variable c
 98:     ST  3,-8(1) 	Save left side 
 99:    LDC  3,1(6) 	Load constant 
100:     LD  4,-8(1) 	Load left into ac1 
101:    ADD  3,4,3 	Op + 
102:     ST  3,-6(1) 	Store variable c
* EXPRESSION STMT
103:     LD  3,-7(1) 	Load variable cc
104:     ST  3,-8(1) 	Save left side 
105:    LDC  3,2(6) 	Load constant 
106:     ST  3,-9(1) 	Save left side 
107:     LD  3,-6(1) 	Load variable c
108:     LD  4,-9(1) 	Load left into ac1 
109:    MUL  3,4,3 	Op * 
110:     LD  4,-8(1) 	Load left into ac1 
111:    ADD  3,4,3 	Op + 
112:     ST  3,-8(1) 	Save left side 
113:    LDC  3,1(6) 	Load constant 
114:     LD  4,-8(1) 	Load left into ac1 
115:    SUB  3,4,3 	Op - 
116:     ST  3,-7(1) 	Store variable cc
* END compound statement
117:    LDA  7,-22(7) 	go to beginning of loop 
 96:    LDA  7,21(7) 	No more loop 
* end WHILE
118:     LD  3,-4(1) 	Load variable aa
119:     ST  3,-8(1) 	Save left side 
120:     LD  3,-5(1) 	Load variable bb
121:     LD  4,-8(1) 	Load left into ac1 
122:    ADD  3,4,3 	Op + 
123:     ST  3,-8(1) 	Save left side 
124:     LD  3,-7(1) 	Load variable cc
125:     LD  4,-8(1) 	Load left into ac1 
126:    SUB  3,4,3 	Op == 
127:    JEQ  3,2(7) 	br if true 
128:    LDC  3,0(3) 	false case 
129:    LDA  7,1(7) 	unconditional jmp 
130:    LDC  3,1(3) 	true case 
* BEGIN compound statement
* EXPRESSION STMT
132:     ST  1,-8(1) 	Store old frame in ghost frame 
133:     LD  3,-2(1) 	Load variable a
134:     ST  3,-10(1) 	Store parameter 
135:    LDA  1,-8(1) 	Load address of new frame 
136:    LDA  3,1(7) 	Return address in ac 
137:    LDA  7,-132(7) 	CALL output
138:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
139:     ST  1,-8(1) 	Store old frame in ghost frame 
140:     LD  3,-3(1) 	Load variable b
141:     ST  3,-10(1) 	Store parameter 
142:    LDA  1,-8(1) 	Load address of new frame 
143:    LDA  3,1(7) 	Return address in ac 
144:    LDA  7,-139(7) 	CALL output
145:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
146:     ST  1,-8(1) 	Store old frame in ghost frame 
147:     LD  3,-6(1) 	Load variable c
148:     ST  3,-10(1) 	Store parameter 
149:    LDA  1,-8(1) 	Load address of new frame 
150:    LDA  3,1(7) 	Return address in ac 
151:    LDA  7,-146(7) 	CALL output
152:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
153:     ST  1,-8(1) 	Store old frame in ghost frame 
154:    LDA  1,-8(1) 	Load address of new frame 
155:    LDA  3,1(7) 	Return address in ac 
156:    LDA  7,-132(7) 	CALL outnl
157:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
131:    JEQ  3,27(7) 	if: jmp to else 
158:    LDA  7,0(7) 	jmp to end 
* END compound statement
 81:    JEQ  3,78(7) 	if: jmp to else 
159:    LDA  7,0(7) 	jmp to end 
* EXPRESSION STMT
160:     LD  3,-3(1) 	Load variable b
161:     ST  3,-8(1) 	Save left side 
162:    LDC  3,1(6) 	Load constant 
163:     LD  4,-8(1) 	Load left into ac1 
164:    ADD  3,4,3 	Op + 
165:     ST  3,-3(1) 	Store variable b
* EXPRESSION STMT
166:     LD  3,-5(1) 	Load variable bb
167:     ST  3,-8(1) 	Save left side 
168:    LDC  3,2(6) 	Load constant 
169:     ST  3,-9(1) 	Save left side 
170:     LD  3,-3(1) 	Load variable b
171:     LD  4,-9(1) 	Load left into ac1 
172:    MUL  3,4,3 	Op * 
173:     LD  4,-8(1) 	Load left into ac1 
174:    ADD  3,4,3 	Op + 
175:     ST  3,-8(1) 	Save left side 
176:    LDC  3,1(6) 	Load constant 
177:     LD  4,-8(1) 	Load left into ac1 
178:    SUB  3,4,3 	Op - 
179:     ST  3,-5(1) 	Store variable bb
* END compound statement
180:    LDA  7,-121(7) 	go to beginning of loop 
 60:    LDA  7,120(7) 	No more loop 
* end WHILE
* EXPRESSION STMT
181:     LD  3,-2(1) 	Load variable a
182:     ST  3,-8(1) 	Save left side 
183:    LDC  3,1(6) 	Load constant 
184:     LD  4,-8(1) 	Load left into ac1 
185:    ADD  3,4,3 	Op + 
186:     ST  3,-2(1) 	Store variable a
* EXPRESSION STMT
187:     LD  3,-4(1) 	Load variable aa
188:     ST  3,-8(1) 	Save left side 
189:    LDC  3,2(6) 	Load constant 
190:     ST  3,-9(1) 	Save left side 
191:     LD  3,-2(1) 	Load variable a
192:     LD  4,-9(1) 	Load left into ac1 
193:    MUL  3,4,3 	Op * 
194:     LD  4,-8(1) 	Load left into ac1 
195:    ADD  3,4,3 	Op + 
196:     ST  3,-8(1) 	Save left side 
197:    LDC  3,1(6) 	Load constant 
198:     LD  4,-8(1) 	Load left into ac1 
199:    SUB  3,4,3 	Op - 
200:     ST  3,-4(1) 	Store variable aa
* END compound statement
201:    LDA  7,-155(7) 	go to beginning of loop 
 47:    LDA  7,154(7) 	No more loop 
* end WHILE
* END compound statement
* Add standard closing in case there is no return statement
202:    LDC  2,0(6) 	Set return value to 0 
203:     LD  3,-1(1) 	Load return address 
204:     LD  1,0(1) 	Adjust fp 
205:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,205(7) 	Jump to init 
* BEGIN Init
206:     LD  0,0(0) 	Set the global pointer 
207:    LDA  1,0(0) 	set first frame at end of globals 
208:     ST  1,0(1) 	store old fp (point to self) 
209:    LDA  3,1(7) 	Return address in ac 
210:    LDA  7,-181(7) 	Jump to main 
211:   HALT  0,0,0 	DONE! 
* END Init
