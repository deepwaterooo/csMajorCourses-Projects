all: individual.o population.o pf.o
	g++ main.cpp individual.o population.o pf.o -o a 

population.o: population.h individual.h pf.h
	g++ -c population.cpp 

individual.o: individual.h pf.h
	g++ -c individual.cpp 

pf.o: pf.h
	g++ -c pf.cpp
    
clean:
	\rm *.o *~ a
  
