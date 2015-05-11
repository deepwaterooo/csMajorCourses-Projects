* BEGIN function input
  :     ST  3,-1(1) 	Store return address 
  :     IN  2,2,2 	Grab int input 
  :     LD  3,-1(1) 	Load return address 
  :     LD  1,0(1) 	Adjust fp 
  :    LDA  7,0(3) 	Return 
* END of function input
* BEGIN function output
  :     ST  3,-1(1) 	Store return address 
  :     LD  3,-2(1) 	Load parameter 
  :    OUT  3,3,3 	Output integer 
  :    LDC  2,0(6) 	Set return to 0 
  :     LD  3,-1(1) 	Load return address 
  :     LD  1,0(1) 	Adjust fp 
  :    LDA  7,0(3) 	Return 
* END of function output
* BEGIN function inputb
  :     ST  3,-1(1) 	Store return address 
  :    INB  2,2,2 	Grab bool input 
  :     LD  3,-1(1) 	Load return address 
  :     LD  1,0(1) 	Adjust fp 
  :    LDA  7,0(3) 	Return 
* END of function inputb
* BEGIN function outputb
  :     ST  3,-1(1) 	Store return address 
  :     LD  3,-2(1) 	Load parameter 
  :   OUTB  3,3,3 	Output bool 
  :    LDC  2,0(6) 	Set return to 0 
  :     LD  3,-1(1) 	Load return address 
  :     LD  1,0(1) 	Adjust fp 
  :    LDA  7,0(3) 	Return 
* END of function outputb
* BEGIN function outnl
  :     ST  3,-1(1) 	Store return address 
  :  OUTNL  3,3,3 	Output a newline 
  :     LD  3,-1(1) 	Load return address 
  :     LD  1,0(1) 	Adjust fp 
  :    LDA  7,0(3) 	Return 
* END of function outnl
