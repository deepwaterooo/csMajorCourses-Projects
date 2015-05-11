* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  walsh.tm
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
* BEGIN function pow
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,1(6) 	Load constant 
 32:     ST  3,-4(1) 	Store variable ans
* EXPRESSION STMT
 33:     LD  3,-2(1) 	Load variable n
 34:     ST  3,0(1) 	Store variable sqr
* WHILE
 35:    LDC  3,0(6) 	Load constant 
 36:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IfK:
* IfK: t->child[0] condition
 38:     LD  3,-3(1) 	Load variable p
 39:     ST  3,-5(1) 	Save left side 
 40:    LDC  3,2(6) 	Load constant 
 41:     LD  4,-5(1) 	Load left into ac1 
 42:     ST  3,-5(1) 	Save left side 
 43:    LDC  3,1(6) 	Load constant 
 44:     LD  4,-5(1) 	Load left into ac1 
 45:    SUB  4,4,3 	Op == 
 46:    LDC  3,1(6) 	True case 
 47:    JEQ  4,1(7) 	Jump if true 
 48:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
 50:     LD  3,-4(1) 	Load variable ans
 51:     ST  3,-5(1) 	Save left side 
 52:     LD  3,0(1) 	Load variable sqr
 53:     LD  4,-5(1) 	Load left into ac1 
 54:    MUL  3,4,3 	Op * 
 55:     ST  3,-4(1) 	Store variable ans
 49:    JEQ  3,7(7) 	if: jmp to else 
* IfK: t->child[2] else part
 56:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
 57:     LD  3,-3(1) 	Load variable p
 58:     ST  3,-5(1) 	Save left side 
 59:    LDC  3,2(6) 	Load constant 
 60:     LD  4,-5(1) 	Load left into ac1 
 61:    DIV  3,4,3 	Op / 
 62:     ST  3,-3(1) 	Store variable p
* IfK:
* IfK: t->child[0] condition
 63:     LD  3,-3(1) 	Load variable p
 64:     ST  3,-5(1) 	Save left side 
 65:    LDC  3,0(6) 	Load constant 
 66:     LD  4,-5(1) 	Load left into ac1 
 67:    SUB  4,4,3 	Op == 
 68:    LDC  3,1(6) 	True case 
 69:    JEQ  4,1(7) 	Jump if true 
 70:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* RETURN
 72:     LD  3,-4(1) 	Load variable ans
 73:    LDA  2,0(3) 	Copy result to rt register 
 74:     LD  3,-1(1) 	Load return address 
 75:     LD  1,0(1) 	Adjust fp 
 76:    LDA  7,0(3) 	Return 
 71:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
 77:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
 78:     LD  3,0(1) 	Load variable sqr
 79:     ST  3,-5(1) 	Save left side 
 80:     LD  3,0(1) 	Load variable sqr
 81:     LD  4,-5(1) 	Load left into ac1 
 82:    MUL  3,4,3 	Op * 
 83:     ST  3,0(1) 	Store variable sqr
* END compound statement
 84:    LDA  7,-50(7) 	go to beginning of loop 
 37:    LDA  7,47(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
 85:    LDC  2,0(6) 	Set return value to 0 
 86:     LD  3,-1(1) 	Load return address 
 87:     LD  1,0(1) 	Adjust fp 
 88:    LDA  7,0(3) 	Return 
* END function pow
* BEGIN function getFunc
 89:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* IfK:
* IfK: t->child[0] condition
* EXPRESSION STMT
* EXPRESSION STMT
 90:     ST  1,-5(1) 	Store old frame in ghost frame 
 91:    LDA  1,-5(1) 	Load address of new frame 
 92:    LDA  3,1(7) 	Return address in ac 
 93:    LDA  7,-93(7) 	CALL input
 94:    LDA  3,0(2) 	Save the result in ac 
 95:     ST  3,-2(1) 	Store variable numbits
 96:     ST  3,-5(1) 	Save left side 
 97:    LDC  3,0(6) 	Load constant 
 98:     LD  4,-5(1) 	Load left into ac1 
 99:    SUB  4,4,3 	Op == 
100:    LDC  3,1(6) 	True case 
101:    JEQ  4,1(7) 	Jump if true 
102:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* RETURN
104:    LDC  3,0(6) 	Load constant 
105:    LDA  2,0(3) 	Copy result to rt register 
106:     LD  3,-1(1) 	Load return address 
107:     LD  1,0(1) 	Adjust fp 
108:    LDA  7,0(3) 	Return 
103:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
109:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
* EXPRESSION STMT
110:     ST  1,-5(1) 	Store old frame in ghost frame 
111:    LDC  3,2(6) 	Load constant 
112:     ST  3,-7(1) 	Store parameter 
113:     LD  3,-2(1) 	Load variable numbits
114:     ST  3,-8(1) 	Store parameter 
115:    LDA  1,-5(1) 	Load address of new frame 
116:    LDA  3,1(7) 	Return address in ac 
117:    LDA  7,-88(7) 	CALL pow
118:    LDA  3,0(2) 	Save the result in ac 
119:     ST  3,-4(1) 	Store variable size
* EXPRESSION STMT
120:    LDC  3,0(6) 	Load constant 
121:     ST  3,-3(1) 	Store variable i
* WHILE
122:     LD  3,-3(1) 	Load variable i
123:     ST  3,-5(1) 	Save left side 
124:     LD  3,-4(1) 	Load variable size
125:     LD  4,-5(1) 	Load left into ac1 
126:    SUB  4,4,3 	Op < 
127:    LDC  3,1(6) 	True case 
128:    JLT  4,1(7) 	Jump if true 
129:    LDC  3,0(6) 	False case 
130:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
132:     LD  3,-3(1) 	Load variable i
133:     ST  3,-5(1) 	Save index 
* EXPRESSION STMT
134:     ST  1,-6(1) 	Store old frame in ghost frame 
135:    LDA  1,-6(1) 	Load address of new frame 
136:    LDA  3,1(7) 	Return address in ac 
137:    LDA  7,-137(7) 	CALL input
138:    LDA  3,0(2) 	Save the result in ac 
139:     ST  3,-2(1) 	Store variable f
* EXPRESSION STMT
140:     LD  3,-3(1) 	Load variable i
141:     ST  3,-6(1) 	Save left side 
142:    LDC  3,1(6) 	Load constant 
143:     LD  4,-6(1) 	Load left into ac1 
144:    ADD  3,4,3 	Op + 
145:     ST  3,-3(1) 	Store variable i
* END compound statement
146:    LDA  7,-25(7) 	go to beginning of loop 
131:    LDA  7,15(7) 	No more loop 
* ENDWHILE
* RETURN
147:     LD  3,-2(1) 	Load variable numbits
148:    LDA  2,0(3) 	Copy result to rt register 
149:     LD  3,-1(1) 	Load return address 
150:     LD  1,0(1) 	Adjust fp 
151:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
152:    LDC  2,0(6) 	Set return value to 0 
153:     LD  3,-1(1) 	Load return address 
154:     LD  1,0(1) 	Adjust fp 
155:    LDA  7,0(3) 	Return 
* END function getFunc
* BEGIN function main
156:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
157:    LDC  3,0(6) 	load size of array f
158:     ST  3,-3(1) 	save size of array f
* WHILE
159:    LDC  3,0(6) 	Load constant 
160:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IfK:
* IfK: t->child[0] condition
* EXPRESSION STMT
* EXPRESSION STMT
162:     ST  1,-6(1) 	Store old frame in ghost frame 
163:     LD  3,-4(1) 	Load variable f
164:     ST  3,-8(1) 	Store parameter 
165:    LDA  1,-6(1) 	Load address of new frame 
166:    LDA  3,1(7) 	Return address in ac 
167:    LDA  7,-79(7) 	CALL getFunc
168:    LDA  3,0(2) 	Save the result in ac 
169:     ST  3,-4(1) 	Store variable numbits
170:     ST  3,-6(1) 	Save left side 
171:    LDC  3,0(6) 	Load constant 
172:     LD  4,-6(1) 	Load left into ac1 
173:    SUB  4,4,3 	Op == 
174:    LDC  3,1(6) 	True case