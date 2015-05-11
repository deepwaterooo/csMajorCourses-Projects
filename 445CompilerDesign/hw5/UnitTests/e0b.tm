* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  e0b.tm
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
* EXPRESSION STMT
 35:     ST  1,-2(1) 	Store old frame in ghost frame 
 36:    LDC  3,666(6) 	Load constant 
 37:     ST  3,-4(1) 	Store parameter 
 38:    LDA  1,-2(1) 	Load address of new frame 
 39:    LDA  3,1(7) 	Return address in ac 
 40:    LDA  7,-35(7) 	CALL output
 41:    LDA  3,0(2) 	Save the result in ac 
 34:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* WHILE
 43:     LD  3,0(1) 	Load variable x
 44:     ST  3,-2(1) 	Save left side 
 45:    LDC  3,10(6) 	Load constant 
 46:     LD  4,-2(1) 	Load left into ac1 
 47:    SUB  4,4,3 	Op < 
 48:    LDC  3,1(6) 	True case 
 49:    JLT  4,1(7) 	Jump if true 
 50:    LDC  3,0(6) 	False case 
 51:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 53:     ST  1,-2(1) 	Store old frame in ghost frame 
 54:     LD  3,0(1) 	Load variable x
 55:     ST  3,-4(1) 	Store parameter 
 56:    LDA  1,-2(1) 	Load address of new frame 
 57:    LDA  3,1(7) 	Return address in ac 
 58:    LDA  7,-53(7) 	CALL output
 59:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 60:     LD  3,0(1) 	Load variable x
 61:     ST  3,-2(1) 	Save left side 
 62:    LDC  3,1(6) 	Load constant 
 63:     LD  4,-2(1) 	Load left into ac1 
 64:    ADD  3,4,3 	Op + 
 65:     ST  3,0(1) 	Store variable x
* END compound statement
 66:    LDA  7,-24(7) 	go to beginning of loop 
 52:    LDA  7,14(7) 	No more loop 
* ENDWHILE
 42:    LDA  7,24(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
 67:    LDC  3,0(6) 	Load constant 
 68:     ST  3,0(1) 	Store variable x
* IfK:
* IfK: t->child[0] condition
 69:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* EXPRESSION STMT
 71:     ST  1,-2(1) 	Store old frame in ghost frame 
 72:    LDC  3,666(6) 	Load constant 
 73:     ST  3,-4(1) 	Store parameter 
 74:    LDA  1,-2(1) 	Load address of new frame 
 75:    LDA  3,1(7) 	Return address in ac 
 76:    LDA  7,-71(7) 	CALL output
 77:    LDA  3,0(2) 	Save the result in ac 
 70:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* WHILE
 79:     LD  3,0(1) 	Load variable x
 80:     ST  3,-2(1) 	Save left side 
 81:    LDC  3,10(6) 	Load constant 
 82:     LD  4,-2(1) 	Load left into ac1 
 83:    SUB  4,4,3 	Op < 
 84:    LDC  3,1(6) 	True case 
 85:    JLT  4,1(7) 	Jump if true 
 86:    LDC  3,0(6) 	False case 
 87:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 89:     ST  1,-2(1) 	Store old frame in ghost frame 
 90:     LD  3,0(1) 	Load variable x
 91:     ST  3,-4(1) 	Store parameter 
 92:    LDA  1,-2(1) 	Load address of new frame 
 93:    LDA  3,1(7) 	Return address in ac 
 94:    LDA  7,-89(7) 	CALL output
 95:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 96:     LD  3,0(1) 	Load variable x
 97:     ST  3,-2(1) 	Save left side 
 98:    LDC  3,1(6) 	Load constant 
 99:     LD  4,-2(1) 	Load left into ac1 
100:    ADD  3,4,3 	Op + 
101:     ST  3,0(1) 	Store variable x
* END compound statement
102:    LDA  7,-24(7) 	go to beginning of loop 
 88:    LDA  7,14(7) 	No more loop 
* ENDWHILE
 78:    LDA  7,24(7) 	jmp to end 
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
