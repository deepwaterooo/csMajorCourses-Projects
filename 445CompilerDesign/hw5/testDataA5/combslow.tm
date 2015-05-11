* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  combslow.c-
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
* BEGIN function comb
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
 31:     LD  3,-2(1) 	Load variable a
 32:     ST  3,-4(1) 	Save left side 
 33:     LD  3,-3(1) 	Load variable b
 34:     LD  4,-4(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op == 
 36:    LDC  3,1(6) 	True case 
 37:    JEQ  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
 39:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
 41:    LDC  3,1(6) 	Load constant 
 42:    LDA  2,0(3) 	Copy result to rt register 
 43:     LD  3,-1(1) 	Load return address 
 44:     LD  1,0(1) 	Adjust fp 
 45:    LDA  7,0(3) 	Return 
 40:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* IF
 46:     LD  3,-3(1) 	Load variable b
 47:     ST  3,-4(1) 	Save left side 
 48:    LDC  3,0(6) 	Load constant 
 49:     LD  4,-4(1) 	Load left into ac1 
 50:    SUB  4,4,3 	Op == 
 51:    LDC  3,1(6) 	True case 
 52:    JEQ  4,1(7) 	Jump if true 
 53:    LDC  3,0(6) 	False case 
 54:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
 56:    LDC  3,1(6) 	Load constant 
 57:    LDA  2,0(3) 	Copy result to rt register 
 58:     LD  3,-1(1) 	Load return address 
 59:     LD  1,0(1) 	Adjust fp 
 60:    LDA  7,0(3) 	Return 
 55:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* IF
 61:     LD  3,-3(1) 	Load variable b
 62:     ST  3,-4(1) 	Save left side 
 63:    LDC  3,1(6) 	Load constant 
 64:     LD  4,-4(1) 	Load left into ac1 
 65:    SUB  4,4,3 	Op == 
 66:    LDC  3,1(6) 	True case 
 67:    JEQ  4,1(7) 	Jump if true 
 68:    LDC  3,0(6) 	False case 
 69:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
 71:     LD  3,-2(1) 	Load variable a
 72:    LDA  2,0(3) 	Copy result to rt register 
 73:     LD  3,-1(1) 	Load return address 
 74:     LD  1,0(1) 	Adjust fp 
 75:    LDA  7,0(3) 	Return 
 70:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* RETURN
 76:     ST  1,-4(1) 	Store old fp in ghost frame 
 77:     LD  3,-2(1) 	Load variable a
 78:     ST  3,-6(1) 	Save left side 
 79:    LDC  3,1(6) 	Load constant 
 80:     LD  4,-6(1) 	Load left into ac1 
 81:    SUB  3,4,3 	Op - 
 82:     ST  3,-6(1) 	Store parameter 
 83:     LD  3,-3(1) 	Load variable b
 84:     ST  3,-7(1) 	Save left side 
 85:    LDC  3,1(6) 	Load constant 
 86:     LD  4,-7(1) 	Load left into ac1 
 87:    SUB  3,4,3 	Op - 
 88:     ST  3,-7(1) 	Store parameter 
 89:    LDA  1,-4(1) 	Load address of new frame 
 90:    LDA  3,1(7) 	Return address in ac 
 91:    LDA  7,-62(7) 	CALL comb
 92:    LDA  3,0(2) 	Save the result in ac 
 93:     ST  3,-4(1) 	Save left side 
 94:     ST  1,-5(1) 	Store old fp in ghost frame 
 95:     LD  3,-2(1) 	Load variable a
 96:     ST  3,-7(1) 	Save left side 
 97:    LDC  3,1(6) 	Load constant 
 98:     LD  4,-7(1) 	Load left into ac1 
 99:    SUB  3,4,3 	Op - 
100:     ST  3,-7(1) 	Store parameter 
101:     LD  3,-3(1) 	Load variable b
102:     ST  3,-8(1) 	Store parameter 
103:    LDA  1,-5(1) 	Load address of new frame 
104:    LDA  3,1(7) 	Return address in ac 
105:    LDA  7,-76(7) 	CALL comb
106:    LDA  3,0(2) 	Save the result in ac 
107:     LD  4,-4(1) 	Load left into ac1 
108:    ADD  3,4,3 	Op + 
109:    LDA  2,0(3) 	Copy result to rt register 
110:     LD  3,-1(1) 	Load return address 
111:     LD  1,0(1) 	Adjust fp 
112:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
113:    LDC  2,0(6) 	Set return value to 0 
114:     LD  3,-1(1) 	Load return address 
115:     LD  1,0(1) 	Adjust fp 
116:    LDA  7,0(3) 	Return 
* END of function comb
* BEGIN function main
117:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* WHILE
118:    LDC  3,1(6) 	Load constant 
119:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
121:     ST  1,-5(1) 	Store old fp in ghost frame 
122:    LDA  1,-5(1) 	Load address of new frame 
123:    LDA  3,1(7) 	Return address in ac 
124:    LDA  7,-124(7) 	CALL input
125:    LDA  3,0(2) 	Save the result in ac 
126:     ST  3,-4(1) 	Store variable n
127:     ST  3,-5(1) 	Save left side 
128:    LDC  3,0(6) 	Load constant 
129:     LD  4,-5(1) 	Load left into ac1 
130:    SUB  4,4,3 	Op == 
131:    LDC  3,1(6) 	True case 
132:    JEQ  4,1(7) 	Jump if true 
133:    LDC  3,0(6) 	False case 
134:    JGT  3,1(7) 	Jump to then part 
* THEN
* BREAK
136:    LDA  7,-17(7) 	break 
135:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
137:    LDC  3,0(6) 	Load constant 
138:     ST  3,-2(1) 	Store variable a
* WHILE
139:     LD  3,-2(1) 	Load variable a
140:     ST  3,-5(1) 	Save left side 
141:     LD  3,-4(1) 	Load variable n
142:     LD  4,-5(1) 	Load left into ac1 
143:    SUB  4,4,3 	Op <= 
144:    LDC  3,1(6) 	True case 
145:    JLE  4,1(7) 	Jump if true 
146:    LDC  3,0(6) 	False case 
147:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
149:    LDC  3,0(6) 	Load constant 
150:     ST  3,-3(1) 	Store variable b
* WHILE
151:     LD  3,-3(1) 	Load variable b
152:     ST  3,-5(1) 	Save left side 
153:     LD  3,-2(1) 	Load variable a
154:     LD  4,-5(1) 	Load left into ac1 
155:    SUB  4,4,3 	Op <= 
156:    LDC  3,1(6) 	True case 
157:    JLE  4,1(7) 	Jump if true 
158:    LDC  3,0(6) 	False case 
159:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
161:     ST  1,-5(1) 	Store old fp in ghost frame 
162:     ST  1,-7(1) 	Store old fp in ghost frame 
163:     LD  3,-2(1) 	Load variable a
164:     ST  3,-9(1) 	Store parameter 
165:     LD  3,-3(1) 	Load variable b
166:     ST  3,-10(1) 	Store parameter 
167:    LDA  1,-7(1) 	Load address of new frame 
168:    LDA  3,1(7) 	Return address in ac 
169:    LDA  7,-140(7) 	CALL comb
170:    LDA  3,0(2) 	Save the result in ac 
171:     ST  3,-7(1) 	Store parameter 
172:    LDA  1,-5(1) 	Load address of new frame 
173:    LDA  3,1(7) 	Return address in ac 
174:    LDA  7,-169(7) 	CALL output
175:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
176:     LD  3,-3(1) 	load lhs variable b
177:    LDA  3,1(3) 	increment value of b
178:     ST  3,-3(1) 	Store variable b
* END compound statement
179:    LDA  7,-29(7) 	go to beginning of loop 
160:    LDA  7,19(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
180:     ST  1,-5(1) 	Store old fp in ghost frame 
181:    LDA  1,-5(1) 	Load address of new frame 
182:    LDA  3,1(7) 	Return address in ac 
183:    LDA  7,-159(7) 	CALL outnl
184:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
185:     LD  3,-2(1) 	load lhs variable a
186:    LDA  3,1(3) 	increment value of a
187:     ST  3,-2(1) 	Store variable a
* END compound statement
188:    LDA  7,-50(7) 	go to beginning of loop 
148:    LDA  7,40(7) 	No more loop 
* ENDWHILE
* END compound statement
189:    LDA  7,-72(7) 	go to beginning of loop 
120:    LDA  7,69(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
190:    LDC  2,0(6) 	Set return value to 0 
191:     LD  3,-1(1) 	Load return address 
192:     LD  1,0(1) 	Adjust fp 
193:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,193(7) 	Jump to init 
* BEGIN Init
194:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
195:    LDA  1,0(0) 	set first frame at end of globals 
196:     ST  1,0(1) 	store old fp (point to self) 
197:    LDA  3,1(7) 	Return address in ac 
198:    LDA  7,-82(7) 	Jump to main 
199:   HALT  0,0,0 	DONE! 
* END Init
