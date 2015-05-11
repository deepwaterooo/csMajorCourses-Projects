#ifndef POPULATION_H
#define POPULATION_H

#include <iostream>
#include "node.h"
#include "individual.h"

using namespace std;

typedef struct twoIdxPoint 
{
    int fst;
    int snd;
} twoIdx;

    
class Population: public Individual {
 public:
    Population(int n, int maxdepth, Individual* indiptr);
    virtual ~Population();
    
    // functions
    int getSize();  // get population size
    void print();   // print population
    void generate();// generate population
    //void mutate(float mutRate);
    //void mutateAll();

    void genRanIndi(int n);
    void printRanIndi(int len);
    
    twoIdx tourSelection(int len);
    twoIdx maxFitness();

    float minFitness();
    float avgFitness();
    float avgIndiSize();
    
    int roulSelection();
    void evaluate_print();
    
    void mutateCrossOver2Point(twoIdx winIdx, int cnt);
    void newGen(twoIdx winIdx, int cnt);
    
    bool reachBest();    
    int* idxArray;

 private:
    int size;
    int depth;
    Individual* indiPtr;
    Individual* popu;
};

#endif
