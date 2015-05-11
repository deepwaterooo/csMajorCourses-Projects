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
 32:     ST  3,-2(1) 	Store variable i
* WHILE
 33:     LD  3,-2(1) 	Load variable i
 34:     ST  3,-4(1) 	Save left side 
 35:    LDC  3,10(6) 	Load constant 
 36:     LD  4,-4(1) 	Load left into ac1 
 37:    SUB  3,4,3 	Op < 
 38:    JLT  3,2(7) 	br if true 
 39:    LDC  3,0(3) 	false case 
 40:    LDA  7,1(7) 	unconditional jmp 
 41:    LDC  3,1(3) 	true case 
 42:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 44:    LDC  3,0(6) 	Load constant 
 45:     ST  3,-3(1) 	Store variable j
* WHILE
 46:     LD  3,-3(1) 	Load variable j
 47:     ST  3,-4(1) 	Save left side 
 48:    LDC  3,5(6) 	Load constant 
 49:     LD  4,-4(1) 	Load left into ac1 
 50:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 52:     ST  1,-4(1) 	Store old frame in ghost frame 
 53:     LD  3,-2(1) 	Load variable i
 54:     ST  3,-6(1) 	Store parameter 
 55:    LDA  1,-4(1) 	Load address of new frame 
 56:    LDA  3,1(7) 	Return address in ac 
 57:    LDA  7,-52(7) 	CALL output
 58:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 59:     ST  1,-4(1) 	Store old frame in ghost frame 
 60:     LD  3,-3(1) 	Load variable j
 61:     ST  3,-6(1) 	Store parameter 
 62:    LDA  1,-4(1) 	Load address of new frame 
 63:    LDA  3,1(7) 	Return address in ac 
 64:    LDA  7,-59(7) 	CALL output
 65:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 66:     ST  1,-4(1) 	Store old frame in ghost frame 
 67:    LDA  1,-4(1) 	Load address of new frame 
 68:    LDA  3,1(7) 	Return address in ac 
 69:    LDA  7,-45(7) 	CALL outnl
 70:    LDA  3,0(2) 	Save the result in ac 
 71:     LD  3,-2(1) 	Load variable i
 72:     ST  3,-4(1) 	Save left side 
 73:    LDC  3,4(6) 	Load constant 
 74:     LD  4,-4(1) 	Load left into ac1 
 75:    JEQ  3,1(7) 	if: jmp to else 
 76:    LDA  7,0(7) 	jmp to end 
* EXPRESSION STMT
 77:     ST  3,-3(1) 	Store variable j
* END compound statement
 78:    LDA  7,-28(7) 	go to beginning of loop 
 51:    LDA  7,27(7) 	No more loop 
* end WHILE
 79:     LD  3,-3(1) 	Load variable j
 80:     ST  3,-4(1) 	Save left side 
 81:    LDC  3,3(6) 	Load constant 
 82:     LD  4,-4(1) 	Load left into ac1 
 83:    JEQ  3,1(7) 	if: jmp to else 
 84:    LDA  7,0(7) 	jmp to end 
* EXPRESSION STMT
 85:     ST  3,-2(1) 	Store variable i
* END compound statement
 86:    LDA  7,-44(7) 	go to beginning of loop 
 43:    LDA  7,43(7) 	No more loop 
* end WHILE
* RETURN
 87:    LDC  3,0(6) 	Load constant 
 88:    LDA  2,0(3) 	Copy result to rt register 
 89:     LD  3,-1(1) 	Load return address 
 90:     LD  1,0(1) 	Adjust fp 
 91:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 92:    LDC  2,0(6) 	Set return value to 0 
 93:     LD  3,-1(1) 	Load return address 
 94:     LD  1,0(1) 	Adjust fp 
 95:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,95(7) 	Jump to init 
* BEGIN Init
 96:     LD  0,0(0) 	Set the global pointer 
 97:    LDA  1,0(0) 	set first frame at end of globals 
 98:     ST  1,0(1) 	store old fp (point to self) 
 99:    LDA  3,1(7) 	Return address in ac 
100:    LDA  7,-71(7) 	Jump to main 
101:   HALT  0,0,0 	DONE! 
* END Init
