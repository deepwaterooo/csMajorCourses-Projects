* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  comb.tm
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
* EXPRESSION STMT
 31:     LD  3,-2(1) 	Load variable n
 32:     ST  3,-6(1) 	Save left side 
 33:     LD  3,-3(1) 	Load variable r
 34:     LD  4,-6(1) 	Load left into ac1 
 35:    SUB  3,4,3 	Op - 
 36:     ST  3,-6(1) 	Save left side 
 37:    LDC  3,1(6) 	Load constant 
 38:     LD  4,-6(1) 	Load left into ac1 
 39:    ADD  3,4,3 	Op + 
 40:     ST  3,-5(1) 	Store variable c
* EXPRESSION STMT
 41:     LD  3,-2(1) 	Load variable n
 42:     ST  3,-6(1) 	Save left side 
 43:     LD  3,-3(1) 	Load variable r
 44:     LD  4,-6(1) 	Load left into ac1 
 45:    SUB  3,4,3 	Op - 
 46:     ST  3,-6(1) 	Save left side 
 47:    LDC  3,2(6) 	Load constant 
 48:     LD  4,-6(1) 	Load left into ac1 
 49:    ADD  3,4,3 	Op + 
 50:     ST  3,0(1) 	Store variable i
* EXPRESSION STMT
 51:    LDC  3,2(6) 	Load constant 
 52:     ST  3,-4(1) 	Store variable j
* WHILE
 53:     LD  3,0(1) 	Load variable i
 54:     ST  3,-6(1) 	Save left side 
 55:     LD  3,-2(1) 	Load variable n
 56:     LD  4,-6(1) 	Load left into ac1 
 57:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 59:     LD  3,-5(1) 	Load variable c
 60:     ST  3,-6(1) 	Save left side 
 61:     LD  3,0(1) 	Load variable i
 62:     LD  4,-6(1) 	Load left into ac1 
 63:    MUL  3,4,3 	Op * 
 64:     ST  3,-6(1) 	Save left side 
 65:     LD  3,-4(1) 	Load variable j
 66:     LD  4,-6(1) 	Load left into ac1 
 67:    DIV  3,4,3 	Op / 
 68:     ST  3,-5(1) 	Store variable c
* EXPRESSION STMT
 69:     ST  3,0(1) 	Store variable i
* EXPRESSION STMT
 70:     ST  3,-4(1) 	Store variable j
* END compound statement
 71:    LDA  7,-19(7) 	go to beginning of loop 
 58:    LDA  7,13(7) 	No more loop 
* ENDWHILE
* RETURN
 72:     LD  3,-5(1) 	Load variable c
 73:    LDA  2,0(3) 	Copy result to rt register 
 74:     LD  3,-1(1) 	Load return address 
 75:     LD  1,0(1) 	Adjust fp 
 76:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 77:    LDC  2,0(6) 	Set return value to 0 
 78:     LD  3,-1(1) 	Load return address 
 79:     LD  1,0(1) 	Adjust fp 
 80:    LDA  7,0(3) 	Return 
* END function comb
* BEGIN function main
 81:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 82:    LDC  3,15(6) 	Load constant 
 83:     ST  3,-2(1) 	Store variable max
* EXPRESSION STMT
 84:    LDC  3,2(6) 	Load constant 
 85:     ST  3,-2(1) 	Store variable n
* WHILE
 86:     LD  3,-2(1) 	Load variable n
 87:     ST  3,-5(1) 	Save left side 
 88:     LD  3,-2(1) 	Load variable max
 89:     LD  4,-5(1) 	Load left into ac1 
 90:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 92:    LDC  3,2(6) 	Load constant 
 93:     ST  3,-4(1) 	Store variable r
* WHILE
 94:     LD  3,-4(1) 	Load variable r
 95:     ST  3,-5(1) 	Save left side 
 96:     LD  3,-2(1) 	Load variable n
 97:     ST  3,-6(1) 	Save left side 
 98:    LDC  3,2(6) 	Load constant 
 99:     LD  4,-6(1) 	Load left into ac1 
100:    DIV  3,4,3 	Op / 
101:     LD  4,-5(1) 	Load left into ac1 
102:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
104:     ST  1,-5(1) 	Store old frame in ghost frame 
105:     LD  3,-2(1) 	Load variable n
106:     ST  3,-7(1) 	Store parameter 
107:    LDA  1,-5(1) 	Load address of new frame 
108:    LDA  3,1(7) 	Return address in ac 
109:    LDA  7,-104(7) 	CALL output
110:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
111:     ST  1,-5(1) 	Store old frame in ghost frame 
112:     LD  3,-4(1) 	Load variable r
113:     ST  3,-7(1) 	Store parameter 
114:    LDA  1,-5(1) 	Load address of new frame 
115:    LDA  3,1(7) 	Return address in ac 
116:    LDA  7,-111(7) 	CALL output
117:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
118:     ST  1,-5(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
119:     ST  1,-7(1) 	Store old frame in ghost frame 
120:     LD  3,-2(1) 	Load variable n
121:     ST  3,-9(1) 	Store parameter 
122:     LD  3,-4(1) 	Load variable r
123:     ST  3,-10(1) 	Store parameter 
124:    LDA  1,-7(1) 	Load address of new frame 
125:    LDA  3,1(7) 	Return address in ac 
126:    LDA  7,-97(7) 	CALL comb
127:    LDA  3,0(2) 	Save the result in ac 
128:     ST  3,-7(1) 	Store parameter 
129:    LDA  1,-5(1) 	Load address of new frame 
130:    LDA  3,1(7) 	Return address in ac 
131:    LDA  7,-126(7) 	CALL output
132:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
133:     ST  1,-5(1) 	Store old frame in ghost frame 
134:    LDA  1,-5(1) 	Load address of new frame 
135:    LDA  3,1(7) 	Return address in ac 
136:    LDA  7,-112(7) 	CALL outnl
137:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
138:     ST  3,-4(1) 	Store variable r
* END compound statement
139:    LDA  7,-46(7) 	go to beginning of loop 
103:    LDA  7,36(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
140:     ST  3,-2(1) 	Store variable n
* END compound statement
141:    LDA  7,-56(7) 	go to beginning of loop 
103:    LDA  7,38(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
142:    LDC  2,0(6) 	Set return value to 0 
143:     LD  3,-1(1) 	Load return address 
144:     LD  1,0(1) 	Adjust fp 
145:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,145(7) 	Jump to init 
* BEGIN Init
146:     LD  0,0(0) 	Set the global pointer 
147:    LDA  1,0(0) 	set first frame at end of globals 
148:     ST  1,0(1) 	store old fp (point to self) 
149:    LDA  3,1(7) 	Return address in ac 
150:    LDA  7,-70(7) 	Jump to main 
151:   HALT  0,0,0 	DONE! 
* END Init
