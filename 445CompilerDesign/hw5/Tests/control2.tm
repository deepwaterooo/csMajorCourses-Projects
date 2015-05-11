* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  control2.tm
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
 31:    LDC  3,10(6) 	Load constant 
 32:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 33:    LDC  3,7(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable y
* WHILE
 35:     LD  3,0(1) 	Load variable x
 36:     ST  3,-3(1) 	Save left side 
 37:    LDC  3,0(6) 	Load constant 
 38:     LD  4,-3(1) 	Load left into ac1 
 39:    SUB  4,4,3 	Op > 
 40:    LDC  3,1(6) 	True case 
 41:    JLT  4,1(7) 	Jump if true 
 42:    LDC  3,0(6) 	False case 
 43:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
 45:     LD  3,0(1) 	Load variable x
 46:     ST  3,-3(1) 	Save left side 
 47:     LD  3,-2(1) 	Load variable y
 48:     LD  4,-3(1) 	Load left into ac1 
 49:    SUB  4,4,3 	Op == 
 50:    LDC  3,1(6) 	True case 
 51:    JEQ  4,1(7) 	Jump if true 
 52:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
 54:    LDC  3,666(6) 	Load constant 
 55:     ST  3,-2(1) 	Store variable y
 53:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
 57:     LD  3,0(1) 	Load variable x
 58:     ST  3,-3(1) 	Save left side 
 59:    LDC  3,1(6) 	Load constant 
 60:     LD  4,-3(1) 	Load left into ac1 
 61:    SUB  3,4,3 	Op - 
 62:     ST  3,0(1) 	Store variable x
 56:    LDA  7,6(7) 	jmp to end 
* ENDIF
 63:    LDA  7,-29(7) 	go to beginning of loop 
 44:    LDA  7,19(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 64:     ST  1,-3(1) 	Store old frame in ghost frame 
 65:     LD  3,-2(1) 	Load variable y
 66:     ST  3,-5(1) 	Store parameter 
 67:    LDA  1,-3(1) 	Load address of new frame 
 68:    LDA  3,1(7) 	Return address in ac 
 69:    LDA  7,-64(7) 	CALL output
 70:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 71:     ST  1,-3(1) 	Store old frame in ghost frame 
 72:    LDA  1,-3(1) 	Load address of new frame 
 73:    LDA  3,1(7) 	Return address in ac 
 74:    LDA  7,-50(7) 	CALL outnl
 75:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 76:    LDC  3,1(6) 	Load constant 
 77:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 78:    LDC  3,1(6) 	Load constant 
 79:     ST  3,-2(1) 	Store variable y
* WHILE
 80:     LD  3,0(1) 	Load variable x
 81:     ST  3,-3(1) 	Save left side 
 82:    LDC  3,5(6) 	Load constant 
 83:     LD  4,-3(1) 	Load left into ac1 
 84:    SUB  4,4,3 	Op < 
 85:    LDC  3,1(6) 	True case 
 86:    JLT  4,1(7) 	Jump if true 
 87:    LDC  3,0(6) 	False case 
 88:    JGT  3,1(7) 	Jump to while part 
* DO
* IfK:
* IfK: t->child[0] condition
 90:     LD  3,-2(1) 	Load variable y
 91:     ST  3,-3(1) 	Save left side 
 92:    LDC  3,5(6) 	Load constant 
 93:     LD  4,-3(1) 	Load left into ac1 
 94:    SUB  4,4,3 	Op < 
 95:    LDC  3,1(6) 	True case 
 96:    JLT  4,1(7) 	Jump if true 
 97:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* WHILE
 99:     LD  3,-2(1) 	Load variable y
100:     ST  3,-3(1) 	Save left side 
101:    LDC  3,5(6) 	Load constant 
102:     LD  4,-3(1) 	Load left into ac1 
103:    SUB  4,4,3 	Op < 
104:    LDC  3,1(6) 	True case 
105:    JLT  4,1(7) 	Jump if true 
106:    LDC  3,0(6) 	False case 
107:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
109:     ST  1,-3(1) 	Store old frame in ghost frame 
110:     LD  3,0(1) 	Load variable x
111:     ST  3,-5(1) 	Store parameter 
112:    LDA  1,-3(1) 	Load address of new frame 
113:    LDA  3,1(7) 	Return address in ac 
114:    LDA  7,-109(7) 	CALL output
115:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
116:     ST  1,-3(1) 	Store old frame in ghost frame 
117:     LD  3,-2(1) 	Load variable y
118:     ST  3,-5(1) 	Store parameter 
119:    LDA  1,-3(1) 	Load address of new frame 
120:    LDA  3,1(7) 	Return address in ac 
121:    LDA  7,-116(7) 	CALL output
122:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
123:     ST  1,-3(1) 	Store old frame in ghost frame 
124:    LDA  1,-3(1) 	Load address of new frame 
125:    LDA  3,1(7) 	Return address in ac 
126:    LDA  7,-102(7) 	CALL outnl
127:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
128:     ST  3,-2(1) 	Store variable y
* END compound statement
129:    LDA  7,-31(7) 	go to beginning of loop 
108:    LDA  7,21(7) 	No more loop 
* ENDWHILE
 98:    JEQ  3,32(7) 	if: jmp to else 
* IfK: t->child[2] else part
* BEGIN compound statement
* EXPRESSION STMT
131:    LDC  3,1(6) 	Load constant 
132:     ST  3,0(1) 	Store variable y
* EXPRESSION STMT
133:     ST  3,0(1) 	Store variable x
* END compound statement
130:    LDA  7,3(7) 	jmp to end 
* ENDIF
134:    LDA  7,-55(7) 	go to beginning of loop 
108:    LDA  7,26(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
135:     ST  1,-3(1) 	Store old frame in ghost frame 
136:     LD  3,0(1) 	Load variable x
137:     ST  3,-5(1) 	Store parameter 
138:    LDA  1,-3(1) 	Load address of new frame 
139:    LDA  3,1(7) 	Return address in ac 
140:    LDA  7,-135(7) 	CALL output
141:    LDA  3,0(2) 	Save the result in ac 
* RETURN
142:    LDA  2,0(3) 	Copy result to rt register 
143:     LD  3,-1(1) 	Load return address 
144:     LD  1,0(1) 	Adjust fp 
145:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
146:    LDC  2,0(6) 	Set return value to 0 
147:     LD  3,-1(1) 	Load return address 
148:     LD  1,0(1) 	Adjust fp 
149:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,149(7) 	Jump to init 
* BEGIN Init
150:     LD  0,0(0) 	Set the global pointer 
151:    LDA  1,0(0) 	set first frame at end of globals 
152:     ST  1,0(1) 	store old fp (point to self) 
153:    LDA  3,1(7) 	Return address in ac 
154:    LDA  7,-125(7) 	Jump to main 
155:   HALT  0,0,0 	DONE! 
* END Init
