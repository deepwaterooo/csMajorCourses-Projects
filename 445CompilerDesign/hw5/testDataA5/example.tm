* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  example.c-
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
* BEGIN function cat
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 31:    LDC  3,10(6) 	load size of array s
 32:     ST  3,-5(1) 	save size of array s
* EXPRESSION STMT
 33:     LD  3,-2(1) 	Load variable p
 34:     ST  3,0(0) 	Store variable g
* EXPRESSION STMT
 35:     LD  3,-2(1) 	Load variable p
 36:     ST  3,-2(1) 	Store variable p
* EXPRESSION STMT
 37:     LD  3,-4(1) 	Load variable r
 38:     ST  3,-4(1) 	Store variable r
* EXPRESSION STMT
 39:    LDC  3,100(6) 	Load constant 
 40:     ST  3,-16(1) 	Save index 
 41:    LDC  3,666(6) 	Load constant 
 42:     LD  4,-16(1) 	Restore index 
 43:    LDA  5,-6(1) 	Load address of base of array s
 44:    SUB  5,5,4 	Compute offset of value 
 45:     ST  3,0(5) 	Store variable s
* EXPRESSION STMT
 46:    LDC  3,101(6) 	Load constant 
 47:     ST  3,-16(1) 	Save index 
 48:    LDC  3,102(6) 	Load constant 
 49:    LDA  4,-6(1) 	Load address of base of array s
 50:    SUB  3,4,3 	Compute offset of value 
 51:     LD  3,0(3) 	Load the value 
 52:     LD  4,-16(1) 	Restore index 
 53:    LDA  5,-6(1) 	Load address of base of array s
 54:    SUB  5,5,4 	Compute offset of value 
 55:     ST  3,0(5) 	Store variable s
* EXPRESSION STMT
 56:    LDC  3,103(6) 	Load constant 
 57:     ST  3,-16(1) 	Save index 
 58:    LDC  3,104(6) 	Load constant 
 59:     LD  4,-3(1) 	Load address of base of array q
 60:    SUB  3,4,3 	Compute offset of value 
 61:     LD  3,0(3) 	Load the value 
 62:     LD  4,-16(1) 	Restore index 
 63:     LD  5,-3(1) 	Load address of base of array q
 64:    SUB  5,5,4 	Compute offset of value 
 65:     ST  3,0(5) 	Store variable q
* END compound statement
* Add standard closing in case there is no return statement
 66:    LDC  2,0(6) 	Set return value to 0 
 67:     LD  3,-1(1) 	Load return address 
 68:     LD  1,0(1) 	Adjust fp 
 69:    LDA  7,0(3) 	Return 
* END of function cat
* BEGIN function dog
 70:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
 71:     LD  3,-2(1) 	Load variable a
 72:     ST  3,-4(1) 	Save left side 
 73:     LD  3,-3(1) 	Load variable b
 74:     LD  4,-4(1) 	Load left into ac1 
 75:    ADD  3,4,3 	Op + 
 76:    LDA  2,0(3) 	Copy result to rt register 
 77:     LD  3,-1(1) 	Load return address 
 78:     LD  1,0(1) 	Adjust fp 
 79:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 80:    LDC  2,0(6) 	Set return value to 0 
 81:     LD  3,-1(1) 	Load return address 
 82:     LD  1,0(1) 	Adjust fp 
 83:    LDA  7,0(3) 	Return 
* END of function dog
* BEGIN function main
 84:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 85:    LDC  3,111(6) 	Load constant 
 86:     ST  3,-4(1) 	Save left side 
 87:    LDC  3,222(6) 	Load constant 
 88:     LD  4,-4(1) 	Load left into ac1 
 89:    MUL  3,4,3 	Op * 
 90:     ST  3,-4(1) 	Save left side 
 91:    LDC  3,333(6) 	Load constant 
 92:     ST  3,-5(1) 	Save left side 
 93:    LDC  3,444(6) 	Load constant 
 94:     LD  4,-5(1) 	Load left into ac1 
 95:    MUL  3,4,3 	Op * 
 96:     LD  4,-4(1) 	Load left into ac1 
 97:    ADD  3,4,3 	Op + 
 98:     ST  3,-3(1) 	Store variable y
 99:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
100:    LDC  3,111(6) 	Load constant 
101:     ST  3,-4(1) 	Save left side 
102:    LDC  3,222(6) 	Load constant 
103:     ST  3,-5(1) 	Save left side 
104:    LDC  3,333(6) 	Load constant 
105:     ST  3,-6(1) 	Save left side 
106:    LDC  3,444(6) 	Load constant 
107:     ST  3,-7(1) 	Save left side 
108:    LDC  3,555(6) 	Load constant 
109:     LD  4,-7(1) 	Load left into ac1 
110:    SUB  3,4,3 	Op - 
111:     LD  4,-6(1) 	Load left into ac1 
112:    DIV  3,4,3 	Op / 
113:     LD  4,-5(1) 	Load left into ac1 
114:    MUL  3,4,3 	Op * 
115:     LD  4,-4(1) 	Load left into ac1 
116:    ADD  3,4,3 	Op + 
117:     ST  3,-3(1) 	Store variable y
* EXPRESSION STMT
118:     ST  1,-4(1) 	Store old fp in ghost frame 
119:     LD  3,-2(1) 	Load variable x
120:     ST  3,-6(1) 	Store parameter 
121:     LD  3,-3(1) 	Load variable y
122:     ST  3,-7(1) 	Store parameter 
123:    LDA  1,-4(1) 	Load address of new frame 
124:    LDA  3,1(7) 	Return address in ac 
125:    LDA  7,-56(7) 	CALL dog
126:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
127:     ST  1,-4(1) 	Store old fp in ghost frame 
128:     ST  1,-6(1) 	Store old fp in ghost frame 
129:     LD  3,-2(1) 	Load variable x
130:     ST  3,-8(1) 	Store parameter 
131:     LD  3,-3(1) 	Load variable y
132:     ST  3,-9(1) 	Store parameter 
133:    LDA  1,-6(1) 	Load address of new frame 
134:    LDA  3,1(7) 	Return address in ac 
135:    LDA  7,-66(7) 	CALL dog
136:    LDA  3,0(2) 	Save the result in ac 
137:     ST  3,-6(1) 	Store parameter 
138:    LDC  3,666(6) 	Load constant 
139:     ST  3,-7(1) 	Store parameter 
140:    LDA  1,-4(1) 	Load address of new frame 
141:    LDA  3,1(7) 	Return address in ac 
142:    LDA  7,-73(7) 	CALL dog
143:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
144:    LDC  2,0(6) 	Set return value to 0 
145:     LD  3,-1(1) 	Load return address 
146:     LD  1,0(1) 	Adjust fp 
147:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,147(7) 	Jump to init 
* BEGIN Init
148:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
149:    LDA  1,-1(0) 	set first frame at end of globals 
150:     ST  1,0(1) 	store old fp (point to self) 
151:    LDA  3,1(7) 	Return address in ac 
152:    LDA  7,-69(7) 	Jump to main 
153:   HALT  0,0,0 	DONE! 
* END Init
