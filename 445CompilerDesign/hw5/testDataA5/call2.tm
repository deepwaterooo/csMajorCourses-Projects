* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  call2.c-
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
* EXPRESSION STMT
 31:    LDC  3,444(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable a
* EXPRESSION STMT
 33:    LDC  3,9(6) 	Load constant 
 34:     ST  3,-4(1) 	Save index 
 35:    LDC  3,555(6) 	Load constant 
 36:     LD  4,-4(1) 	Restore index 
 37:     LD  5,-3(1) 	Load address of base of array b
 38:    SUB  5,5,4 	Compute offset of value 
 39:     ST  3,0(5) 	Store variable b
* RETURN
 40:     LD  3,-3(1) 	Load address of base of array b
 41:     LD  3,1(3) 	Load array size 
 42:    LDA  2,0(3) 	Copy result to rt register 
 43:     LD  3,-1(1) 	Load return address 
 44:     LD  1,0(1) 	Adjust fp 
 45:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 46:    LDC  2,0(6) 	Set return value to 0 
 47:     LD  3,-1(1) 	Load return address 
 48:     LD  1,0(1) 	Adjust fp 
 49:    LDA  7,0(3) 	Return 
* END of function dog
* BEGIN function main
 50:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 51:    LDC  3,10(6) 	load size of array y
 52:     ST  3,-3(1) 	save size of array y
* EXPRESSION STMT
 53:    LDC  3,1(6) 	Load constant 
 54:     ST  3,0(0) 	Store variable g
* EXPRESSION STMT
 55:    LDC  3,9(6) 	Load constant 
 56:     ST  3,-14(1) 	Save index 
 57:    LDC  3,0(6) 	Load constant 
 58:     LD  4,-14(1) 	Restore index 
 59:    LDA  5,-2(0) 	Load address of base of array h
 60:    SUB  5,5,4 	Compute offset of value 
 61:     ST  3,0(5) 	Store variable h
* EXPRESSION STMT
 62:    LDC  3,111(6) 	Load constant 
 63:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 64:    LDC  3,9(6) 	Load constant 
 65:     ST  3,-14(1) 	Save index 
 66:    LDC  3,222(6) 	Load constant 
 67:     LD  4,-14(1) 	Restore index 
 68:    LDA  5,-4(1) 	Load address of base of array y
 69:    SUB  5,5,4 	Compute offset of value 
 70:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 71:    LDC  3,333(6) 	Load constant 
 72:     ST  3,-14(1) 	Save left side 
 73:     ST  1,-15(1) 	Store old fp in ghost frame 
 74:     LD  3,-2(1) 	Load variable x
 75:     ST  3,-17(1) 	Store parameter 
 76:    LDA  3,-4(1) 	Load address of base of array y
 77:     ST  3,-18(1) 	Store parameter 
 78:    LDA  1,-15(1) 	Load address of new frame 
 79:    LDA  3,1(7) 	Return address in ac 
 80:    LDA  7,-51(7) 	CALL dog
 81:    LDA  3,0(2) 	Save the result in ac 
 82:     LD  4,-14(1) 	Load left into ac1 
 83:    ADD  3,4,3 	Op + 
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
 89:    LDC  3,10(6) 	load size of array h
 90:     ST  3,-1(0) 	save size of array h
* END init of global array sizes
 91:    LDA  1,-12(0) 	set first frame at end of globals 
 92:     ST  1,0(1) 	store old fp (point to self) 
 93:    LDA  3,1(7) 	Return address in ac 
 94:    LDA  7,-45(7) 	Jump to main 
 95:   HALT  0,0,0 	DONE! 
* END Init
