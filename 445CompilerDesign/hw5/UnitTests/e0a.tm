* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  e0a.tm
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
* IfK:
* IfK: t->child[0] condition
 33:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
 35:     LD  3,0(1) 	Load variable x
 36:     ST  3,-2(1) 	Save left side 
 37:    LDC  3,10(6) 	Load constant 
 38:     LD  4,-2(1) 	Load left into ac1 
 39:    SUB  4,4,3 	Op < 
 40:    LDC  3,1(6) 	True case 
 41:    JLT  4,1(7) 	Jump if true 
 42:    LDC  3,0(6) 	False case 
 43:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 45:     ST  1,-2(1) 	Store old frame in ghost frame 
 46:     LD  3,0(1) 	Load variable x
 47:     ST  3,-4(1) 	Store parameter 
 48:    LDA  1,-2(1) 	Load address of new frame 
 49:    LDA  3,1(7) 	Return address in ac 
 50:    LDA  7,-45(7) 	CALL output
 51:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 52:     LD  3,0(1) 	Load variable x
 53:     ST  3,-2(1) 	Save left side 
 54:    LDC  3,1(6) 	Load constant 
 55:     LD  4,-2(1) 	Load left into ac1 
 56:    ADD  3,4,3 	Op + 
 57:     ST  3,0(1) 	Store variable x
* END compound statement
 58:    LDA  7,-24(7) 	go to beginning of loop 
 44:    LDA  7,14(7) 	No more loop 
* ENDWHILE
 34:    JEQ  3,25(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
 60:     ST  1,-2(1) 	Store old frame in ghost frame 
 61:    LDC  3,666(6) 	Load constant 
 62:     ST  3,-4(1) 	Store parameter 
 63:    LDA  1,-2(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-60(7) 	CALL output
 66:    LDA  3,0(2) 	Save the result in ac 
 59:    LDA  7,7(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
 67:    LDC  3,0(6) 	Load constant 
 68:     ST  3,0(1) 	Store variable x
* IfK:
* IfK: t->child[0] condition
 69:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* WHILE
 71:     LD  3,0(1) 	Load variable x
 72:     ST  3,-2(1) 	Save left side 
 73:    LDC  3,10(6) 	Load constant 
 74:     LD  4,-2(1) 	Load left into ac1 
 75:    SUB  4,4,3 	Op < 
 76:    LDC  3,1(6) 	True case 
 77:    JLT  4,1(7) 	Jump if true 
 78:    LDC  3,0(6) 	False case 
 79:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 81:     ST  1,-2(1) 	Store old frame in ghost frame 
 82:     LD  3,0(1) 	Load variable x
 83:     ST  3,-4(1) 	Store parameter 
 84:    LDA  1,-2(1) 	Load address of new frame 
 85:    LDA  3,1(7) 	Return address in ac 
 86:    LDA  7,-81(7) 	CALL output
 87:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 88:     LD  3,0(1) 	Load variable x
 89:     ST  3,-2(1) 	Save left side 
 90:    LDC  3,1(6) 	Load constant 
 91:     LD  4,-2(1) 	Load left into ac1 
 92:    ADD  3,4,3 	Op + 
 93:     ST  3,0(1) 	Store variable x
* END compound statement
 94:    LDA  7,-24(7) 	go to beginning of loop 
 80:    LDA  7,14(7) 	No more loop 
* ENDWHILE
 70:    JEQ  3,25(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
 96:     ST  1,-2(1) 	Store old frame in ghost frame 
 97:    LDC  3,666(6) 	Load constant 
 98:     ST  3,-4(1) 	Store parameter 
 99:    LDA  1,-2(1) 	Load address of new frame 
100:    LDA  3,1(7) 	Return address in ac 
101:    LDA  7,-96(7) 	CALL output
102:    LDA  3,0(2) 	Save the result in ac 
 95:    LDA  7,7(7) 	jmp to end 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
103:    LDC  2,0(6) 	Set return value to 0 
104:     LD  3,-1(1) 	Load return address 
105:     LD  1,0(1) 	Adjust fp 
106:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,106(7) 	Jump to init 
* BEGIN Init
107:     LD  0,0(0) 	Set the global pointer 
108:    LDA  1,0(0) 	set first frame at end of globals 
109:     ST  1,0(1) 	store old fp (point to self) 
110:    LDA  3,1(7) 	Return address in ac 
111:    LDA  7,-82(7) 	Jump to main 
112:   HALT  0,0,0 	DONE! 
* END Init
