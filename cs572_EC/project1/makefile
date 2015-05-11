all: individual.o population.o function.o fitness.o 
	g++ main.cpp individual.o population.o fitness.o function.o

population.o: population.h individual.h function.h fitness.h 
	g++ -c population.cpp 

individual.o: individual.h function.h fitness.h 
	g++ -c individual.cpp 

function.o: function.h fitness.h 
	g++ -c function.cpp

fitness.o: fitness.h 
	g++ -c fitness.cpp

clean:
	\rm *.o *~ a.out
  
