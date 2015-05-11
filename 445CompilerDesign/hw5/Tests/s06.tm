* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  s06.tm
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
* RETURN
* EXPRESSION STMT
 31:     ST  3,0(1) 	Store variable x
 32:    LDA  2,0(3) 	Copy result to rt register 
 33:     LD  3,-1(1) 	Load return address 
 34:     LD  1,0(1) 	Adjust fp 
 35:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 36:    LDC  2,0(6) 	Set return value to 0 
 37:     LD  3,-1(1) 	Load return address 
 38:     LD  1,0(1) 	Adjust fp 
 39:    LDA  7,0(3) 	Return 
* END function dog
* BEGIN function main
 40:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 41:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 42:     ST  1,-4(1) 	Store old frame in ghost frame 
 43:    LDA  1,-4(1) 	Load address of new frame 
 44:    LDA  3,1(7) 	Return address in ac 
 45:    LDA  7,-16(7) 	CALL dog
 46:    LDA  3,0(2) 	Save the result in ac 
 47:     ST  3,-4(1) 	Store parameter 
 48:    LDA  1,-2(1) 	Load address of new frame 
 49:    LDA  3,1(7) 	Return address in ac 
 50:    LDA  7,-45(7) 	CALL output
 51:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 52:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 53:     ST  1,-4(1) 	Store old frame in ghost frame 
 54:    LDA  1,-4(1) 	Load address of new frame 
 55:    LDA  3,1(7) 	Return address in ac 
 56:    LDA  7,-27(7) 	CALL dog
 57:    LDA  3,0(2) 	Save the result in ac 
 58:     ST  3,-4(1) 	Store parameter 
 59:    LDA  1,-2(1) 	Load address of new frame 
 60:    LDA  3,1(7) 	Return address in ac 
 61:    LDA  7,-56(7) 	CALL output
 62:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 63:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 64:     ST  1,-4(1) 	Store old frame in ghost frame 
 65:    LDA  1,-4(1) 	Load address of new frame 
 66:    LDA  3,1(7) 	Return address in ac 
 67:    LDA  7,-38(7) 	CALL dog
 68:    LDA  3,0(2) 	Save the result in ac 
 69:     ST  3,-4(1) 	Store parameter 
 70:    LDA  1,-2(1) 	Load address of new frame 
 71:    LDA  3,1(7) 	Return address in ac 
 72:    LDA  7,-67(7) 	CALL output
 73:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 74:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 75:     ST  1,-4(1) 	Store old frame in ghost frame 
 76:    LDA  1,-4(1) 	Load address of new frame 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-49(7) 	CALL dog
 79:    LDA  3,0(2) 	Save the result in ac 
 80:     ST  3,-4(1) 	Store parameter 
 81:    LDA  1,-2(1) 	Load address of new frame 
 82:    LDA  3,1(7) 	Return address in ac 
 83:    LDA  7,-78(7) 	CALL output
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
 90:    LDA  1,0(0) 	set first frame at end of globals 
 91:     ST  1,0(1) 	store old fp (point to self) 
 92:    LDA  3,1(7) 	Return address in ac 
 93:    LDA  7,-54(7) 	Jump to main 
 94:   HALT  0,0,0 	DONE! 
* END Init
