* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  ainit.c-
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
 31:    LDC  3,11(6) 	load size of array m
 32:     ST  3,-2(1) 	save size of array m
* EXPRESSION STMT
 33:    LDC  3,0(6) 	Load constant 
 34:     ST  3,-41(1) 	Save index 
 35:    LDC  3,111(6) 	Load constant 
 36:     LD  4,-41(1) 	Restore index 
 37:    LDA  5,-3(1) 	Load address of base of array m
 38:    SUB  5,5,4 	Compute offset of value 
 39:     ST  3,0(5) 	Store variable m
* BEGIN compound statement
 40:    LDC  3,12(6) 	load size of array c
 41:     ST  3,-14(1) 	save size of array c
* EXPRESSION STMT
 42:    LDC  3,0(6) 	Load constant 
 43:     ST  3,-41(1) 	Save index 
 44:    LDC  3,222(6) 	Load constant 
 45:     LD  4,-41(1) 	Restore index 
 46:    LDA  5,-15(1) 	Load address of base of array c
 47:    SUB  5,5,4 	Compute offset of value 
 48:     ST  3,0(5) 	Store variable c
* EXPRESSION STMT
 49:     ST  1,-41(1) 	Store old fp in ghost frame 
 50:    LDA  3,-1(0) 	Load address of base of array g
 51:     LD  3,1(3) 	Load array size 
 52:     ST  3,-43(1) 	Store parameter 
 53:    LDA  1,-41(1) 	Load address of new frame 
 54:    LDA  3,1(7) 	Return address in ac 
 55:    LDA  7,-50(7) 	CALL output
 56:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 57:     ST  1,-41(1) 	Store old fp in ghost frame 
 58:    LDA  3,-3(1) 	Load address of base of array m
 59:     LD  3,1(3) 	Load array size 
 60:     ST  3,-43(1) 	Store parameter 
 61:    LDA  1,-41(1) 	Load address of new frame 
 62:    LDA  3,1(7) 	Return address in ac 
 63:    LDA  7,-58(7) 	CALL output
 64:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 65:     ST  1,-41(1) 	Store old fp in ghost frame 
 66:    LDA  3,-15(1) 	Load address of base of array c
 67:     LD  3,1(3) 	Load array size 
 68:     ST  3,-43(1) 	Store parameter 
 69:    LDA  1,-41(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-66(7) 	CALL output
 72:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 73:     ST  1,-41(1) 	Store old fp in ghost frame 
 74:    LDA  1,-41(1) 	Load address of new frame 
 75:    LDA  3,1(7) 	Return address in ac 
 76:    LDA  7,-52(7) 	CALL outnl
 77:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* BEGIN compound statement
 78:    LDC  3,13(6) 	load size of array d
 79:     ST  3,-27(1) 	save size of array d
* EXPRESSION STMT
 80:    LDC  3,0(6) 	Load constant 
 81:     ST  3,-41(1) 	Save index 
 82:    LDC  3,333(6) 	Load constant 
 83:     LD  4,-41(1) 	Restore index 
 84:    LDA  5,-28(1) 	Load address of base of array d
 85:    SUB  5,5,4 	Compute offset of value 
 86:     ST  3,0(5) 	Store variable d
* EXPRESSION STMT
 87:     ST  1,-41(1) 	Store old fp in ghost frame 
 88:    LDA  3,-1(0) 	Load address of base of array g
 89:     LD  3,1(3) 	Load array size 
 90:     ST  3,-43(1) 	Store parameter 
 91:    LDA  1,-41(1) 	Load address of new frame 
 92:    LDA  3,1(7) 	Return address in ac 
 93:    LDA  7,-88(7) 	CALL output
 94:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 95:     ST  1,-41(1) 	Store old fp in ghost frame 
 96:    LDA  3,-3(1) 	Load address of base of array m
 97:     LD  3,1(3) 	Load array size 
 98:     ST  3,-43(1) 	Store parameter 
 99:    LDA  1,-41(1) 	Load address of new frame 
100:    LDA  3,1(7) 	Return address in ac 
101:    LDA  7,-96(7) 	CALL output
102:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
103:     ST  1,-41(1) 	Store old fp in ghost frame 
104:    LDA  3,-28(1) 	Load address of base of array d
105:     LD  3,1(3) 	Load array size 
106:     ST  3,-43(1) 	Store parameter 
107:    LDA  1,-41(1) 	Load address of new frame 
108:    LDA  3,1(7) 	Return address in ac 
109:    LDA  7,-104(7) 	CALL output
110:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
111:     ST  1,-41(1) 	Store old fp in ghost frame 
112:    LDA  1,-41(1) 	Load address of new frame 
113:    LDA  3,1(7) 	Return address in ac 
114:    LDA  7,-90(7) 	CALL outnl
115:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* BEGIN compound statement
116:    LDC  3,14(6) 	load size of array s
117:     ST  3,-11(0) 	save size of array s
* EXPRESSION STMT
118:    LDC  3,0(6) 	Load constant 
119:     ST  3,-41(1) 	Save index 
120:    LDC  3,444(6) 	Load constant 
121:     LD  4,-41(1) 	Restore index 
122:    LDA  5,-12(0) 	Load address of base of array s
123:    SUB  5,5,4 	Compute offset of value 
124:     ST  3,0(5) 	Store variable s
* EXPRESSION STMT
125:     ST  1,-41(1) 	Store old fp in ghost frame 
126:    LDA  3,-1(0) 	Load address of base of array g
127:     LD  3,1(3) 	Load array size 
128:     ST  3,-43(1) 	Store parameter 
129:    LDA  1,-41(1) 	Load address of new frame 
130:    LDA  3,1(7) 	Return address in ac 
131:    LDA  7,-126(7) 	CALL output
132:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
133:     ST  1,-41(1) 	Store old fp in ghost frame 
134:    LDA  3,-3(1) 	Load address of base of array m
135:     LD  3,1(3) 	Load array size 
136:     ST  3,-43(1) 	Store parameter 
137:    LDA  1,-41(1) 	Load address of new frame 
138:    LDA  3,1(7) 	Return address in ac 
139:    LDA  7,-134(7) 	CALL output
140:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
141:     ST  1,-41(1) 	Store old fp in ghost frame 
142:    LDA  3,-12(0) 	Load address of base of array s
143:     LD  3,1(3) 	Load array size 
144:     ST  3,-43(1) 	Store parameter 
145:    LDA  1,-41(1) 	Load address of new frame 
146:    LDA  3,1(7) 	Return address in ac 
147:    LDA  7,-142(7) 	CALL output
148:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
149:     ST  1,-41(1) 	Store old fp in ghost frame 
150:    LDA  1,-41(1) 	Load address of new frame 
151:    LDA  3,1(7) 	Return address in ac 
152:    LDA  7,-128(7) 	CALL outnl
153:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* EXPRESSION STMT
154:     ST  1,-41(1) 	Store old fp in ghost frame 
155:    LDA  3,-1(0) 	Load address of base of array g
156:     LD  3,1(3) 	Load array size 
157:     ST  3,-43(1) 	Store parameter 
158:    LDA  1,-41(1) 	Load address of new frame 
159:    LDA  3,1(7) 	Return address in ac 
160:    LDA  7,-155(7) 	CALL output
161:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
162:     ST  1,-41(1) 	Store old fp in ghost frame 
163:    LDA  3,-3(1) 	Load address of base of array m
164:     LD  3,1(3) 	Load array size 
165:     ST  3,-43(1) 	Store parameter 
166:    LDA  1,-41(1) 	Load address of new frame 
167:    LDA  3,1(7) 	Return address in ac 
168:    LDA  7,-163(7) 	CALL output
169:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
170:     ST  1,-41(1) 	Store old fp in ghost frame 
171:    LDA  1,-41(1) 	Load address of new frame 
172:    LDA  3,1(7) 	Return address in ac 
173:    LDA  7,-149(7) 	CALL outnl
174:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
175:    LDC  2,0(6) 	Set return value to 0 
176:     LD  3,-1(1) 	Load return address 
177:     LD  1,0(1) 	Adjust fp 
178:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,178(7) 	Jump to init 
* BEGIN Init
179:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
180:    LDC  3,10(6) 	load size of array g
181:     ST  3,0(0) 	save size of array g
* END init of global array sizes
182:    LDA  1,-26(0) 	set first frame at end of globals 
183:     ST  1,0(1) 	store old fp (point to self) 
184:    LDA  3,1(7) 	Return address in ac 
185:    LDA  7,-156(7) 	Jump to main 
186:   HALT  0,0,0 	DONE! 
* END Init
