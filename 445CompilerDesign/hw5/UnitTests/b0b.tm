* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  b0b.tm
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
 31:     ST  1,-2(1) 	Store old frame in ghost frame 
 32:    LDC  3,0(6) 	Load constant 
 33:     ST  3,-4(1) 	Save left side 
 34:    LDC  3,0(6) 	Load constant 
 35:     LD  4,-4(1) 	Load left into ac1 
 36:     ST  3,-4(1) 	Store parameter 
 37:    LDA  1,-2(1) 	Load address of new frame 
 38:    LDA  3,1(7) 	Return address in ac 
 39:    LDA  7,-22(7) 	CALL outputb
 40:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 41:     ST  1,-2(1) 	Store old frame in ghost frame 
 42:    LDC  3,0(6) 	Load constant 
 43:     ST  3,-4(1) 	Save left side 
 44:    LDC  3,0(6) 	Load constant 
 45:     LD  4,-4(1) 	Load left into ac1 
 46:     ST  3,-4(1) 	Store parameter 
 47:    LDA  1,-2(1) 	Load address of new frame 
 48:    LDA  3,1(7) 	Return address in ac 
 49:    LDA  7,-32(7) 	CALL outputb
 50:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 51:     ST  1,-2(1) 	Store old frame in ghost frame 
 52:    LDC  3,0(6) 	Load constant 
 53:     ST  3,-4(1) 	Save left side 
 54:    LDC  3,0(6) 	Load constant 
 55:     LD  4,-4(1) 	Load left into ac1 
 56:     ST  3,-4(1) 	Store parameter 
 57:    LDA  1,-2(1) 	Load address of new frame 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-42(7) 	CALL outputb
 60:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 61:     ST  1,-2(1) 	Store old frame in ghost frame 
 62:    LDC  3,0(6) 	Load constant 
 63:     ST  3,-4(1) 	Save left side 
 64:    LDC  3,0(6) 	Load constant 
 65:     LD  4,-4(1) 	Load left into ac1 
 66:     ST  3,-4(1) 	Store parameter 
 67:    LDA  1,-2(1) 	Load address of new frame 
 68:    LDA  3,1(7) 	Return address in ac 
 69:    LDA  7,-52(7) 	CALL outputb
 70:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 71:     ST  1,-2(1) 	Store old frame in ghost frame 
 72:    LDC  3,0(6) 	Load constant 
 73:     ST  3,-4(1) 	Save left side 
 74:    LDC  3,0(6) 	Load constant 
 75:     LD  4,-4(1) 	Load left into ac1 
 76:    JEQ  3,1(7) 	Op AND 
 77:    LDA  3,0(4) 	 
 78:     ST  3,-4(1) 	Store parameter 
 79:    LDA  1,-2(1) 	Load address of new frame 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-64(7) 	CALL outputb
 82:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 83:     ST  1,-2(1) 	Store old frame in ghost frame 
 84:    LDC  3,0(6) 	Load constant 
 85:     ST  3,-4(1) 	Save left side 
 86:    LDC  3,0(6) 	Load constant 
 87:     LD  4,-4(1) 	Load left into ac1 
 88:    JEQ  3,1(7) 	Op AND 
 89:    LDA  3,0(4) 	 
 90:     ST  3,-4(1) 	Store parameter 
 91:    LDA  1,-2(1) 	Load address of new frame 
 92:    LDA  3,1(7) 	Return address in ac 
 93:    LDA  7,-76(7) 	CALL outputb
 94:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 95:     ST  1,-2(1) 	Store old frame in ghost frame 
 96:    LDC  3,0(6) 	Load constant 
 97:     ST  3,-4(1) 	Save left side 
 98:    LDC  3,0(6) 	Load constant 
 99:     LD  4,-4(1) 	Load left into ac1 
100:    JEQ  3,1(7) 	Op AND 
101:    LDA  3,0(4) 	 
102:     ST  3,-4(1) 	Store parameter 
103:    LDA  1,-2(1) 	Load address of new frame 
104:    LDA  3,1(7) 	Return address in ac 
105:    LDA  7,-88(7) 	CALL outputb
106:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
107:     ST  1,-2(1) 	Store old frame in ghost frame 
108:    LDC  3,0(6) 	Load constant 
109:     ST  3,-4(1) 	Save left side 
110:    LDC  3,0(6) 	Load constant 
111:     LD  4,-4(1) 	Load left into ac1 
112:    JEQ  3,1(7) 	Op AND 
113:    LDA  3,0(4) 	 
114:     ST  3,-4(1) 	Store parameter 
115:    LDA  1,-2(1) 	Load address of new frame 
116:    LDA  3,1(7) 	Return address in ac 
117:    LDA  7,-100(7) 	CALL outputb
118:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
119:     ST  1,-2(1) 	Store old frame in ghost frame 
120:    LDC  3,0(6) 	Load constant 
121:     ST  3,-4(1) 	Store parameter 
122:    LDA  1,-2(1) 	Load address of new frame 
123:    LDA  3,1(7) 	Return address in ac 
124:    LDA  7,-107(7) 	CALL outputb
125:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
126:     ST  1,-2(1) 	Store old frame in ghost frame 
127:    LDC  3,0(6) 	Load constant 
128:     ST  3,-4(1) 	Store parameter 
129:    LDA  1,-2(1) 	Load address of new frame 
130:    LDA  3,1(7) 	Return address in ac 
131:    LDA  7,-114(7) 	CALL outputb
132:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
133:     ST  1,-2(1) 	Store old frame in ghost frame 
134:    LDA  1,-2(1) 	Load address of new frame 
135:    LDA  3,1(7) 	Return address in ac 
136:    LDA  7,-112(7) 	CALL outnl
137:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
138:    LDC  2,0(6) 	Set return value to 0 
139:     LD  3,-1(1) 	Load return address 
140:     LD  1,0(1) 	Adjust fp 
141:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,141(7) 	Jump to init 
* BEGIN Init
142:     LD  0,0(0) 	Set the global pointer 
143:    LDA  1,0(0) 	set first frame at end of globals 
144:     ST  1,0(1) 	store old fp (point to self) 
145:    LDA  3,1(7) 	Return address in ac 
146:    LDA  7,-117(7) 	Jump to main 
147:   HALT  0,0,0 	DONE! 
* END Init
