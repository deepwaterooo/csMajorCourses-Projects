#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <time.h>
#include "fitness.h"
#include "function.h"
#include "individual.h"
#include "population.h"

using namespace std;

typedef float (*funPtrSep)(float);
typedef float (*funPtrNSe)(float*, int);

// g++ -g main.cpp individual.cpp population.cpp fitness.cpp function.cpp -o a

int main() {
    srand(time(NULL));
    Function* funptr;
    funPtrSep pfun;   // separatable
    funPtrSep pFun[3] = {        
        getSphFitness,
        getRasFitness,
        getSchFitness
    };
    int i = 2;
    pfun = pFun[i];
    funptr = new Function(schl, schh, pFun[i], true); // 2000
    
    Individual* indi = new Individual(funptr);
    indi->generate();
    /*
    int popuSize[8] = {20, 25, 50, 100, 200, 400, 800, 1000};
    int genCount[8] = {1000, 800, 400, 200, 100, 50, 25, 20};
    float minFitness[8];
    float avgFitness[8];
    */
    int popuSize = 100;
    int sampleSize = 10;
    float mutateRate = 0.5;
    float crsRate = 0.9;
    int* idxArray = new int[sampleSize];
    int counter = 0;
    twoIdx winIdx;
    float min, avg;
    /*
    for (int it = 0; it < 8; ++it) {
        cout << "it: " << it << endl;
        
        min = 0.0;
        avg = 0.0;
        for (int i = 0; i < 300; ++i) {         
            Population* popu = new Population(popuSize[it], mutateRate, crsRate, indi);
            counter = 0;
            while (counter < genCount[it]) {
                popu->genRanIndi(sampleSize);
                idxArray = popu->idxArray;
                winIdx = popu->tourSelection(sampleSize);
                popu->newGen(winIdx, counter);
                ++counter;
            }
            min += popu->minFitness();
            avg += popu->avgFitness();
        }
        minFitness[it] = min / 300.0;
        avgFitness[it] = avg / 300.0;
        cout << "minFitness[" << it << "]: " << minFitness[it] << endl;
        cout << "avgFitness[" << it << "]: " << avgFitness[it] << endl;
    }
    for (int i = 0; i < 8; ++i) 
        printf("%5.5f\t %5.5f\n", minFitness[i], avgFitness[i]);
    delete idxArray;
    delete funptr;
    return 0;    
    */
    Population* popu = new Population(popuSize, mutateRate, crsRate, indi);
    counter = 0;
    while (counter < 10000) {
        popu->genRanIndi(sampleSize);
        idxArray = popu->idxArray;
        winIdx = popu->tourSelection(sampleSize);
        popu->newGen(winIdx, counter);
        ++counter;
        if (counter == 0 || counter % 200 == 0)
            printf("%d\t%5.5f\t %5.5f\n", counter, popu->minFitness(),  popu->avgFitness());
    }
    delete idxArray;
    delete funptr;
    return 0;
}
