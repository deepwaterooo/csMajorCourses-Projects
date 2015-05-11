* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  if.c-
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
 31:    LDC  3,23(6) 	Load constant 
 32:     ST  3,-3(1) 	Store variable j
 33:     ST  3,-2(1) 	Store variable i
* IF
 34:     LD  3,-2(1) 	Load variable i
 35:     ST  3,-4(1) 	Save left side 
 36:     LD  3,-3(1) 	Load variable j
 37:     LD  4,-4(1) 	Load left into ac1 
 38:    SUB  4,4,3 	Op > 
 39:    LDC  3,1(6) 	True case 
 40:    JGT  4,1(7) 	Jump if true 
 41:    LDC  3,0(6) 	False case 
 42:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 44:    LDC  3,666(6) 	Load constant 
 45:     ST  3,-2(1) 	Store variable i
 43:    LDA  7,2(7) 	Jump around the THEN 
* ENDIF
* IF
 46:     LD  3,-3(1) 	Load variable j
 47:     ST  3,-4(1) 	Save left side 
 48:     LD  3,-2(1) 	Load variable i
 49:     LD  4,-4(1) 	Load left into ac1 
 50:    SUB  4,4,3 	Op == 
 51:    LDC  3,1(6) 	True case 
 52:    JEQ  4,1(7) 	Jump if true 
 53:    LDC  3,0(6) 	False case 
 54:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 56:    LDC  3,666(6) 	Load constant 
 57:     ST  3,-2(1) 	Store variable i
* ELSE
 55:    LDA  7,3(7) 	Jump around the THEN 
* EXPRESSION STMT
 59:    LDC  3,777(6) 	Load constant 
 60:     ST  3,-3(1) 	Store variable j
 58:    LDA  7,2(7) 	Jump around the ELSE 
* ENDIF
* EXPRESSION STMT
 61:     ST  1,-4(1) 	Store old fp in ghost frame 
 62:     LD  3,-2(1) 	Load variable i
 63:     ST  3,-6(1) 	Store parameter 
 64:    LDA  1,-4(1) 	Load address of new frame 
 65:    LDA  3,1(7) 	Return address in ac 
 66:    LDA  7,-61(7) 	CALL output
 67:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 68:     ST  1,-4(1) 	Store old fp in ghost frame 
 69:     LD  3,-3(1) 	Load variable j
 70:     ST  3,-6(1) 	Store parameter 
 71:    LDA  1,-4(1) 	Load address of new frame 
 72:    LDA  3,1(7) 	Return address in ac 
 73:    LDA  7,-68(7) 	CALL output
 74:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 75:     ST  1,-4(1) 	Store old fp in ghost frame 
 76:    LDA  1,-4(1) 	Load address of new frame 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-54(7) 	CALL outnl
 79:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 80:    LDC  2,0(6) 	Set return value to 0 
 81:     LD  3,-1(1) 	Load return address 
 82:     LD  1,0(1) 	Adjust fp 
 83:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,83(7) 	Jump to init 
* BEGIN Init
 84:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 85:    LDA  1,0(0) 	set first frame at end of globals 
 86:     ST  1,0(1) 	store old fp (point to self) 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-59(7) 	Jump to main 
 89:   HALT  0,0,0 	DONE! 
* END Init
