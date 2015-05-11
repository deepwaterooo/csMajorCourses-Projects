#include <cstdio>
#include <cstdlib>
#include "fitness.h"
#include "function.h"
#include "individual.h"
#include "population.h"

using namespace std;

extern int genNum ;

Population::Population(float l, float h, funPtrSep ptr, bool flag, int n, float mutRate):
    size(n), mutRate(mutRate) {
    popu = new Individual[size];
    for (int i = 0; i < size; ++i);
}

Population::Population(float l, float h, funPtrNSe ptr, bool flag, int n, float mutRate):
    size(n), mutRate(mutRate)  
{
    for (int i = 0; i < size; ++i);
}

Population::Population(int n, float mutRate, float crsrate, Individual* indiptr):
    size(n), mutRate(mutRate), crsRate(crsrate), indiPtr(indiptr) {
    popu = new Individual[size];
    popu[0] = *indiptr;
    popu[0].getFitness();
    
    for (int i = 1; i < size; ++i) {
        popu[i] = *indiptr;
        popu[i].Individual::generate();
        popu[i].getFitness();
    }
}
 
/*
Population::Population(const Population &orig):
    popu.Individual(orig), size(orig.size) { }
*/

Population& Population::operator=(Population &rhs) {
    if (this != &rhs) {
        Individual::operator=(rhs);   // assigns the base part
        size = rhs.size;
        mutRate = rhs.mutRate;
        popu = rhs.popu;
        idxArray = rhs.idxArray;
    }
    return *this;
}

Population::~Population() {
    // FOR loop delete individuals separately to make safe
    for (int i = 0; i < size; ++i) 
        popu[i].Individual::~Individual();
    indiPtr->~Individual();
    delete indiPtr;
    delete [] idxArray;
}

bool Population::reachBest() {
    float minF = minFitness();
    if (minF < 0.0001) {
	for (int i = 0; i < size; ++i) {
	    if (popu[i].fitness == minF)
		printf("Best individual: \n");
		popu[i].Individual::print();
	}
	return true;
    }
    return false;
}

int Population::getSize() { // get population size
    return size;
}

/*
void Population::newGen(int winIdx, int cnt) {
    // keep sample elite
    // replace worst population individual with mutated elite

    int worIdx = maxFitness();
    for (int i =0; i < p; ++i) {
        popu[worIdx].point[i] = popu[winIdx].point[i];
        popu[worIdx].fitness = popu[winIdx].fitness;
    }
    popu[winIdx].mutate(mutRate, cnt);
}
*/
/*
// a complete new generation with all offsprings generated from two parent
void Population::newGen(twoIdx winIdx, int cnt) {
    // keep sample elite
    // replace other population individuals with crossover and mutated elites with probas
    int fst = winIdx.fst;
    int snd = winIdx.snd;
    int other;

    // copy elite parent to worst two positions
    if ( (fst == 0 && snd == 1) || (fst == 1 && snd == 0) ) {;}
    else if ( (fst == 0 && snd != 1) || (snd == 0 && fst != 1) ) // 0 occupied
    {
        other = (fst == 0) ? snd : fst;
        for (int i = 0; i < p; ++i) {
            popu[1].point[i] = popu[other].point[i];
            popu[1].fitness = popu[other].fitness;
        }
    } else if ( (fst == 1 && snd != 0) || (snd == 1 && fst != 0) ) { // 1 occupied
        other = (fst == 1) ? snd : fst;
        for (int i = 0; i < p; ++i) {
            popu[0].point[i] = popu[other].point[i];
            popu[0].fitness = popu[other].fitness;
        }
    } else {
        for (int i = 0; i < p; ++i) {
            popu[0].point[i] = popu[fst].point[i];
            popu[1].point[i] = popu[snd].point[i];
            popu[0].fitness = popu[fst].fitness;
            popu[1].fitness = popu[snd].fitness;
        }
    }
    
    int lowIdx, highIdx;
    int second, tmpidx;

    // mutate both crossoved offspring with mutrate
    int lowThd, highThd;
    lowThd = (*(popu[0].funPtr)).low;
    highThd = (*(popu[0].funPtr)).high;

    float delta, tempval;
    
    for (int ip = 2; ip < size; ip+=2) 
    {
        second = ip + 1;
        // copy over to place ip & second 
        for (int i = 0; i < p; ++i) {
            popu[ip].point[i] = popu[fst].point[i];
            popu[second].point[i] = popu[snd].point[i];
        }
        
        if ( (rand() % 100 / 100.0) < crsRate ) // crossover parent to produce child
        {
            lowIdx = rand() % size;
            highIdx = rand() % size;
            while (lowIdx == 0 || highIdx == size-1 || lowIdx == highIdx) 
            {
                lowIdx = rand() % size;
                highIdx = rand() % size;
            }
            if (lowIdx > highIdx)
                swap(lowIdx, highIdx);

            float temp[highIdx-lowIdx];
            tmpidx = lowIdx;

            // save and swap fragments of the snd fragment
            for (int i = 0; i < highIdx-lowIdx; ++i) 
            {
                temp[i] = popu[second].point[tmpidx];
                popu[second].point[tmpidx] = popu[ip].point[tmpidx];
                popu[ip].point[tmpidx] = temp[i];
                tmpidx++;
            } // done crossover with probability
        } else { // mutate only
            popu[ip].Individual::mutate(mutRate, cnt);
            popu[second].Individual::mutate(mutRate, cnt);
        }
        
        if (cnt % 500000 == 0)  
            genNum *= 10;       // ?

        // fst parent mutate
        for (int i = 0; i < p; ++i) {
            if (rand()%1000/1000.0 < mutRate) {            
                delta = (float)((highThd - lowThd) / genNum );
                if ( (rand()%100/100.0) < 0.5)   // pos
                    tempval = popu[ip].point[i] + delta;
                else                  // neg
                    tempval = popu[ip].point[i] - delta;
                while (tempval < lowThd || tempval > highThd) {
                    delta = (float)(highThd - lowThd) / genNum;
                    if ( (rand()%100/100.0) < 0.5)   // pos
                        tempval = popu[ip].point[i] + delta;
                    else                  // neg
                        tempval = popu[ip].point[i] - delta;
                } // while
            }
            popu[ip].point[i] = tempval;

            if (rand()%1000/1000.0 < mutRate) {            
                delta = (float)((highThd - lowThd) / genNum );
                if ( (rand()%100/100.0) < 0.5)   // pos
                    tempval = popu[second].point[i] + delta;
                else                  // neg
                    tempval = popu[second].point[i] - delta;
                while (tempval < lowThd || tempval > highThd) {
                    delta = (float)(highThd - lowThd) / genNum;
                    if ( (rand()%100/100.0) < 0.5)   // pos
                        tempval = popu[second].point[i] + delta;
                    else                  // neg
                        tempval = popu[second].point[i] - delta;
                } // while
            }
            popu[second].point[i] = tempval;
        }
        popu[ip].fitness = popu[ip].Individual::getFitness();
        popu[second].fitness = popu[second].Individual::getFitness();
    }
}
*/

void Population::newGen(twoIdx winIdx, int cnt) {
    // keep sample elite
    // replace worst population individual with mutated elite

    twoIdx worIdx = maxFitness();
    int fst = worIdx.fst;
    int snd = worIdx.snd;
    
    int winfst = winIdx.fst;
    int winsnd = winIdx.snd;

    // copy elite parent to worst two positions
    for (int i = 0; i < p; ++i) {
        popu[fst].point[i] = popu[winfst].point[i];
        popu[snd].point[i] = popu[winsnd].point[i];
        popu[fst].fitness = popu[winfst].fitness;
        popu[snd].fitness = popu[winsnd].fitness;
    }
    
    // 2 point crossover two elite parent on place
    mutateCrossOver2Point(winIdx, cnt);
}

void Population::mutateCrossOver2Point(twoIdx winIdx, int cnt) 
{
    int lowIdx = rand() % p;
    int highIdx = rand() % p;
    
    while (lowIdx == 0 || highIdx == p-1
           || highIdx == 0 || lowIdx == p-1
           || lowIdx == highIdx) {    
        lowIdx = rand() % p;
        highIdx = rand() % p;
    }
    if (lowIdx > highIdx)
        swap(lowIdx, highIdx);
    
    float temp[highIdx-lowIdx];
    int fst = winIdx.fst;
    int snd = winIdx.snd;
    int tmpidx = lowIdx;

    // save and swap fragments
    for (int i = 0; i < highIdx-lowIdx; ++i) {    
        temp[i] = popu[snd].point[tmpidx];
        popu[snd].point[tmpidx] = popu[fst].point[tmpidx];
        popu[fst].point[tmpidx] = temp[i];
        tmpidx++;
    }
        
    float delta, tempval;
    if (cnt % 2 == 0)  
        genNum *= 10.0;    

    // mutate both crossoved parent with mutrate
    float lowThd, highThd;
    lowThd = (*(popu[0].funPtr)).low;
    highThd = (*(popu[0].funPtr)).high;
        
    // fst parent mutate
    for (int i = 0; i < p; ++i) {
        if (rand()%1000/1000.0 < mutRate) 
        {
            delta = (float)((highThd - lowThd) / genNum );
            
            if ( (rand()%100/100.0) < 0.5)   // pos
                tempval = popu[fst].point[i] + delta;
            else                  // neg
                tempval = popu[fst].point[i] - delta;
            while (tempval < lowThd || tempval > highThd) {
                delta = (float)(highThd - lowThd) / genNum;
                if ( (rand()%100/100.0) < 0.5)   // pos
                    tempval = popu[fst].point[i] + delta;
                else                  // neg
                    tempval = popu[fst].point[i] - delta;
            } // while
        }
        popu[fst].point[i] = tempval;
    }
    popu[fst].fitness = popu[fst].getFitness();
    
    for (int i = 0; i < p; ++i) {
        if (rand()%1000/1000.0 < mutRate) 
        {
            delta = (float)((highThd - lowThd) / genNum );
            if ( (rand()%100/100.0) < 0.5)   // pos
                tempval = popu[snd].point[i] + delta;
            else                  // neg
                tempval = popu[snd].point[i] - delta;
            while (tempval < lowThd || tempval > highThd) {
                    printf("I got here 307\n");

                delta = (float)(highThd - lowThd) / genNum;
                if ( (rand()%100/100.0) < 0.5)   // pos
                    tempval = popu[snd].point[i] + delta;
                else                  // neg
                    tempval = popu[snd].point[i] - delta;
            } // while
        }
        popu[snd].point[i] = tempval;
    }
    popu[snd].fitness = popu[snd].Individual::getFitness();
}

void Population::print() {  // print population
    for (int i = 0; i < size; ++i) 
    {
        //printf("popu[%d]: \n", i);
        popu[i].Individual::print();
    }
    printf("\n\n");
}

void Population::generate() { // generate population
    for (int i = 0; i < size; ++i) 
        popu[i].Individual::generate();
}
/*
void Population::mutateAll() {    // miss understanding
    for (int i = 0; i < size; ++i) {
	popu[i].Individual::mutate(mutRate);
    }
}
*/
void Population::printRanIndi(int len) {
    for (int i = 0; i < len; ++i)
	printf("%d ", idxArray[i]);
    printf("\n");
}

void Population::genRanIndi(int n) {
  idxArray = new int[n];
  idxArray[0] = rand() % size;
  for (int i = 1; i < n; ++i) 
  {
	idxArray[i] = rand() % size;
    while (idxArray[i] == idxArray[i-1])
        idxArray[i] = rand() % size;
  }
}

twoIdx Population::tourSelection(int len) {
    twoIdx idx;
    int winIdx = idxArray[0], sndIdx = winIdx;
    float winFitness = popu[winIdx].fitness, sndFitness = winFitness;
    int temp = idxArray[0], snd;
    float tempFitness = popu[temp].fitness, sndfit;
    for (int i = 1; i < len; ++i) {
        snd = temp;
        sndfit = tempFitness;
        temp = idxArray[i];
        tempFitness = popu[temp].fitness;
        if (tempFitness-winFitness < 0.000001) {        
            sndFitness = winFitness;
            sndIdx = winIdx;
            winFitness = tempFitness;
            winIdx = temp;
        }
        if ( (tempFitness-winFitness>0.000001)
             && (sndFitness-tempFitness>0.000001) ) {
            sndFitness = tempFitness;
            sndIdx = temp;
        }
    }
    idx.fst = winIdx;
    idx.snd = sndIdx;
    return idx;
}
/*
int Population::tourSelection(int len) {
    int winIdx = rand() % len;
    float winFitness = popu[idxArray[winIdx]].fitness;
    int temp;
    float tempFitness;
    for (int i = 0; i < len; ++i) {
	temp = idxArray[i];
	tempFitness = popu[temp].fitness;
	if (tempFitness < winFitness) {
	    winFitness = tempFitness;
	    winIdx = temp;
	}
    }
    return winIdx;
}
*/
float Population::minFitness() {
    float minFitness = popu[0].fitness;
    float tempFitness;
    for (int i = 1; i < size; ++i) {
	tempFitness = popu[i].fitness;
	if (tempFitness < minFitness)
	    minFitness = tempFitness;
    }
    return minFitness;
}

twoIdx Population::maxFitness() {
    twoIdx idx;
    float maxFitness = popu[0].fitness, sndFitness;
    int worIdx = 0, sndIdx, temp = 0, snd;
    float tempFitness = popu[temp].fitness, sndfit;

    for (int i = 1; i < size; ++i) {
        snd = temp;
        sndfit = tempFitness;        
        temp = i;
        tempFitness = popu[i].fitness;
        
        if (tempFitness - maxFitness > 0.00001) {
            sndFitness = maxFitness;
            sndIdx = worIdx;
            maxFitness = tempFitness;
            worIdx = temp;
        } else if ( (tempFitness - maxFitness <= 0.00001) && (tempFitness - sndFitness > 0.00001) ) {
            sndFitness = tempFitness;
            sndIdx = i;
        }
    }
    idx.fst = worIdx;
    idx.snd = sndIdx;
    return idx;
}
/*
int Population::maxFitness() {
    float maxFitness = popu[0].fitness;
    float tempFitness;
    int worIdx = 0;
    for (int i = 1; i < size; ++i) {
	tempFitness = popu[i].fitness;
	if (tempFitness - maxFitness > 0.00001) {
	    maxFitness = tempFitness;
	    worIdx = i;
	}
    }
    return worIdx;
}
    */
float Population::avgFitness() {
    float avgFitness = 0.0;
    for (int i = 0; i < size; ++i) {
	avgFitness += popu[i].fitness;
    }
    avgFitness = (float) (avgFitness / size);
    return avgFitness;
}

int Population::roulSelection() {
    float* weight = new float[size];

    float minFitness = Population::minFitness();
    float tempFitness;
    float sumFitness;
    bool negFlag = false;
    float sum = 0.0;

    if ( minFitness < 0.000001)
        negFlag = true;

    if (negFlag) {
        sumFitness = (avgFitness() - minFitness)*size;
        for (int i = 0; i < size; ++i) {
            tempFitness = popu[i].fitness - minFitness;
            sum += -minFitness + tempFitness;
            weight[i] = (float) (sum / sumFitness );
        }
    } else {
        sumFitness = avgFitness()*size;
        for (int i = 0; i < size; ++i) {
            tempFitness = popu[i].fitness;
            sum += tempFitness;
            weight[i] = (float) (sum / sumFitness );
        }
    }

    float prob = ( rand() % 1000 ) / 1000.0;
    for (int i = 0; i < size; ++i) {
        if (weight[i] < prob && weight[i+1] >= prob) {
            delete [] weight;
            return i+1;
        }
    }

    delete [] weight;
    return -1;
}
