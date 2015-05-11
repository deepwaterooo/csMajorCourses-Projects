* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  sort.tm
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
* BEGIN function minloc
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 31:     LD  3,-3(1) 	Load variable low
 32:     ST  3,-6(1) 	Store variable k
* EXPRESSION STMT
 33:     LD  3,-3(1) 	Load variable low
 34:     ST  3,-7(1) 	Save index 
 35:     ST  3,-5(1) 	Store variable x
* EXPRESSION STMT
 36:     LD  3,-3(1) 	Load variable low
 37:     ST  3,-8(1) 	Save left side 
 38:    LDC  3,1(6) 	Load constant 
 39:     LD  4,-8(1) 	Load left into ac1 
 40:    ADD  3,4,3 	Op + 
 41:     ST  3,-1(1) 	Store variable i
* WHILE
 42:     LD  3,-1(1) 	Load variable i
 43:     ST  3,-8(1) 	Save left side 
 44:     LD  3,-4(1) 	Load variable high
 45:     LD  4,-8(1) 	Load left into ac1 
 46:    SUB  4,4,3 	Op < 
 47:    LDC  3,1(6) 	True case 
 48:    JLT  4,1(7) 	Jump if true 
 49:    LDC  3,0(6) 	False case 
 50:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IfK:
* IfK: t->child[0] condition
 52:     LD  3,-1(1) 	Load variable i
 53:     ST  3,-8(1) 	Save index 
 54:     ST  3,-9(1) 	Save left side 
 55:     LD  3,-5(1) 	Load variable x
 56:     LD  4,-9(1) 	Load left into ac1 
 57:    SUB  4,4,3 	Op < 
 58:    LDC  3,1(6) 	True case 
 59:    JLT  4,1(7) 	Jump if true 
 60:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* BEGIN compound statement
* EXPRESSION STMT
 62:     LD  3,-1(1) 	Load variable i
 63:     ST  3,-9(1) 	Save index 
 64:     ST  3,-5(1) 	Store variable x
* EXPRESSION STMT
 65:     LD  3,-1(1) 	Load variable i
 66:     ST  3,-6(1) 	Store variable k
* END compound statement
 61:    JEQ  3,6(7) 	if: jmp to else 
* IfK: t->child[2] else part
 67:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
 68:     ST  3,-1(1) 	Store variable i
* END compound statement
 69:    LDA  7,-28(7) 	go to beginning of loop 
 51:    LDA  7,18(7) 	No more loop 
* ENDWHILE
* RETURN
 70:     LD  3,-6(1) 	Load variable k
 71:    LDA  2,0(3) 	Copy result to rt register 
 72:     LD  3,-1(1) 	Load return address 
 73:     LD  1,0(1) 	Adjust fp 
 74:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 75:    LDC  2,0(6) 	Set return value to 0 
 76:     LD  3,-1(1) 	Load return address 
 77:     LD  1,0(1) 	Adjust fp 
 78:    LDA  7,0(3) 	Return 
* END function minloc
* BEGIN function main
 79:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 80:    LDC  3,0(6) 	Load constant 
 81:     ST  3,-3(1) 	Store variable i
* WHILE
 82:     LD  3,-3(1) 	Load variable i
 83:     ST  3,-2(1) 	Save left side 
 84:    LDC  3,10(6) 	Load constant 
 85: 