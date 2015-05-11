* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  d02.tm
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
 31:    LDC  3,755(6) 	Load constant 
 32:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 33:    LDC  3,88(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 35:    LDC  3,3(6) 	Load constant 
 36:     ST  3,-3(1) 	Store variable z
* EXPRESSION STMT
 37:     ST  1,-4(1) 	Store old frame in ghost frame 
 38:    LDC  3,755(6) 	Load constant 
 39:     ST  3,-6(1) 	Save left side 
 40:    LDC  3,88(6) 	Load constant 
 41:     ST  3,-7(1) 	Save left side 
 42:    LDC  3,3(6) 	Load constant 
 43:     LD  4,-7(1) 	Load left into ac1 
 44:    MUL  3,4,3 	Op * 
 45:     LD  4,-6(1) 	Load left into ac1 
 46:    ADD  3,4,3 	Op + 
 47:     ST  3,-6(1) 	Store parameter 
 48:    LDA  1,-4(1) 	Load address of new frame 
 49:    LDA  3,1(7) 	Return address in ac 
 50:    LDA  7,-45(7) 	CALL output
 51:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 52:     ST  1,-4(1) 	Store old frame in ghost frame 
 53:    LDC  3,755(6) 	Load constant 
 54:     ST  3,-6(1) 	Save left side 
 55:    LDC  3,88(6) 	Load constant 
 56:     LD  4,-6(1) 	Load left into ac1 
 57:    MUL  3,4,3 	Op * 
 58:     ST  3,-6(1) 	Save left side 
 59:    LDC  3,3(6) 	Load constant 
 60:     LD  4,-6(1) 	Load left into ac1 
 61:    ADD  3,4,3 	Op + 
 62:     ST  3,-6(1) 	Store parameter 
 63:    LDA  1,-4(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-60(7) 	CALL output
 66:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 67:     ST  1,-4(1) 	Store old frame in ghost frame 
 68:    LDC  3,755(6) 	Load constant 
 69:     ST  3,-6(1) 	Save left side 
 70:    LDC  3,88(6) 	Load constant 
 71:     LD  4,-6(1) 	Load left into ac1 
 72:    SUB  3,4,3 	Op - 
 73:     ST  3,-6(1) 	Save left side 
 74:    LDC  3,3(6) 	Load constant 
 75:     LD  4,-6(1) 	Load left into ac1 
 76:    SUB  3,4,3 	Op - 
 77:     ST  3,-6(1) 	Store parameter 
 78:    LDA  1,-4(1) 	Load address of new frame 
 79:    LDA  3,1(7) 	Return address in ac 
 80:    LDA  7,-75(7) 	CALL output
 81:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 82:     ST  1,-4(1) 	Store old frame in ghost frame 
 83:    LDC  3,755(6) 	Load constant 
 84:     ST  3,-6(1) 	Save left side 
 85:    LDC  3,88(6) 	Load constant 
 86:     LD  4,-6(1) 	Load left into ac1 
 87:    DIV  3,4,3 	Op / 
 88:     ST  3,-6(1) 	Save left side 
 89:    LDC  3,3(6) 	Load constant 
 90:     LD  4,-6(1) 	Load left into ac1 
 91:    DIV  3,4,3 	Op / 
 92:     ST  3,-6(1) 	Store parameter 
 93:    LDA  1,-4(1) 	Load address of new frame 
 94:    LDA  3,1(7) 	Return address in ac 
 95:    LDA  7,-90(7) 	CALL output
 96:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 97:     ST  1,-4(1) 	Store old frame in ghost frame 
 98:    LDC  3,755(6) 	Load constant 
 99:     ST  3,-6(1) 	Save left side 
100:    LDC  3,88(6) 	Load constant 
101:     LD  4,-6(1) 	Load left into ac1 
102:    MUL  3,4,3 	Op * 
103:     ST  3,-6(1) 	Save left side 
104:    LDC  3,3(6) 	Load constant 
105:     ST  3,-7(1) 	Save left side 
106:    LDC  3,3(6) 	Load constant 
107:     LD  4,-7(1) 	Load left into ac1 
108:    MUL  3,4,3 	Op * 
109:     LD  4,-6(1) 	Load left into ac1 
110:    ADD  3,4,3 	Op + 
111:     ST  3,-6(1) 	Store parameter 
112:    LDA  1,-4(1) 	Load address of new frame 
113:    LDA  3,1(7) 	Return address in ac 
114:    LDA  7,-109(7) 	CALL output
115:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
116:     ST  1,-4(1) 	Store old frame in ghost frame 
117:    LDC  3,755(6) 	Load constant 
118:     ST  3,-6(1) 	Save left side 
119:    LDC  3,88(6) 	Load constant 
120:     LD  4,-6(1) 	Load left into ac1 
121:     ST  3,-6(1) 	Save left side 
122:    LDC  3,3(6) 	Load constant 
123:     LD  4,-6(1) 	Load left into ac1 
124:     ST  3,-6(1) 	Store parameter 
125:    LDA  1,-4(1) 	Load address of new frame 
126:    LDA  3,1(7) 	Return address in ac 
127:    LDA  7,-122(7) 	CALL output
128:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
129:     ST  1,-4(1) 	Store old frame in ghost frame 
130:    LDC  3,755(6) 	Load constant 
131:    LDC  4,0(6) 	Load 0 
132:    SUB  3,4,3 	Op unary - 
133:     ST  3,-6(1) 	Save left side 
134:    LDC  3,88(6) 	Load constant 
135:     ST  3,-7(1) 	Save left side 
136:    LDC  3,3(6) 	Load constant 
137:     LD  4,-7(1) 	Load left into ac1 
138:    MUL  3,4,3 	Op * 
139:     LD  4,-6(1) 	Load left into ac1 
140:    ADD  3,4,3 	Op + 
141:     ST  3,-6(1) 	Store parameter 
142:    LDA  1,-4(1) 	Load address of new frame 
143:    LDA  3,1(7) 	Return address in ac 
144:    LDA  7,-139(7) 	CALL output
145:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
146:     ST  1,-4(1) 	Store old frame in ghost frame 
147:    LDA  1,-4(1) 	Load address of new frame 
148:    LDA  3,1(7) 	Return address in ac 
149:    LDA  7,-125(7) 	CALL outnl
150:    LDA  3,0(2) 	Save the result in ac 
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
