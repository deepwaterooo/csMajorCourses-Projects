* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  loop.c-
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
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,1(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable x
* WHILE
 33:     LD  3,-2(1) 	Load variable x
 34:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 36:     LD  3,-2(1) 	Load variable x
 37:    LDC  4,1(6) 	Load 1 
 38:    SUB  3,4,3 	Op NOT 
 39:     ST  3,-2(1) 	Store variable x
* END compound statement
 40:    LDA  7,-8(7) 	go to beginning of loop 
 35:    LDA  7,5(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
 41:    LDC  2,0(6) 	Set return value to 0 
 42:     LD  3,-1(1) 	Load return address 
 43:     LD  1,0(1) 	Adjust fp 
 44:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,44(7) 	Jump to init 
* BEGIN Init
 45:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 46:    LDA  1,0(0) 	set first frame at end of globals 
 47:     ST  1,0(1) 	store old fp (point to self) 
 48:    LDA  3,1(7) 	Return address in ac 
 49:    LDA  7,-20(7) 	Jump to main 
 50:   HALT  0,0,0 	DONE! 
* END Init
