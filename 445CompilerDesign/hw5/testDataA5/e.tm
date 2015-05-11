* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  e.c-
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
 31:     ST  1,-2(1) 	Store old fp in ghost frame 
 32:    LDC  3,111(6) 	Load constant 
 33:     ST  3,-4(1) 	Save left side 
 34:    LDC  3,222(6) 	Load constant 
 35:     ST  3,-5(1) 	Save left side 
 36:    LDC  3,333(6) 	Load constant 
 37:     ST  3,-6(1) 	Save left side 
 38:    LDC  3,444(6) 	Load constant 
 39:     LD  4,-6(1) 	Load left into ac1 
 40:    ADD  3,4,3 	Op + 
 41:     LD  4,-5(1) 	Load left into ac1 
 42:    ADD  3,4,3 	Op + 
 43:     LD  4,-4(1) 	Load left into ac1 
 44:    ADD  3,4,3 	Op + 
 45:     ST  3,-4(1) 	Store parameter 
 46:    LDA  1,-2(1) 	Load address of new frame 
 47:    LDA  3,1(7) 	Return address in ac 
 48:    LDA  7,-43(7) 	CALL output
 49:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 50:     ST  1,-2(1) 	Store old fp in ghost frame 
 51:    LDA  1,-2(1) 	Load address of new frame 
 52:    LDA  3,1(7) 	Return address in ac 
 53:    LDA  7,-29(7) 	CALL outnl
 54:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 55:     ST  1,-2(1) 	Store old fp in ghost frame 
 56:    LDC  3,111(6) 	Load constant 
 57:     ST  3,-4(1) 	Save left side 
 58:    LDC  3,222(6) 	Load constant 
 59:     LD  4,-4(1) 	Load left into ac1 
 60:    ADD  3,4,3 	Op + 
 61:     ST  3,-4(1) 	Save left side 
 62:    LDC  3,333(6) 	Load constant 
 63:     LD  4,-4(1) 	Load left into ac1 
 64:    ADD  3,4,3 	Op + 
 65:     ST  3,-4(1) 	Save left side 
 66:    LDC  3,444(6) 	Load constant 
 67:     LD  4,-4(1) 	Load left into ac1 
 68:    ADD  3,4,3 	Op + 
 69:     ST  3,-4(1) 	Store parameter 
 70:    LDA  1,-2(1) 	Load address of new frame 
 71:    LDA  3,1(7) 	Return address in ac 
 72:    LDA  7,-67(7) 	CALL output
 73:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 74:     ST  1,-2(1) 	Store old fp in ghost frame 
 75:    LDA  1,-2(1) 	Load address of new frame 
 76:    LDA  3,1(7) 	Return address in ac 
 77:    LDA  7,-53(7) 	CALL outnl
 78:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 79:     ST  1,-2(1) 	Store old fp in ghost frame 
 80:    LDC  3,111(6) 	Load constant 
 81:     ST  3,-4(1) 	Save left side 
 82:    LDC  3,222(6) 	Load constant 
 83:     ST  3,-5(1) 	Save left side 
 84:    LDC  3,333(6) 	Load constant 
 85:     ST  3,-6(1) 	Save left side 
 86:    LDC  3,444(6) 	Load constant 
 87:     LD  4,-6(1) 	Load left into ac1 
 88:    SUB  3,4,3 	Op - 
 89:     LD  4,-5(1) 	Load left into ac1 
 90:    SUB  3,4,3 	Op - 
 91:     LD  4,-4(1) 	Load left into ac1 
 92:    SUB  3,4,3 	Op - 
 93:     ST  3,-4(1) 	Store parameter 
 94:    LDA  1,-2(1) 	Load address of new frame 
 95:    LDA  3,1(7) 	Return address in ac 
 96:    LDA  7,-91(7) 	CALL output
 97:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 98:     ST  1,-2(1) 	Store old fp in ghost frame 
 99:    LDA  1,-2(1) 	Load address of new frame 
100:    LDA  3,1(7) 	Return address in ac 
101:    LDA  7,-77(7) 	CALL outnl
102:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
103:     ST  1,-2(1) 	Store old fp in ghost frame 
104:    LDC  3,111(6) 	Load constant 
105:     ST  3,-4(1) 	Save left side 
106:    LDC  3,222(6) 	Load constant 
107:     LD  4,-4(1) 	Load left into ac1 
108:    SUB  3,4,3 	Op - 
109:     ST  3,-4(1) 	Save left side 
110:    LDC  3,333(6) 	Load constant 
111:     LD  4,-4(1) 	Load left into ac1 
112:    SUB  3,4,3 	Op - 
113:     ST  3,-4(1) 	Save left side 
114:    LDC  3,444(6) 	Load constant 
115:     LD  4,-4(1) 	Load left into ac1 
116:    SUB  3,4,3 	Op - 
117:     ST  3,-4(1) 	Store parameter 
118:    LDA  1,-2(1) 	Load address of new frame 
119:    LDA  3,1(7) 	Return address in ac 
120:    LDA  7,-115(7) 	CALL output
121:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
122:     ST  1,-2(1) 	Store old fp in ghost frame 
123:    LDA  1,-2(1) 	Load address of new frame 
124:    LDA  3,1(7) 	Return address in ac 
125:    LDA  7,-101(7) 	CALL outnl
126:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
127:     ST  1,-2(1) 	Store old fp in ghost frame 
128:    LDC  3,111(6) 	Load constant 
129:     ST  3,-4(1) 	Save left side 
130:    LDC  3,222(6) 	Load constant 
131:     LD  4,-4(1) 	Load left into ac1 
132:    SUB  3,4,3 	Op - 
133:     ST  3,-4(1) 	Save left side 
134:    LDC  3,333(6) 	Load constant 
135:     LD  4,-4(1) 	Load left into ac1 
136:    SUB  3,4,3 	Op - 
137:     ST  3,-4(1) 	Save left side 
138:    LDC  3,444(6) 	Load constant 
139:     LD  4,-4(1) 	Load left into ac1 
140:    SUB  3,4,3 	Op - 
141:     ST  3,-4(1) 	Store parameter 
142:    LDA  1,-2(1) 	Load address of new frame 
143:    LDA  3,1(7) 	Return address in ac 
144:    LDA  7,-139(7) 	CALL output
145:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
146:     ST  1,-2(1) 	Store old fp in ghost frame 
147:    LDA  1,-2(1) 	Load address of new frame 
148:    LDA  3,1(7) 	Return address in ac 
149:    LDA  7,-125(7) 	CALL outnl
150:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
151:    LDC  2,0(6) 	Set return value to 0 
152:     LD  3,-1(1) 	Load return address 
153:     LD  1,0(1) 	Adjust fp 
154:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,154(7) 	Jump to init 
* BEGIN Init
155:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
156:    LDA  1,0(0) 	set first frame at end of globals 
157:     ST  1,0(1) 	store old fp (point to self) 
158:    LDA  3,1(7) 	Return address in ac 
159:    LDA  7,-130(7) 	Jump to main 
160:   HALT  0,0,0 	DONE! 
* END Init
