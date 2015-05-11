* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  gcd.c-
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
* BEGIN function gcd
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
 31:     LD  3,-3(1) 	Load variable v
 32:     ST  3,-4(1) 	Save left side 
 33:    LDC  3,0(6) 	Load constant 
 34:     LD  4,-4(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op == 
 36:    LDC  3,1(6) 	True case 
 37:    JEQ  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
 39:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
 41:     LD  3,-2(1) 	Load variable u
 42:    LDA  2,0(3) 	Copy result to rt register 
 43:     LD  3,-1(1) 	Load return address 
 44:     LD  1,0(1) 	Adjust fp 
 45:    LDA  7,0(3) 	Return 
* ELSE
 40:    LDA  7,6(7) 	Jump around the THEN 
* RETURN
 47:     ST  1,-4(1) 	Store old fp in ghost frame 
 48:     LD  3,-3(1) 	Load variable v
 49:     ST  3,-6(1) 	Store parameter 
 50:     LD  3,-2(1) 	Load variable u
 51:     ST  3,-7(1) 	Save left side 
 52:     LD  3,-2(1) 	Load variable u
 53:     ST  3,-8(1) 	Save left side 
 54:     LD  3,-3(1) 	Load variable v
 55:     LD  4,-8(1) 	Load left into ac1 
 56:    DIV  3,4,3 	Op / 
 57:     ST  3,-8(1) 	Save left side 
 58:     LD  3,-3(1) 	Load variable v
 59:     LD  4,-8(1) 	Load left into ac1 
 60:    MUL  3,4,3 	Op * 
 61:     LD  4,-7(1) 	Load left into ac1 
 62:    SUB  3,4,3 	Op - 
 63:     ST  3,-7(1) 	Store parameter 
 64:    LDA  1,-4(1) 	Load address of new frame 
 65:    LDA  3,1(7) 	Return address in ac 
 66:    LDA  7,-37(7) 	CALL gcd
 67:    LDA  3,0(2) 	Save the result in ac 
 68:    LDA  2,0(3) 	Copy result to rt register 
 69:     LD  3,-1(1) 	Load return address 
 70:     LD  1,0(1) 	Adjust fp 
 71:    LDA  7,0(3) 	Return 
 46:    LDA  7,25(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
 72:    LDC  2,0(6) 	Set return value to 0 
 73:     LD  3,-1(1) 	Load return address 
 74:     LD  1,0(1) 	Adjust fp 
 75:    LDA  7,0(3) 	Return 
* END of function gcd
* BEGIN function main
 76:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 77:     ST  1,-5(1) 	Store old fp in ghost frame 
 78:    LDA  1,-5(1) 	Load address of new frame 
 79:    LDA  3,1(7) 	Return address in ac 
 80:    LDA  7,-80(7) 	CALL input
 81:    LDA  3,0(2) 	Save the result in ac 
 82:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 83:     ST  1,-5(1) 	Store old fp in ghost frame 
 84:    LDA  1,-5(1) 	Load address of new frame 
 85:    LDA  3,1(7) 	Return address in ac 
 86:    LDA  7,-86(7) 	CALL input
 87:    LDA  3,0(2) 	Save the result in ac 
 88:     ST  3,-3(1) 	Store variable y
* EXPRESSION STMT
 89:     ST  1,-5(1) 	Store old fp in ghost frame 
 90:     LD  3,-2(1) 	Load variable x
 91:     ST  3,-7(1) 	Store parameter 
 92:     LD  3,-3(1) 	Load variable y
 93:     ST  3,-8(1) 	Store parameter 
 94:    LDA  1,-5(1) 	Load address of new frame 
 95:    LDA  3,1(7) 	Return address in ac 
 96:    LDA  7,-67(7) 	CALL gcd
 97:    LDA  3,0(2) 	Save the result in ac 
 98:     ST  3,-4(1) 	Store variable z
* EXPRESSION STMT
 99:     ST  1,-5(1) 	Store old fp in ghost frame 
100:     LD  3,-4(1) 	Load variable z
101:     ST  3,-7(1) 	Store parameter 
102:    LDA  1,-5(1) 	Load address of new frame 
103:    LDA  3,1(7) 	Return address in ac 
104:    LDA  7,-99(7) 	CALL output
105:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
106:     ST  1,-5(1) 	Store old fp in ghost frame 
107:    LDA  1,-5(1) 	Load address of new frame 
108:    LDA  3,1(7) 	Return address in ac 
109:    LDA  7,-85(7) 	CALL outnl
110:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
111:    LDC  2,0(6) 	Set return value to 0 
112:     LD  3,-1(1) 	Load return address 
113:     LD  1,0(1) 	Adjust fp 
114:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,114(7) 	Jump to init 
* BEGIN Init
115:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
116:    LDA  1,0(0) 	set first frame at end of globals 
117:     ST  1,0(1) 	store old fp (point to self) 
118:    LDA  3,1(7) 	Return address in ac 
119:    LDA  7,-44(7) 	Jump to main 
120:   HALT  0,0,0 	DONE! 
* END Init
