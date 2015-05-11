all: population.o individual.o node.o ant.o
	g++ test.cpp population.o individual.o node.o ant.o

population.o: population.h individual.h node.h
	g++ -c population.cpp

individual.o: individual.h node.h
	g++ -c individual.cpp

node.o: node.h
	g++ -c node.cpp

ant.o: ant.h
	g++ -c ant.cpp

clean:
	\rm *.o *~ a.out
