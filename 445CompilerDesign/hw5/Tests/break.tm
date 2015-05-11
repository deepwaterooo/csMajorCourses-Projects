* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  break.tm
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
* BEGIN function frozenOnTheCuspOfForeverTheSpacecraftHungLikeATimelessDewdropOnTheLeavesOfSpace
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
* EXPRESSION STMT
* EXPRESSION STMT
 31:    LDC  3,0(6) 	Load constant 
 32:     ST  3,-3(1) 	Store variable c
 33:     ST  3,-2(1) 	Store variable b
 34:     ST  3,0(1) 	Store variable a
* WHILE
 35:     LD  3,0(1) 	Load variable a
 36:     ST  3,-4(1) 	Save left side 
 37:    LDC  3,3(6) 	Load constant 
 38:     LD  4,-4(1) 	Load left into ac1 
 39:    SUB  4,4,3 	Op < 
 40:    LDC  3,1(6) 	True case 
 41:    JLT  4,1(7) 	Jump if true 
 42:    LDC  3,0(6) 	False case 
 43:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* WHILE
 45:     LD  3,-2(1) 	Load variable b
 46:     ST  3,-4(1) 	Save left side 
 47:    LDC  3,3(6) 	Load constant 
 48:     LD  4,-4(1) 	Load left into ac1 
 49:    SUB  4,4,3 	Op < 
 50:    LDC  3,1(6) 	True case 
 51:    JLT  4,1(7) 	Jump if true 
 52:    LDC  3,0(6) 	False case 
 53:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* WHILE
 55:     LD  3,-3(1) 	Load variable c
 56:     ST  3,-4(1) 	Save left side 
 57:    LDC  3,3(6) 	Load constant 
 58:     LD  4,-4(1) 	Load left into ac1 
 59:    SUB  4,4,3 	Op < 
 60:    LDC  3,1(6) 	True case 
 61:    JLT  4,1(7) 	Jump if true 
 62:    LDC  3,0(6) 	False case 
 63:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 65:     ST  3,-3(1) 	Store variable c
* IfK:
* IfK: t->child[0] condition
 66:     LD  3,-3(1) 	Load variable c
 67:     ST  3,-4(1) 	Save left side 
 68:    LDC  3,2(6) 	Load constant 
 69:     LD  4,-4(1) 	Load left into ac1 
 70:    SUB  4,4,3 	Op == 
 71:    LDC  3,1(6) 	True case 
 72:    JEQ  4,1(7) 	Jump if true 
 73:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
 74:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
 75:    LDA  7,0(7) 	jmp to end 
* ENDIF
* END compound statement
 76:    LDA  7,-22(7) 	go to beginning of loop 
 64:    LDA  7,12(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 77:     ST  3,-2(1) 	Store variable b
* IfK:
* IfK: t->child[0] condition
 78:     LD  3,-2(1) 	Load variable b
 79:     ST  3,-4(1) 	Save left side 
 80:    LDC  3,2(6) 	Load constant 
 81:     LD  4,-4(1) 	Load left into ac1 
 82:    SUB  4,4,3 	Op == 
 83:    LDC  3,1(6) 	True case 
 84:    JEQ  4,1(7) 	Jump if true 
 85:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
 86:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
 87:    LDA  7,0(7) 	jmp to end 
* ENDIF
* END compound statement
 88:    LDA  