* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  j00.tm
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
* BEGIN function cat
 30:     ST  3,-1(1) 	Store return address 
* RETURN
 31:     LD  3,-3(1) 	Load variable i
 32:     ST  3,-4(1) 	Save index 
 33:    LDA  2,0(3) 	Copy result to rt register 
 34:     LD  3,-1(1) 	Load return address 
 35:     LD  1,0(1) 	Adjust fp 
 36:    LDA  7,0(3) 	Return 
* Add standard closing in case there is no return statement
 37:    LDC  2,0(6) 	Set return value to 0 
 38:     LD  3,-1(1) 	Load return address 
 39:     LD  1,0(1) 	Adjust fp 
 40:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function dog
 41:     ST  3,-1(1) 	Store return address 
* RETURN
* EXPRESSION STMT
 42:     ST  1,-4(1) 	Store old frame in ghost frame 
 43:     LD  3,-2(1) 	Load variable x
 44:     ST  3,-6(1) 	Store parameter 
 45:     LD  3,-3(1) 	Load variable i
 46:     ST  3,-7(1) 	Store parameter 
 47:    LDA  1,-4(1) 	Load address of new frame 
 48:    LDA  3,1(7) 	Return address in ac 
 49:    LDA  7,-20(7) 	CALL cat
 50:    LDA  3,0(2) 	Save the result in ac 
 51:    LDA  2,0(3) 	Copy result to rt register 
 52:     LD  3,-1(1) 	Load return address 
 53:     LD  1,0(1) 	Adjust fp 
 54:    LDA  7,0(3) 	Return 
* Add standard closing in case there is no return statement
 55:    LDC  2,0(6) 	Set return value to 0 
 56:     LD  3,-1(1) 	Load return address 
 57:     LD  1,0(1) 	Adjust fp 
 58:    LDA  7,0(3) 	Return 
* END function dog
* BEGIN function main
 59:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 60:    LDC  3,0(6) 	load size of array h
 61:     ST  3,-2(1) 	save size of array h
 62:    LDC  3,0(6) 	load size of array s
 63:     ST  3,-3(1) 	save size of array s
* EXPRESSION STMT
 64:    LDC  3,1(6) 	Load constant 
 65:     ST  3,0(1) 	Store variable i
* WHILE
 66:     LD  3,0(1) 	Load variable i
 67:     ST  3,-4(1) 	Save left side 
 68:    LDC  3,10(6) 	Load constant 
 69:     LD  4,-4(1) 	Load left into ac1 
 70:    SUB  4,4,3 	Op < 
 71:    LDC  3,1(6) 	True case 
 72:    JLT  4,1(7) 	Jump if true 
 73:    LDC  3,0(6) 	False case 
 74:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
 76:     LD  3,0(1) 	Load variable i
 77:     ST  3,-4(1) 	Save index 
* EXPRESSION STMT
 78:     LD  3,0(1) 	Load variable i
 79:     ST  3,-5(1) 	Save index 
* EXPRESSION STMT
 80:     LD  3,0(1) 	Load variable i
 81:     ST  3,-6(1) 	Save index 
* EXPRESSION STMT
 82:     ST  3,0(1) 	Store variable i
 83:     ST  3,-4(1) 	Store variable s
 84:     ST  3,0(1) 	Store variable g
 85:     ST  3,-3(1) 	Store variable h
 86:    LDA  7,-21(7) 	go to beginning of loop 
 75:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 87:     ST  1,-7(1) 	Store old frame in ghost frame 
 88:    LDC  3,6(6) 	Load constant 
 89:     ST  3,-9(1) 	Save index 
 90:     ST  3,-10(1) 	Store parameter 
 91:    LDA  1,-7(1) 	Load address of new frame 
 92:    LDA  3,1(7) 	Return address in ac 
 93:    LDA  7,-88(7) 	CALL output
 94:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 95:     ST  1,-7(1) 	Store old frame in ghost frame 
 96:    LDC  3,6(6) 	Load constant 
 97:     ST  3,-9(1) 	Save index 
 98:     ST  3,-10(1) 	Store parameter 
 99:    LDA  1,-7(1) 	Load address of new frame 
100:    LDA  3,1(7) 	Return address in ac 
101:    LDA  7,-96(7) 	CALL output
102:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
103:     ST  1,-7(1) 	Store old frame in ghost frame 
104:    LDC  3,6(6) 	Load constant 
105:     ST  3,-9(1) 	Save index 
106:     ST  3,-10(1) 	Store parameter 
107:    LDA  1,-7(1) 	Load address of new frame 
108:    LDA  3,1(7) 	Return address in ac 
109:    LDA  7,-104(7) 	CALL output
110:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
111:     ST  1,-7(1) 	Store old frame in ghost frame 
112:    LDA  1,-7(1) 	Load address of new frame 
113:    LDA  3,1(7) 	Return address in ac 
114:    LDA  7,-90(7) 	CALL outnl
115:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
116:     ST  1,-7(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
117:     ST  1,-9(1) 	Store old frame in ghost frame 
118:     LD  3,0(1) 	Load variable g
119:     ST  3,-11(1) 	Store parameter 
120:    LDC  3,6(6) 	Load constant 
121:     ST  3,-12(1) 	Store parameter 
122:    LDA  1,-9(1) 	Load address of new frame 
123:    LDA  3,1(7) 	Return address in ac 
124:    LDA  7,-95(7) 	CALL cat
125:    LDA  3,0(2) 	Save the result in ac 
126:     ST  3,-9(1) 	Store parameter 
127:    LDA  1,-7(1) 	Load address of new frame 
128:    LDA  3,1(7) 	Return address in ac 
129:    LDA  7,-124(7) 	CALL output
130:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
131:     ST  1,-7(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
132:     ST  1,-9(1) 	Store old frame in ghost frame 
133:     LD  3,-3(1) 	Load variable h
134:     ST  3,-11(1) 	Store parameter 
135:    LDC  3,6(6) 	Load constant 
136:     ST  3,-12(1) 	Store parameter 
137:    LDA  1,-9(1) 	Load address of new frame 
138:    LDA  3,1(7) 	Return address in ac 
139:    LDA  7,-110(7) 	CALL cat
140:    LDA  3,0(2) 	Save the result in ac 
141:     ST  3,-9(1) 	Store parameter 
142:    LDA  1,-7(1) 	Load address of new frame 
143:    LDA  3,1(7) 	Return address in ac 
144:    LDA  7,-139(7) 	CALL output
145:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
146:     ST  1,-7(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
147:     ST  1,-9(1) 	Store old frame in ghost frame 
148:     LD  3,-4(1) 	Load variable s
149:     ST  3,-11(1) 	Store parameter 
150:    LDC  3,6(6) 	Load constant 
151:     ST  3,-12(1) 	Store parameter 
152:    LDA  1,-9(1) 	Load address of new frame 
153:    LDA  3,1(7) 	Return address in ac 
154:    LDA  7,-125(7) 	CALL cat
155:    LDA  3,0(2) 	Save the result in ac 
156:     ST  3,-9(1) 	Store parameter 
157:    LDA  1,-7(1) 	Load address of new frame 
158:    LDA  3,1(7) 	Return address in ac 
159:    LDA  7,-154(7) 	CALL output
160:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
161:     ST  1,-7(1) 	Store old frame in ghost frame 
162:    LDA  1,-7(1) 	Load address of new frame 
163:    LDA  3,1(7) 	Return address in ac 
164:    LDA  7,-140(7) 	CALL outnl
165:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
166:     ST  1,-7(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
167:     ST  1,-9(1) 	Store old frame in ghost frame 
168:     LD  3,0(1) 	Load variable g
169:     ST  3,-11(1) 	Store parameter 
170:    LDC  3,6(6) 	Load constant 
171:     ST  3,-12(1) 	Store parameter 
172:    LDA  1,-9(1) 	Load address of new frame 
173:    LDA  3,1(7) 	Return address in ac 
174:    LDA  7,-134(7) 	CALL dog
175:    LDA  3,0(2) 	Save the result in ac 
176:     ST  3,-9(1) 	Store parameter 
177:    LDA  1,-7(1) 	Load address of new frame 
178:  