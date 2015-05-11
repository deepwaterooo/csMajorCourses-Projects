* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  sieve.tm
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
 31:    LDC  3,0(6) 	load size of array n
 32:     ST  3,-3(1) 	save size of array n
* EXPRESSION STMT
 33:    LDC  3,200(6) 	Load constant 
 34:     ST  3,0(1) 	Store variable max
* EXPRESSION STMT
 35:    LDC  3,2(6) 	Load constant 
 36:     ST  3,-2(1) 	Store variable k
* WHILE
 37:     LD  3,-2(1) 	Load variable k
 38:     ST  3,-4(1) 	Save left side 
 39:     LD  3,0(1) 	Load variable max
 40:     LD  4,-4(1) 	Load left into ac1 
 41:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 43:     LD  3,-2(1) 	Load variable k
 44:     ST  3,-4(1) 	Save index 
 45:    LDC  3,0(6) 	Load constant 
 46:     ST  3,-4(1) 	Store variable n
* EXPRESSION STMT
 47:     LD  3,-2(1) 	Load variable k
 48:     ST  3,-5(1) 	Save left side 
 49:    LDC  3,1(6) 	Load constant 
 50:     LD  4,-5(1) 	Load left into ac1 
 51:    ADD  3,4,3 	Op + 
 52:     ST  3,-2(1) 	Store variable k
* END compound statement
 53:    LDA  7,-17(7) 	go to beginning of loop 
 42:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 54:    LDC  3,2(6) 	Load constant 
 55:     ST  3,-2(1) 	Store variable k
* WHILE
 56:     LD  3,-2(1) 	Load variable k
 57:     ST  3,-5(1) 	Save left side 
 58:     LD  3,-2(1) 	Load variable k
 59:     LD  4,-5(1) 	Load left into ac1 
 60:    MUL  3,4,3 	Op * 
 61:     ST  3,-5(1) 	Save left side 
 62:     LD  3,0(1) 	Load variable max
 63:     LD  4,-5(1) 	Load left into ac1 
 64:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 66:     LD  3,-2(1) 	Load variable k
 67:     ST  3,-5(1) 	Save left side 
 68:     LD  3,-2(1) 	Load variable k
 69:     LD  4,-5(1) 	Load left into ac1 
 70:    MUL  3,4,3 	Op * 
 71:     ST  3,-2(1) 	Store variable j
* WHILE
 72:     LD  3,-2(1) 	Load variable j
 73:     ST  3,-5(1) 	Save left side 
 74:     LD  3,0(1) 	Load variable max
 75:     LD  4,-5(1) 	Load left into ac1 
 76:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 78:     LD  3,-2(1) 	Load variable j
 79:     ST  3,-5(1) 	Save index 
 80:    LDC  3,0(6) 	Load constant 
 81:     ST  3,-4(1) 	Store variable n
* EXPRESSION STMT
 82:     LD  3,-2(1) 	Load variable j
 83:     ST  3,-6(1) 	Save left side 
 84:     LD  3,-2(1) 	Load variable k
 85:     LD  4,-6(1) 	Load left into ac1 
 86:    ADD  3,4,3 	Op + 
 87:     ST  3,-2(1) 	Store variable j
* END compound statement
 88:    LDA  7,-17(7) 	go to beginning of loop 
 77:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 89:     LD  3,-2(1) 	Load variable k
 90:     ST  3,-6(1) 	Save left side 
 91:    LDC  3,1(6) 	Load constant 
 92:     LD  4,-6(1) 	Load left into ac1 
 93:    ADD  3,4,3 	Op + 
 94:     ST  3,-2(1) 	Store variable k
* WHILE
 95:     LD  3,-2(1) 	Load variable k
 96:     ST  3,-6(1) 	Save left side 
 97:     LD  3,0(1) 	Load variable max
 98:     LD  4,-6(1) 	Load left into ac1 
 99:     ST  3,-6(1) 	Save left side 
100:     LD  3,-2(1) 	Load variable k
101:     ST  3,-7(1) 	Save index 
102:     LD  4,-7(1) 	Load left into ac1 
103:    JEQ  3,1(7) 	Op AND 
104:    LDA  3,0(4) 	 
105:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
107:     LD  3,-2(1) 	Load variable k
108:     ST  3,-7(1) 	Save left side 
109:    LDC  3,1(6) 	Load constant 
110:     LD  4,-7(1) 	Load left into ac1 
111:    ADD  3,4,3 	Op + 
112:     ST  3,-2(1) 	Store variable k
113:    LDA  7,-19(7) 	go to beginning of loop 
106:    LDA  7,7(7) 	No more loop 
* ENDWHILE
* END compound statement
114:    LDA  7,-59(7) 	go to beginning of loop 
 65:    LDA  7,49(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
115:    LDC  3,2(6) 	Load constant 
116:     ST  3,-2(1) 	Store variable k
* WHILE
117:     LD  3,-2(1) 	Load variable k
118:     ST  3,-7(1) 	Save left side 
119:     LD  3,0(1) 	Load variable max
120:     LD  4,-7(1) 	Load left into ac1 
121:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IfK:
* IfK: t->child[0] condition
123:     LD  3,-2(1) 	Load variable k
124:     ST  3,-7(1) 	Save index 
* IfK: t->child[1] then part
* BEGIN compound statement
* EXPRESSION STMT
126:     ST  1,-8(1) 	Store old frame in ghost frame 
127:     LD  3,-2(1) 	Load variable k
128:     ST  3,-10(1) 	Store parameter 
129:    LDA  1,-8(1) 	Load address of new frame 
130:    LDA  3,1(7) 	Return address in ac 
131:    LDA  7,-126(7) 	CALL output
132:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
133:     ST  1,-8(1) 	Store old frame in ghost frame 
134:    LDA  1,-8(1) 	Load address of new frame 
135:    LDA  3,1(7) 	Return address in ac 
136:    LDA  7,-112(7) 	CALL outnl
137:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
125:    JEQ  3,13(7) 	if: jmp to else 
* IfK: t->child[2] else part
138:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
139:     LD  3,-2(1) 	Load variable k
140:     ST  3,-8(1) 	Save left side 
141:    LDC  3,1(6) 	Load constant 
142:     LD  4,-8(1) 	Load left into ac1 
143:    ADD  3,4,3 	Op + 
144:     ST  3,-2(1) 	Store variable k
* END compound statement
145:    LDA  7,-29(7) 	go to beginning of loop 
122:    LDA  7,23(7) 	No more loop 
* ENDWHILE
* RETURN
146:    LDC  3,0(6) 	Load constant 
147:    LDA  2,0(3) 	Copy result to rt register 
148:     LD  3,-1(1) 	Load return address 
149:     LD  1,0(1) 	Adjust fp 
150:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
151:    LDC  2,0(6) 	Set return value to 0 
152:     LD  3,-1(1) 	Load return address 
153:     LD  1,0(1) 	Adjust fp 
154:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,154(7) 	Jump to init 
* BEGIN Init
155:     LD  0,0(0) 	Set the global pointer 
156:    LDA  1,0(0) 	set first frame at end of globals 
157:     ST  1,0(1) 	store old fp (point to self) 
158:    LDA  3,1(7) 	Return address in ac 
159:    LDA  7,-130(7) 	Jump to main 
160:   HALT  0,0,0 	DONE! 
* END Init
