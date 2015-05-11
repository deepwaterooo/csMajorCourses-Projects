c-: main.o c.tab.o lex.yy.o
	gcc -o c- main.o c.tab.o lex.yy.o

main.o: main.c
	gcc -c main.c 

c.tab.o: c.tab.c
	gcc -c c.tab.c 

c.tab.c: c.y
	bison -d c.y

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

lex.yy.c: c-.l c.tab.h
	flex c-.l

c.tab.h: c.tab.c

