* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  unarystar.tm
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
 31:    LDC  3,0(6) 	load size of array n
 32:     ST  3,-2(1) 	save size of array n
 33:    LDC  3,0(6) 	load size of array a
 34:     ST  3,-4(1) 	save size of array a
 35:     LD  3,0(1) 	Load variable k
 36:    MUL  3,4,3 	Op * 
 37:     LD  3,-3(1) 	Load variable b
 38:    MUL  3,4,3 	Op * 
 39:     LD  3,-3(1) 	Load variable n
 40:    MUL  3,4,3 	Op * 
 41:     LD  3,-5(1) 	Load variable a
 42:    MUL  3,4,3 	Op * 
 43:     LD  3,0(1) 	Load variable k
 44:    MUL  3,4,3 	Op * 
 45:     ST  3,-5(1) 	Save left side 
 46:    LDC  3,10(6) 	Load constant 
 47:     LD  4,-5(1) 	Load left into ac1 
 48:    ADD  3,4,3 	Op + 
 49:     LD  3,-3(1) 	Load variable b
 50:    MUL  3,4,3 	Op * 
 51:     ST  3,-5(1) 	Save left side 
 52:    LDC  3,10(6) 	Load constant 
 53:     LD  4,-5(1) 	Load left into ac1 
 54:    ADD  3,4,3 	Op + 
 55:     LD  3,-3(1) 	Load variable n
 56:    MUL  3,4,3 	Op * 
 57:     ST  3,-5(1) 	Save left side 
 58:    LDC  3,10(6) 	Load constant 
 59:     LD  4,-5(1) 	Load left into ac1 
 60:    ADD  3,4,3 	Op + 
 61:     LD  3,-5(1) 	Load variable a
 62:    MUL  3,4,3 	Op * 
 63:     ST  3,-5(1) 	Save left side 
 64:    LDC  3,10(6) 	Load constant 
 65:     LD  4,-5(1) 	Load left into ac1 
 66:    ADD  3,4,3 	Op + 
 67:     LD  3,-3(1) 	Load variable n
 68:    MUL  3,4,3 	Op * 
 69:     ST  3,-5(1) 	Save index 
 70:    LDC  3,1984(6) 	Load constant 
 71:     ST  3,-6(1) 	Save index 
 72:     LD  3,-5(1) 	Load variable a
 73:    MUL  3,4,3 	Op * 
 74:     ST  3,-7(1) 	Save left side 
 75:     LD  3,-3(1) 	Load variable n
 76:    MUL  3,4,3 	Op * 
 77:     LD  4,-7(1) 	Load left into ac1 
 78:    MUL  3,4,3 	Op * 
* RETURN
 79:     LD  3,-3(1) 	Load variable n
 80:    MUL  3,4,3 	Op * 
 81:    LDA  2,0(3) 	Copy result to rt register 
 82:     LD  3,-1(1) 	Load return address 
 83:     LD  1,0(1) 	Adjust fp 
 84:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 85:    LDC  2,0(6) 	Set return value to 0 
 86:     LD  3,-1(1) 	Load return address 
 87:     LD  1,0(1) 	Adjust fp 
 88:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,88(7) 	Jump to init 
* BEGIN Init
 89:     LD  0,0(0) 	Set the global pointer 
 90:    LDA  1,0(0) 	set first frame at end of globals 
 91:     ST  1,0(1) 	store old fp (point to self) 
 92:    LDA  3,1(7) 	Return address in ac 
 93:    LDA  7,-64(7) 	Jump to main 
 94:   HALT  0,0,0 	DONE! 
* END Init
