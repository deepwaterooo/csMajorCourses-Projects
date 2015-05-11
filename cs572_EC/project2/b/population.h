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
    Population(int n, int maxdepth, Individual* indiptr, float mutrate);
    virtual ~Population();
    
    void generate();// generate population
    int getSize(){return size;}  // get population size
    void print();   // print population
    void evaluate_print();

    //void mutate();
    //void mutateAll();

    void genRanIndi(int n);
    void printRanIndi(int len);

    int TourSelection(int len);
    twoIdx tourSelection(int len);
    twoIdx maxFitness();

    float minFitness();
    float avgFitness();
    float avgIndiSize();
    
    void swapSubtree(int winIdx1, int winIdx2, int cnt);
    void newGen(int winIdx1, int winIdx2, int cnt);
    bool reachBest();    

    int* idxArray;
    float mutRate;
 private:
    int size;
    int depth;
    Individual* indiPtr;
    Individual* popu;
};

#endif
