#include <iostream>
#include <cstdio>
#include "population.h"
#include "pf.h"

using namespace std;

int main() {
    /*
      
    Individual* indi = new Individual;
    indi->generate();
    indi->print();
    float fit = indi->getFitness();
    pf("fit", fit);

    indi->mutate();
    indi->print();
    fit = indi->getFitness();
    pf("fit", fit);
    
    */
    
    int popuSize = 100;
 
    Population* popu = new Population(popuSize);
    popu->generate();

    int sampleSize = 5;
    int counter = 0;
    int* idxArray = new int[sampleSize];
    int winIdx;

    //while(!popu->reachBest()) {
    while (counter < 1000) {
	popu->genRanIndi(sampleSize);
	idxArray = popu->idxArray;
	//popu->printRanIndi(sampleSize);
    
	winIdx = popu->tourSelection(sampleSize);

	popu->newGen(winIdx);
	++counter;

	if (counter % 10 == 0)
	    printf("%d\t%4.5f\t%4.5f\n", counter, popu->minFitness(), popu->avgFitness());
    }
    
    popu->minFitness();
    printf("number of loops have conducted: %d\n", counter);
    
    delete idxArray;

    return 0;
}
