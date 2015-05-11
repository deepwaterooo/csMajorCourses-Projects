#ifndef INDIVIDUAL_H
#define INDIVIDUAL_H

#include <iostream>
#include "individual.h"
#include "pf.h"

using namespace std;

const float INF = 5.12*5.12*30; 
const float sphl = -5.12; 
const float sphh = 5.12; 
const int p = 30;

class Individual {
 public:
    // copy management
    Individual();                        // default constructor
    Individual(const Individual& rhs);   // copy constructor
    Individual& operator=(const Individual &);//assign operator
    virtual ~Individual();

    // functions
    void generate();   // generate an individual
    void print();      // print out the individual
    float getFitness();// caculate the fitness when initialization
    void mutate();     // mutate individual

    float* point;      // pointer to dynamic array of dimension size p (constant)
    float fitness;     // store fitness value for the point
};

#endif
