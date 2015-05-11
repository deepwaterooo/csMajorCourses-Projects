* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  examplearray.tm
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
 32:     ST  3,0(1) 	save size of array y
* EXPRESSION STMT
 33:    LDC  3,11(6) 	Load constant 
 34:     ST  3,-4(1) 	Save index 
 35:     LD  3,-2(1) 	Load variable x
 36:     ST  3,-5(1) 	Save left side 
 37:    LDC  3,111(6) 	Load constant 
 38:     LD  4,-5(1) 	Load left into ac1 
 39:    MUL  3,4,3 	Op * 
 40:     ST  3,-5(1) 	Save left side 
 41:    LDC  3,222(6) 	Load constant 
 42:     LD  4,-5(1) 	Load left into ac1 
 43:    ADD  3,4,3 	Op + 
 44:     ST  3,-1(1) 	Store variable y
* EXPRESSION STMT
 45:    LDC  3,11(6) 	Load constant 
 46:     ST  3,-5(1) 	Save index 
 47:     ST  3,-3(1) 	Store variable z
* EXPRESSION STMT
 48:    LDC  3,13(6) 	Load constant 
 49:     ST  3,-6(1) 	Save index 
 50:    LDC  3,15(6) 	Load constant 
 51:     ST  3,-7(1) 	Save index 
 52:    LDC  4,0(6) 	Load 0 
 53:    SUB  3,4,3 	Op unary - 
 54:     ST  3,-8(1) 	Save left side 
 55:     LD  3,-2(1) 	Load variable x
 56:     LD  4,-8(1) 	Load left into ac1 
 57:    MUL  3,4,3 	Op * 
 58:     ST  3,-8(1) 	Save left side 
 59:    LDC  3,17(6) 	Load constant 
 60:     ST  3,-9(1) 	Save index 
 61:     LD  4,-9(1) 	Load left into ac1 
 62:    MUL  3,4,3 	Op * 
 63:     ST  3,-9(1) 	Save left side 
 64:     LD  3,-3(1) 	Load variable z
 65:     LD  4,-9(1) 	Load left into ac1 
 66:    MUL  3,4,3 	Op * 
 67:     ST  3,-1(1) 	Store variable w
* RETURN
 68:     LD  3,-3(1) 	Load variable z
 69:    LDA  2,0(3) 	Copy result to rt register 
 70:     LD  3,-1(1) 	Load return address 
 71:     LD  1,0(1) 	Adjust fp 
 72:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 73:    LDC  2,0(6) 	Set return value to 0 
 74:     LD  3,-1(1) 	Load return address 
 75:     LD  1,0(1) 	Adjust fp 
 76:    LDA  7,0(3) 	Return 
* END function dog
* BEGIN function main
 77:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 78:     ST  1,-2(1) 	Store old frame in ghost frame 
 79:    LDC  3,666(6) 	Load constant 
 80:     ST  3,-4(1) 	Store parameter 
 81:    LDA  1,-2(1) 	Load address of new frame 
 82:    LDA  3,1(7) 	Return address in ac 
 83:    LDA  7,-54(7) 	CALL dog
 84:    LDA  3,0(2) 	Save the result in ac 
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
* BEGIN init of global array sizes
 90:    LDC  3,0(6) 	load size of array w
 91:     ST  3,-1(0) 	save size of array w
* END init of global array sizes
 92:    LDA  1,-1(0) 	set first frame at end of globals 
 93:     ST  1,0(1) 	store old fp (point to self) 
 94:    LDA  3,1(7) 	Return address in ac 
 95:    LDA  7,-19(7) 	Jump to main 
 96:   HALT  0,0,0 	DONE! 
* END Init
