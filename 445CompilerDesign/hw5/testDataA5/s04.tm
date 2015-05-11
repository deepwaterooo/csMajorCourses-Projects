* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  s04.c-
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
* BEGIN function dog
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
 31:     LD  3,-2(1) 	Load variable d
 32:     ST  3,-3(1) 	Save left side 
 33:    LDC  3,0(6) 	Load constant 
 34:     LD  4,-3(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op == 
 36:    LDC  3,1(6) 	True case 
 37:    JEQ  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
 39:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 41:     ST  1,-3(1) 	Store old fp in ghost frame 
 42:     LD  3,-1(0) 	Load variable s
 43:     ST  3,-5(1) 	Store parameter 
 44:    LDA  1,-3(1) 	Load address of new frame 
 45:    LDA  3,1(7) 	Return address in ac 
 46:    LDA  7,-41(7) 	CALL output
 47:    LDA  3,0(2) 	Save the result in ac 
* ELSE
 40:    LDA  7,8(7) 	Jump around the THEN 
* EXPRESSION STMT
 49:     LD  3,-2(1) 	Load variable d
 50:     ST  3,-1(0) 	Store variable s
 48:    LDA  7,2(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
 51:    LDC  2,0(6) 	Set return value to 0 
 52:     LD  3,-1(1) 	Load return address 
 53:     LD  1,0(1) 	Adjust fp 
 54:    LDA  7,0(3) 	Return 
* END of function dog
* BEGIN function cat
 55:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
 56:     LD  3,-2(1) 	Load variable c
 57:     ST  3,-3(1) 	Save left side 
 58:    LDC  3,0(6) 	Load constant 
 59:     LD  4,-3(1) 	Load left into ac1 
 60:    SUB  4,4,3 	Op == 
 61:    LDC  3,1(6) 	True case 
 62:    JEQ  4,1(7) 	Jump if true 
 63:    LDC  3,0(6) 	False case 
 64:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 66:     ST  1,-3(1) 	Store old fp in ghost frame 
 67:     LD  3,-2(0) 	Load variable s
 68:     ST  3,-5(1) 	Store parameter 
 69:    LDA  1,-3(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-66(7) 	CALL output
 72:    LDA  3,0(2) 	Save the result in ac 
* ELSE
 65:    LDA  7,8(7) 	Jump around the THEN 
* EXPRESSION STMT
 74:     LD  3,-2(1) 	Load variable c
 75:     ST  3,-2(0) 	Store variable s
 73:    LDA  7,2(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
 76:    LDC  2,0(6) 	Set return value to 0 
 77:     LD  3,-1(1) 	Load return address 
 78:     LD  1,0(1) 	Adjust fp 
 79:    LDA  7,0(3) 	Return 
* END of function cat
* BEGIN function main
 80:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 81:    LDC  3,333(6) 	Load constant 
 82:     ST  3,0(0) 	Store variable s
* EXPRESSION STMT
 83:     ST  1,-2(1) 	Store old fp in ghost frame 
 84:    LDC  3,111(6) 	Load constant 
 85:     ST  3,-4(1) 	Store parameter 
 86:    LDA  1,-2(1) 	Load address of new frame 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-59(7) 	CALL dog
 89:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 90:     ST  1,-2(1) 	Store old fp in ghost frame 
 91:    LDC  3,222(6) 	Load constant 
 92:     ST  3,-4(1) 	Store parameter 
 93:    LDA  1,-2(1) 	Load address of new frame 
 94:    LDA  3,1(7) 	Return address in ac 
 95:    LDA  7,-41(7) 	CALL cat
 96:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 97:     ST  1,-2(1) 	Store old fp in ghost frame 
 98:    LDC  3,0(6) 	Load constant 
 99:     ST  3,-4(1) 	Store parameter 
100:    LDA  1,-2(1) 	Load address of new frame 
101:    LDA  3,1(7) 	Return address in ac 
102:    LDA  7,-73(7) 	CALL dog
103:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
104:     ST  1,-2(1) 	Store old fp in ghost frame 
105:    LDC  3,0(6) 	Load constant 
106:     ST  3,-4(1) 	Store parameter 
107:    LDA  1,-2(1) 	Load address of new frame 
108:    LDA  3,1(7) 	Return address in ac 
109:    LDA  7,-55(7) 	CALL cat
110:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
111:     ST  1,-2(1) 	Store old fp in ghost frame 
112:     LD  3,0(0) 	Load variable s
113:     ST  3,-4(1) 	Store parameter 
114:    LDA  1,-2(1) 	Load address of new frame 
115:    LDA  3,1(7) 	Return address in ac 
116:    LDA  7,-111(7) 	CALL output
117:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
118:    LDC  2,0(6) 	Set return value to 0 
119:     LD  3,-1(1) 	Load return address 
120:     LD  1,0(1) 	Adjust fp 
121:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,121(7) 	Jump to init 
* BEGIN Init
122:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
123:    LDA  1,-3(0) 	set first frame at end of globals 
124:     ST  1,0(1) 	store old fp (point to self) 
125:    LDA  3,1(7) 	Return address in ac 
126:    LDA  7,-47(7) 	Jump to main 
127:   HALT  0,0,0 	DONE! 
* END Init
