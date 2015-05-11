#include<iostream>
#include<cmath>
#include<ctime>
#include<cstdlib>
#include <cstring>

#include "node.h"
#include "individual.h"
#include "population.h"

using namespace std;

// g++ -g test.cpp individual.cpp population.cpp node.cpp ant.cpp

double X;

int main(){
	srand(time(NULL));
	Individual i;
    int maxDepth = 2;

    i.generate(maxDepth);
	i.evaluate_print();
    i.calc_size();

    Individual* indi = &i;
    float mutateRate = 0.6;
    float crsRate = 0.9;
    int step = 600;
    int popuSize = 6;
    Population* popu = new Population(popuSize, maxDepth, indi, mutateRate, step);
    popu->generate();
    //popu->print();
    cout << "Population Information: " << endl;
    cout << "min:" << popu->minFitness() << endl;
    cout << "avg:" << popu->avgFitness() << endl;
    cout << "avgSize:" << popu->avgIndiSize() << endl;
    int sampleSize = 2;
    int counter = 0;
    int* idxArray = new int[sampleSize];
    int winIdx1, winIdx2;
    cout << "00" << " \t " << popu->minFitness() << " \t " << popu->avgFitness() << "\t"
         << popu->maxfitness() << " \t " << popu->avgIndiSize() << endl;

    //while (counter < 1000) {
    while(!popu->reachBest()) {    
        //while (popu->minFitness() - 2.5 > 0.00001) {     
        popu->genRanIndi(sampleSize);
        idxArray = popu->idxArray;
        //popu->printRanIndi(sampleSize);
        winIdx1 = popu->TourSelection(sampleSize);

        memset(idxArray, 0, sizeof(idxArray));
        popu->genRanIndi(sampleSize);
        //popu->printRanIndi(sampleSize);
        winIdx2 = popu->TourSelection(sampleSize);
        while (winIdx2 == winIdx1) {        
            memset(idxArray, 0, sizeof(idxArray));
            popu->genRanIndi(sampleSize);
            idxArray = popu->idxArray;
            //popu->printRanIndi(sampleSize);
            winIdx2 = popu->TourSelection(sampleSize);
        }

        popu->newGen(winIdx1, winIdx2, counter);
        //popu->print();

        if (counter % 10 == 0 || counter == 0 || counter < 10)
            cout << counter << " \t " << popu->minFitness() << " \t " << popu->avgFitness()
                 << "\t" << popu->maxfitness() << " \t " << popu->avgIndiSize() << endl;
        /*
          if (counter == 49999) 
          {
          float minFitness = popu->minFitness();
          for (int i = 0; i < popuSize; ++i) 
          {
          if (popu[i].getFitness() - minFitness < 0.000001) 
          {
          cout << "popu[" << i << "]: " << endl;
          popu[i].Individual::print(popu[i].getNodePtr(), 0);
          }
          }
          } 
          popu->print();
          }
*/  
        if (popu->minFitness() - 70 > 0)
          popu->print();
        ++counter;
    }

}

