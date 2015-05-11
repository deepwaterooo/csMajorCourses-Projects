* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  combslow.tm
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
* BEGIN function comb
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* IfK:
* IfK: t->child[0] condition
 31:     LD  3,-2(1) 	Load variable a
 32:     ST  3,-4(1) 	Save left side 
 33:     LD  3,-3(1) 	Load variable b
 34:     LD  4,-4(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op == 
 36:    LDC  3,1(6) 	True case 
 37:    JEQ  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* RETURN
 40:    LDC  3,1(6) 	Load constant 
 41:    LDA  2,0(3) 	Copy result to rt register 
 42:     LD  3,-1(1) 	Load return address 
 43:     LD  1,0(1) 	Adjust fp 
 44:    LDA  7,0(3) 	Return 
 39:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
 45:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 46:     LD  3,-3(1) 	Load variable b
 47:     ST  3,-4(1) 	Save left side 
 48:    LDC  3,0(6) 	Load constant 
 49:     LD  4,-4(1) 	Load left into ac1 
 50:    SUB  4,4,3 	Op == 
 51:    LDC  3,1(6) 	True case 
 52:    JEQ  4,1(7) 	Jump if true 
 53:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* RETURN
 55:    LDC  3,1(6) 	Load constant 
 56:    LDA  2,0(3) 	Copy result to rt register 
 57:     LD  3,-1(1) 	Load return address 
 58:     LD  1,0(1) 	Adjust fp 
 59:    LDA  7,0(3) 	Return 
 54:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
 60:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 61:     LD  3,-3(1) 	Load variable b
 62:     ST  3,-4(1) 	Save left side 
 63:    LDC  3,1(6) 	Load constant 
 64:     LD  4,-4(1) 	Load left into ac1 
 65:    SUB  4,4,3 	Op == 
 66:    LDC  3,1(6) 	True case 
 67:    JEQ  4,1(7) 	Jump if true 
 68:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* RETURN
 70:     LD  3,-2(1) 	Load variable a
 71:    LDA  2,0(3) 	Copy result to rt register 
 72:     LD  3,-1(1) 	Load return address 
 73:     LD  1,0(1) 	Adjust fp 
 74:    LDA  7,0(3) 	Return 
 69:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
 75:    LDA  7,0(7) 	jmp to end 
* ENDIF
* RETURN
* EXPRESSION STMT
 76:     ST  1,-4(1) 	Store old frame in ghost frame 
 77:     LD  3,-2(1) 	Load variable a
 78:     ST  3,-6(1) 	Save left side 
 79:    LDC  3,1(6) 	Load constant 
 80:     LD  4,-6(1) 	Load left into ac1 
 81:    SUB  3,4,3 	Op - 
 82:     LD  3,-3(1) 	Load variable b
 83:     ST  3,-6(1) 	Save left side 
 84:    LDC  3,1(6) 	Load constant 
 85:     LD  4,-6(1) 	Load left into ac1 
 86:    SUB  3,4,3 	Op - 
 87:     ST  3,-6(1) 	Store parameter 
 88:     LD  3,-3(1) 	Load variable b
 89:     ST  3,-7(1) 	Save left side 
 90:    LDC  3,1(6) 	Load constant 
 91:     LD  4,-7(1) 	Load left into ac1 
 92:    SUB  3,4,3 	Op - 
 93:     ST  3,-7(1) 	Store parameter 
 94:    LDA  1,-4(1) 	Load address of new frame 
 95:    LDA  3,1(7) 	Return address in ac 
 96:    LDA  7,-67(7) 	CALL comb
 97:    LDA  3,0(2) 	Save the result in ac 
 98:     ST  3,-4(1) 	Save left side 
* EXPRESSION STMT
 99:     ST  1,-5(1) 	Store old frame in ghost frame 
100:     LD  3,-2(1) 	Load variable a
101:     ST  3,-7(1) 	Save left side 
102:    LDC  3,1(6) 	Load constant 
103:     LD  4,-7(1) 	Load left into ac1 
104:    SUB  3,4,3 	Op - 
105:     LD  3,-3(1) 	Load variable b
106:     ST  3,-7(1) 	Store parameter 
107:     LD  3,-3(1) 	Load variable b
108:     ST  3,-8(1) 	Store parameter 
109:    LDA  1,-5(1) 	Load address of new frame 
110:    LDA  3,1(7) 	Return address in ac 
111:    LDA  7,-82(7) 	CALL comb
112:    LDA  3,0(2) 	Save the result in ac 
113:     LD  4,-4(1) 	Load left into ac1 
114:    ADD  3,4,3 	Op + 
115:    LDA  2,0(3) 	Copy result to rt register 
116:     LD  3,-1(1) 	Load return address 
117:     LD  1,0(1) 	Adjust fp 
118:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
119:    LDC  2,0(6) 	Set return value to 0 
120:     LD  3,-1(1) 	Load return address 
121:     LD  1,0(1) 	Adjust fp 
122:    LDA  7,0(3) 	Return 
* END function comb
* BEGIN function main
123:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* WHILE
124:    LDC  3,1(6) 	Load constant 
125:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IfK:
* IfK: t->child[0] condition
* EXPRESSION STMT
* EXPRESSION STMT
127:     ST  1,-4(1) 	Store old frame in ghost frame 
128:    LDA  1,-4(1) 	Load address of new frame 
129:    LDA  3,1(7) 	Return address in ac 
130:    LDA  7,-130(7) 	CALL input
131:    LDA  3,0(2) 	Save the result in ac 
132:     ST  3,-3(1) 	Store variable n
133:     ST  3,-4(1) 	Save left side 
134:    LDC  3,0(6) 	Load constant 
135:     LD  4,-4(1) 	Load left into ac1 
136:    SUB  4,4,3 	Op == 
137:    LDC  3,1(6) 	True case 
138:    JEQ  4,1(7) 	Jump if true 
139:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
140:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
141:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
142:    LDC  3,0(6) 	Load constant 
143:     ST  3,0(1) 	Store variable a
* WHILE
144:     LD  3,0(1) 	Load variable a
145:     ST  3,-4(1) 	Save left side 
146:     LD  3,-3(1) 	Load variable n
147:     LD  4,-4(1) 	Load left into ac1 
148:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
150:    LDC  3,0(6) 	Load constant 
151:     ST  3,-2(1) 	Store variable b
* WHILE
152:     LD  3,-2(1) 	Load variable b
153:     ST  3,-4(1) 	Save left side 
154:     LD  3,0(1) 	Load variable a
155:     LD  4,-4(1) 	Load left into ac1 
156:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
158:     ST  1,-4(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
159:     ST  1,-6(1) 	Store old frame in ghost frame 
160:     LD  3,0(1) 	Load variable a
161:     ST  3,-8(1) 	Store parameter 
162:     LD  3,-2(1) 	Load variable b
163:     ST  3,-9(1) 	Store parameter 
164:    LDA  1,-6(1) 	Load address of new frame 
165:    LDA  3,1(7) 	Return address in ac 
166:    LDA  7,-137(7) 	CALL comb
167:    LDA  3,0(2) 	Save the result in ac 
168:     ST  3,-6(1) 	Store parameter 
169:    LDA  1,-4(1) 	Load address of new frame 
170:    LDA  3,1(7) 	Return address in ac 
171:    LDA  7,-166(7) 	CALL output
172:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
173:     ST  3,-2(1) 	Store variable b
* END compound statement
174:    LDA  7,-23(7) 	go to beginning of loop 
157:    LDA  7,17(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
175:     ST  1,-4(1) 	Store old frame in ghost frame 
176:    LDA  1,-4(1) 	Load address of new frame 
177:    LDA  3,1(7) 	Return address in ac 
178:    LDA  7,-154(7) 	CALL outnl
179:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
180:     ST  3,0(1) 	Store variable a
* END compound statement
181:    LDA  7,-38(7) 	go to beginning of loop 
157:    LDA  7,24(7) 	No more loop 
* ENDWHILE
* END compound statement
182:    LDA  7,-59(7) 	go to beginning of loop 
149:    LDA  7,33(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
183:    LDC  2,0(6) 	Set return value to 0 
184:     LD  3,-1(1) 	Load return address 
185:     LD  1,0(1) 	Adjust fp 
186:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,186(7) 	Jump to init 
* BEGIN Init
187:     LD  0,0(0) 	Set the global pointer 
188:    LDA  1,0(0) 	set first frame at end of globals 
189:     ST  1,0(1) 	store old fp (point to self) 
190:    LDA  3,1(7) 	Return address in ac 
191:    LDA  7,-69(7) 	Jump to main 
192:   HALT  0,0,0 	DONE! 
* END Init
