* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  control.c-
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
* IF
 31:    LDC  3,6(6) 	Load constant 
 32:     ST  3,-3(1) 	Save left side 
 33:    LDC  3,3(6) 	Load constant 
 34:     LD  4,-3(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op > 
 36:    LDC  3,1(6) 	True case 
 37:    JGT  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
 39:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
 41:    LDC  3,111(6) 	Load constant 
 42:     ST  3,-2(1) 	Store variable x
* END compound statement
* ELSE
 40:    LDA  7,3(7) 	Jump around the THEN 
* BEGIN compound statement
* EXPRESSION STMT
 44:    LDC  3,222(6) 	Load constant 
 45:     ST  3,-2(1) 	Store variable x
* END compound statement
 43:    LDA  7,2(7) 	Jump around the ELSE 
* ENDIF
* WHILE
 46:    LDC  3,7(6) 	Load constant 
 47:     ST  3,-3(1) 	Save left side 
 48:    LDC  3,3(6) 	Load constant 
 49:     LD  4,-3(1) 	Load left into ac1 
 50:    SUB  4,4,3 	Op > 
 51:    LDC  3,1(6) 	True case 
 52:    JGT  4,1(7) 	Jump if true 
 53:    LDC  3,0(6) 	False case 
 54:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 56:    LDC  3,333(6) 	Load constant 
 57:     ST  3,-2(1) 	Store variable x
* IF
 58:     LD  3,-2(1) 	Load variable x
 59:     ST  3,-3(1) 	Save left side 
 60:    LDC  3,9(6) 	Load constant 
 61:     LD  4,-3(1) 	Load left into ac1 
 62:    SUB  4,4,3 	Op < 
 63:    LDC  3,1(6) 	True case 
 64:    JLT  4,1(7) 	Jump if true 
 65:    LDC  3,0(6) 	False case 
 66:    JGT  3,1(7) 	Jump to then part 
* THEN
* BREAK
 68:    LDA  7,-14(7) 	break 
 67:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
 69:    LDC  3,444(6) 	Load constant 
 70:     ST  3,-2(1) 	Store variable x
* BREAK
 71:    LDA  7,-17(7) 	break 
* END compound statement
 72:    LDA  7,-27(7) 	go to beginning of loop 
 55:    LDA  7,17(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
 73:    LDC  2,0(6) 	Set return value to 0 
 74:     LD  3,-1(1) 	Load return address 
 75:     LD  1,0(1) 	Adjust fp 
 76:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,76(7) 	Jump to init 
* BEGIN Init
 77:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 78:    LDA  1,0(0) 	set first frame at end of globals 
 79:     ST  1,0(1) 	store old fp (point to self) 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-52(7) 	Jump to main 
 82:   HALT  0,0,0 	DONE! 
* END Init
