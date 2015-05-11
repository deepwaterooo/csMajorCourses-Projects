#ifndef POPULATION_H
#define POPULATION_H

#include <iostream>
#include "fitness.h"
#include "function.h"
#include "individual.h"
using namespace std;

typedef struct twoIdxPoint {
    int fst;
    int snd;
} twoIdx;
    
class Population: public Individual {
 public:
    Population(float l, float h, funPtrSep ptr, bool flag, int n, float mutRate);
    Population(float l, float h, funPtrNSe ptr, bool flag, int n, float mutRate);
    Population(int n, float mutRate, float crsrate, Individual* indiptr);
    
    //Population(const Population&);
    //virtual Population& operator=(const Population&);
    virtual Population& operator=(Population&);
    
    //~Population();
    virtual ~Population();
    
    // functions
    int getSize(){return size;}  // get population size
    void print();   // print population
    void generate();// generate population
    //void mutate(float mutRate);

    void genRanIndi(int n);
    void printRanIndi(int len);
    
    //twoIdx tourSelection(int len);
    twoIdx maxFitness();

    float minFitness();
    float avgFitness();
    void distance(int x);
    twoIdx roulSelection();

    void mutateCrossOver2Point(twoIdx winIdx, int cnt);
    void newGen(twoIdx winIdx, int cnt);
    bool reachBest();    

    int* idxArray;
    float* dist;
    float* fitshare;
 private:
    int size;
    float mutRate;
    float crsRate;
    Individual* indiPtr;
    Individual* popu;
};

#endif
