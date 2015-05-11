* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  s05.c-
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
 31:    LDC  3,22(6) 	load size of array b
 32:     ST  3,-3(1) 	save size of array b
 33:    LDC  3,23(6) 	load size of array bs
 34:     ST  3,-14(0) 	save size of array bs
* BEGIN compound statement
 35:    LDC  3,33(6) 	load size of array d
 36:     ST  3,-27(1) 	save size of array d
 37:    LDC  3,34(6) 	load size of array ds
 38:     ST  3,-39(0) 	save size of array ds
* EXPRESSION STMT
 39:     ST  1,-107(1) 	Store old fp in ghost frame 
 40:    LDA  3,-2(0) 	Load address of base of array h
 41:     LD  3,1(3) 	Load array size 
 42:     ST  3,-109(1) 	Store parameter 
 43:    LDA  1,-107(1) 	Load address of new frame 
 44:    LDA  3,1(7) 	Return address in ac 
 45:    LDA  7,-40(7) 	CALL output
 46:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 47:     ST  1,-107(1) 	Store old fp in ghost frame 
 48:    LDA  3,-4(1) 	Load address of base of array b
 49:     LD  3,1(3) 	Load array size 
 50:     ST  3,-109(1) 	Store parameter 
 51:    LDA  1,-107(1) 	Load address of new frame 
 52:    LDA  3,1(7) 	Return address in ac 
 53:    LDA  7,-48(7) 	CALL output
 54:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 55:     ST  1,-107(1) 	Store old fp in ghost frame 
 56:    LDA  3,-15(0) 	Load address of base of array bs
 57:     LD  3,1(3) 	Load array size 
 58:     ST  3,-109(1) 	Store parameter 
 59:    LDA  1,-107(1) 	Load address of new frame 
 60:    LDA  3,1(7) 	Return address in ac 
 61:    LDA  7,-56(7) 	CALL output
 62:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 63:     ST  1,-107(1) 	Store old fp in ghost frame 
 64:    LDA  3,-28(1) 	Load address of base of array d
 65:     LD  3,1(3) 	Load array size 
 66:     ST  3,-109(1) 	Store parameter 
 67:    LDA  1,-107(1) 	Load address of new frame 
 68:    LDA  3,1(7) 	Return address in ac 
 69:    LDA  7,-64(7) 	CALL output
 70:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 71:     ST  1,-107(1) 	Store old fp in ghost frame 
 72:    LDA  3,-40(0) 	Load address of base of array ds
 73:     LD  3,1(3) 	Load array size 
 74:     ST  3,-109(1) 	Store parameter 
 75:    LDA  1,-107(1) 	Load address of new frame 
 76:    LDA  3,1(7) 	Return address in ac 
 77:    LDA  7,-72(7) 	CALL output
 78:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* BEGIN compound statement
 79:    LDC  3,44(6) 	load size of array d
 80:     ST  3,-62(1) 	save size of array d
 81:    LDC  3,45(6) 	load size of array ds
 82:     ST  3,-75(0) 	save size of array ds
* EXPRESSION STMT
 83:     ST  1,-107(1) 	Store old fp in ghost frame 
 84:    LDA  3,-2(0) 	Load address of base of array h
 85:     LD  3,1(3) 	Load array size 
 86:     ST  3,-109(1) 	Store parameter 
 87:    LDA  1,-107(1) 	Load address of new frame 
 88:    LDA  3,1(7) 	Return address in ac 
 89:    LDA  7,-84(7) 	CALL output
 90:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 91:     ST  1,-107(1) 	Store old fp in ghost frame 
 92:    LDA  3,-4(1) 	Load address of base of array b
 93:     LD  3,1(3) 	Load array size 
 94:     ST  3,-109(1) 	Store parameter 
 95:    LDA  1,-107(1) 	Load address of new frame 
 96:    LDA  3,1(7) 	Return address in ac 
 97:    LDA  7,-92(7) 	CALL output
 98:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 99:     ST  1,-107(1) 	Store old fp in ghost frame 
100:    LDA  3,-15(0) 	Load address of base of array bs
101:     LD  3,1(3) 	Load array size 
102:     ST  3,-109(1) 	Store parameter 
103:    LDA  1,-107(1) 	Load address of new frame 
104:    LDA  3,1(7) 	Return address in ac 
105:    LDA  7,-100(7) 	CALL output
106:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
107:     ST  1,-107(1) 	Store old fp in ghost frame 
108:    LDA  3,-63(1) 	Load address of base of array d
109:     LD  3,1(3) 	Load array size 
110:     ST  3,-109(1) 	Store parameter 
111:    LDA  1,-107(1) 	Load address of new frame 
112:    LDA  3,1(7) 	Return address in ac 
113:    LDA  7,-108(7) 	CALL output
114:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
115:     ST  1,-107(1) 	Store old fp in ghost frame 
116:    LDA  3,-76(0) 	Load address of base of array ds
117:     LD  3,1(3) 	Load array size 
118:     ST  3,-109(1) 	Store parameter 
119:    LDA  1,-107(1) 	Load address of new frame 
120:    LDA  3,1(7) 	Return address in ac 
121:    LDA  7,-116(7) 	CALL output
122:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* END compound statement
* Add standard closing in case there is no return statement
123:    LDC  2,0(6) 	Set return value to 0 
124:     LD  3,-1(1) 	Load return address 
125:     LD  1,0(1) 	Adjust fp 
126:    LDA  7,0(3) 	Return 
* END of function cat
* BEGIN function dog
127:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
128:     ST  1,-2(1) 	Store old fp in ghost frame 
129:    LDA  3,-123(0) 	Load address of base of array j
130:     LD  3,1(3) 	Load array size 
131:     ST  3,-4(1) 	Store parameter 
132:    LDA  1,-2(1) 	Load address of new frame 
133:    LDA  3,1(7) 	Return address in ac 
134:    LDA  7,-129(7) 	CALL output
135:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
136:    LDC  2,0(6) 	Set return value to 0 
137:     LD  3,-1(1) 	Load return address 
138:     LD  1,0(1) 	Adjust fp 
139:    LDA  7,0(3) 	Return 
* END of function dog
* BEGIN function main
140:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
141:     ST  1,-2(1) 	Store old fp in ghost frame 
142:    LDA  1,-2(1) 	Load address of new frame 
143:    LDA  3,1(7) 	Return address in ac 
144:    LDA  7,-115(7) 	CALL cat
145:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
146:     ST  1,-2(1) 	Store old fp in ghost frame 
147:    LDA  1,-2(1) 	Load address of new frame 
148:    LDA  3,1(7) 	Return address in ac 
149:    LDA  7,-23(7) 	CALL dog
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
156:    LDC  3,11(6) 	load size of array h
157:     ST  3,-1(0) 	save size of array h
158:    LDC  3,55(6) 	load size of array j
159:     ST  3,-122(0) 	save size of array j
* END init of global array sizes
160:    LDA  1,-178(0) 	set first frame at end of globals 
161:     ST  1,0(1) 	store old fp (point to self) 
162:    LDA  3,1(7) 	Return address in ac 
163:    LDA  7,-24(7) 	Jump to main 
164:   HALT  0,0,0 	DONE! 
* END Init
