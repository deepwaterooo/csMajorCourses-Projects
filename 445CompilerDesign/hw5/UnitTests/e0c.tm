* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  e0c.tm
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
 31:    LDC  3,0(6) 	Load constant 
 32:     ST  3,0(1) 	Store variable x
* WHILE
 33:     LD  3,0(1) 	Load variable x
 34:     ST  3,-3(1) 	Save left side 
 35:    LDC  3,6(6) 	Load constant 
 36:     LD  4,-3(1) 	Load left into ac1 
 37:    SUB  4,4,3 	Op < 
 38:    LDC  3,1(6) 	True case 
 39:    JLT  4,1(7) 	Jump if true 
 40:    LDC  3,0(6) 	False case 
 41:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 43:    LDC  3,0(6) 	Load constant 
 44:     ST  3,-2(1) 	Store variable y
* WHILE
 45:     LD  3,-2(1) 	Load variable y
 46:     ST  3,-3(1) 	Save left side 
 47:    LDC  3,6(6) 	Load constant 
 48:     LD  4,-3(1) 	Load left into ac1 
 49:    SUB  4,4,3 	Op < 
 50:    LDC  3,1(6) 	True case 
 51:    JLT  4,1(7) 	Jump if true 
 52:    LDC  3,0(6) 	False case 
 53:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 55:     ST  1,-3(1) 	Store old frame in ghost frame 
 56:     LD  3,-2(1) 	Load variable y
 57:     ST  3,-5(1) 	Store parameter 
 58:    LDA  1,-3(1) 	Load address of new frame 
 59:    LDA  3,1(7) 	Return address in ac 
 60:    LDA  7,-55(7) 	CALL output
 61:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 62:     LD  3,-2(1) 	Load variable y
 63:     ST  3,-3(1) 	Save left side 
 64:    LDC  3,1(6) 	Load constant 
 65:     LD  4,-3(1) 	Load left into ac1 
 66:    ADD  3,4,3 	Op + 
 67:     ST  3,-2(1) 	Store variable y
* END compound statement
 68:    LDA  7,-24(7) 	go to beginning of loop 
 54:    LDA  7,14(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 69:     ST  1,-3(1) 	Store old frame in ghost frame 
 70:     LD  3,0(1) 	Load variable x
 71:     ST  3,-5(1) 	Store parameter 
 72:    LDA  1,-3(1) 	Load address of new frame 
 73:    LDA  3,1(7) 	Return address in ac 
 74:    LDA  7,-69(7) 	CALL output
 75:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 76:     LD  3,0(1) 	Load variable x
 77:     ST  3,-3(1) 	Save left side 
 78:    LDC  3,1(6) 	Load constant 
 79:     LD  4,-3(1) 	Load left into ac1 
 80:    ADD  3,4,3 	Op + 
 81:     ST  3,0(1) 	Store variable x
* END compound statement
 82:    LDA  7,-50(7) 	go to beginning of loop 
 42:    LDA  7,40(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
 83:    LDC  2,0(6) 	Set return value to 0 
 84:     LD  3,-1(1) 	Load return address 
 85:     LD  1,0(1) 	Adjust fp 
 86:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,86(7) 	Jump to init 
* BEGIN Init
 87:     LD  0,0(0) 	Set the global pointer 
 88:    LDA  1,0(0) 	set first frame at end of globals 
 89:     ST  1,0(1) 	store old fp (point to self) 
 90:    LDA  3,1(7) 	Return address in ac 
 91:    LDA  7,-62(7) 	Jump to main 
 92:   HALT  0,0,0 	DONE! 
* END Init
