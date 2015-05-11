* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  example.tm
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
* EXPRESSION STMT
 31:     LD  3,-2(1) 	Load variable x
 32:     ST  3,-4(1) 	Save left side 
 33:    LDC  3,111(6) 	Load constant 
 34:     LD  4,-4(1) 	Load left into ac1 
 35:    MUL  3,4,3 	Op * 
 36:     ST  3,-4(1) 	Save left side 
 37:    LDC  3,222(6) 	Load constant 
 38:     LD  4,-4(1) 	Load left into ac1 
 39:    ADD  3,4,3 	Op + 
 40:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 41:     LD  3,-2(1) 	Load variable y
 42:     ST  3,-4(1) 	Save left side 
 43:    LDC  3,333(6) 	Load constant 
 44:     ST  3,-5(1) 	Save left side 
 45:    LDC  3,444(6) 	Load constant 
 46:     ST  3,-6(1) 	Save left side 
 47:    LDC  3,555(6) 	Load constant 
 48:     LD  4,-6(1) 	Load left into ac1 
 49:    ADD  3,4,3 	Op + 
 50:     LD  4,-5(1) 	Load left into ac1 
 51:    MUL  3,4,3 	Op * 
 52:     LD  4,-4(1) 	Load left into ac1 
 53:    ADD  3,4,3 	Op + 
 54:     ST  3,-3(1) 	Store variable z
* EXPRESSION STMT
 55:    LDC  3,111(6) 	Load constant 
 56:     ST  3,-4(1) 	Save left side 
 57:    LDC  3,222(6) 	Load constant 
 58:     LD  4,-4(1) 	Load left into ac1 
 59:    ADD  3,4,3 	Op + 
 60:     ST  3,-4(1) 	Save left side 
 61:    LDC  3,333(6) 	Load constant 
 62:     ST  3,-5(1) 	Save left side 
 63:    LDC  3,444(6) 	Load constant 
 64:     LD  4,-5(1) 	Load left into ac1 
 65:    ADD  3,4,3 	Op + 
 66:     LD  4,-4(1) 	Load left into ac1 
 67:    MUL  3,4,3 	Op * 
 68:     ST  3,-1(1) 	Store variable w
* EXPRESSION STMT
* EXPRESSION STMT
 69:     ST  1,-4(1) 	Store old frame in ghost frame 
 70:    LDC  3,3(6) 	Load constant 
 71:     ST  3,-6(1) 	Store parameter 
 72:    LDA  1,-4(1) 	Load address of new frame 
 73:    LDA  3,1(7) 	Return address in ac 
 74:    LDA  7,-45(7) 	CALL dog
 75:    LDA  3,0(2) 	Save the result in ac 
 76:     ST  3,-4(1) 	Save left side 
* EXPRESSION STMT
 77:     ST  1,-5(1) 	Store old frame in ghost frame 
 78:    LDC  3,3(6) 	Load constant 
 79:     ST  3,-7(1) 	Store parameter 
 80:    LDA  1,-5(1) 	Load address of new frame 
 81:    LDA  3,1(7) 	Return address in ac 
 82:    LDA  7,-53(7) 	CALL dog
 83:    LDA  3,0(2) 	Save the result in ac 
 84:     LD  4,-4(1) 	Load left into ac1 
 85:    MUL  3,4,3 	Op * 
 86:     ST  3,-1(1) 	Store variable w
* RETURN
 87:     LD  3,-3(1) 	Load variable z
 88:    LDA  2,0(3) 	Copy result to rt register 
 89:     LD  3,-1(1) 	Load return address 
 90:     LD  1,0(1) 	Adjust fp 
 91:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 92:    LDC  2,0(6) 	Set return value to 0 
 93:     LD  3,-1(1) 	Load return address 
 94:     LD  1,0(1) 	Adjust fp 
 95:    LDA  7,0(3) 	Return 
* END function dog
* BEGIN function main
 96:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 97:     ST  1,-2(1) 	Store old frame in ghost frame 
 98:    LDC  3,666(6) 	Load constant 
 99:     ST  3,-4(1) 	Store parameter 
100:    LDA  1,-2(1) 	Load address of new frame 
101:    LDA  3,1(7) 	Return address in ac 
102:    LDA  7,-73(7) 	CALL dog
103:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
104:    LDC  2,0(6) 	Set return value to 0 
105:     LD  3,-1(1) 	Load return address 
106:     LD  1,0(1) 	Adjust fp 
107:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,107(7) 	Jump to init 
* BEGIN Init
108:     LD  0,0(0) 	Set the global pointer 
109:    LDA  1,-1(0) 	set first frame at end of globals 
110:     ST  1,0(1) 	store old fp (point to self) 
111:    LDA  3,1(7) 	Return address in ac 
112:    LDA  7,-17(7) 	Jump to main 
113:   HALT  0,0,0 	DONE! 
* END Init
