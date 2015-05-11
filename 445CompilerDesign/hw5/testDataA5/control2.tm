* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  control2.c-
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
 31:    LDC  3,10(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 33:    LDC  3,7(6) 	Load constant 
 34:     ST  3,-3(1) 	Store variable y
* WHILE
 35:     LD  3,-2(1) 	Load variable x
 36:     ST  3,-4(1) 	Save left side 
 37:    LDC  3,0(6) 	Load constant 
 38:     LD  4,-4(1) 	Load left into ac1 
 39:    SUB  4,4,3 	Op > 
 40:    LDC  3,1(6) 	True case 
 41:    JGT  4,1(7) 	Jump if true 
 42:    LDC  3,0(6) 	False case 
 43:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
 45:     LD  3,-2(1) 	Load variable x
 46:     ST  3,-4(1) 	Save left side 
 47:     LD  3,-3(1) 	Load variable y
 48:     LD  4,-4(1) 	Load left into ac1 
 49:    SUB  4,4,3 	Op == 
 50:    LDC  3,1(6) 	True case 
 51:    JEQ  4,1(7) 	Jump if true 
 52:    LDC  3,0(6) 	False case 
 53:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 55:    LDC  3,666(6) 	Load constant 
 56:     ST  3,-3(1) 	Store variable y
* ELSE
 54:    LDA  7,3(7) 	Jump around the THEN 
* EXPRESSION STMT
 58:     LD  3,-2(1) 	Load variable x
 59:     ST  3,-4(1) 	Save left side 
 60:    LDC  3,1(6) 	Load constant 
 61:     LD  4,-4(1) 	Load left into ac1 
 62:    SUB  3,4,3 	Op - 
 63:     ST  3,-2(1) 	Store variable x
 57:    LDA  7,6(7) 	Jump around the ELSE 
* ENDIF
 64:    LDA  7,-30(7) 	go to beginning of loop 
 44:    LDA  7,20(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 65:     ST  1,-4(1) 	Store old fp in ghost frame 
 66:     LD  3,-3(1) 	Load variable y
 67:     ST  3,-6(1) 	Store parameter 
 68:    LDA  1,-4(1) 	Load address of new frame 
 69:    LDA  3,1(7) 	Return address in ac 
 70:    LDA  7,-65(7) 	CALL output
 71:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 72:     ST  1,-4(1) 	Store old fp in ghost frame 
 73:    LDA  1,-4(1) 	Load address of new frame 
 74:    LDA  3,1(7) 	Return address in ac 
 75:    LDA  7,-51(7) 	CALL outnl
 76:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 77:    LDC  3,1(6) 	Load constant 
 78:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 79:    LDC  3,1(6) 	Load constant 
 80:     ST  3,-3(1) 	Store variable y
* WHILE
 81:     LD  3,-2(1) 	Load variable x
 82:     ST  3,-4(1) 	Save left side 
 83:    LDC  3,5(6) 	Load constant 
 84:     LD  4,-4(1) 	Load left into ac1 
 85:    SUB  4,4,3 	Op < 
 86:    LDC  3,1(6) 	True case 
 87:    JLT  4,1(7) 	Jump if true 
 88:    LDC  3,0(6) 	False case 
 89:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
 91:     LD  3,-3(1) 	Load variable y
 92:     ST  3,-4(1) 	Save left side 
 93:    LDC  3,5(6) 	Load constant 
 94:     LD  4,-4(1) 	Load left into ac1 
 95:    SUB  4,4,3 	Op < 
 96:    LDC  3,1(6) 	True case 
 97:    JLT  4,1(7) 	Jump if true 
 98:    LDC  3,0(6) 	False case 
 99:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
101:     LD  3,-3(1) 	Load variable y
102:     ST  3,-4(1) 	Save left side 
103:    LDC  3,5(6) 	Load constant 
104:     LD  4,-4(1) 	Load left into ac1 
105:    SUB  4,4,3 	Op < 
106:    LDC  3,1(6) 	True case 
107:    JLT  4,1(7) 	Jump if true 
108:    LDC  3,0(6) 	False case 
109:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
111:     ST  1,-4(1) 	Store old fp in ghost frame 
112:     LD  3,-2(1) 	Load variable x
113:     ST  3,-6(1) 	Store parameter 
114:    LDA  1,-4(1) 	Load address of new frame 
115:    LDA  3,1(7) 	Return address in ac 
116:    LDA  7,-111(7) 	CALL output
117:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
118:     ST  1,-4(1) 	Store old fp in ghost frame 
119:     LD  3,-3(1) 	Load variable y
120:     ST  3,-6(1) 	Store parameter 
121:    LDA  1,-4(1) 	Load address of new frame 
122:    LDA  3,1(7) 	Return address in ac 
123:    LDA  7,-118(7) 	CALL output
124:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
125:     ST  1,-4(1) 	Store old fp in ghost frame 
126:    LDA  1,-4(1) 	Load address of new frame 
127:    LDA  3,1(7) 	Return address in ac 
128:    LDA  7,-104(7) 	CALL outnl
129:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
130:     LD  3,-3(1) 	load lhs variable y
131:    LDA  3,1(3) 	increment value of y
132:     ST  3,-3(1) 	Store variable y
* END compound statement
133:    LDA  7,-33(7) 	go to beginning of loop 
110:    LDA  7,23(7) 	No more loop 
* ENDWHILE
* ELSE
100:    LDA  7,34(7) 	Jump around the THEN 
* BEGIN compound statement
* EXPRESSION STMT
135:    LDC  3,1(6) 	Load constant 
136:     ST  3,-3(1) 	Store variable y
* EXPRESSION STMT
137:     LD  3,-2(1) 	load lhs variable x
138:    LDA  3,1(3) 	increment value of x
139:     ST  3,-2(1) 	Store variable x
* END compound statement
134:    LDA  7,5(7) 	Jump around the ELSE 
* ENDIF
140:    LDA  7,-60(7) 	go to beginning of loop 
 90:    LDA  7,50(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
141:     ST  1,-4(1) 	Store old fp in ghost frame 
142:     LD  3,-2(1) 	Load variable x
143:     ST  3,-6(1) 	Store parameter 
144:    LDA  1,-4(1) 	Load address of new frame 
145:    LDA  3,1(7) 	Return address in ac 
146:    LDA  7,-141(7) 	CALL output
147:    LDA  3,0(2) 	Save the result in ac 
* RETURN
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
* END of function main
  0:    LDA  7,155(7) 	Jump to init 
* BEGIN Init
156:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
157:    LDA  1,0(0) 	set first frame at end of globals 
158:     ST  1,0(1) 	store old fp (point to self) 
159:    LDA  3,1(7) 	Return address in ac 
160:    LDA  7,-131(7) 	Jump to main 
161:   HALT  0,0,0 	DONE! 
* END Init
