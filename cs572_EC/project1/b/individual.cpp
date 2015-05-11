// individual.cpp

#include <cstdio>
#include <stdlib.h>
#include <math.h>
#include "individual.h"
#include "pf.h"

using namespace std;

Individual::Individual(): fitness(INF) {
    point = new float[p];
}

Individual::Individual(const Individual &orig): fitness(orig.fitness)
{ }

Individual& Individual::operator=(const Individual &rhs) {
  /*
  Individual* pOrig = this;
    point = new (Individual(*rhs)).point;
    delete [] pOrig;

    Individual temp(rhs);
    std::swap(temp);

    return *this;
      */
}

Individual::~Individual() {
    delete [] point;
}

void Individual::generate() {
    for (int i = 0; i < p; ++i) {
	if ( (rand()%100/100.0) >= 0.50 )
	    point[i] = rand() % 7 - (rand() % 100000)/100000.0;
	else
	    point[i] = -rand() % 7 + (rand() % 100000)/100000.0;
	while (point[i] < sphl || point[i] > sphh) {
	    if ( (rand()%100/100.0) >= 0.50 )
		point[i] = rand() % 7 - (rand() % 100000)/100000.0;
	    else
		point[i] = -rand() % 7 + (rand() % 100000)/100000.0;
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
    printf("\n");
}

float Individual::getFitness() {
    float y = 0;
    for (int i = 0; i < p; ++i) {
	y += pow(point[i], 2);		
    }
    return y;
}
/*
void Individual::mutate() {
    double* y = new double[p];
    float delta, temp;
    
    for (int i = 0; i < p; ++i) {
	delta = ( rand() % 1000 ) / 1000.0;
	if ( (rand()%100/100.0) < 0.5)   // pos
	    temp = point[i] + delta;  // segmentation fault
	else                  // neg
	    temp = point[i] - delta;
	
	while (temp < sphl || temp > sphh) {
	    delta = ( rand() % 1000 ) / 1000.0;
	    if ( (rand()%100/100.0) < 0.5)   // pos
		temp = point[i] + delta;
	    else                  // neg
		temp = point[i] - delta;
	} // while
	y[i] = temp;
    }

    for (int i = 0; i < p; ++i) 
	point[i] = y[i];
    
    delete [] y;
}
*/

void Individual::mutate() {
    float delta, temp;
    //printf("fitness before: %5.6f\n", fitness);
    for (int i = 0; i < p; ++i) {

	delta = ( rand() % 100000 ) / 100000.00000;
	if ( (rand()%100/100.0) < 0.5)   // pos
	    temp = point[i] + delta;
	else                  // neg
	    temp = point[i] - delta;
	while (temp < sphl || temp > sphh) {
	    delta = ( rand() % 100000 ) / 100000.00000;
	    if ( (rand()%100/100.0) < 0.5)   // pos
		temp = point[i] + delta;
	    else                  // neg
		temp = point[i] - delta;
	} // while
	point[i] = temp;
    }
    fitness = getFitness();
    //printf("fitness after: %5.6f\n", fitness);
}

