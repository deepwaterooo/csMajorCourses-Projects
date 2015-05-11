BIN  = c-
CC   = g++
CFLAGS = -DCPLUSPLUS -g     # for use with C++ if file ext is .c

SRCS = $(BIN).y $(BIN).l
HDRS = scanType.h symtab.h emitCode.h
OBJS = lex.yy.o $(BIN).tab.o symtab.o emitCode.o
LIBS = -lfl -lm 

$(BIN): $(OBJS)
	$(CC) -Wno-Wwrite-strings $(CFLAGS) $(OBJS) $(LIBS) -o $(BIN) 

$(BIN).tab.h $(BIN).tab.c: $(BIN).y
	bison -v -t -d $(BIN).y  

lex.yy.c: $(BIN).l $(BIN).tab.h
	flex $(BIN).l

all:    
	touch $(SRCS)
	make

clean:
	rm -f $(OBJS) $(BIN) lex.yy.c $(BIN).tab.h $(BIN).tab.c $(BIN).tar $(BIN).output *~

tar:
	tar -cvf $(BIN).tar $(SRCS) $(HDRS) makefile 
	ls -l $(BIN).tar

test:
	echo $(TSTS) | xargs -n1 runtest

tartests: 
	tar -cvf setOfTests.tar $(TSTS) $(OUTS) $(OUTP)
	tar -cvf justTests.tar $(TSTS)
	ls -l setOfTests.tar justTests.tar

tarall: 
	make tartests
	tar -cvf $(BIN)-all.tar $(SRCS) $(HDRS) $(TSTS) setOfTests.tar makefile	
	ls -l $(BIN)-all.tar

add:
	hg add $(SRCS) $(HDRS) makefile	
