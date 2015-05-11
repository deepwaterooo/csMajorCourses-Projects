* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  massign.c-
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
 31:    LDC  3,11(6) 	load size of array y
 32:     ST  3,-5(1) 	save size of array y
* EXPRESSION STMT
 33:     LD  3,-4(1) 	Load variable a
 34:     ST  3,-17(1) 	Save left side 
 35:    LDC  3,777(6) 	Load constant 
 36:     LD  4,-17(1) 	Load left into ac1 
 37:    ADD  3,4,3 	Op + 
 38:     ST  3,-4(1) 	Store variable a
* EXPRESSION STMT
 39:    LDC  3,777(6) 	Load constant 
 40:     LD  4,-4(1) 	load lhs variable a
 41:    ADD  3,4,3 	op += 
 42:     ST  3,-4(1) 	Store variable a
* EXPRESSION STMT
 43:    LDC  3,7(6) 	Load constant 
 44:     ST  3,-17(1) 	Save index 
 45:    LDC  3,7(6) 	Load constant 
 46:    LDA  4,-6(1) 	Load address of base of array y
 47:    SUB  3,4,3 	Compute offset of value 
 48:     LD  3,0(3) 	Load the value 
 49:     ST  3,-18(1) 	Save left side 
 50:    LDC  3,888(6) 	Load constant 
 51:     LD  4,-18(1) 	Load left into ac1 
 52:    ADD  3,4,3 	Op + 
 53:     LD  4,-17(1) 	Restore index 
 54:    LDA  5,-6(1) 	Load address of base of array y
 55:    SUB  5,5,4 	Compute offset of value 
 56:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 57:    LDC  3,7(6) 	Load constant 
 58:     ST  3,-17(1) 	Save index 
 59:    LDC  3,888(6) 	Load constant 
 60:     LD  4,-17(1) 	Restore index 
 61:    LDA  5,-6(1) 	Load address of base of array y
 62:    SUB  5,5,4 	Compute offset of value 
 63:     LD  4,0(5) 	load lhs variable y
 64:    ADD  3,4,3 	op += 
 65:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 66:    LDC  3,7(6) 	Load constant 
 67:     ST  3,-17(1) 	Save index 
 68:    LDC  3,7(6) 	Load constant 
 69:     LD  4,-2(1) 	Load address of base of array x
 70:    SUB  3,4,3 	Compute offset of value 
 71:     LD  3,0(3) 	Load the value 
 72:     ST  3,-18(1) 	Save left side 
 73:    LDC  3,888(6) 	Load constant 
 74:     LD  4,-18(1) 	Load left into ac1 
 75:    ADD  3,4,3 	Op + 
 76:     LD  4,-17(1) 	Restore index 
 77:     LD  5,-2(1) 	Load address of base of array x
 78:    SUB  5,5,4 	Compute offset of value 
 79:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 80:    LDC  3,7(6) 	Load constant 
 81:     ST  3,-17(1) 	Save index 
 82:    LDC  3,888(6) 	Load constant 
 83:     LD  4,-17(1) 	Restore index 
 84:     LD  5,-2(1) 	Load address of base of array x
 85:    SUB  5,5,4 	Compute offset of value 
 86:     LD  4,0(5) 	load lhs variable x
 87:    ADD  3,4,3 	op += 
 88:     ST  3,0(5) 	Store variable x
* END compound statement
* Add standard closing in case there is no return statement
 89:    LDC  2,0(6) 	Set return value to 0 
 90:     LD  3,-1(1) 	Load return address 
 91:     LD  1,0(1) 	Adjust fp 
 92:    LDA  7,0(3) 	Return 
* END of function dog
* BEGIN function main
 93:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 94:    LDC  3,22(6) 	load size of array ma
 95:     ST  3,-3(1) 	save size of array ma
* EXPRESSION STMT
 96:     ST  1,-26(1) 	Store old fp in ghost frame 
 97:    LDA  3,-4(1) 	Load address of base of array ma
 98:     ST  3,-28(1) 	Store parameter 
 99:     LD  3,-2(1) 	Load variable m
100:     ST  3,-29(1) 	Store parameter 
101:    LDA  1,-26(1) 	Load address of new frame 
102:    LDA  3,1(7) 	Return address in ac 
103:    LDA  7,-74(7) 	CALL dog
104:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
105:    LDC  2,0(6) 	Set return value to 0 
106:     LD  3,-1(1) 	Load return address 
107:     LD  1,0(1) 	Adjust fp 
108:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,108(7) 	Jump to init 
* BEGIN Init
109:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
110:    LDA  1,0(0) 	set first frame at end of globals 
111:     ST  1,0(1) 	store old fp (point to self) 
112:    LDA  3,1(7) 	Return address in ac 
113:    LDA  7,-21(7) 	Jump to main 
114:   HALT  0,0,0 	DONE! 
* END Init
