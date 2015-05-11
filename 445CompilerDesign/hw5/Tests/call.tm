* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  call.tm
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
* BEGIN function showInt
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 31:     ST  1,-3(1) 	Store old frame in ghost frame 
 32:     LD  3,-2(1) 	Load variable x
 33:     ST  3,-5(1) 	Store parameter 
 34:    LDA  1,-3(1) 	Load address of new frame 
 35:    LDA  3,1(7) 	Return address in ac 
 36:    LDA  7,-31(7) 	CALL output
 37:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 38:     ST  1,-3(1) 	Store old frame in ghost frame 
 39:    LDA  1,-3(1) 	Load address of new frame 
 40:    LDA  3,1(7) 	Return address in ac 
 41:    LDA  7,-17(7) 	CALL outnl
 42:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 43:    LDC  2,0(6) 	Set return value to 0 
 44:     LD  3,-1(1) 	Load return address 
 45:     LD  1,0(1) 	Adjust fp 
 46:    LDA  7,0(3) 	Return 
* END function showInt
* BEGIN function showIntArray
 47:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 48:    LDC  3,0(6) 	Load constant 
 49:     ST  3,0(1) 	Store variable i
* WHILE
 50:     LD  3,0(1) 	Load variable i
 51:     ST  3,-4(1) 	Save left side 
 52:     LD  3,-3(1) 	Load variable size
 53:     LD  4,-4(1) 	Load left into ac1 
 54:    SUB  4,4,3 	Op < 
 55:    LDC  3,1(6) 	True case 
 56:    JLT  4,1(7) 	Jump if true 
 57:    LDC  3,0(6) 	False case 
 58:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 60:     ST  1,-4(1) 	Store old frame in ghost frame 
 61:     LD  3,0(1) 	Load variable i
 62:     ST  3,-6(1) 	Save index 
 63:     ST  3,-7(1) 	Store parameter 
 64:    LDA  1,-4(1) 	Load address of new frame 
 65:    LDA  3,1(7) 	Return address in ac 
 66:    LDA  7,-61(7) 	CALL output
 67:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 68:     LD  3,0(1) 	Load variable i
 69:     ST  3,-4(1) 	Save left side 
 70:    LDC  3,1(6) 	Load constant 
 71:     LD  4,-4(1) 	Load left into ac1 
 72:    ADD  3,4,3 	Op + 
 73:     ST  3,0(1) 	Store variable i
* END compound statement
 74:    LDA  7,-25(7) 	go to beginning of loop 
 59:    LDA  7,15(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 75:     ST  1,-4(1) 	Store old frame in ghost frame 
 76:    LDA  1,-4(1) 	Load address of new frame 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-54(7) 	CALL outnl
 79:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 80:    LDC  2,0(6) 	Set return value to 0 
 81:     LD  3,-1(1) 	Load return address 
 82:     LD  1,0(1) 	Adjust fp 
 83:    LDA