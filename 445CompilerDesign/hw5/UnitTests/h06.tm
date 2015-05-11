* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  h06.tm
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
* BEGIN function cat
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* IfK:
* IfK: t->child[0] condition
 31:     LD  3,-3(1) 	Load variable y
 32:     ST  3,-4(1) 	Save left side 
 33:    LDC  3,0(6) 	Load constant 
 34:     LD  4,-4(1) 	Load left into ac1 
* IfK: t->child[1] then part
* BEGIN compound statement
* EXPRESSION STMT
 36:     LD  3,-3(1) 	Load variable y
 37:     ST  3,-4(1) 	Save index 
 38:     LD  3,-3(1) 	Load variable y
 39:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 40:     ST  1,-5(1) 	Store old frame in ghost frame 
 41:     LD  3,-2(1) 	Load variable x
 42:     ST  3,-7(1) 	Store parameter 
 43:     LD  3,-3(1) 	Load variable y
 44:     ST  3,-8(1) 	Save left side 
 45:    LDC  3,1(6) 	Load constant 
 46:     LD  4,-8(1) 	Load left into ac1 
 47:    SUB  3,4,3 	Op - 
 48:     ST  3,-8(1) 	Store parameter 
 49:    LDA  1,-5(1) 	Load address of new frame 
 50:    LDA  3,1(7) 	Return address in ac 
 51:    LDA  7,-22(7) 	CALL cat
 52:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
 35:    JEQ  3,18(7) 	if: jmp to else 
* IfK: t->child[2] else part
 53:    LDA  7,0(7) 	jmp to end 
* ENDIF
* RETURN
 54:    LDA  2,0(3) 	Copy result to rt register 
 55:     LD  3,-1(1) 	Load return address 
 56:     LD  1,0(1) 	Adjust fp 
 57:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 58:    LDC  2,0(6) 	Set return value to 0 
 59:     LD  3,-1(1) 	Load return address 
 60:     LD  1,0(1) 	Adjust fp 
 61:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function main
 62:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 63:    LDC  3,0(6) 	load size of array x
 64:     ST  3,1(1) 	save size of array x
* EXPRESSION STMT
 65:    LDC  3,12(6) 	Load constant 
 66:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 67:     ST  1,-3(1) 	Store old frame in ghost frame 
 68:     LD  3,0(1) 	Load variable x
 69:     ST  3,-5(1) 	Store parameter 
 70:     LD  3,-2(1) 	Load variable y
 71:     ST  3,-6(1) 	Store parameter 
 72:    LDA  1,-3(1) 	Load address of new frame 
 73:    LDA  3,1(7) 	Return address in ac 
 74:    LDA  7,-45(7) 	CALL cat
 75:    LDA  3,0(2) 	Save the result in ac 
* WHILE
 76:     LD  3,-2(1) 	Load variable y
 77:     ST  3,-3(1) 	Save left side 
 78:    LDC  3,0(6) 	Load constant 
 79:     LD  4,-3(1) 	Load left into ac1 
 80:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 82:     ST  1,-3(1) 	Store old frame in ghost frame 
 83:     LD  3,-2(1) 	Load variable y
 84:     ST  3,-5(1) 	Store parameter 
 85:    LDA  1,-3(1) 	Load address of new frame 
 86:    LDA  3,1(7) 	Return address in ac 
 87:    LDA  7,-82(7) 	CALL output
 88:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 89:     ST  1,-3(1) 	Store old frame in ghost frame 
 90:    LDA  1,-3(1) 	Load address of new frame 
 91:    LDA  3,1(7) 	Return address in ac 
 92:    LDA  7,-68(7) 	CALL outnl
 93:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 94:     LD  3,-2(1) 	Load variable y
 95:     ST  3,-3(1) 	Save left side 
 96:    LDC  3,1(6) 	Load constant 
 97:     LD  4,-3(1) 	Load left into ac1 
 98:    SUB  3,4,3 	Op - 
 99:     ST  3,-2(1) 	Store variable y
* END compound statement
100:    LDA  7,-25(7) 	go to beginning of loop 
 81:    LDA  7,19(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
101:    LDC  2,0(6) 	Set return value to 0 
102:     LD  3,-1(1) 	Load return address 
103:     LD  1,0(1) 	Adjust fp 
104:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,104(7) 	Jump to init 
* BEGIN Init
105:     LD  0,0(0) 	Set the global pointer 
106:    LDA  1,0(0) 	set first frame at end of globals 
107:     ST  1,0(1) 	store old fp (point to self) 
108:    LDA  3,1(7) 	Return address in ac 
109:    LDA  7,-48(7) 	Jump to main 
110:   HALT  0,0,0 	DONE! 
* END Init
