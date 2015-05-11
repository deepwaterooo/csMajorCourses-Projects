* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  allErrors.tm
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
* BEGIN function dog
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* RETURN
 31:     LD  3,0(1) 	Load variable b
 32:    LDA  2,0(3) 	Copy result to rt register 
 33:     LD  3,-1(1) 	Load return address 
 34:     LD  1,0(1) 	Adjust fp 
 35:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 36:    LDC  2,0(6) 	Set return value to 0 
 37:     LD  3,-1(1) 	Load return address 
 38:     LD  1,0(1) 	Adjust fp 
 39:    LDA  7,0(3) 	Return 
* END function dog
* BEGIN function cat
 40:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* RETURN
 41:    LDA  2,0(3) 	Copy result to rt register 
 42:     LD  3,-1(1) 	Load return address 
 43:     LD  1,0(1) 	Adjust fp 
 44:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 45:    LDC  2,0(6) 	Set return value to 0 
 46:     LD  3,-1(1) 	Load return address 
 47:     LD  1,0(1) 	Adjust fp 
 48:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function main
 49:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 50:    LDC  3,0(6) 	load size of array aa
 51:     ST  3,-3(1) 	save size of array aa
 52:    LDC  3,0(6) 	load size of array zz
 53:     ST  3,-4(1) 	save size of array zz
 54:    LDC  3,0(6) 	load size of array bb
 55:     ST  3,-5(1) 	save size of array bb
 56:     LD  3,0(1) 	Load variable v
* IfK:
* IfK: t->child[0] condition
 57:     LD  3,-4(1) 	Load variable x
* IfK: t->child[1] then part
 59:     LD  3,-4(1) 	Load variable x
 58:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
 60:    LDA  7,0(7) 	jmp to end 
* ENDIF
* WHILE
 61:     LD  3,-4(1) 	Load variable x
 62:    JGT  3,1(7) 	Jump to while part 
* DO
 64:     LD  3,-4(1) 	Load variable x
 65:    LDA  7,-5(7) 	go to beginning of loop 
 63:    LDA  7,2(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 66:     LD  3,0(1) 	Load variable cat
 67:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
 68:     LD  3,-6(1) 	Load variable b
 69:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
 70:     LD  3,-6(1) 	Load variable b
 71:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
 72:     LD  3,-4(1) 	Load variable x
 73:     ST  3,-6(1) 	Store variable b
* IfK:
* IfK: t->child[0] condition
 74:     LD  3,-6(1) 	Load variable bb
* IfK: t->child[1] then part
 76:     LD  3,-4(1) 	Load variable x
 75:    JEQ  3,2(7) 	if: jmp to else 
* IfK: t->child[2] else part
 77:    LDA  7,0(7) 	jmp to end 
* ENDIF
* WHILE
 78:     LD  3,-6(1) 	Load variable bb
 79:    JGT  3,1(7) 	Jump to while part 
*