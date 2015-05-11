#include <cstdio>
#include <cstdlib>
#include "node.h"
#include "individual.h"
#include "population.h"

using namespace std;

extern int genNum ;

Population::Population(int n, int maxdepth, Individual* indiptr):
    size(n), depth(maxdepth) {
    popu = new Individual[size];
    //popu[0] = *indiPtr; //->copy();
    //popu[0].getFitness();

    //int dep;
    for (int i = 0; i < size; ++i) {
        //dep = rand() % depth + 1;
        //cout << "dep: " << dep << endl;
        
        popu[i] = *indiptr;
        popu[i].Individual::generate(depth);
        //popu[i].getFitness();
    }
}

Population::~Population() {
    // FOR loop delete individuals separately to make safe
    for (int i = 0; i < size; ++i) 
        popu[i].Individual::~Individual();
    indiPtr->~Individual();
    delete indiPtr;
    delete [] idxArray;
}

void Population::evaluate_print() 
{
    for (int i = 0; i < size; ++i)
        popu[i].evaluate_print();
}

bool Population::reachBest() {
    float minF = minFitness();
    if (minF < 0.0001) {
        for (int i = 0; i < size; ++i) {
            if (popu[i].fitness == minF)
                printf("Best individual: \n");
            //popu[i].Individual::print();
        }
        return true;
    }
    return false;
}

int Population::getSize() { // get population size
    return size;
}

void Population::print() {  // print population
    for (int i = 0; i < size; ++i) 
    {
        cout << "popu[" << i << "]: " << endl;
        popu[i].Individual::print(popu[i].getNodePtr(), depth);
    }
    printf("\n\n");
}

void Population::generate() { // generate population
    int dep;
    for (int i = 0; i < size; ++i)
    {
        dep = rand() % depth + 1;
        cout << "popu[" << i << "] " << "dep: " << dep << endl;
        
        popu[i].Individual::generate(dep);
    }
}

void Population::printRanIndi(int len) {
    for (int i = 0; i < len; ++i)
	printf("%d ", idxArray[i]);
    printf("\n");
}

void Population::genRanIndi(int n) {
  idxArray = new int[n];
  idxArray[0] = rand() % size;
  for (int i = 1; i < n; ++i) 
  {
	idxArray[i] = rand() % size;
    while (idxArray[i] == idxArray[i-1])
        idxArray[i] = rand() % size;
  }
}

float Population::avgIndiSize() 
{
    int res = 0;
    for (int i = 0; i < size; ++i) 
    {
        //cout << "popu[" << i << "].size: " << popu[i].Individual::getSize() << endl;
        res += popu[i].getSize();
    }
    return (float)(res/size);
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

twoIdx Population::maxFitness() {
    twoIdx idx;
    float maxFitness = popu[0].fitness, sndFitness;
    int worIdx = 0, sndIdx, temp = 0, snd;
    float tempFitness = popu[temp].fitness, sndfit;

    for (int i = 1; i < size; ++i) {
        snd = temp;
        sndfit = tempFitness;        
        temp = i;
        tempFitness = popu[i].fitness;
        
        if (tempFitness - maxFitness > 0.00001) {
            sndFitness = maxFitness;
            sndIdx = worIdx;
            maxFitness = tempFitness;
            worIdx = temp;
        } else if ( (tempFitness - maxFitness <= 0.00001) && (tempFitness - sndFitness > 0.00001) ) {
            sndFitness = tempFitness;
            sndIdx = i;
        }
    }
    idx.fst = worIdx;
    idx.snd = sndIdx;
    return idx;
}
/*
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
    */
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
