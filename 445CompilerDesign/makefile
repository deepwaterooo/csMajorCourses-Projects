BIN  = calc
CC   = g++
# CFLAGS = -g

# for use with C++ if file ext is .cc
# CCFLAGS = -DCPLUSPLUS -g
CFLAGS = -DCPLUSPLUS -g
SRCS = $(BIN).y $(BIN).l
OBJS = lex.yy.o $(BIN).tab.o
LIBS = -lfl -lm 

$(BIN): $(OBJS)
	$(CC) $(CCFLAGS) $(OBJS) $(LIBS) -o $(BIN)

$(BIN).tab.h $(BIN).tab.c: $(BIN).y
	bison -v -t -d $(BIN).y  

lex.yy.c: $(BIN).l $(BIN).tab.h
	flex $(BIN).l  # -d debug

all:    
	touch $(SRCS)
	make

clean:
	rm -f $(OBJS) $(BIN) lex.yy.c $(BIN).tab.h $(BIN).tab.c $(BIN).tar

tar:
	tar -cvf $(BIN).tar $(SRCS) makefile 
