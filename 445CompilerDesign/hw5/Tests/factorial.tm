* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  factorial.tm
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
 53:     ST  3,0(1) 	Store variable i
* END compound statement
 54:    LDA  7,-21(7) 	go to beginning of loop 
 39:    LDA  7,15(7) 	No more loop 
* ENDWHILE
* RETURN
 55:     LD  3,-3(1) 	Load variable f
 56:    LDA  2,0(3) 	Copy result to rt register 
 57:     LD  3,-1(1) 	Load return address 
 58:     LD  1,0(1) 	Adjust fp 
 59:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 60:    LDC  2,0(6) 	Set return value to 0 
 61:     LD  3,-1(1) 	Load return address 
 62:     LD  1,0(1) 	Adjust fp 
 63:    LDA  7,0(3) 	Return 
* END function factorial
* BEGIN function main
 64:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
* EXPRESSION STMT
 65:     ST  1,-2(1) 	Store old frame in ghost frame 
 66:    LDA  1,-2(1) 	Load address of new frame 
 67:    LDA  3,1(7) 	Return address in ac 
 68:    LDA  7,-68(7) 	CALL input
 69:    LDA  3,0(2) 	Save the result in ac 
 70:     ST  3,-2(1) 	Store variable n
* EXPRESSION STMT
* EXPRESSION STMT
 71:     ST  1,-2(1) 	Store old frame in ghost frame 
 72:     LD  3,-2(1) 	Load variable n
 73:     ST  3,-4(1) 	Store parameter 
 74:    LDA  1,-2(1) 	Load address of new frame 
 75:    LDA  3,1(7) 	Return address in ac 
 76:    LDA  7,-47(7) 	CALL factorial
 77:    LDA  3,0(2) 	Save the result in ac 
 78:     ST  3,-2(1) 	Store variable n
* EXPRESSION STMT
 79:     ST  1,-2(1) 	Store old frame in ghost frame 
 80:     LD  3,-2(1) 	Load variable n
 81:     ST  3,-4(1) 	Store parameter 
 82:    LDA  1,-2(1) 	Load address of new frame 
 83:    LDA  3,1(7) 	Return address in ac 
 84:    LDA  7,-79(7) 	CALL output
 85:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 86:     ST  1,-2(1) 	Store old frame in ghost frame 
 87:    LDA  1,-2(1) 	Load address of new frame 
 88:    LDA  3,1(7) 	Return address in ac 
 89:    LDA  7,-65(7) 	CALL outnl
 90:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 91:    LDC  2,0(6) 	Set return value to 0 
 92:     LD  3,-1(1) 	Load return address 
 93:     LD  1,0(1) 	Adjust fp 
 94:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,94(7) 	Jump to init 
* BEGIN Init
 95:     LD  0,0(0) 	Set the global pointer 
 96:    LDA  1,0(0) 	set first frame at end of globals 
 97:     ST  1,0(1) 	store old fp (point to self) 
 98:    LDA  3,1(7) 	Return address in ac 
 99:    LDA  7,-36(7) 	Jump to main 
100:   HALT  0,0,0 	DONE! 
* END Init
