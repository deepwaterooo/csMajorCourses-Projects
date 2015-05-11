* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  factorial2.c-
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
* BEGIN function factorial
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,1(6) 	Load constant 
 32:     ST  3,-3(1) 	Store variable i
 33:     ST  3,-4(1) 	Store variable f
* WHILE
 34:     LD  3,-3(1) 	Load variable i
 35:     ST  3,-5(1) 	Save left side 
 36:     LD  3,-2(1) 	Load variable n
 37:     LD  4,-5(1) 	Load left into ac1 
 38:    SUB  4,4,3 	Op <= 
 39:    LDC  3,1(6) 	True case 
 40:    JLE  4,1(7) 	Jump if true 
 41:    LDC  3,0(6) 	False case 
 42:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 44:     ST  1,-5(1) 	Store old fp in ghost frame 
 45:     LD  3,-3(1) 	Load variable i
 46:     ST  3,-7(1) 	Store parameter 
 47:    LDA  1,-5(1) 	Load address of new frame 
 48:    LDA  3,1(7) 	Return address in ac 
 49:    LDA  7,-44(7) 	CALL output
 50:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 51:     LD  3,-4(1) 	Load variable f
 52:     ST  3,-5(1) 	Save left side 
 53:     LD  3,-3(1) 	Load variable i
 54:     LD  4,-5(1) 	Load left into ac1 
 55:    MUL  3,4,3 	Op * 
 56:     ST  3,-4(1) 	Store variable f
* EXPRESSION STMT
 57:    LDC  3,1(6) 	Load constant 
 58:     LD  4,-3(1) 	load lhs variable i
 59:    ADD  3,4,3 	op += 
 60:     ST  3,-3(1) 	Store variable i
* END compound statement
 61:    LDA  7,-28(7) 	go to beginning of loop 
 43:    LDA  7,18(7) 	No more loop 
* ENDWHILE
* RETURN
 62:     LD  3,-4(1) 	Load variable f
 63:    LDA  2,0(3) 	Copy result to rt register 
 64:     LD  3,-1(1) 	Load return address 
 65:     LD  1,0(1) 	Adjust fp 
 66:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 67:    LDC  2,0(6) 	Set return value to 0 
 68:     LD  3,-1(1) 	Load return address 
 69:     LD  1,0(1) 	Adjust fp 
 70:    LDA  7,0(3) 	Return 
* END of function factorial
* BEGIN function main
 71:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 72:     ST  1,-3(1) 	Store old fp in ghost frame 
 73:    LDA  1,-3(1) 	Load address of new frame 
 74:    LDA  3,1(7) 	Return address in ac 
 75:    LDA  7,-75(7) 	CALL input
 76:    LDA  3,0(2) 	Save the result in ac 
 77:     ST  3,-2(1) 	Store variable n
* EXPRESSION STMT
 78:     ST  1,-3(1) 	Store old fp in ghost frame 
 79:     LD  3,-2(1) 	Load variable n
 80:     ST  3,-5(1) 	Store parameter 
 81:    LDA  1,-3(1) 	Load address of new frame 
 82:    LDA  3,1(7) 	Return address in ac 
 83:    LDA  7,-54(7) 	CALL factorial
 84:    LDA  3,0(2) 	Save the result in ac 
 85:     ST  3,-2(1) 	Store variable n
* EXPRESSION STMT
 86:     ST  1,-3(1) 	Store old fp in ghost frame 
 87:     LD  3,-2(1) 	Load variable n
 88:     ST  3,-5(1) 	Store parameter 
 89:    LDA  1,-3(1) 	Load address of new frame 
 90:    LDA  3,1(7) 	Return address in ac 
 91:    LDA  7,-86(7) 	CALL output
 92:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 93:     ST  1,-3(1) 	Store old fp in ghost frame 
 94:    LDA  1,-3(1) 	Load address of new frame 
 95:    LDA  3,1(7) 	Return address in ac 
 96:    LDA  7,-72(7) 	CALL outnl
 97:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 98:    LDC  2,0(6) 	Set return value to 0 
 99:     LD  3,-1(1) 	Load return address 
100:     LD  1,0(1) 	Adjust fp 
101:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,101(7) 	Jump to init 
* BEGIN Init
102:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
103:    LDA  1,0(0) 	set first frame at end of globals 
104:     ST  1,0(1) 	store old fp (point to self) 
105:    LDA  3,1(7) 	Return address in ac 
106:    LDA  7,-36(7) 	Jump to main 
107:   HALT  0,0,0 	DONE! 
* END Init
