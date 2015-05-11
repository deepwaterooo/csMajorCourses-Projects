* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  tiny3.c-
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
* BEGIN function wolf
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
 31:     LD  3,-2(1) 	Load variable garion
 32:     ST  3,-4(1) 	Save left side 
 33:     LD  3,0(0) 	Load variable g
 34:     LD  4,-4(1) 	Load left into ac1 
 35:    ADD  3,4,3 	Op + 
 36:    LDA  2,0(3) 	Copy result to rt register 
 37:     LD  3,-1(1) 	Load return address 
 38:     LD  1,0(1) 	Adjust fp 
 39:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 40:    LDC  2,0(6) 	Set return value to 0 
 41:     LD  3,-1(1) 	Load return address 
 42:     LD  1,0(1) 	Adjust fp 
 43:    LDA  7,0(3) 	Return 
* END of function wolf
* BEGIN function polgara
 44:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
 45:     LD  3,-2(1) 	Load variable silk
 46:     ST  3,-4(1) 	Save left side 
 47:    LDC  3,1(6) 	Load constant 
 48:     LD  4,-4(1) 	Load left into ac1 
 49:    ADD  3,4,3 	Op + 
 50:    LDA  2,0(3) 	Copy result to rt register 
 51:     LD  3,-1(1) 	Load return address 
 52:     LD  1,0(1) 	Adjust fp 
 53:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 54:    LDC  2,0(6) 	Set return value to 0 
 55:     LD  3,-1(1) 	Load return address 
 56:     LD  1,0(1) 	Adjust fp 
 57:    LDA  7,0(3) 	Return 
* END of function polgara
* BEGIN function main
 58:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 59:    LDC  3,33(6) 	Load constant 
 60:     ST  3,0(0) 	Store variable g
* EXPRESSION STMT
 61:    LDC  3,666(6) 	Load constant 
 62:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 63:     ST  1,-3(1) 	Store old fp in ghost frame 
 64:     ST  1,-5(1) 	Store old fp in ghost frame 
 65:     LD  3,-2(1) 	Load variable x
 66:     ST  3,-7(1) 	Store parameter 
 67:    LDA  1,-5(1) 	Load address of new frame 
 68:    LDA  3,1(7) 	Return address in ac 
 69:    LDA  7,-26(7) 	CALL polgara
 70:    LDA  3,0(2) 	Save the result in ac 
 71:     ST  3,-5(1) 	Store parameter 
 72:    LDA  1,-3(1) 	Load address of new frame 
 73:    LDA  3,1(7) 	Return address in ac 
 74:    LDA  7,-45(7) 	CALL wolf
 75:    LDA  3,0(2) 	Save the result in ac 
 76:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 77:     ST  1,-3(1) 	Store old fp in ghost frame 
 78:     LD  3,-2(1) 	Load variable x
 79:     ST  3,-5(1) 	Store parameter 
 80:    LDA  1,-3(1) 	Load address of new frame 
 81:    LDA  3,1(7) 	Return address in ac 
 82:    LDA  7,-77(7) 	CALL output
 83:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 84:    LDC  2,0(6) 	Set return value to 0 
 85:     LD  3,-1(1) 	Load return address 
 86:     LD  1,0(1) 	Adjust fp 
 87:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,87(7) 	Jump to init 
* BEGIN Init
 88:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 89:    LDA  1,-1(0) 	set first frame at end of globals 
 90:     ST  1,0(1) 	store old fp (point to self) 
 91:    LDA  3,1(7) 	Return address in ac 
 92:    LDA  7,-35(7) 	Jump to main 
 93:   HALT  0,0,0 	DONE! 
* END Init
