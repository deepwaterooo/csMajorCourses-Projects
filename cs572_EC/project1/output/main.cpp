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
     int popuSize = 1000;
     float mutateRate = 0.5;
     float crsRate = 0.9;
     Population* popu = new Population(popuSize, mutateRate, crsRate, indi);
     //popu->print();     
     
     int sampleSize = 50;
     int counter = 0;
     int* idxArray = new int[sampleSize];
     twoIdx winIdx;

     while (counter < 2000) {
     //while (popu->minFitness() - 2.5 > 0.00001) {     
         popu->genRanIndi(sampleSize);
         idxArray = popu->idxArray;
         //popu->printRanIndi(sampleSize);
         winIdx = popu->tourSelection(sampleSize);
         popu->newGen(winIdx, counter);
         ++counter;

         if (counter % 10 == 0)
             printf("%d\t%4.5f\t%4.5f\n", counter, popu->minFitness(), popu->avgFitness());
     }

     float tmp = popu->minFitness();
     //int index;
     pf("tmp", tmp);
     /*     
     for (int i = 0; i < popuSize; i++) {
         pf("popu[i].fitness", popu[i].fitness);
         if (popu[i].fitness - tmp < 0.000001) 
             index = i;
         i = popuSize;
     }
     popu->print();     
     printf("min index: %d\n", index);
     */
     printf("number of loops have conducted: %d\n", counter);
     delete idxArray;
     delete funptr;
     return 0;    
}
