* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  tiny5.tm
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
* BEGIN function wolf
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 31:    LDC  3,0(6) 	load size of array w
 32:     ST  3,0(1) 	save size of array w
* RETURN
 33:    LDC  3,77(6) 	Load constant 
 34:     ST  3,-3(1) 	Save left side 
 35:    LDC  3,1(6) 	Load constant 
 36:     ST  3,-4(1) 	Save index 
 37:     LD  4,-4(1) 	Load left into ac1 
 38:    ADD  3,4,3 	Op + 
 39:    LDA  2,0(3) 	Copy result to rt register 
 40:     LD  3,-1(1) 	Load return address 
 41:     LD  1,0(1) 	Adjust fp 
 42:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 43:    LDC  2,0(6) 	Set return value to 0 
 44:     LD  3,-1(1) 	Load return address 
 45:     LD  1,0(1) 	Adjust fp 
 46:    LDA  7,0(3) 	Return 
* END function wolf
* BEGIN function main
 47:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 48:    LDC  3,0(6) 	load size of array y
 49:     ST  3,-1(1) 	save size of array y
* EXPRESSION STMT
 50:    LDC  3,1(6) 	Load constant 
 51:     ST  3,-2(1) 	Save index 
 52:    LDC  3,666(6) 	Load constant 
 53:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 54:     ST  1,-3(1) 	Store old frame in ghost frame 
 55:     LD  3,-2(1) 	Load variable y
 56:     ST  3,-5(1) 	Store parameter 
 57:    LDA  1,-3(1) 	Load address of new frame 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-30(7) 	CALL wolf
 60:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 61:    LDC  2,0(6) 	Set return value to 0 
 62:     LD  3,-1(1) 	Load return address 
 63:     LD  1,0(1) 	Adjust fp 
 64:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,64(7) 	Jump to init 
* BEGIN Init
 65:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
 66:    LDC  3,0(6) 	load size of array g
 67:     ST  3,-1(0) 	save size of array g
* END init of global array sizes
 68:    LDA  1,-1(0) 	set first frame at end of globals 
 69:     ST  1,0(1) 	store old fp (point to self) 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-25(7) 	Jump to main 
 72:   HALT  0,0,0 	DONE! 
* END Init