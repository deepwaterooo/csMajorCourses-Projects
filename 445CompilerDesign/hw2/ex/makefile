
CCC = g++
CCFLAGS= -O2
LEX = flex
LFLAGS= -8     
YACC= bison 
YFLAGS= -d -t -y

RM = /bin/rm -f

exp: y.tab.o lex.yy.o exp.o
	${CCC} ${CCFLAGS} lex.yy.o y.tab.o exp.o -o exp -lfl

exp.o: exp.cpp exp.h
	${CCC} -c exp.cpp
y.tab.o: exp.yacc
	${YACC} ${YFLAGS} exp.yacc
	${CCC} ${CCFLAGS} y.tab.c -c 

lex.yy.o: exp.lex
	${LEX} $(LFLAGS) exp.lex
	${CCC} ${CCFLAGS} lex.yy.c -c 

clean:
	/bin/rm -f lex.yy.* y.tab.* *.o exp
