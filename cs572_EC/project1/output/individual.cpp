// individual.cpp

#include <cstdio>
#include <stdlib.h>
#include <math.h>
#include "fitness.h"
#include "function.h"
#include "individual.h"

using namespace std;

float genNum = 100.0;

Individual::Individual() 
{
    //funPtr = new Function();
    point = new float[p];
}

Individual::Individual(float l, float h, funPtrSep ptr, bool flag) 
{
    funPtr = new Function(l, h, ptr, flag);
    point = new float[p];
}

Individual::Individual(float l, float h, funPtrNSe ptr, bool flag)
{
    funPtr = new Function(l, h, ptr, flag);
    point = new float[p];
}

Individual::Individual(Function* funptr): funPtr(funptr) {
    point = new float[p];
}

Individual::Individual(Individual &orig):
    funPtr(orig.funPtr),           
    fitness(orig.fitness),
    mutRate(orig.mutRate)
{
}

Individual& Individual::operator=(Individual &rhs) {
    fitness = rhs.fitness;
    mutRate = rhs.mutRate;
    funPtr = rhs.funPtr;
    for (int i = 0; i < p; ++i)
        point[i] = rhs.point[i];
    
    return *this;
}

Individual::~Individual() {
    delete [] point;
    funPtr->~Function();
    delete funPtr;
}
/*
void Individual::generate() {            // need modify here
    // get integer values for range
    int high = (int)((*funPtr).high);
    if (high < (*funPtr).high)
        high = high + 2;
            
    for (int i = 0; i < p; ++i) {
        if ( (rand()%100/100.0) >= 0.50 )
            point[i] = -420.0 - (rand() % 100000)/100000.0;
        else
            point[i] = -420.0 + (rand() % 100000)/100000.0;
        while (point[i] < (*funPtr).low || point[i] > (*funPtr).high) {
            if ( (rand()%100/100.0) >= 0.50 )
                point[i] = -420.0 - (rand() % 100000)/100000.0;
            else
                point[i] = -420.0 + (rand() % 100000)/100000.0;
        } // while
    }     // for
    fitness = getFitness();
}
*/
/*
void Individual::generate() {            // need modify here
    // get integer values for range
    int high = (int)((*funPtr).high);
    if (high < (*funPtr).high)
        high = high + 2;
            
    for (int i = 0; i < p; ++i) {
        if ( (rand()%100/100.0) >= 0.50 )
            point[i] = 0.5 - (rand() % 100000)/100000.0;
        else
            point[i] = -0.5 + (rand() % 100000)/100000.0;
        while (point[i] < (*funPtr).low || point[i] > (*funPtr).high) {
            if ( (rand()%100/100.0) >= 0.50 )
                point[i] = 0.5 - (rand() % 100000)/100000.0;
            else
                point[i] = -0.5 + (rand() % 100000)/100000.0;
        } // while
    }     // for
    fitness = getFitness();
}
*/

void Individual::generate() {            // need modify here
    // get integer values for range
    int high = (int)((*funPtr).high);
    if (high < (*funPtr).high)
        high = high + 2;

    for (int i = 0; i < p; ++i) {
        if ( (rand()%100/100.0) >= 0.50 )
            point[i] = rand() % high - (rand() % 100000)/100000.0;
        else
            point[i] = -rand() % high + (rand() % 100000)/100000.0;
        while (point[i] < (*funPtr).low || point[i] > (*funPtr).high) {
            if ( (rand()%100/100.0) >= 0.50 )
                point[i] = rand() % high - (rand() % 100000)/100000.0;
            else
                point[i] = -rand() % high + (rand() % 100000)/100000.0;
        } // while
    }     // for
    fitness = getFitness();
}

void Individual::print() {
    for (int i = 0; i < p; ++i) {
	printf("%5.5f ", point[i]);
	if (i % 5 == 4)
	    printf(" ");
	if (i % 10 == 9)
	    printf("\n");
    }
    pf("", fitness);
    printf("\n");
}

float Individual::getFitness() {
    float y = 0;
    
    if ((*funPtr).sepaFlag) 
    {
        for (int i = 0; i < p; ++i) 
        {
            y += funPtr->getFitness(point[i]);
        }
    }
    else    
        y = funPtr->getFitness(point, p);
    fitness = y;
    return y;
}

void Individual::mutate(float mutRate, int cnt) {
    float delta, temp, random;
    if (cnt % 100 == 0)  
        genNum *= 10.0;
        
    for (int i = 0; i < p; ++i) {
        if (rand()%1000/1000 < mutRate) 
        {
            delta = (float)(((*funPtr).high - (*funPtr).low) / genNum );
            random = rand() % 1000 / 1000.0;
            //if ( (rand()%100/100.0) < 0.5)   // pos
            if ( random < 0.5)   // pos
                temp = point[i] + delta;
            else                  // neg
                temp = point[i] - delta;
            while (temp < (*funPtr).low || temp > (*funPtr).high) {
                delta = (float)((*funPtr).high - (*funPtr).low) / genNum;
                random = rand() % 1000 / 1000.0;
                //if ( (rand()%100/100.0) < 0.5)   // pos
                if ( random < 0.5)   // pos
                    temp = point[i] + delta;
                else                  // neg
                    temp = point[i] - delta;
            } // while
        }
        point[i] = temp;
    }
    fitness = getFitness();
}
