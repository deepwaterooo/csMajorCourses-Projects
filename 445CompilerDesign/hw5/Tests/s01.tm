* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  s01.tm
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
* BEGIN function save
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 31:     LD  3,-3(1) 	Load variable y
 32:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 33:     LD  3,-2(1) 	Load variable z
 34:     ST  3,-3(1) 	Store variable y
* RETURN
 35:     LD  3,0(1) 	Load variable x
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
* END function save
* BEGIN function main
 44:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 45:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 46:     ST  1,-4(1) 	Store old frame in ghost frame 
 47:    LDC  3,1(6) 	Load constant 
 48:     ST  3,-6(1) 	Store parameter 
 49:    LDA  1,-4(1) 	Load address of new frame 
 50:    LDA  3,1(7) 	Return address in ac 
 51:    LDA  7,-22(7) 	CALL save
 52:    LDA  3,0(2) 	Save the result in ac 
 53:     ST  3,-4(1) 	Store parameter 
 54:    LDA  1,-2(1) 	Load address of new frame 
 55:    LDA  3,1(7) 	Return address in ac 
 56:    LDA  7,-51(7) 	CALL output
 57:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 58:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 59:     ST  1,-4(1) 	Store old frame in ghost frame 
 60:    LDC  3,2(6) 	Load constant 
 61:     ST  3,-6(1) 	Store parameter 
 62:    LDA  1,-4(1) 	Load address of new frame 
 63:    LDA  3,1(7) 	Return address in ac 
 64:    LDA  7,-35(7) 	CALL save
 65:    LDA  3,0(2) 	Save the result in ac 
 66:     ST  3,-4(1) 	Store parameter 
 67:    LDA  1,-2(1) 	Load address of new frame 
 68:    LDA  3,1(7) 	Return address in ac 
 69:    LDA  7,-64(7) 	CALL output
 70:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 71:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 72:     ST  1,-4(1) 	Store old frame in ghost frame 
 73:    LDC  3,3(6) 	Load constant 
 74:     ST  3,-6(1) 	Store parameter 
 75:    LDA  1,-4(1) 	Load address of new frame 
 76:    LDA  3,1(7) 	Return address in ac 
 77:    LDA  7,-48(7) 	CALL save
 78:    LDA  3,0(2) 	Save the result in ac 
 79:     ST  3,-4(1) 	Store parameter 
 80:    LDA  1,-2(1) 	Load address of new frame 
 81:    LDA  3,1(7) 	Return address in ac 
 82:    LDA  7,-77(7) 	CALL output
 83:    LDA  3,0(2) 	Save the result in ac 
* RETURN
 84:    LDC  3,0(6) 	Load constant 
 85:    LDA  2,0(3) 	Copy result to rt register 
 86:     LD  3,-1(1) 	Load return address 
 87:     LD  1,0(1) 	Adjust fp 
 88:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 89:    LDC  2,0(6) 	Set return value to 0 
 90:     LD  3,-1(1) 	Load return address 
 91:     LD  1,0(1) 	Adjust fp 
 92:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,92(7) 	Jump to init 
* BEGIN Init
 93:     LD  0,0(0) 	Set the global pointer 
 94:    LDA  1,0(0) 	set first frame at end of globals 
 95:     ST  1,0(1) 	store old fp (point to self) 
 96:    LDA  3,1(7) 	Return address in ac 
 97:    LDA  7,-54(7) 	Jump to main 
 98:   HALT  0,0,0 	DONE! 
* END Init
