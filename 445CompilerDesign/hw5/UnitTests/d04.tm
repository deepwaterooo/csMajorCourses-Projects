* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  d04.tm
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
 32:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 33:    LDC  3,0(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 35:    LDC  3,0(6) 	Load constant 
 36:     ST  3,-3(1) 	Store variable z
* EXPRESSION STMT
 37:     ST  1,-4(1) 	Store old frame in ghost frame 
 38:     LD  3,0(1) 	Load variable x
 39:     ST  3,-6(1) 	Save left side 
 40:     LD  3,-2(1) 	Load variable y
 41:     ST  3,-7(1) 	Save left side 
 42:     LD  3,-3(1) 	Load variable z
 43:     LD  4,-7(1) 	Load left into ac1 
 44:    JEQ  3,1(7) 	Op AND 
 45:    LDA  3,0(4) 	 
 46:     LD  4,-6(1) 	Load left into ac1 
 47:     ST  3,-6(1) 	Store parameter 
 48:    LDA  1,-4(1) 	Load address of new frame 
 49:    LDA  3,1(7) 	Return address in ac 
 50:    LDA  7,-33(7) 	CALL outputb
 51:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 52:     ST  1,-4(1) 	Store old frame in ghost frame 
 53:     LD  3,0(1) 	Load variable x
 54:     ST  3,-6(1) 	Save left side 
 55:     LD  3,-2(1) 	Load variable y
 56:     LD  4,-6(1) 	Load left into ac1 
 57:    JEQ  3,1(7) 	Op AND 
 58:    LDA  3,0(4) 	 
 59:     ST  3,-6(1) 	Save left side 
 60:     LD  3,-3(1) 	Load variable z
 61:     LD  4,-6(1) 	Load left into ac1 
 62:     ST  3,-6(1) 	Store parameter 
 63:    LDA  1,-4(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-48(7) 	CALL outputb
 66:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 67:     ST  1,-4(1) 	Store old frame in ghost frame 
 68:     LD  3,0(1) 	Load variable x
 69:     ST  3,-6(1) 	Save left side 
 70:     LD  3,-2(1) 	Load variable y
 71:     LD  4,-6(1) 	Load left into ac1 
 72:    JEQ  3,1(7) 	Op AND 
 73:    LDA  3,0(4) 	 
 74:     ST  3,-6(1) 	Save left side 
 75:     LD  3,-3(1) 	Load variable z
 76:     ST  3,-7(1) 	Save left side 
 77:     LD  3,-3(1) 	Load variable z
 78:     LD  4,-7(1) 	Load left into ac1 
 79:    JEQ  3,1(7) 	Op AND 
 80:    LDA  3,0(4) 	 
 81:     LD  4,-6(1) 	Load left into ac1 
 82:     ST  3,-6(1) 	Store parameter 
 83:    LDA  1,-4(1) 	Load address of new frame 
 84:    LDA  3,1(7) 	Return address in ac 
 85:    LDA  7,-68(7) 	CALL outputb
 86:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 87:     ST  1,-4(1) 	Store old frame in ghost frame 
 88:     LD  3,0(1) 	Load variable x
 89:     ST  3,-6(1) 	Save left side 
 90:     LD  3,-2(1) 	Load variable y
 91:     ST  3,-7(1) 	Save left side 
 92:     LD  3,-3(1) 	Load variable z
 93:     LD  4,-7(1) 	Load left into ac1 
 94:    JEQ  3,1(7) 	Op AND 
 95:    LDA  3,0(4) 	 
 96:     LD  4,-6(1) 	Load left into ac1 
 97:     ST  3,-6(1) 	Store parameter 
 98:    LDA  1,-4(1) 	Load address of new frame 
 99:    LDA  3,1(7) 	Return address in ac 
100:    LDA  7,-83(7) 	CALL outputb
101:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
102:     ST  1,-4(1) 	Store old frame in ghost frame 
103:     LD  3,0(1) 	Load variable x
104:     ST  3,-6(1) 	Save left side 
105:     LD  3,-2(1) 	Load variable y
106:     LD  4,-6(1) 	Load left into ac1 
107:    JEQ  3,1(7) 	Op AND 
108:    LDA  3,0(4) 	 
109:     ST  3,-6(1) 	Save left side 
110:     LD  3,-3(1) 	Load variable z
111:     LD  4,-6(1) 	Load left into ac1 
112:     ST  3,-6(1) 	Store parameter 
113:    LDA  1,-4(1) 	Load address of new frame 
114:    LDA  3,1(7) 	Return address in ac 
115:    LDA  7,-98(7) 	CALL outputb
116:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
117:     ST  1,-4(1) 	Store old frame in ghost frame 
118:    LDA  1,-4(1) 	Load address of new frame 
119:    LDA  3,1(7) 	Return address in ac 
120:    LDA  7,-96(7) 	CALL outnl
121:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
122:    LDC  3,0(6) 	Load constant 
123:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
124:    LDC  3,0(6) 	Load constant 
125:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
126:    LDC  3,0(6) 	Load constant 
127:     ST  3,-3(1) 	Store variable z
* EXPRESSION STMT
128:     ST  1,-4(1) 	Store old frame in ghost frame 
129:     LD  3,0(1) 	Load variable x
130:     ST  3,-6(1) 	Save left side 
131:     LD  3,-2(1) 	Load variable y
132:     ST  3,-7(1) 	Save left side 
133:     LD  3,-3(1) 	Load variable z
134:     LD  4,-7(1) 	Load left into ac1 
135:    JEQ  3,1(7) 	Op AND 
136:    LDA  3,0(4) 	 
137:     LD  4,-6(1) 	Load left into ac1 
138:     ST  3,-6(1) 	Store parameter 
139:    LDA  1,-4(1) 	Load address of new frame 
140:    LDA  3,1(7) 	Return address in ac 
141:    LDA  7,-124(7) 	CALL outputb
142:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
143:     ST  1,-4(1) 	Store old frame in ghost frame 
144:     LD  3,0(1) 	Load variable x
145:     ST  3,-6(1) 	Save left side 
146:     LD  3,-2(1) 	Load variable y
147:     LD  4,-6(1) 	Load left into ac1 
148:    JEQ  3,1(7) 	Op AND 
149:    LDA  3,0(4) 	 
150:     ST  3,-6(1) 	Save left side 
151:     LD  3,-3(1) 	Load variable z
152:     LD  4,-6(1) 	Load left into ac1 
153:     ST  3,-6(1) 	Store parameter 
154:    LDA  1,-4(1) 	Load address of new frame 
155:    LDA  3,1(7) 	Return address in ac 
156:    LDA  7,-139(7) 	CALL outputb
157:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
158:     ST  1,-4(1) 	Store old frame in ghost frame 
159:     LD  3,0(1) 	Load variable x
160:     ST  3,-6(1) 	Save left side 
161:     LD  3,-2(1) 	Load variable y
162:     LD  4,-6(1) 	Load left into ac1 
163:    JEQ  3,1(7) 	Op AND 
164:    LDA  3,0(4) 	 
165:     ST  3,-6(1) 	Save left side 
166:     LD  3,-3(1) 	Load variable z
167:     ST  3,-7(1) 	Save left side 
168:     LD  3,-3(1) 	Load variable z
169:     LD  4,-7(1) 	Load left into ac1 
170:    JEQ  3,1(7) 	Op AND 
171:    LDA  3,0(4) 	 
172:     LD  4,-6(1) 	Load left into ac1 
173:     ST  3,-6(1) 	Store parameter 
174:    LDA  1,-4(1) 	Load address of new frame 
175:    LDA  3,1(7) 	Return address in ac 
176:    LDA  7,-159(7) 	CALL outputb
177:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
178:     ST  1,-4(1) 	Store old frame in ghost frame 
179:     LD  3,0(1) 	Load variable x
180:     ST  3,-6(1) 	Save left side 
181:     LD  3,-2(1) 	Load variable y
182:     ST  3,-7(1) 	Save left side 
183:     LD  3,-3(1) 	Load variable z
184:     LD  4,-7(1) 	Load left into ac1 
185:    JEQ  3,1(7) 	Op AND 
186:    LDA  3,0(4) 	 
187:     LD  4,-6(1) 	Load left into ac1 
188:     ST  3,-6(1) 	Store parameter 
189:    LDA  1,-4(1) 	Load address of new frame 
190:    LDA  3,1(7) 	Return address in ac 
191:    LDA  7,-174(7) 	CALL outputb
192:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
193:     ST  1,-4(1) 	Store old frame in ghost frame 
194:     LD  3,0(1) 	Load variable x
195:     ST  3,-6(1) 	Save left side 
196:     LD  3,-2(1) 	Load variable y
197:     LD  4,-6(1) 	Load left into ac1 
198:    JEQ  3,1(7) 	Op AND 
199:    LDA  3,0(4) 	 
200:     ST  3,-6(1) 	Save left side 
201:     LD  3,-3(1) 	Load variable z
202:     LD  4,-6(1) 	Load left into ac1 
203:     ST  3,-6(1) 	Store parameter 
204:    LDA  1,-4(1) 	Load address of new frame 
205:    LDA  3,1(7) 	Return address in ac 
206:    LDA  7,-189(7) 	CALL outputb
207:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
208:     ST  1,-4(1) 	Store old frame in ghost frame 
209:    LDA  1,-4(1) 	Load address of new frame 
210:    LDA  3,1(7) 	Return address in ac 
211:    LDA  7,-187(7) 	CALL outnl
212:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
213:    LDC  2,0(6) 	Set return value to 0 
214:     LD  3,-1(1) 	Load return address 
215:     LD  1,0(1) 	Adjust fp 
216:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,216(7) 	Jump to init 
* BEGIN Init
217:     LD  0,0(0) 	Set the global pointer 
218:    LDA  1,0(0) 	set first frame at end of globals 
219:     ST  1,0(1) 	store old fp (point to self) 
220:    LDA  3,1(7) 	Return address in ac 
221:    LDA  7,-192(7) 	Jump to main 
222:   HALT  0,0,0 	DONE! 
* END Init
