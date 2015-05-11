* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  massign.tm
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
* BEGIN function dog
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 31:    LDC  3,0(6) 	load size of array y
 32:     ST  3,-4(1) 	save size of array y
* EXPRESSION STMT
 33:     LD  3,0(1) 	Load variable a
 34:     ST  3,-5(1) 	Save left side 
 35:    LDC  3,777(6) 	Load constant 
 36:     LD  4,-5(1) 	Load left into ac1 
 37:    ADD  3,4,3 	Op + 
 38:     ST  3,0(1) 	Store variable a
* EXPRESSION STMT
 39:    LDC  3,777(6) 	Load constant 
 40:     ST  3,0(1) 	Store variable a
* EXPRESSION STMT
 41:    LDC  3,7(6) 	Load constant 
 42:     ST  3,-5(1) 	Save index 
 43:    LDC  3,7(6) 	Load constant 
 44:     ST  3,-6(1) 	Save index 
 45:     ST  3,-7(1) 	Save left side 
 46:    LDC  3,888(6) 	Load constant 
 47:     LD  4,-7(1) 	Load left into ac1 
 48:    ADD  3,4,3 	Op + 
 49:     ST  3,-5(1) 	Store variable y
* EXPRESSION STMT
 50:    LDC  3,7(6) 	Load constant 
 51:     ST  3,-7(1) 	Save index 
 52:    LDC  3,888(6) 	Load constant 
 53:     ST  3,-5(1) 	Store variable y
* EXPRESSION STMT
 54:    LDC  3,7(6) 	Load constant 
 55:     ST  3,-8(1) 	Save index 
 56:    LDC  3,7(6) 	Load constant 
 57:     ST  3,-9(1) 	Save index 
 58:     ST  3,-10(1) 	Save left side 
 59:    LDC  3,888(6) 	Load constant 
 60:     LD  4,-10(1) 	Load left into ac1 
 61:    ADD  3,4,3 	Op + 
 62:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 63:    LDC  3,7(6) 	Load constant 
 64:     ST  3,-10(1) 	Save index 
 65:    LDC  3,888(6) 	Load constant 
 66:     ST  3,-2(1) 	Store variable x
* END compound statement
* Add standard closing in case there is no return statement
 67:    LDC  2,0(6) 	Set return value to 0 
 68:     LD  3,-1(1) 	Load return address 
 69:     LD  1,0(1) 	Adjust fp 
 70:    LDA  7,0(3) 	Return 
* END function dog
* BEGIN function main
 71:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 72:    LDC  3,0(6) 	load size of array ma
 73:     ST  3,-2(1) 	save size of array ma
* EXPRESSION STMT
 74:     ST  1,-3(1) 	Store old frame in ghost frame 
 75:     LD  3,-3(1) 	Load variable ma
 76:     ST  3,-5(1) 	Store parameter 
 77:     LD  3,-2(1) 	Load variable m
 78:     ST  3,-6(1) 	Store parameter 
 79:    LDA  1,-3(1) 	Load address of new frame 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-52(7) 	CALL dog
 82:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 83:    LDC  2,0(6) 	Set return value to 0 
 84:     LD  3,-1(1) 	Load return address 
 85:     LD  1,0(1) 	Adjust fp 
 86:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,86(7) 	Jump to init 
* BEGIN Init
 87:     LD  0,0(0) 	Set the global pointer 
 88:    LDA  1,0(0) 	set first frame at end of globals 
 89:     ST  1,0(1) 	store old fp (point to self) 
 90:    LDA  3,1(7) 	Return address in ac 
 91:    LDA  7,-21(7) 	Jump to main 
 92:   HALT  0,0,0 	DONE! 
* END Init
