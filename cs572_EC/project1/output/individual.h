#ifndef INDIVIDUAL_H
#define INDIVIDUAL_H

#include <iostream>
#include "fitness.h"
#include "function.h"

using namespace std;

const int p = 30;


class Individual {
 public:
    // copy management
    Individual();
    Individual(float l, float h, funPtrSep ptr, bool flag);
    Individual(float l, float h, funPtrNSe ptr, bool flag);

    Individual(Function* funptr);                        // default constructor
    Individual(Individual& rhs);        // copy constructor
    virtual Individual& operator=(Individual &);//assign operator
    virtual ~Individual();

    // functions
    void generate();   // generate an individual
    void print();      // print out the individual
    float getFitness();// caculate the fitness when initialization
    void mutate(float mutRate, int gennum);     // mutate individual

    float* point;      // pointer to dynamic array of dimension size p (constant)
    float fitness;     // store fitness value for the point
    float mutRate;
    Function* funPtr;
};

#endif
