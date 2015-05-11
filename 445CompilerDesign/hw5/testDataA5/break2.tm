* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  break2.c-
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
 31:    LDC  3,0(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable i
* WHILE
 33:     LD  3,-2(1) 	Load variable i
 34:     ST  3,-4(1) 	Save left side 
 35:    LDC  3,10(6) 	Load constant 
 36:     LD  4,-4(1) 	Load left into ac1 
 37:    SUB  4,4,3 	Op < 
 38:    LDC  3,1(6) 	True case 
 39:    JLT  4,1(7) 	Jump if true 
 40:    LDC  3,0(6) 	False case 
 41:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 43:    LDC  3,0(6) 	Load constant 
 44:     ST  3,-3(1) 	Store variable j
* WHILE
 45:     LD  3,-3(1) 	Load variable j
 46:     ST  3,-4(1) 	Save left side 
 47:    LDC  3,5(6) 	Load constant 
 48:     LD  4,-4(1) 	Load left into ac1 
 49:    SUB  4,4,3 	Op <= 
 50:    LDC  3,1(6) 	True case 
 51:    JLE  4,1(7) 	Jump if true 
 52:    LDC  3,0(6) 	False case 
 53:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 55:     ST  1,-4(1) 	Store old fp in ghost frame 
 56:     LD  3,-2(1) 	Load variable i
 57:     ST  3,-6(1) 	Store parameter 
 58:    LDA  1,-4(1) 	Load address of new frame 
 59:    LDA  3,1(7) 	Return address in ac 
 60:    LDA  7,-55(7) 	CALL output
 61:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 62:     ST  1,-4(1) 	Store old fp in ghost frame 
 63:     LD  3,-3(1) 	Load variable j
 64:     ST  3,-6(1) 	Store parameter 
 65:    LDA  1,-4(1) 	Load address of new frame 
 66:    LDA  3,1(7) 	Return address in ac 
 67:    LDA  7,-62(7) 	CALL output
 68:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 69:     ST  1,-4(1) 	Store old fp in ghost frame 
 70:    LDA  1,-4(1) 	Load address of new frame 
 71:    LDA  3,1(7) 	Return address in ac 
 72:    LDA  7,-48(7) 	CALL outnl
 73:    LDA  3,0(2) 	Save the result in ac 
* IF
 74:     LD  3,-2(1) 	Load variable i
 75:     ST  3,-4(1) 	Save left side 
 76:    LDC  3,4(6) 	Load constant 
 77:     LD  4,-4(1) 	Load left into ac1 
 78:    SUB  4,4,3 	Op > 
 79:    LDC  3,1(6) 	True case 
 80:    JGT  4,1(7) 	Jump if true 
 81:    LDC  3,0(6) 	False case 
 82:    JGT  3,1(7) 	Jump to then part 
* THEN
* BREAK
 84:    LDA  7,-31(7) 	break 
 83:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
 85:     LD  3,-3(1) 	load lhs variable j
 86:    LDA  3,1(3) 	increment value of j
 87:     ST  3,-3(1) 	Store variable j
* END compound statement
 88:    LDA  7,-44(7) 	go to beginning of loop 
 54:    LDA  7,34(7) 	No more loop 
* ENDWHILE
* IF
 89:     LD  3,-3(1) 	Load variable j
 90:     ST  3,-4(1) 	Save left side 
 91:    LDC  3,3(6) 	Load constant 
 92:     LD  4,-4(1) 	Load left into ac1 
 93:    SUB  4,4,3 	Op > 
 94:    LDC  3,1(6) 	True case 
 95:    JGT  4,1(7) 	Jump if true 
 96:    LDC  3,0(6) 	False case 
 97:    JGT  3,1(7) 	Jump to then part 
* THEN
* BREAK
 99:    LDA  7,-58(7) 	break 
 98:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
100:     LD  3,-2(1) 	load lhs variable i
101:    LDA  3,1(3) 	increment value of i
102:     ST  3,-2(1) 	Store variable i
* END compound statement
103:    LDA  7,-71(7) 	go to beginning of loop 
 42:    LDA  7,61(7) 	No more loop 
* ENDWHILE
* RETURN
104:    LDC  3,0(6) 	Load constant 
105:    LDA  2,0(3) 	Copy result to rt register 
106:     LD  3,-1(1) 	Load return address 
107:     LD  1,0(1) 	Adjust fp 
108:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
109:    LDC  2,0(6) 	Set return value to 0 
110:     LD  3,-1(1) 	Load return address 
111:     LD  1,0(1) 	Adjust fp 
112:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,112(7) 	Jump to init 
* BEGIN Init
113:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
114:    LDA  1,0(0) 	set first frame at end of globals 
115:     ST  1,0(1) 	store old fp (point to self) 
116:    LDA  3,1(7) 	Return address in ac 
117:    LDA  7,-88(7) 	Jump to main 
118:   HALT  0,0,0 	DONE! 
* END Init
