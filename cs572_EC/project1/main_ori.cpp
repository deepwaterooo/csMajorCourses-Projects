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

// funPtrNSe set

int main() {
    srand(time(NULL));
    Function* funptr;
    funPtrSep pfun;   // separatable
    funPtrSep pFun[3] = {        
        getSphFitness,
        getRasFitness,
        getSchFitness
    };
    /*    
          funPtrNSe pfun;  // non separatable
          funPtrNSe pFun[3] = {        
          getRosFitness,    
          getAckFitness,
          getGriFitness
          };
    */
    int i = 2;
    pfun = pFun[i];

    //funptr = new Function(sphl, sphh, pFun[0], true); 
    //funptr = new Function(rasl, rash, pFun[1], true);
    funptr = new Function(schl, schh, pFun[2], true); // 2000
    //funptr = new Function(rosl, rosh, pFun[0], false);  
    //funptr = new Function(ackl, ackh, pFun[1], false);
    //funptr = new Function(gril, grih, pFun[2], false);
    
    Individual* indi = new Individual(funptr);
    indi->generate();
     
    int popuSize[8] = {20, 25, 50, 100, 200, 400, 800, 1000};
    int genCount[8] = {1000, 800, 400, 200, 100, 50, 25, 20};
    float minFitness[8];
    float avgFitness[8];

    int sampleSize = 10;
    float mutateRate = 0.5;
    float crsRate = 0.9;
    int* idxArray = new int[sampleSize];
    int counter = 0;
    twoIdx winIdx;
    float min, avg;

    for (int it = 0; it < 8; ++it) {     
        min = 0.0;
        avg = 0.0;
        for (int i = 0; i < 100; ++i) {         
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
        minFitness[it] = min / 1000.0;
        avgFitness[it] = avg / 1000.0;
        cout << "minFitness[" << it << "]: " << endl;
        cout << "avgFitness[" << it << "]: " << endl;
    }

    for (int i = 0; i < 8; ++i) 
        printf("%5.5f\t %5.5f\n", minFitness[i], avgFitness[i]);
    delete idxArray;
    delete funptr;
    return 0;    
}
