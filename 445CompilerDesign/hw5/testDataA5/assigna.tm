* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  assigna.c-
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
* BEGIN function cat
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,7(6) 	Load constant 
 32:     LD  4,-2(1) 	Load address of base of array z
 33:    SUB  3,4,3 	Compute offset of value 
 34:     LD  3,0(3) 	Load the value 
* EXPRESSION STMT
 35:     LD  3,-2(1) 	Load address of base of array z
 36:     LD  3,1(3) 	Load array size 
* END compound statement
* Add standard closing in case there is no return statement
 37:    LDC  2,0(6) 	Set return value to 0 
 38:     LD  3,-1(1) 	Load return address 
 39:     LD  1,0(1) 	Adjust fp 
 40:    LDA  7,0(3) 	Return 
* END of function cat
* BEGIN function dog
 41:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 42:    LDC  3,11(6) 	load size of array y
 43:     ST  3,-5(1) 	save size of array y
* EXPRESSION STMT
 44:     LD  3,0(0) 	Load variable gnu
 45:     ST  3,0(0) 	Store variable gnu
* EXPRESSION STMT
 46:    LDC  3,9(6) 	Load constant 
 47:     ST  3,-17(1) 	Save index 
 48:    LDC  3,10(6) 	Load constant 
 49:    LDA  4,-2(0) 	Load address of base of array goat
 50:    SUB  3,4,3 	Compute offset of value 
 51:     LD  3,0(3) 	Load the value 
 52:     LD  4,-17(1) 	Restore index 
 53:    LDA  5,-2(0) 	Load address of base of array goat
 54:    SUB  5,5,4 	Compute offset of value 
 55:     ST  3,0(5) 	Store variable goat
* EXPRESSION STMT
 56:    LDA  3,-2(0) 	Load address of base of array goat
 57:     LD  3,1(3) 	Load array size 
* EXPRESSION STMT
 58:     LD  3,-4(1) 	Load variable a
 59:     ST  3,-4(1) 	Store variable a
* EXPRESSION STMT
 60:    LDC  3,3(6) 	Load constant 
 61:     ST  3,-17(1) 	Save index 
 62:    LDC  3,4(6) 	Load constant 
 63:    LDA  4,-6(1) 	Load address of base of array y
 64:    SUB  3,4,3 	Compute offset of value 
 65:     LD  3,0(3) 	Load the value 
 66:     LD  4,-17(1) 	Restore index 
 67:    LDA  5,-6(1) 	Load address of base of array y
 68:    SUB  5,5,4 	Compute offset of value 
 69:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 70:    LDA  3,-6(1) 	Load address of base of array y
 71:     LD  3,1(3) 	Load array size 
* EXPRESSION STMT
 72:     LD  3,-3(1) 	Load variable p
 73:     ST  3,-3(1) 	Store variable p
* EXPRESSION STMT
 74:    LDC  3,3(6) 	Load constant 
 75:     ST  3,-17(1) 	Save index 
 76:    LDC  3,4(6) 	Load constant 
 77:     LD  4,-2(1) 	Load address of base of array x
 78:    SUB  3,4,3 	Compute offset of value 
 79:     LD  3,0(3) 	Load the value 
 80:     LD  4,-17(1) 	Restore index 
 81:     LD  5,-2(1) 	Load address of base of array x
 82:    SUB  5,5,4 	Compute offset of value 
 83:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 84:     LD  3,-2(1) 	Load address of base of array x
 85:     LD  3,1(3) 	Load array size 
* EXPRESSION STMT
 86:     ST  1,-17(1) 	Store old fp in ghost frame 
 87:     LD  3,-2(1) 	Load address of base of array x
 88:     ST  3,-19(1) 	Store parameter 
 89:    LDA  1,-17(1) 	Load address of new frame 
 90:    LDA  3,1(7) 	Return address in ac 
 91:    LDA  7,-62(7) 	CALL cat
 92:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 93:    LDC  2,0(6) 	Set return value to 0 
 94:     LD  3,-1(1) 	Load return address 
 95:     LD  1,0(1) 	Adjust fp 
 96:    LDA  7,0(3) 	Return 
* END of function dog
* BEGIN function main
 97:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 98:    LDC  3,22(6) 	load size of array ma
 99:     ST  3,-3(1) 	save size of array ma
* EXPRESSION STMT
100:     ST  1,-26(1) 	Store old fp in ghost frame 
101:    LDA  3,-4(1) 	Load address of base of array ma
102:     ST  3,-28(1) 	Store parameter 
103:     LD  3,-2(1) 	Load variable m
104:     ST  3,-29(1) 	Store parameter 
105:    LDA  1,-26(1) 	Load address of new frame 
106:    LDA  3,1(7) 	Return address in ac 
107:    LDA  7,-67(7) 	CALL dog
108:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
109:    LDC  2,0(6) 	Set return value to 0 
110:     LD  3,-1(1) 	Load return address 
111:     LD  1,0(1) 	Adjust fp 
112:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,112(7) 	Jump to init 
* BEGIN Init
113:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
114:    LDC  3,16(6) 	load size of array goat
115:     ST  3,-1(0) 	save size of array goat
* END init of global array sizes
116:    LDA  1,-18(0) 	set first frame at end of globals 
117:     ST  1,0(1) 	store old fp (point to self) 
118:    LDA  3,1(7) 	Return address in ac 
119:    LDA  7,-23(7) 	Jump to main 
120:   HALT  0,0,0 	DONE! 
* END Init
