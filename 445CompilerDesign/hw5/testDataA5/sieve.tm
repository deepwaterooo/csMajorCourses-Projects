* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  sieve.c-
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
 31:    LDC  3,201(6) 	load size of array n
 32:     ST  3,-4(1) 	save size of array n
* EXPRESSION STMT
 33:    LDC  3,200(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable max
* EXPRESSION STMT
 35:    LDC  3,2(6) 	Load constant 
 36:     ST  3,-3(1) 	Store variable k
* WHILE
 37:     LD  3,-3(1) 	Load variable k
 38:     ST  3,-207(1) 	Save left side 
 39:     LD  3,-2(1) 	Load variable max
 40:     LD  4,-207(1) 	Load left into ac1 
 41:    SUB  4,4,3 	Op <= 
 42:    LDC  3,1(6) 	True case 
 43:    JLE  4,1(7) 	Jump if true 
 44:    LDC  3,0(6) 	False case 
 45:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 47:     LD  3,-3(1) 	Load variable k
 48:     ST  3,-207(1) 	Save index 
 49:    LDC  3,1(6) 	Load constant 
 50:     LD  4,-207(1) 	Restore index 
 51:    LDA  5,-5(1) 	Load address of base of array n
 52:    SUB  5,5,4 	Compute offset of value 
 53:     ST  3,0(5) 	Store variable n
* EXPRESSION STMT
 54:     LD  3,-3(1) 	Load variable k
 55:     ST  3,-207(1) 	Save left side 
 56:    LDC  3,1(6) 	Load constant 
 57:     LD  4,-207(1) 	Load left into ac1 
 58:    ADD  3,4,3 	Op + 
 59:     ST  3,-3(1) 	Store variable k
* END compound statement
 60:    LDA  7,-24(7) 	go to beginning of loop 
 46:    LDA  7,14(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 61:    LDC  3,2(6) 	Load constant 
 62:     ST  3,-3(1) 	Store variable k
* WHILE
 63:     LD  3,-3(1) 	Load variable k
 64:     ST  3,-207(1) 	Save left side 
 65:     LD  3,-3(1) 	Load variable k
 66:     LD  4,-207(1) 	Load left into ac1 
 67:    MUL  3,4,3 	Op * 
 68:     ST  3,-207(1) 	Save left side 
 69:     LD  3,-2(1) 	Load variable max
 70:     LD  4,-207(1) 	Load left into ac1 
 71:    SUB  4,4,3 	Op <= 
 72:    LDC  3,1(6) 	True case 
 73:    JLE  4,1(7) 	Jump if true 
 74:    LDC  3,0(6) 	False case 
 75:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 77:     LD  3,-3(1) 	Load variable k
 78:     ST  3,-207(1) 	Save left side 
 79:     LD  3,-3(1) 	Load variable k
 80:     LD  4,-207(1) 	Load left into ac1 
 81:    MUL  3,4,3 	Op * 
 82:     ST  3,-206(1) 	Store variable j
* WHILE
 83:     LD  3,-206(1) 	Load variable j
 84:     ST  3,-207(1) 	Save left side 
 85:     LD  3,-2(1) 	Load variable max
 86:     LD  4,-207(1) 	Load left into ac1 
 87:    SUB  4,4,3 	Op <= 
 88:    LDC  3,1(6) 	True case 
 89:    JLE  4,1(7) 	Jump if true 
 90:    LDC  3,0(6) 	False case 
 91:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 93:     LD  3,-206(1) 	Load variable j
 94:     ST  3,-207(1) 	Save index 
 95:    LDC  3,0(6) 	Load constant 
 96:     LD  4,-207(1) 	Restore index 
 97:    LDA  5,-5(1) 	Load address of base of array n
 98:    SUB  5,5,4 	Compute offset of value 
 99:     ST  3,0(5) 	Store variable n
* EXPRESSION STMT
100:     LD  3,-206(1) 	Load variable j
101:     ST  3,-207(1) 	Save left side 
102:     LD  3,-3(1) 	Load variable k
103:     LD  4,-207(1) 	Load left into ac1 
104:    ADD  3,4,3 	Op + 
105:     ST  3,-206(1) 	Store variable j
* END compound statement
106:    LDA  7,-24(7) 	go to beginning of loop 
 92:    LDA  7,14(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
107:     LD  3,-3(1) 	Load variable k
108:     ST  3,-207(1) 	Save left side 
109:    LDC  3,1(6) 	Load constant 
110:     LD  4,-207(1) 	Load left into ac1 
111:    ADD  3,4,3 	Op + 
112:     ST  3,-3(1) 	Store variable k
* WHILE
113:     LD  3,-3(1) 	Load variable k
114:     ST  3,-207(1) 	Save left side 
115:     LD  3,-2(1) 	Load variable max
116:     LD  4,-207(1) 	Load left into ac1 
117:    SUB  4,4,3 	Op <= 
118:    LDC  3,1(6) 	True case 
119:    JLE  4,1(7) 	Jump if true 
120:    LDC  3,0(6) 	False case 
121:     ST  3,-207(1) 	Save left side 
122:     LD  3,-3(1) 	Load variable k
123:    LDA  4,-5(1) 	Load address of base of array n
124:    SUB  3,4,3 	Compute offset of value 
125:     LD  3,0(3) 	Load the value 
126:    LDC  4,1(6) 	Load 1 
127:    SUB  3,4,3 	Op NOT 
128:     LD  4,-207(1) 	Load left into ac1 
129:    JEQ  3,1(7) 	Op AND 
130:    LDA  3,0(4) 	 
131:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
133:     LD  3,-3(1) 	Load variable k
134:     ST  3,-207(1) 	Save left side 
135:    LDC  3,1(6) 	Load constant 
136:     LD  4,-207(1) 	Load left into ac1 
137:    ADD  3,4,3 	Op + 
138:     ST  3,-3(1) 	Store variable k
139:    LDA  7,-27(7) 	go to beginning of loop 
132:    LDA  7,7(7) 	No more loop 
* ENDWHILE
* END compound statement
140:    LDA  7,-78(7) 	go to beginning of loop 
 76:    LDA  7,64(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
141:    LDC  3,2(6) 	Load constant 
142:     ST  3,-3(1) 	Store variable k
* WHILE
143:     LD  3,-3(1) 	Load variable k
144:     ST  3,-207(1) 	Save left side 
145:     LD  3,-2(1) 	Load variable max
146:     LD  4,-207(1) 	Load left into ac1 
147:    SUB  4,4,3 	Op <= 
148:    LDC  3,1(6) 	True case 
149:    JLE  4,1(7) 	Jump if true 
150:    LDC  3,0(6) 	False case 
151:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
153:     LD  3,-3(1) 	Load variable k
154:    LDA  4,-5(1) 	Load address of base of array n
155:    SUB  3,4,3 	Compute offset of value 
156:     LD  3,0(3) 	Load the value 
157:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
159:     ST  1,-207(1) 	Store old fp in ghost frame 
160:     LD  3,-3(1) 	Load variable k
161:     ST  3,-209(1) 	Store parameter 
162:    LDA  1,-207(1) 	Load address of new frame 
163:    LDA  3,1(7) 	Return address in ac 
164:    LDA  7,-159(7) 	CALL output
165:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
166:     ST  1,-207(1) 	Store old fp in ghost frame 
167:    LDA  1,-207(1) 	Load address of new frame 
168:    LDA  3,1(7) 	Return address in ac 
169:    LDA  7,-145(7) 	CALL outnl
170:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
158:    LDA  7,12(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
171:     LD  3,-3(1) 	Load variable k
172:     ST  3,-207(1) 	Save left side 
173:    LDC  3,1(6) 	Load constant 
174:     LD  4,-207(1) 	Load left into ac1 
175:    ADD  3,4,3 	Op + 
176:     ST  3,-3(1) 	Store variable k
* END compound statement
177:    LDA  7,-35(7) 	go to beginning of loop 
152:    LDA  7,25(7) 	No more loop 
* ENDWHILE
* RETURN
178:    LDC  3,0(6) 	Load constant 
179:    LDA  2,0(3) 	Copy result to rt register 
180:     LD  3,-1(1) 	Load return address 
181:     LD  1,0(1) 	Adjust fp 
182:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
183:    LDC  2,0(6) 	Set return value to 0 
184:     LD  3,-1(1) 	Load return address 
185:     LD  1,0(1) 	Adjust fp 
186:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,186(7) 	Jump to init 
* BEGIN Init
187:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
188:    LDA  1,0(0) 	set first frame at end of globals 
189:     ST  1,0(1) 	store old fp (point to self) 
190:    LDA  3,1(7) 	Return address in ac 
191:    LDA  7,-162(7) 	Jump to main 
192:   HALT  0,0,0 	DONE! 
* END Init
