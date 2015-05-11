* C- compiler version C-F07
* Author: Robert B. Heckendorn
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  z.c-
* Nov 29, 2007
* BEGIN function input
  1:     ST  3,-1(1)    Store return address
  2:     IN  2,2,2      Grab int input
  3:     LD  3,-1(1)    Load return address
  4:     LD  1,0(1)     Adjust fp
  5:    LDA  7,0(3)     Return
* END of function input
* BEGIN function output
  6:     ST  3,-1(1)    Store return address
  7:     LD  3,-2(1)    Load parameter
  8:    OUT  3,3,3      Output integer
  9:    LDC  2,0(6)     Set return to 0
 10:     LD  3,-1(1)    Load return address
 11:     LD  1,0(1)     Adjust fp
 12:    LDA  7,0(3)     Return
* END of function output
* BEGIN function inputb
 13:     ST  3,-1(1)    Store return address
 14:    INB  2,2,2      Grab bool input
 15:     LD  3,-1(1)    Load return address
 16:     LD  1,0(1)     Adjust fp
 17:    LDA  7,0(3)     Return
* END of function inputb
* BEGIN function outputb
 18:     ST  3,-1(1)    Store return address
 19:     LD  3,-2(1)    Load parameter
 20:   OUTB  3,3,3      Output bool
 21:    LDC  2,0(6)     Set return to 0
 22:     LD  3,-1(1)    Load return address
 23:     LD  1,0(1)     Adjust fp
 24:    LDA  7,0(3)     Return
* END of function outputb
* BEGIN function outnl
 25:     ST  3,-1(1)    Store return address
 26:  OUTNL  3,3,3      Output a newline
 27:     LD  3,-1(1)    Load return address
 28:     LD  1,0(1)     Adjust fp
 29:    LDA  7,0(3)     Return
* END of function outnl
* BEGIN function dog
 30:     ST  3,-1(1)    Store return address.
* BEGIN compound statement
* EXPRESSION STMT
 31:     LD  3,-2(1)    Load variable x
 32:     ST  3,-5(1)    Save left side
 33:     LD  3,-3(1)    Load variable y
 34:     LD  4,-5(1)    Load left into ac1
 35:    ADD  3,4,3      Op +
 36:     ST  3,-4(1)    Store variable z
* RETURN
 37:     LD  3,0(0)     Load variable g
 38:     ST  3,-5(1)    Save left side
 39:     LD  3,-4(1)    Load variable z
 40:     LD  4,-5(1)    Load left into ac1
 41:    MUL  3,4,3      Op *
 42:    LDA  2,0(3)     Copy result to rt register
 43:     LD  3,-1(1)    Load return address
 44:     LD  1,0(1)     Adjust fp
 45:    LDA  7,0(3)     Return
* END compound statement
* Add standard closing in case there is no return statement
 46:    LDC  2,0(6)     Set return value to 0
 47:     LD  3,-1(1)    Load return address
 48:     LD  1,0(1)     Adjust fp
 49:    LDA  7,0(3)     Return
* END of function dog
* BEGIN function cat
 50:     ST  3,-1(1)    Store return address.
* BEGIN compound statement
 51:    LDC  3,10(6)    load size of array z
 52:     ST  3,-4(1)    save size of array z
* EXPRESSION STMT
 53:    LDC  3,8(6)     Load constant
 54:     ST  3,-15(1)   Save index
 55:    LDC  3,9(6)     Load constant
 56:    LDA  4,-5(1)    Load address of base of array z
 57:    SUB  3,4,3      Compute offset of value
 58:     LD  3,0(3)     Load the value
 59:     LD  4,-15(1)   Restore index
 60:    LDA  5,-5(1)    Load address of base of array z
 61:    SUB  5,5,4      Compute offset of value
 62:     ST  3,0(5)     Store variable z
* EXPRESSION STMT
 63:    LDC  3,8(6)     Load constant
 64:     ST  3,-15(1)   Save index
 65:    LDC  3,9(6)     Load constant
 66:    LDA  4,-2(0)    Load address of base of array h
 67:    SUB  3,4,3      Compute offset of value
 68:     LD  3,0(3)     Load the value
 69:     LD  4,-15(1)   Restore index
 70:    LDA  5,-2(0)    Load address of base of array h
 71:    SUB  5,5,4      Compute offset of value
 72:     ST  3,0(5)     Store variable h
* EXPRESSION STMT
 73:    LDC  3,7(6)     Load constant
 74:     ST  3,-15(1)   Save index
 75:     LD  3,-3(1)    Load variable y
 76:     LD  4,-2(1)    Load address of base of array x
 77:    SUB  3,4,3      Compute offset of value
 78:     LD  3,0(3)     Load the value
 79:     LD  4,-15(1)   Restore index
 80:    LDA  5,-5(1)    Load address of base of array z
 81:    SUB  5,5,4      Compute offset of value
 82:     ST  3,0(5)     Store variable z
* EXPRESSION STMT
 83:    LDC  3,7(6)     Load constant
 84:     ST  3,-15(1)   Save index
 85:     LD  3,-3(1)    Load variable y
 86:    LDA  4,-5(1)    Load address of base of array z
 87:    SUB  3,4,3      Compute offset of value
 88:     LD  3,0(3)     Load the value
 89:     LD  4,-15(1)   Restore index
 90:     LD  5,-2(1)    Load address of base of array x
 91:    SUB  5,5,4      Compute offset of value
 92:     ST  3,0(5)     Store variable x
* END compound statement
* Add standard closing in case there is no return statement
 93:    LDC  2,0(6)     Set return value to 0
 94:     LD  3,-1(1)    Load return address
 95:     LD  1,0(1)     Adjust fp
 96:    LDA  7,0(3)     Return
* END of function cat
* BEGIN function main
 97:     ST  3,-1(1)    Store return address.
* BEGIN compound statement
 98:    LDC  3,10(6)    load size of array a
 99:     ST  3,-2(1)    save size of array a
* EXPRESSION STMT
100:     ST  1,-14(1)   Store old fp in ghost frame
101:     LD  3,-13(1)   Load variable b
102:     ST  3,-16(1)   Store parameter
103:    LDC  3,999(6)   Load constant
104:     ST  3,-17(1)   Store parameter
105:    LDA  1,-14(1)   Load address of new frame
106:    LDA  3,1(7)     Return address in ac
107:    LDA  7,-78(7)   call dog
108:    LDA  3,0(2)     Save the result in ac
* EXPRESSION STMT
109:     ST  1,-14(1)   Store old fp in ghost frame
110:    LDA  3,-3(1)    Load address of base of array a
111:     ST  3,-16(1)   Store parameter
112:    LDC  3,6(6)     Load constant
113:     ST  3,-17(1)   Store parameter
114:    LDA  1,-14(1)   Load address of new frame
115:    LDA  3,1(7)     Return address in ac
116:    LDA  7,-67(7)   call cat
117:    LDA  3,0(2)     Save the result in ac
* EXPRESSION STMT
118:     ST  1,-14(1)   Store old fp in ghost frame
119:    LDC  3,777(6)   Load constant
120:     ST  3,-16(1)   Store parameter
121:    LDC  3,888(6)   Load constant
122:     ST  3,-17(1)   Store parameter
123:    LDA  1,-14(1)   Load address of new frame
124:    LDA  3,1(7)     Return address in ac
125:    LDA  7,-96(7)   call dog
126:    LDA  3,0(2)     Save the result in ac
127:     ST  3,-13(1)   Store variable b
* END compound statement
* Add standard closing in case there is no return statement
128:    LDC  2,0(6)     Set return value to 0
129:     LD  3,-1(1)    Load return address
130:     LD  1,0(1)     Adjust fp
131:    LDA  7,0(3)     Return
* END of function main
  0:    LDA  7,131(7)   Jump to init
* BEGIN Init
132:     LD  0,0(0)     Set the global pointer
* BEGIN init of global array sizes
133:    LDC  3,10(6)    load size of array h
134:     ST  3,-1(0)    save size of array h
* END init of global array sizes
135:    LDA  1,-12(0)   set first frame at end of globals
136:     ST  1,0(1)     store old fp (point to self)
137:    LDA  3,1(7)     Return address in ac
138:    LDA  7,-42(7)   Jump to main
139:   HALT  0,0,0      DONE!
* END Init
