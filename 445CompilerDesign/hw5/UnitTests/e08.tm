* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  e08.tm
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
 34:     ST  3,-2(1) 	Save left side 
 35:    LDC  3,10(6) 	Load constant 
 36:     LD  4,-2(1) 	Load left into ac1 
 37:    SUB  4,4,3 	Op < 
 38:    LDC  3,1(6) 	True case 
 39:    JLT  4,1(7) 	Jump if true 
 40:    LDC  3,0(6) 	False case 
 41:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 43:     ST  1,-2(1) 	Store old frame in ghost frame 
 44:     LD  3,0(1) 	Load variable x
 45:     ST  3,-4(1) 	Store parameter 
 46:    LDA  1,-2(1) 	Load address of new frame 
 47:    LDA  3,1(7) 	Return address in ac 
 48:    LDA  7,-43(7) 	CALL output
 49:    LDA  3,0(2) 	Save the result in ac 
* IfK:
* IfK: t->child[0] condition
 50:     LD  3,0(1) 	Load variable x
 51:     ST  3,-2(1) 	Save left side 
 52:    LDC  3,5(6) 	Load constant 
 53:     LD  4,-2(1) 	Load left into ac1 
* IfK: t->child[1] then part
* EXPRESSION STMT
 55:     LD  3,0(1) 	Load variable x
 56:     ST  3,-2(1) 	Save left side 
 57:    LDC  3,1(6) 	Load constant 
 58:     LD  4,-2(1) 	Load left into ac1 
 59:    ADD  3,4,3 	Op + 
 60:     ST  3,0(1) 	Store variable x
 54:    JEQ  3,7(7) 	if: jmp to else 
* IfK: t->child[2] else part
 61:    LDA  7,0(7) 	jmp to end 
* ENDIF
* END compound statement
 62:    LDA  7,-30(7) 	go to beginning of loop 
 42:    LDA  7,20(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 63:     ST  1,-2(1) 	Store old frame in ghost frame 
 64:    LDC  3,666(6) 	Load constant 
 65:     ST  3,-4(1) 	Store parameter 
 66:    LDA  1,-2(1) 	Load address of new frame 
 67:    LDA  3,1(7) 	Return address in ac 
 68:    LDA  7,-63(7) 	CALL output
 69:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 70:    LDC  2,0(6) 	Set return value to 0 
 71:     LD  3,-1(1) 	Load return address 
 72:     LD  1,0(1) 	Adjust fp 
 73:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,73(7) 	Jump to init 
* BEGIN Init
 74:     LD  0,0(0) 	Set the global pointer 
 75:    LDA  1,0(0) 	set first frame at end of globals 
 76:     ST  1,0(1) 	store old fp (point to self) 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-49(7) 	Jump to main 
 79:   HALT  0,0,0 	DONE! 
* END Init
