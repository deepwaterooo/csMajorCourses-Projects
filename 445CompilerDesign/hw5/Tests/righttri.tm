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
 32:     ST  3,0(1) 	Store variable a
* EXPRESSION STMT
 33:    LDC  3,1(6) 	Load constant 
 34:     ST  3,-3(1) 	Store variable aa
* EXPRESSION STMT
 35:    LDC  3,0(6) 	Load constant 
 36:     ST  3,-5(1) 	Store variable c
* WHILE
 37:     LD  3,-5(1) 	Load variable c
 38:     ST  3,-7(1) 	Save left side 
 39:    LDC  3,50(6) 	Load constant 
 40:     LD  4,-7(1) 	Load left into ac1 
 41:    SUB  4,4,3 	Op < 
 42:    LDC  3,1(6) 	True case 
 43:    JLT  4,1(7) 	Jump if true 
 44:    LDC  3,0(6) 	False case 
 45:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
* EXPRESSION STMT
 47:    LDC  3,1(6) 	Load constant 
 48:     ST  3,-6(1) 	Store variable cc
 49:     ST  3,-5(1) 	Store variable c
* EXPRESSION STMT
 50:    LDC  3,1(6) 	Load constant 
 51:     ST  3,-2(1) 	Store variable b
* EXPRESSION STMT
 52:    LDC  3,1(6) 	Load constant 
 53:     ST  3,-4(1) 	Store variable bb
* WHILE
 54:     LD  3,-2(1) 	Load variable b
 55:     ST  3,-7(1) 	Save left side 
 56:     LD  3,0(1) 	Load variable a
 57:     LD  4,-7(1) 	Load left into ac1 
 58:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IfK:
* IfK: t->child[0] condition
 60:     LD  3,-3(1) 	Load variable aa
 61:     ST  3,-7(1) 	Save left side 
 62:     LD  3,-4(1) 	Load variable bb
 63:     LD  4,-7(1) 	Load left into ac1 
 64:    ADD  3,4,3 	Op + 
 65:     ST  3,-7(1) 	Save left side 
 66:    LDC  3,2(6) 	Load constant 
 67:     LD  4,-7(1) 	Load left into ac1 
 68:    DIV  3,4,3 	Op / 
 69:     ST  3,-7(1) 	Save left side 
 70:    LDC  3,2(6) 	Load constant 
 71:     LD  4,-7(1) 	Load left into ac1 
 72:     ST  3,-7(1) 	Save left side 
 73:    LDC  3,0(6) 	Load constant 
 74:     LD  4,-7(1) 	Load left into ac1 
 75:    SUB  4,4,3 	Op == 
 76:    LDC  3,1(6) 	True case 
 77:    JEQ  4,1(7) 	Jump if true 
 78:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* BEGIN compound statement
* WHILE
 80:     LD  3,-6(1) 	Load variable cc
 81:     ST  3,-7(1) 	Save left side 
 82:     LD  3,-3(1) 	Load variable aa
 83:     ST  3,-8(1) 	Save left side 
 84:     LD  3,-4(1) 	Load variable bb
 85:     LD  4,-8(1) 	Load left into ac1 
 86:    ADD  3,4,3 	Op + 
 87:     LD  4,-7(1) 	Load left into ac1 
 88:    SUB  4,4,3 	Op < 
 89:    LDC  3,1(6) 	True case 
 90:    JLT  4,1(7) 	Jump if true 
 91:    LDC  3,0(6) 	False case 
 92:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 94:     LD  3,-5(1) 	Load variable c
 95:     ST  3,-7(1) 	Save left side 
 96:    LDC  3,1(6) 	Load constant 
 97:     LD  4,-7(1) 	Load left into ac1 
 98:    ADD  3,4,3 	Op + 
 99:     ST  3,-5(1) 	Store variable c
* EXPRESSION STMT
100:     LD  3,-6(1) 	Load variable cc
101:     ST  3,-7(1) 	Save left side 
102:    LDC  3,2(6) 	Load constant 
103:     ST  3,-8(1) 	Save left side 
104:     LD  3,-5(1) 	Load variable c
105:     LD  4,-8(1) 	Load left into ac1 
106:    MUL  3,4,3 	Op * 
107:     LD  4,-7(1) 	Load left into ac1 
108:    ADD  3,4,3 	Op + 
109:     ST  3,-7(1) 	Save left side 
110:    LDC  3,1(6) 	Load constant 
111:     LD  4,-7(1) 	Load left into ac1 
112:    SUB  3,4,3 	Op - 
113:     ST  3,-6(1) 	Store variable cc
* END compound statement
114:    LDA  7,-35(7) 	go to beginning of loop 
 93:    LDA  7,21(7) 	No more loop 
* ENDWHILE
* IfK:
* IfK: t->child[0] condition
115:     LD  3,-3(1) 	Load variable aa
116:     ST  3,-7(1) 	Save left side 
117:     LD  3,-4(1) 	Load variable bb
118:     LD  4,-7(1) 	Load left into ac1 
119:    ADD  3,4,3 	Op + 
120:     ST  3,-7(1) 	Save left side 
121:     LD  3,-6(1) 	Load variable cc
122:     LD  4,-7(1) 	Load left into ac1 
123:    SUB  4,4,3 	Op == 
124:    LDC  3,1(6) 	True case 
125:    JEQ  4,1(7) 	Jump if true 
126:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* BEGIN compound statement
* EXPRESSION STMT
128:     ST  1,-7(1) 	Store old frame in ghost frame 
129:     LD  3,0(1) 	Load variable a
130:     ST  3,-9(1) 	Store parameter 
131:    LDA  1,-7(1) 	Load address of new frame 
132:    LDA  3,1(7) 	Return address in ac 
133:    LDA  7,-128(7) 	CALL output
134:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
135:     ST  1,-7(1) 	Store old frame in ghost frame 
136:     LD  3,-2(1) 	Load variable b
137:     ST  3,-9(1) 	Store parameter 
138:    LDA  1,-7(1) 	Load address of new frame 
139:    LDA  3,1(7) 	Return address in ac 
140:    LDA  7,-135(7) 	CALL output
141:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
142:     ST  1,-7(1) 	Store old frame in ghost frame 
143:     LD  3,-5(1) 	Load variable c
144:     ST  3,-9(1) 	Store parameter 
145:    LDA  1,-7(1) 	Load address of new frame 
146:    LDA  3,1(7) 	Return address in ac 
147:    LDA  7,-142(7) 	CALL output
148:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
149:     ST  1,-7(1) 	Store old frame in ghost frame 
150:    LDA  1,-7(1) 	Load address of new frame 
151:    LDA  3,1(7) 	Return address in ac 
152:    LDA  7,-128(7) 	CALL outnl
153:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
127:    JEQ  3,27(7) 	if: jmp to else 
* IfK: t->child[2] else part
154:    LDA  7,0(7) 	jmp to end 
* ENDIF
* END compound statement
 79:    JEQ  3,76(7) 	if: jmp to else 
* IfK: t->child[2] else part
155:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
156:     LD  3,-2(1) 	Load variable b
157:     ST  3,-7(1) 	Save left side 
158:    LDC  3,1(6) 	Load constant 
159:     LD  4,-7(1) 	Load left into ac1 
160:    ADD  3,4,3 	Op + 
161:     ST  3,-2(1) 	Store variable b
* EXPRESSION STMT
162:     LD  3,-4(1) 	Load variable bb
163:     ST  3,-7(1) 	Save left side 
164:    LDC  3,2(6) 	Load constant 
165:     ST  3,-8(1) 	Save left side 
166:     LD  3,-2(1) 	Load variable b
167:     LD  4,-8(1) 	Load left into ac1 
168:    MUL  3,4,3 	Op * 
169:     LD  4,-7(1) 	Load left into ac1 
170:    ADD  3,4,3 	Op + 
171:     ST  3,-7(1) 	Save left side 
172:    LDC  3,1(6) 	Load constant 
173:     LD  4,-7(1) 	Load left into ac1 
174:    SUB  3,4,3 	Op - 
175:     ST  3,-4(1) 	Store variable bb
* END compound statement
176:    LDA  7,-123(7) 	go to beginning of loop 
 59:    LDA  7,117(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
177:     LD  3,0(1) 	Load variable a
178:     ST  3,-7(1) 	Save left side 
179:    LDC  3,1(6) 	Load constant 
180:     LD  4,-7(1) 	Load left into ac1 
181:    ADD  3,4,3 	Op + 
182:     ST  3,0(1) 	Store variable a
* EXPRESSION STMT
183:     LD  3,-3(1) 	Load variable aa
184:     ST  3,-7(1) 	Save left side 
185:    LDC  3,2(6) 	Load constant 
186:     ST  3,-8(1) 	Save left side 
187:     LD  3,0(1) 	Load variable a
188:     LD  4,-8(1) 	Load left into ac1 
189:    MUL  3,4,3 	Op * 
190:     LD  4,-7(1) 	Load left into ac1 
191:    ADD  3,4,3 	Op + 
192:     ST  3,-7(1) 	Save left side 
193:    LDC  3,1(6) 	Load constant 
194:     LD  4,-7(1) 	Load left into ac1 
195:    SUB  3,4,3 	Op - 
196:     ST  3,-3(1) 	Store variable aa
* END compound statement
197:    LDA  7,-161(7) 	go to beginning of loop 
 46:    LDA  7,151(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
198:    LDC  2,0(6) 	Set return value to 0 
199:     LD  3,-1(1) 	Load return address 
200:     LD  1,0(1) 	Adjust fp 
201:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,201(7) 	Jump to init 
* BEGIN Init
202:     LD  0,0(0) 	Set the global pointer 
203:    LDA  1,0(0) 	set first frame at end of globals 
204:     ST  1,0(1) 	store old fp (point to self) 
205:    LDA  3,1(7) 	Return address in ac 
206:    LDA  7,-177(7) 	Jump to main 
207:   HALT  0,0,0 	DONE! 
* END Init
