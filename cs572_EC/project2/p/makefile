all: population.o individual.o node.o
	g++ test.cpp population.o individual.o node.o

population.o: population.h individual.h node.h
	g++ -c population.cpp

individual.o: individual.h node.h
	g++ -c individual.cpp

node.o: node.h
	g++ -c node.cpp

clean:
	\rm *.o *~ a.out
