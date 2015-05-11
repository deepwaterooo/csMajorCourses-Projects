#include <iostream>
#include "fitness.h"
#include "function.h"

Function::Function(float l, float h, funPtrSep  ptr, bool flag):
    low(l), high(h), fitness(0.0), sepaFlag(flag), sepPtr(ptr) {
}

Function::Function(float l, float h, funPtrNSe  ptr, bool flag):
    low(l), high(h), fitness(0.0), sepaFlag(flag), nsePtr(ptr) {
}

Function::Function(const Function& orig):
    low(orig.low),
    high(orig.high),
    fitness(orig.fitness),
    sepaFlag(orig.sepaFlag),
    sepPtr(orig.sepPtr),
    nsePtr(orig.nsePtr) {
}

Function::~Function()  {
    //delete sepPtr;
    //delete nsePtr;
}

float Function::getFitness(float x)  {
    fitness = (*sepPtr)(x);
    return fitness;
}

float Function::getFitness(float* x, int p)  {
    fitness = (*nsePtr)(x, p);
    return fitness;
}
