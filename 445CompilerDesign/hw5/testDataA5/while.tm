* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  while.c-
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
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,10(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable i
* WHILE
 33:     LD  3,-2(1) 	Load variable i
 34:     ST  3,-3(1) 	Save left side 
 35:    LDC  3,0(6) 	Load constant 
 36:     LD  4,-3(1) 	Load left into ac1 
 37:    SUB  4,4,3 	Op > 
 38:    LDC  3,1(6) 	True case 
 39:    JGT  4,1(7) 	Jump if true 
 40:    LDC  3,0(6) 	False case 
 41:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 43:     ST  1,-3(1) 	Store old fp in ghost frame 
 44:     LD  3,-2(1) 	Load variable i
 45:     ST  3,-5(1) 	Store parameter 
 46:    LDA  1,-3(1) 	Load address of new frame 
 47:    LDA  3,1(7) 	Return address in ac 
 48:    LDA  7,-43(7) 	CALL output
 49:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 50:     LD  3,-2(1) 	load lhs variable i
 51:    LDA  3,-1(3) 	decrement value of i
 52:     ST  3,-2(1) 	Store variable i
* END compound statement
 53:    LDA  7,-21(7) 	go to beginning of loop 
 42:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 54:     ST  1,-3(1) 	Store old fp in ghost frame 
 55:    LDA  1,-3(1) 	Load address of new frame 
 56:    LDA  3,1(7) 	Return address in ac 
 57:    LDA  7,-33(7) 	CALL outnl
 58:    LDA  3,0(2) 	Save the result in ac 
* WHILE
 59:     LD  3,-2(1) 	Load variable i
 60:     ST  3,-3(1) 	Save left side 
 61:    LDC  3,10(6) 	Load constant 
 62:     LD  4,-3(1) 	Load left into ac1 
 63:    SUB  4,4,3 	Op < 
 64:    LDC  3,1(6) 	True case 
 65:    JLT  4,1(7) 	Jump if true 
 66:    LDC  3,0(6) 	False case 
 67:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
 69:     LD  3,-2(1) 	Load variable i
 70:     ST  3,-3(1) 	Save left side 
 71:    LDC  3,1(6) 	Load constant 
 72:     LD  4,-3(1) 	Load left into ac1 
 73:    ADD  3,4,3 	Op + 
 74:     ST  3,-2(1) 	Store variable i
 75:    LDA  7,-17(7) 	go to beginning of loop 
 68:    LDA  7,7(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 76:     ST  1,-3(1) 	Store old fp in ghost frame 
 77:     LD  3,-2(1) 	Load variable i
 78:     ST  3,-5(1) 	Store parameter 
 79:    LDA  1,-3(1) 	Load address of new frame 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-76(7) 	CALL output
 82:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 83:    LDC  2,0(6) 	Set return value to 0 
 84:     LD  3,-1(1) 	Load return address 
 85:     LD  1,0(1) 	Adjust fp 
 86:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,86(7) 	Jump to init 
* BEGIN Init
 87:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 88:    LDA  1,0(0) 	set first frame at end of globals 
 89:     ST  1,0(1) 	store old fp (point to self) 
 90:    LDA  3,1(7) 	Return address in ac 
 91:    LDA  7,-62(7) 	Jump to main 
 92:   HALT  0,0,0 	DONE! 
* END Init
