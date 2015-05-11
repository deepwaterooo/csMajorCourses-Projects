* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  factorialr.c-
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
* BEGIN function factorial
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
 31:     LD  3,-2(1) 	Load variable n
 32:     ST  3,-3(1) 	Save left side 
 33:    LDC  3,2(6) 	Load constant 
 34:     LD  4,-3(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op < 
 36:    LDC  3,1(6) 	True case 
 37:    JLT  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
 39:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
 41:    LDC  3,1(6) 	Load constant 
 42:    LDA  2,0(3) 	Copy result to rt register 
 43:     LD  3,-1(1) 	Load return address 
 44:     LD  1,0(1) 	Adjust fp 
 45:    LDA  7,0(3) 	Return 
* ELSE
 40:    LDA  7,6(7) 	Jump around the THEN 
* RETURN
 47:     LD  3,-2(1) 	Load variable n
 48:     ST  3,-3(1) 	Save left side 
 49:     ST  1,-4(1) 	Store old fp in ghost frame 
 50:     LD  3,-2(1) 	Load variable n
 51:     ST  3,-6(1) 	Save left side 
 52:    LDC  3,1(6) 	Load constant 
 53:     LD  4,-6(1) 	Load left into ac1 
 54:    SUB  3,4,3 	Op - 
 55:     ST  3,-6(1) 	Store parameter 
 56:    LDA  1,-4(1) 	Load address of new frame 
 57:    LDA  3,1(7) 	Return address in ac 
 58:    LDA  7,-29(7) 	CALL factorial
 59:    LDA  3,0(2) 	Save the result in ac 
 60:     LD  4,-3(1) 	Load left into ac1 
 61:    MUL  3,4,3 	Op * 
 62:    LDA  2,0(3) 	Copy result to rt register 
 63:     LD  3,-1(1) 	Load return address 
 64:     LD  1,0(1) 	Adjust fp 
 65:    LDA  7,0(3) 	Return 
 46:    LDA  7,19(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
 66:    LDC  2,0(6) 	Set return value to 0 
 67:     LD  3,-1(1) 	Load return address 
 68:     LD  1,0(1) 	Adjust fp 
 69:    LDA  7,0(3) 	Return 
* END of function factorial
* BEGIN function main
 70:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 71:     ST  1,-3(1) 	Store old fp in ghost frame 
 72:    LDA  1,-3(1) 	Load address of new frame 
 73:    LDA  3,1(7) 	Return address in ac 
 74:    LDA  7,-74(7) 	CALL input
 75:    LDA  3,0(2) 	Save the result in ac 
 76:     ST  3,-2(1) 	Store variable n
* EXPRESSION STMT
 77:     ST  1,-3(1) 	Store old fp in ghost frame 
 78:     LD  3,-2(1) 	Load variable n
 79:     ST  3,-5(1) 	Store parameter 
 80:    LDA  1,-3(1) 	Load address of new frame 
 81:    LDA  3,1(7) 	Return address in ac 
 82:    LDA  7,-53(7) 	CALL factorial
 83:    LDA  3,0(2) 	Save the result in ac 
 84:     ST  3,-2(1) 	Store variable n
* EXPRESSION STMT
 85:     ST  1,-3(1) 	Store old fp in ghost frame 
 86:     LD  3,-2(1) 	Load variable n
 87:     ST  3,-5(1) 	Store parameter 
 88:    LDA  1,-3(1) 	Load address of new frame 
 89:    LDA  3,1(7) 	Return address in ac 
 90:    LDA  7,-85(7) 	CALL output
 91:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 92:     ST  1,-3(1) 	Store old fp in ghost frame 
 93:    LDA  1,-3(1) 	Load address of new frame 
 94:    LDA  3,1(7) 	Return address in ac 
 95:    LDA  7,-71(7) 	CALL outnl
 96:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 97:    LDC  2,0(6) 	Set return value to 0 
 98:     LD  3,-1(1) 	Load return address 
 99:     LD  1,0(1) 	Adjust fp 
100:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,100(7) 	Jump to init 
* BEGIN Init
101:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
102:    LDA  1,0(0) 	set first frame at end of globals 
103:     ST  1,0(1) 	store old fp (point to self) 
104:    LDA  3,1(7) 	Return address in ac 
105:    LDA  7,-36(7) 	Jump to main 
106:   HALT  0,0,0 	DONE! 
* END Init
