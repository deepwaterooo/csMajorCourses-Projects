* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  while.tm
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
* BEGIN function main
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,10(6) 	Load constant 
 32:     ST  3,0(1) 	Store variable i
* WHILE
 33:     LD  3,0(1) 	Load variable i
 34:     ST  3,-2(1) 	Save left side 
 35:    LDC  3,0(6) 	Load constant 
 36:     LD  4,-2(1) 	Load left into ac1 
 37:    SUB  4,4,3 	Op > 
 38:    LDC  3,1(6) 	True case 
 39:    JLT  4,1(7) 	Jump if true 
 40:    LDC  3,0(6) 	False case 
 41:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 43:     ST  1,-2(1) 	Store old frame in ghost frame 
 44:     LD  3,0(1) 	Load variable i
 45:     ST  3,-4(1) 	Store parameter 
 46:    LDA  1,-2(1) 	Load address of new frame 
 47:    LDA  3,1(7) 	Return address in ac 
 48:    LDA  7,-43(7) 	CALL output
 49:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
* END compound statement
 50:    LDA  7,-18(7) 	go to beginning of loop 
 42:    LDA  7,8(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 51:     ST  1,-2(1) 	Store old frame in ghost frame 
 52:    LDA  1,-2(1) 	Load address of new frame 
 53:    LDA  3,1(7) 	Return address in ac 
 54:    LDA  7,-30(7) 	CALL outnl
 55:    LDA  3,0(2) 	Save the result in ac 
* WHILE
 56:     LD  3,0(1) 	Load variable i
 57:     ST  3,-2(1) 	Save left side 
 58:    LDC  3,10(6) 	Load constant 
 59:     LD  4,-2(1) 	Load left into ac1 
 60:    SUB  4,4,3 	Op < 
 61:    LDC  3,1(6) 	True case 
 62:    JLT  4,1(7) 	Jump if true 
 63:    LDC  3,0(6) 	False case 
 64:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
 66:     LD  3,0(1) 	Load variable i
 67:     ST  3,-2(1) 	Save left side 
 68:    LDC  3,1(6) 	Load constant 
 69:     LD  4,-2(1) 	Load left into ac1 
 70:    ADD  3,4,3 	Op + 
 71:     ST  3,0(1) 	Store variable i
 72:    LDA  7,-17(7) 	go to beginning of loop 
 65:    LDA  7,7(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 73:     ST  1,-2(1) 	Store old frame in ghost frame 
 74:     LD  3,0(1) 	Load variable i
 75:     ST  3,-4(1) 	Store parameter 
 76:    LDA  1,-2(1) 	Load address of new frame 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-73(7) 	CALL output
 79:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 80:    LDC  2,0(6) 	Set return value to 0 
 81:     LD  3,-1(1) 	Load return address 
 82:     LD  1,0(1) 	Adjust fp 
 83:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,83(7) 	Jump to init 
* BEGIN Init
 84:     LD  0,0(0) 	Set the global pointer 
 85:    LDA  1,0(0) 	set first frame at end of globals 
 86:     ST  1,0(1) 	store old fp (point to self) 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-59(7) 	Jump to main 
 89:   HALT  0,0,0 	DONE! 
* END Init
