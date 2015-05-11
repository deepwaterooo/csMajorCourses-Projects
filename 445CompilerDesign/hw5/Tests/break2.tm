* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  break2.tm
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
 32:     ST  3,0(1) 	Store variable i
* WHILE
 33:     LD  3,0(1) 	Load variable i
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
 43:    LDC  3,0(6) 	Load constant 
 44:     ST  3,-2(1) 	Store variable j
* WHILE
 45:     LD  3,-2(1) 	Load variable j
 46:     ST  3,-2(1) 	Save left side 
 47:    LDC  3,5(6) 	Load constant 
 48:     LD  4,-2(1) 	Load left into ac1 
 49:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 51:     ST  1,-2(1) 	Store old frame in ghost frame 
 52:     LD  3,0(1) 	Load variable i
 53:     ST  3,-4(1) 	Store parameter 
 54:    LDA  1,-2(1) 	Load address of new frame 
 55:    LDA  3,1(7) 	Return address in ac 
 56:    LDA  7,-51(7) 	CALL output
 57:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 58:     ST  1,-2(1) 	Store old frame in ghost frame 
 59:     LD  3,-2(1) 	Load variable j
 60:     ST  3,-4(1) 	Store parameter 
 61:    LDA  1,-2(1) 	Load address of new frame 
 62:    LDA  3,1(7) 	Return address in ac 
 63:    LDA  7,-58(7) 	CALL output
 64:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 65:     ST  1,-2(1) 	Store old frame in ghost frame 
 66:    LDA  1,-2(1) 	Load address of new frame 
 67:    LDA  3,1(7) 	Return address in ac 
 68:    LDA  7,-44(7) 	CALL outnl
 69:    LDA  3,0(2) 	Save the result in ac 
* IfK:
* IfK: t->child[0] condition
 70:     LD  3,0(1) 	Load variable i
 71:     ST  3,-2(1) 	Save left side 
 72:    LDC  3,4(6) 	Load constant 
 73:     LD  4,-2(1) 	Load left into ac1 
 74:    SUB  4,4,3 	Op > 
 75:    LDC  3,1(6) 	True case 
 76:    JLT  4,1(7) 	Jump if true 
 77:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
 78:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
 79:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
 80:     ST  3,-2(1) 	Store variable j
* END compound statement
 81:    LDA  7,-37(7) 	go to beginning of loop 
 50:    LDA  7,31(7) 	No more loop 
* ENDWHILE
* IfK:
* IfK: t->child[0] condition
 82:     LD  3,-2(1) 	Load variable j
 83:     ST  3,-2(1) 	Save left side 
 84:    LDC  3,3(6) 	Load constant 
 85:     LD  4,-2(1) 	Load left into ac1 
 86:    SUB  4,4,3 	Op > 
 87:    LDC  3,1(6) 	True case 
 88:    JLT  4,1(7) 	Jump if true 
 89:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
 90:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
 91:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
 92:     ST  3,0(1) 	Store variable i
* END compound statement
 93:    LDA  7,-61(7) 	go to beginning of loop 
 50:    LDA  7,43(7) 	No more loop 
* ENDWHILE
* RETURN
 94:    LDC  3,0(6) 	Load constant 
 95:    LDA  2,0(3) 	Copy result to rt register 
 96:     LD  3,-1(1) 	Load return address 
 97:     LD  1,0(1) 	Adjust fp 
 98:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 99:    LDC  2,0(6) 	Set return value to 0 
100:     LD  3,-1(1) 	Load return address 
101:     LD  1,0(1) 	Adjust fp 
102:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,102(7) 	Jump to init 
* BEGIN Init
103:     LD  0,0(0) 	Set the global pointer 
104:    LDA  1,0(0) 	set first frame at end of globals 
105:     ST  1,0(1) 	store old fp (point to self) 
106:    LDA  3,1(7) 	Return address in ac 
107:    LDA  7,-78(7) 	Jump to main 
108:   HALT  0,0,0 	DONE! 
* END Init
