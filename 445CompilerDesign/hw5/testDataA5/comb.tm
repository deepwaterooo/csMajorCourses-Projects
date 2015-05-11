* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  comb.c-
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
* EXPRESSION STMT
 31:    LDC  3,1(6) 	Load constant 
 32:     ST  3,-6(1) 	Store variable c
* EXPRESSION STMT
 33:     LD  3,-2(1) 	Load variable n
 34:     ST  3,-4(1) 	Store variable i
* EXPRESSION STMT
 35:    LDC  3,1(6) 	Load constant 
 36:     ST  3,-5(1) 	Store variable j
* WHILE
 37:     LD  3,-5(1) 	Load variable j
 38:     ST  3,-7(1) 	Save left side 
 39:     LD  3,-3(1) 	Load variable r
 40:     LD  4,-7(1) 	Load left into ac1 
 41:    SUB  4,4,3 	Op <= 
 42:    LDC  3,1(6) 	True case 
 43:    JLE  4,1(7) 	Jump if true 
 44:    LDC  3,0(6) 	False case 
 45:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 47:     LD  3,-6(1) 	Load variable c
 48:     ST  3,-7(1) 	Save left side 
 49:     LD  3,-4(1) 	Load variable i
 50:     LD  4,-7(1) 	Load left into ac1 
 51:    MUL  3,4,3 	Op * 
 52:     ST  3,-7(1) 	Save left side 
 53:     LD  3,-5(1) 	Load variable j
 54:     LD  4,-7(1) 	Load left into ac1 
 55:    DIV  3,4,3 	Op / 
 56:     ST  3,-6(1) 	Store variable c
* EXPRESSION STMT
 57:     LD  3,-4(1) 	load lhs variable i
 58:    LDA  3,-1(3) 	decrement value of i
 59:     ST  3,-4(1) 	Store variable i
* EXPRESSION STMT
 60:     LD  3,-5(1) 	load lhs variable j
 61:    LDA  3,1(3) 	increment value of j
 62:     ST  3,-5(1) 	Store variable j
* END compound statement
 63:    LDA  7,-27(7) 	go to beginning of loop 
 46:    LDA  7,17(7) 	No more loop 
* ENDWHILE
* RETURN
 64:     LD  3,-6(1) 	Load variable c
 65:    LDA  2,0(3) 	Copy result to rt register 
 66:     LD  3,-1(1) 	Load return address 
 67:     LD  1,0(1) 	Adjust fp 
 68:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 69:    LDC  2,0(6) 	Set return value to 0 
 70:     LD  3,-1(1) 	Load return address 
 71:     LD  1,0(1) 	Adjust fp 
 72:    LDA  7,0(3) 	Return 
* END of function comb
* BEGIN function main
 73:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 74:    LDC  3,20(6) 	Load constant 
 75:     ST  3,-2(1) 	Store variable max
* EXPRESSION STMT
 76:    LDC  3,1(6) 	Load constant 
 77:     ST  3,-3(1) 	Store variable n
* WHILE
 78:     LD  3,-3(1) 	Load variable n
 79:     ST  3,-6(1) 	Save left side 
 80:     LD  3,-2(1) 	Load variable max
 81:     LD  4,-6(1) 	Load left into ac1 
 82:    SUB  4,4,3 	Op <= 
 83:    LDC  3,1(6) 	True case 
 84:    JLE  4,1(7) 	Jump if true 
 85:    LDC  3,0(6) 	False case 
 86:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 88:    LDC  3,0(6) 	Load constant 
 89:     ST  3,-5(1) 	Store variable r
* WHILE
 90:     LD  3,-5(1) 	Load variable r
 91:     ST  3,-6(1) 	Save left side 
 92:     LD  3,-3(1) 	Load variable n
 93:     LD  4,-6(1) 	Load left into ac1 
 94:    SUB  4,4,3 	Op <= 
 95:    LDC  3,1(6) 	True case 
 96:    JLE  4,1(7) 	Jump if true 
 97:    LDC  3,0(6) 	False case 
 98:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
100:     ST  1,-6(1) 	Store old fp in ghost frame 
101:     ST  1,-8(1) 	Store old fp in ghost frame 
102:     LD  3,-3(1) 	Load variable n
103:     ST  3,-10(1) 	Store parameter 
104:     LD  3,-5(1) 	Load variable r
105:     ST  3,-11(1) 	Store parameter 
106:    LDA  1,-8(1) 	Load address of new frame 
107:    LDA  3,1(7) 	Return address in ac 
108:    LDA  7,-79(7) 	CALL comb
109:    LDA  3,0(2) 	Save the result in ac 
110:     ST  3,-8(1) 	Store parameter 
111:    LDA  1,-6(1) 	Load address of new frame 
112:    LDA  3,1(7) 	Return address in ac 
113:    LDA  7,-108(7) 	CALL output
114:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
115:     LD  3,-5(1) 	load lhs variable r
116:    LDA  3,1(3) 	increment value of r
117:     ST  3,-5(1) 	Store variable r
* END compound statement
118:    LDA  7,-29(7) 	go to beginning of loop 
 99:    LDA  7,19(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
119:     ST  1,-6(1) 	Store old fp in ghost frame 
120:    LDA  1,-6(1) 	Load address of new frame 
121:    LDA  3,1(7) 	Return address in ac 
122:    LDA  7,-98(7) 	CALL outnl
123:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
124:     LD  3,-3(1) 	load lhs variable n
125:    LDA  3,1(3) 	increment value of n
126:     ST  3,-3(1) 	Store variable n
* END compound statement
127:    LDA  7,-50(7) 	go to beginning of loop 
 87:    LDA  7,40(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
128:    LDC  2,0(6) 	Set return value to 0 
129:     LD  3,-1(1) 	Load return address 
130:     LD  1,0(1) 	Adjust fp 
131:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,131(7) 	Jump to init 
* BEGIN Init
132:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
133:    LDA  1,0(0) 	set first frame at end of globals 
134:     ST  1,0(1) 	store old fp (point to self) 
135:    LDA  3,1(7) 	Return address in ac 
136:    LDA  7,-64(7) 	Jump to main 
137:   HALT  0,0,0 	DONE! 
* END Init
