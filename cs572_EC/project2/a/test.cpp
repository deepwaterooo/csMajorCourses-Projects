#include<iostream>
#include<cmath>
#include<ctime>
#include<cstdlib>
#include "node.h"
#include "individual.h"
#include "population.h"

using namespace std;

// g++ -g test.cpp individual.cpp population.cpp node.cpp

double X;

int main(){
	srand(time(NULL));
	Individual i;
    int maxDepth = 5;
    
    i.generate(maxDepth);
    i.print(i.getNodePtr(), 0);

	i.evaluate_print();
    i.calc_size();
	cout << "i Size = " << i.getSize() << endl;
    
    cout << endl << endl << "Individual j copied from i: " << endl;
    Individual j = i.copy();
    j.print(j.getNodePtr(), 0);

    j.evaluate_print();
    j.calc_size();
    cout << "Size = " << j.getSize() << endl;

    Individual* indi = &i;
    
    int popuSize = 100;
    Population* popu = new Population(popuSize, maxDepth, indi);
    popu->generate();
    /*
    cout << endl << endl << "Printing population: " << endl;
    popu->print();
    cout << endl;
    */
    popu->evaluate_print();
    cout << "min:" << popu->minFitness() << endl;
    cout << "avg:" << popu->avgFitness() << endl;
    cout << "avgSize:" << popu->avgIndiSize() << endl;
}
