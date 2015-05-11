* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  righttri.c-
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
 41:    SUB  4,4,3 	Op < 
 42:    LDC  3,1(6) 	True case 
 43:    JLT  4,1(7) 	Jump if true 
 44:    LDC  3,0(6) 	False case 
 45:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 47:    LDC  3,1(6) 	Load constant 
 48:     ST  3,-7(1) 	Store variable cc
 49:     ST  3,-6(1) 	Store variable c
* EXPRESSION STMT
 50:    LDC  3,1(6) 	Load constant 
 51:     ST  3,-3(1) 	Store variable b
* EXPRESSION STMT
 52:    LDC  3,1(6) 	Load constant 
 53:     ST  3,-5(1) 	Store variable bb
* WHILE
 54:     LD  3,-3(1) 	Load variable b
 55:     ST  3,-8(1) 	Save left side 
 56:     LD  3,-2(1) 	Load variable a
 57:     LD  4,-8(1) 	Load left into ac1 
 58:    SUB  4,4,3 	Op <= 
 59:    LDC  3,1(6) 	True case 
 60:    JLE  4,1(7) 	Jump if true 
 61:    LDC  3,0(6) 	False case 
 62:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
 64:     LD  3,-4(1) 	Load variable aa
 65:     ST  3,-8(1) 	Save left side 
 66:     LD  3,-5(1) 	Load variable bb
 67:     LD  4,-8(1) 	Load left into ac1 
 68:    ADD  3,4,3 	Op + 
 69:     ST  3,-8(1) 	Save left side 
 70:    LDC  3,2(6) 	Load constant 
 71:     LD  4,-8(1) 	Load left into ac1 
 72:    DIV  3,4,3 	Op / 
 73:     ST  3,-8(1) 	Save left side 
 74:    LDC  3,2(6) 	Load constant 
 75:     LD  4,-8(1) 	Load left into ac1 
 76:    DIV  5,4,3 	Op % 
 77:    MUL  5,5,3 	 
 78:    SUB  3,4,5 	 
 79:     ST  3,-8(1) 	Save left side 
 80:    LDC  3,0(6) 	Load constant 
 81:     LD  4,-8(1) 	Load left into ac1 
 82:    SUB  4,4,3 	Op == 
 83:    LDC  3,1(6) 	True case 
 84:    JEQ  4,1(7) 	Jump if true 
 85:    LDC  3,0(6) 	False case 
 86:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* WHILE
 88:     LD  3,-7(1) 	Load variable cc
 89:     ST  3,-8(1) 	Save left side 
 90:     LD  3,-4(1) 	Load variable aa
 91:     ST  3,-9(1) 	Save left side 
 92:     LD  3,-5(1) 	Load variable bb
 93:     LD  4,-9(1) 	Load left into ac1 
 94:    ADD  3,4,3 	Op + 
 95:     LD  4,-8(1) 	Load left into ac1 
 96:    SUB  4,4,3 	Op < 
 97:    LDC  3,1(6) 	True case 
 98:    JLT  4,1(7) 	Jump if true 
 99:    LDC  3,0(6) 	False case 
100:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
102:     LD  3,-6(1) 	Load variable c
103:     ST  3,-8(1) 	Save left side 
104:    LDC  3,1(6) 	Load constant 
105:     LD  4,-8(1) 	Load left into ac1 
106:    ADD  3,4,3 	Op + 
107:     ST  3,-6(1) 	Store variable c
* EXPRESSION STMT
108:     LD  3,-7(1) 	Load variable cc
109:     ST  3,-8(1) 	Save left side 
110:    LDC  3,2(6) 	Load constant 
111:     ST  3,-9(1) 	Save left side 
112:     LD  3,-6(1) 	Load variable c
113:     LD  4,-9(1) 	Load left into ac1 
114:    MUL  3,4,3 	Op * 
115:     LD  4,-8(1) 	Load left into ac1 
116:    ADD  3,4,3 	Op + 
117:     ST  3,-8(1) 	Save left side 
118:    LDC  3,1(6) 	Load constant 
119:     LD  4,-8(1) 	Load left into ac1 
120:    SUB  3,4,3 	Op - 
121:     ST  3,-7(1) 	Store variable cc
* END compound statement
122:    LDA  7,-35(7) 	go to beginning of loop 
101:    LDA  7,21(7) 	No more loop 
* ENDWHILE
* IF
123:     LD  3,-4(1) 	Load variable aa
124:     ST  3,-8(1) 	Save left side 
125:     LD  3,-5(1) 	Load variable bb
126:     LD  4,-8(1) 	Load left into ac1 
127:    ADD  3,4,3 	Op + 
128:     ST  3,-8(1) 	Save left side 
129:     LD  3,-7(1) 	Load variable cc
130:     LD  4,-8(1) 	Load left into ac1 
131:    SUB  4,4,3 	Op == 
132:    LDC  3,1(6) 	True case 
133:    JEQ  4,1(7) 	Jump if true 
134:    LDC  3,0(6) 	False case 
135:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
137:     ST  1,-8(1) 	Store old fp in ghost frame 
138:     LD  3,-2(1) 	Load variable a
139:     ST  3,-10(1) 	Store parameter 
140:    LDA  1,-8(1) 	Load address of new frame 
141:    LDA  3,1(7) 	Return address in ac 
142:    LDA  7,-137(7) 	CALL output
143:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
144:     ST  1,-8(1) 	Store old fp in ghost frame 
145:     LD  3,-3(1) 	Load variable b
146:     ST  3,-10(1) 	Store parameter 
147:    LDA  1,-8(1) 	Load address of new frame 
148:    LDA  3,1(7) 	Return address in ac 
149:    LDA  7,-144(7) 	CALL output
150:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
151:     ST  1,-8(1) 	Store old fp in ghost frame 
152:     LD  3,-6(1) 	Load variable c
153:     ST  3,-10(1) 	Store parameter 
154:    LDA  1,-8(1) 	Load address of new frame 
155:    LDA  3,1(7) 	Return address in ac 
156:    LDA  7,-151(7) 	CALL output
157:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
158:     ST  1,-8(1) 	Store old fp in ghost frame 
159:    LDA  1,-8(1) 	Load address of new frame 
160:    LDA  3,1(7) 	Return address in ac 
161:    LDA  7,-137(7) 	CALL outnl
162:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
136:    LDA  7,26(7) 	Jump around the THEN 
* ENDIF
* END compound statement
 87:    LDA  7,75(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
163:     LD  3,-3(1) 	Load variable b
164:     ST  3,-8(1) 	Save left side 
165:    LDC  3,1(6) 	Load constant 
166:     LD  4,-8(1) 	Load left into ac1 
167:    ADD  3,4,3 	Op + 
168:     ST  3,-3(1) 	Store variable b
* EXPRESSION STMT
169:     LD  3,-5(1) 	Load variable bb
170:     ST  3,-8(1) 	Save left side 
171:    LDC  3,2(6) 	Load constant 
172:     ST  3,-9(1) 	Save left side 
173:     LD  3,-3(1) 	Load variable b
174:     LD  4,-9(1) 	Load left into ac1 
175:    MUL  3,4,3 	Op * 
176:     LD  4,-8(1) 	Load left into ac1 
177:    ADD  3,4,3 	Op + 
178:     ST  3,-8(1) 	Save left side 
179:    LDC  3,1(6) 	Load constant 
180:     LD  4,-8(1) 	Load left into ac1 
181:    SUB  3,4,3 	Op - 
182:     ST  3,-5(1) 	Store variable bb
* END compound statement
183:    LDA  7,-130(7) 	go to beginning of loop 
 63:    LDA  7,120(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
184:     LD  3,-2(1) 	Load variable a
185:     ST  3,-8(1) 	Save left side 
186:    LDC  3,1(6) 	Load constant 
187:     LD  4,-8(1) 	Load left into ac1 
188:    ADD  3,4,3 	Op + 
189:     ST  3,-2(1) 	Store variable a
* EXPRESSION STMT
190:     LD  3,-4(1) 	Load variable aa
191:     ST  3,-8(1) 	Save left side 
192:    LDC  3,2(6) 	Load constant 
193:     ST  3,-9(1) 	Save left side 
194:     LD  3,-2(1) 	Load variable a
195:     LD  4,-9(1) 	Load left into ac1 
196:    MUL  3,4,3 	Op * 
197:     LD  4,-8(1) 	Load left into ac1 
198:    ADD  3,4,3 	Op + 
199:     ST  3,-8(1) 	Save left side 
200:    LDC  3,1(6) 	Load constant 
201:     LD  4,-8(1) 	Load left into ac1 
202:    SUB  3,4,3 	Op - 
203:     ST  3,-4(1) 	Store variable aa
* END compound statement
204:    LDA  7,-168(7) 	go to beginning of loop 
 46:    LDA  7,158(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
205:    LDC  2,0(6) 	Set return value to 0 
206:     LD  3,-1(1) 	Load return address 
207:     LD  1,0(1) 	Adjust fp 
208:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,208(7) 	Jump to init 
* BEGIN Init
209:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
210:    LDA  1,0(0) 	set first frame at end of globals 
211:     ST  1,0(1) 	store old fp (point to self) 
212:    LDA  3,1(7) 	Return address in ac 
213:    LDA  7,-184(7) 	Jump to main 
214:   HALT  0,0,0 	DONE! 
* END Init
