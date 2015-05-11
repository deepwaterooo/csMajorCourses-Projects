* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  factorial2.tm
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
* BEGIN function factorial
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
* EXPRESSION STMT
 31:    LDC  3,1(6) 	Load constant 
 32:     ST  3,0(1) 	Store variable i
 33:     ST  3,-3(1) 	Store variable f
* WHILE
 34:     LD  3,0(1) 	Load variable i
 35:     ST  3,-4(1) 	Save left side 
 36:     LD  3,-2(1) 	Load variable n
 37:     LD  4,-4(1) 	Load left into ac1 
 38:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 40:     ST  1,-4(1) 	Store old frame in ghost frame 
 41:     LD  3,0(1) 	Load variable i
 42:     ST  3,-6(1) 	Store parameter 
 43:    LDA  1,-4(1) 	Load address of new frame 
 44:    LDA  3,1(7) 	Return address in ac 
 45:    LDA  7,-40(7) 	CALL output
 46:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 47:     LD  3,-3(1) 	Load variable f
 48:     ST  3,-4(1) 	Save left side 
 49:     LD  3,0(1) 	Load variable i
 50:     LD  4,-4(1) 	Load left into ac1 
 51:    MUL  3,4,3 	Op * 
 52:     ST  3,-3(1) 	Store variable f
* EXPRESSION STMT
 53:    LDC  3,1(6) 	Load constant 
 54:     ST  3,0(1) 	Store variable i
* END compound statement
 55:    LDA  7,-22(7) 	go to beginning of loop 
 39:    LDA  7,16(7) 	No more loop 
* ENDWHILE
* RETURN
 56:     LD  3,-3(1) 	Load variable f
 57:    LDA  2,0(3) 	Copy result to rt register 
 58:     LD  3,-1(1) 	Load return address 
 59:     LD  1,0(1) 	Adjust fp 
 60:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 61:    LDC  2,0(6) 	Set return value to 0 
 62:     LD  3,-1(1) 	Load return address 
 63:     LD  1,0(1) 	Adjust fp 
 64:    LDA  7,0(3) 	Return 
* END function factorial
* BEGIN function main
 65:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
* EXPRESSION STMT
 66:     ST  1,-2(1) 	Store old frame in ghost frame 
 67:    LDA  1,-2(1) 	Load address of new frame 
 68:    LDA  3,1(7) 	Return address in ac 
 69:    LDA  7,-69(7) 	CALL input
 70:    LDA  3,0(2) 	Save the result in ac 
 71:     ST  3,-2(1) 	Store variable n
* EXPRESSION STMT
* EXPRESSION STMT
 72:     ST  1,-2(1) 	Store old frame in ghost frame 
 73:     LD  3,-2(1) 	Load variable n
 74:     ST  3,-4(1) 	Store parameter 
 75:    LDA  1,-2(1) 	Load address of new frame 
 76:    LDA  3,1(7) 	Return address in ac 
 77:    LDA  7,-48(7) 	CALL factorial
 78:    LDA  3,0(2) 	Save the result in ac 
 79:     ST  3,-2(1) 	Store variable n
* EXPRESSION STMT
 80:     ST  1,-2(1) 	Store old frame in ghost frame 
 81:     LD  3,-2(1) 	Load variable n
 82:     ST  3,-4(1) 	Store parameter 
 83:    LDA  1,-2(1) 	Load address of new frame 
 84:    LDA  3,1(7) 	Return address in ac 
 85:    LDA  7,-80(7) 	CALL output
 86:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 87:     ST  1,-2(1) 	Store old frame in ghost frame 
 88:    LDA  1,-2(1) 	Load address of new frame 
 89:    LDA  3,1(7) 	Return address in ac 
 90:    LDA  7,-66(7) 	CALL outnl
 91:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 92:    LDC  2,0(6) 	Set return value to 0 
 93:     LD  3,-1(1) 	Load return address 
 94:     LD  1,0(1) 	Adjust fp 
 95:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,95(7) 	Jump to init 
* BEGIN Init
 96:     LD  0,0(0) 	Set the global pointer 
 97:    LDA  1,0(0) 	set first frame at end of globals 
 98:     ST  1,0(1) 	store old fp (point to self) 
 99:    LDA  3,1(7) 	Return address in ac 
100:    LDA  7,-36(7) 	Jump to main 
101:   HALT  0,0,0 	DONE! 
* END Init
