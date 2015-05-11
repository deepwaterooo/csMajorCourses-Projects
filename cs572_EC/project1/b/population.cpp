#include <cstdio>
#include <cstdlib>
#include "individual.h"
#include "population.h"

using namespace std;

Population::Population(int n): size(n) {
    popu = new Individual[size];
}

Population::Population(const Population &orig):
    Individual(orig), size(orig.size) { }

Population& Population::operator=(const Population &rhs) {
    if (this != &rhs) {
	Individual::operator=(rhs);   // assigns the base part
	size = rhs.size;
    }
    return *this;
}

Population::~Population() {
    // FOR loop delete individuals separately to make safe
    for (int i = 0; i < size; ++i) 
	popu[i].Individual::~Individual();	 
    delete [] idxArray;
}

bool Population::reachBest() {
    float minF = minFitness();
    if (minF < 0.0001) {
	for (int i = 0; i < size; ++i) {
	    if (popu[i].fitness == minF)
		printf("Best individual: \n");
		popu[i].Individual::print();
	}
	return true;
    }
    return false;
}

int Population::getSize() { // get population size
    return size;
}

void Population::newGen(int winIdx) {
    // keep sample elite
    // replace worst population individual with mutated elite

    int worIdx = maxFitness();
    for (int i =0; i < p; ++i) {
	popu[worIdx].point[i] = popu[winIdx].point[i];
	popu[worIdx].fitness = popu[winIdx].fitness;
    }
    popu[winIdx].Individual::mutate();
}

void Population::print() {  // print population
    for (int i = 0; i < size; ++i) {
	popu[i].Individual::print();
    }
    printf("\n\n");
}

void Population::generate() { // generate population
    for (int i = 0; i < size; ++i) {
      popu[i].Individual::generate();
    }
}

void Population::mutateAll() { 
    for (int i = 0; i < size; ++i) {
	popu[i].Individual::mutate();
    }
}

void Population::printRanIndi(int len) {
    for (int i = 0; i < len; ++i)
	printf("%d ", idxArray[i]);
    printf("\n");
}

void Population::genRanIndi(int n) {
  idxArray = new int[n];
    for (int i = 0; i < n; ++i) 
	idxArray[i] = rand() % size;
}

int Population::tourSelection(int len) {
    int winIdx = rand() % len;
    float winFitness = popu[idxArray[winIdx]].fitness;
    int temp;
    float tempFitness;
    for (int i = 0; i < len; ++i) {
	temp = idxArray[i];
	tempFitness = popu[temp].fitness;
	if (tempFitness < winFitness) {
	    winFitness = tempFitness;
	    winIdx = temp;
	}
    }
    return winIdx;
}

float Population::minFitness() {
    float minFitness = popu[0].fitness;
    float tempFitness;
    for (int i = 1; i < size; ++i) {
	tempFitness = popu[i].fitness;
	if (tempFitness < minFitness)
	    minFitness = tempFitness;
    }
    return minFitness;
}

int Population::maxFitness() {
    float maxFitness = popu[0].fitness;
    float tempFitness;
    int worIdx = 0;
    for (int i = 1; i < size; ++i) {
	tempFitness = popu[i].fitness;
	if (tempFitness - maxFitness > 0.00001) {
	    maxFitness = tempFitness;
	    worIdx = i;
	}
    }
    return worIdx;
}

float Population::avgFitness() {
    float avgFitness = 0.0;
    for (int i = 0; i < size; ++i) {
	avgFitness += popu[i].fitness;
    }
    avgFitness = (float) (avgFitness / size);
    return avgFitness;
}

int Population::roulSelection() {
    float* weight = new float[size];

    float minFitness = Population::minFitness();
    float tempFitness;
    float sumFitness;
    bool negFlag = false;
    float sum = 0.0;

    if ( minFitness < 0.000001)
	negFlag = true;

    if (negFlag) {
	sumFitness = (avgFitness() - minFitness)*size;
	for (int i = 0; i < size; ++i) {
	    tempFitness = popu[i].fitness - minFitness;
	    sum += -minFitness + tempFitness;
	    weight[i] = (float) (sum / sumFitness );
	}
    } else {
	sumFitness = avgFitness()*size;
	for (int i = 0; i < size; ++i) {
	    tempFitness = popu[i].fitness;
	    sum += tempFitness;
	    weight[i] = (float) (sum / sumFitness );
	}
    }

    float prob = ( rand() % 1000 ) / 1000.0;
    for (int i = 0; i < size; ++i) {
	if (weight[i] < prob && weight[i+1] >= prob) {
	    delete [] weight;
	    return i+1;
	}
    }

    delete [] weight;
    return -1;
}
