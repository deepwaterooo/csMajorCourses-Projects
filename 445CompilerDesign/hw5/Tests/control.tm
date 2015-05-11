* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  control.tm
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
* IfK:
* IfK: t->child[0] condition
 31:    LDC  3,6(6) 	Load constant 
 32:     ST  3,-2(1) 	Save left side 
 33:    LDC  3,3(6) 	Load constant 
 34:     LD  4,-2(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op > 
 36:    LDC  3,1(6) 	True case 
 37:    JLT  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* BEGIN compound statement
* EXPRESSION STMT
 40:    LDC  3,111(6) 	Load constant 
 41:     ST  3,0(1) 	Store variable x
* END compound statement
 39:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* BEGIN compound statement
* EXPRESSION STMT
 43:    LDC  3,222(6) 	Load constant 
 44:     ST  3,0(1) 	Store variable x
* END compound statement
 42:    LDA  7,2(7) 	jmp to end 
* ENDIF
* WHILE
 45:    LDC  3,7(6) 	Load constant 
 46:     ST  3,-2(1) 	Save left side 
 47:    LDC  3,3(6) 	Load constant 
 48:     LD  4,-2(1) 	Load left into ac1 
 49:    SUB  4,4,3 	Op > 
 50:    LDC  3,1(6) 	True case 
 51:    JLT  4,1(7) 	Jump if true 
 52:    LDC  3,0(6) 	False case 
 53:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 55:    LDC  3,333(6) 	Load constant 
 56:     ST  3,0(1) 	Store variable x
* IfK:
* IfK: t->child[0] condition
 57:     LD  3,0(1) 	Load variable x
 58:     ST  3,-2(1) 	Save left side 
 59:    LDC  3,9(6) 	Load constant 
 60:     LD  4,-2(1) 	Load left into ac1 
 61:    SUB  4,4,3 	Op < 
 62:    LDC  3,1(6) 	True case 
 63:    JLT  4,1(7) 	Jump if true 
 64:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
 65:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
 66:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
 67:    LDC  3,444(6) 	Load constant 
 68:     ST  3,0(1) 	Store variable x
* END compound statement
 69:    LDA  7,-25(7) 	go to beginning of loop 
 54:    LDA  7,15(7) 	No more loop 
* ENDWHILE
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
