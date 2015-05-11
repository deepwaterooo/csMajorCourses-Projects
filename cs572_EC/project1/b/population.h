#ifndef POPULATION_H
#define POPULATION_H

#include <iostream>
#include "individual.h"

using namespace std;

class Population : public Individual {
 public:
    Population(int n);
    Population(const Population&);
    //virtual Population& operator=(const Population&);
    Population& operator=(const Population&);
    //~Population();
    virtual ~Population();
    
    // functions
    int getSize();  // get population size
    void print();   // print population
    void generate();// generate population
    void mutateAll();

    void genRanIndi(int n);
    void printRanIndi(int len);
    int tourSelection(int len);

    float minFitness();
    int maxFitness();
    float avgFitness();
    int roulSelection();

    void newGen(int winIdx);
    bool reachBest();    

    int* idxArray;
 private:
    int size;
    Individual* popu;
};

#endif
