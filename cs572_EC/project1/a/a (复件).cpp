#include <cstdio>
#include <math.h>
#include <vector>
#include <stdlib.h>
#include <time.h>
using namespace std;

typedef vector<float> vf;
typedef vector< vector<float> > vvf;
typedef float(*fptr)(vf f);

const int INT_MAX = 1 << 31 -1;
const float csch = 418.9829 * 30;
const float INF = (5.12*5.12*30 > csch+30*512.03 ? 5.12*5.12*30 : csch+30*512.03);
const float schl = -512.0300;
const float schh = 511.9700;
const float sphl = -5.12;
const float sphh = 5.12;

const float initialStepSizes[] = { 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 
				   5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 
				   5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0
};
float bestScore = INF;
vf vbest, vcurri, vcurrj;

vf hcsph(vf point);
vf hcsch(vf point);
float getsph(vf x);
float getsch(vf x);
void printVector(vf x);
float getprob(float x, float y, int T, float z);
vf sasch(vf point);
vf sasph(vf point);
float genRan();

int main() {
    printf("csch: %4.4f\n", csch);
    printf("INF: %15.4f\n", INF);
    /*
    float x1[] = {-4.5, 1.3, 0.45, 2.055, 2.012,
		  -3.5, 2.3, 2.45, -3.055, 5.012,
		  -2.5, 3.3, 0.45, -1.055, -5.012,
		  -1.5, 4.3, 0.45, 5.055, 4.012,
		  5.05, -5.0, 4.45, 1.055, 3.012,
		  -4.5, -5.12, -5.05, 3.055, -1.012
    };
    */
    float x1[] = {0.001, 0.001, 0.001, 0.001, 0.0010,
		  0.001, 0.001, 0.001, 0.001, 0.0010,
		  0.001, 0.001, 0.001, 0.001, 0.0010,
		  0.001, 0.001, 0.001, 0.001, 0.0010,
		  0.001, 0.001, 0.001, 0.001, 0.0010,
		  0.001, 0.001, 0.001, 0.001, 0.0010
    };
    /*
    float x2[] = {-420.9687, -420.9687, -420.9687, -420.9687, -420.9687, 
		  -420.9687, -420.9687, -420.9687, -420.9687, -420.9687, 
		  -420.9687, -420.9687, -420.9687, -420.9687, -420.9687, 
		  -420.9687, -420.9687, -420.9687, -420.9687, -420.9687, 
		  -420.9687, -420.9687, -420.9687, -420.9687, -420.9687, 
		  -420.9687, -420.9687, -420.9687, -420.9687, -420.9687 
    };
    */
    float x2[] = {-412.02, 435, 47, 511.0, 176,
		  -112.0, 235, 447, 509.0, 476,
		  -512.0, 135, 347, 209.0, 511.96,
		  -312.0, 335, 147, 309.0, 376,
		  -412.0, 435, 247, 509.0, 276,
		  311.0, 135, 397, 409.0, 476
    };

    vf vx1, vx2;
    vector<float>::iterator it;
    for (int i = 0; i < 30; ++i) {
	vx1.push_back(x1[i]);
	vx2.push_back(x2[i]);
    }
    /*
    printf("sph: %5.8f\n", getsph(vx1));
    vf vfsph = hcsph(vx1);
    printVector(vfsph);
    printf("Minimum Value: %5.8f\n\n", bestScore);
    */
    printf("sch Original: %4.8f\n", getsch(vx2));
    //vf vfsch = hcsch(vx2);
    //printVector(vfsch);
    //printf("Minimum Value: %5.8f\n\n", bestScore);
    /*
    printf("print vector main: \n" );
    printVector(vx2);
    */
    vf vfschc = sasch(vx2);
    printVector(vfschc);
    printf("Minimum Value: %5.8f\n\n", bestScore);
    printf("sin(420.9687): %5.4f\n", sin(420.9687));
    printf("min: %5.8f\n", csch-0.0047*420.9687*30);
    return 0;
}

float genRan() {
    float d; 
    d = (float)(rand()%10000)/10000;
    return d;
}

vf sasch(vf point) {
    vf currentPoint;
    bestScore = INF;
    int factor = 10;

    float temp, delta;
    float prob, pp;
    float accelerate = 51.5000005;
    float r = 0.85;
    bool neg = false;

    currentPoint = point;
    float before = getsch(currentPoint);

    for (float t = 100; t > 0.0000001;) {
	printf("t: %5.8f\n", t);
	int xi = rand() % 30;
	delta = rand() % factor;

	if (genRan() < 0.500000) {
	    neg = false;
	    currentPoint[xi] = currentPoint[xi] + delta;
	} else {
	    neg = true;
	    currentPoint[xi] = currentPoint[xi] - delta;
	}

	while (currentPoint[xi] < schl || currentPoint[xi] > schh) {
	    delta = rand() % factor % factor; 

	    if (genRan() < 0.500000) {
		neg = false;
		currentPoint[xi] = currentPoint[xi] + delta;
	    } else {
		neg = true;
		currentPoint[xi] = currentPoint[xi] - delta;
	    }
	}
	temp = getsch(currentPoint);

	if (temp < bestScore) {// accept currentPoint
	    bestScore = temp;
	    before = temp;
	} else {
	    prob = getprob(before, temp, t, accelerate);  // prob < (0, 1)
	    pp = genRan();
	    if (prob <= pp) {  // reject change
		if (neg) {
		    currentPoint[xi] = currentPoint[xi] + delta;
		    neg = false;
		} else
		    currentPoint[xi] = currentPoint[xi] - delta; 
	    } else // accept change
		before = temp;
	}
	temp = INF;
	t = r * t;
    }
    return currentPoint;
}

float getsch(vf x) {
    float y = 0;
    for (int i = 0; i < 30; ++i) {

	if (x[i] < 0) {
	    y += x[i]*sin(-x[i]);
	} else 
	    y += x[i]*sin(x[i]);
    }
    y += csch;
    return y;
}

float getprob(float x, float y, int T, float z) {
    float diff = -z*(x - y) / T;
    return exp(diff);
}

vf hcsch(vf point) {
    vf currentPoint = point;     // the zero-magnitude vector is common
    bestScore = INF;
    float stepSize[30] = { 1.1, 1.1, 1.1, 1.1, 1.1, 
			   1.1, 1.1, 1.1, 1.1, 1.1, 
			   1.1, 1.1, 1.1, 1.1, 1.1, 
			   1.1, 1.1, 1.1, 1.1, 1.1, 
			   1.1, 1.1, 1.1, 1.1, 1.1, 
			   1.1, 1.1, 1.1, 1.1, 1.1
    };
    float acceleration = 2.5;

    float temp;
    float before = getsch(currentPoint);
    int besti, bestj, curri, currj;
    float xi, si;
    float candidate[5];
    vf sschange, ssfive;
    vvf once;
    for (int i = 0; i < 30; ++i)
	sschange.push_back(0);

    for (int x = 0; x < 100; ++x) {
	candidate[0] = -acceleration;
	candidate[1] = -0.5 * acceleration;
	candidate[2] = 0;
	candidate[3] = .5 * acceleration;
	candidate[4] = acceleration;
	besti = -1;
	curri = -1;
	before = getsch(currentPoint);

	for (int i = 0; i < 30; ++i){     //for each element i in currentPoint do
	    bestj = -1;
	    for (int j = 0; j < 5; ++j) {  // try each of 5 candidate locations
		currj = -1;
		currentPoint[i] = currentPoint[i] + stepSize[i]*candidate[j];
		if (currentPoint[i] < schl || currentPoint[i] > schh) 
		    continue;
		temp = getsch(currentPoint);
		if(temp < bestScore) {
		    bestScore = temp;
		    vbest = currentPoint;
		    bestj = j;
		} 
		if (temp < before) {
		    before = temp;
		    currj = j;
		    vcurrj = currentPoint;
		}
		currentPoint[i] = currentPoint[i] - stepSize[i]*candidate[j];
	    } // j

	    if ( (currj != -1) && (candidate[currj] != 0) ) {
		currentPoint = vcurrj;
		sschange[i] = stepSize[i] * candidate[currj];   // record the ith change
		curri = i;
	    }
	    if (bestj != -1) {
		besti = i;
	    }
	    once.push_back(currentPoint);
	    currentPoint = point;
	} // i

	if (curri != -1) {
	    currentPoint = once[curri];
	    stepSize[curri] = sschange[curri];
	    printf("x: %d; i: %d; y: %5.4f\n", x, curri, bestScore);
	}
	for (int i = 0; i < 30; ++i) {
	    sschange[i] = 0;
	    once.pop_back();
	}
    }  // x

    return vbest;
} 

 
float getsph(vf x){
    float y = 0;
    for (int i = 0; i < 30; ++i) {
	y += pow(x[i], 2);
    }
    return y;
}

void printVector(vf x) {
    for (int i = 0; i < 30; ++i) {
	printf("%5.4f ", x[i]);
	if (i % 5 == 4) printf("  ");
	if (i % 10 == 9) printf("\n");
    }
    printf("\n\n");
}

// Continuous Space Hill Climbing Algorithm
// http://en.wikipedia.org/wiki/Hill_climbing
//vf hc(fptr f, vf point) {
vf hcsph(vf point) {
    vf currentPoint = point;     // the zero-magnitude vector is common
    /* 0.0029
    float stepSize[30] = { .5, 0.01, .5, .5, 0.05, 
			   0.25, 0.05, 0.05, .05, .15, 
			   .5, .5, .5, 0.15, -0.25,
			   .5, .5, .59, 0.05, .5, 
			   0.051, .5, .5, .5, .5, 
			   .5, .5, .5, 0.35, 0.005
    };
    float acceleration = 0.05;
*/
    /* 0.2810
    float stepSize[30] = { 3.5, 0.01, 3.5, 2.5, 0.5, 0.25, 0.85, 0.95, 1.5, 2.5, 
			   4.5, 6.5, 1.5, 0.15, -0.25, 1.5, 2.5, 4.5, 3.59, 0.59, 
			   0.51, 7.5, 6.5, 4.5, 3.5, 2.5, 7.5, 1.5, 0.35, 0.005
    };
    float acceleration = 0.031;
    */

    float stepSize[30] = { .0001, 0.0001, .0001, .0001, 0.0001, 
			   .0001, 0.0001, .0001, .0001, 0.0001, 
			   .0001, 0.0001, .0001, .0001, 0.0001, 
			   .0001, 0.0001, .0001, .0001, 0.0001, 
			   .0001, 0.0001, .0001, .0001, 0.0001, 
			   .0001, 0.0001, .0001, .0001, 0.0001
    };
    float acceleration = 0.001;

    float temp;
    float before = getsph(currentPoint);
    int besti, bestj, curri, currj;
    float xi, si;
    float candidate[5];
    vf sschange, ssfive;
    vvf once;
    for (int i = 0; i < 30; ++i)
	sschange.push_back(0);

    for (int x = 0; x < 100; ++x) {
	candidate[0] = -acceleration;
	candidate[1] = -0.05 * acceleration;
	candidate[2] = 0;
	candidate[3] = 0.05 * acceleration;
	candidate[4] = acceleration;
	besti = -1;
	curri = -1;
	before = getsph(currentPoint);

	for (int i = 0; i < 30; ++i){     //for each element i in currentPoint do
	    bestj = -1;
	    for (int j = 0; j < 5; ++j) {  // try each of 5 candidate locations
		currj = -1;
		currentPoint[i] = currentPoint[i] + stepSize[i]*candidate[j];
		if (currentPoint[i] < sphl || currentPoint[i] > sphh) 
		    continue;
		temp = getsph(currentPoint);
		if(temp < bestScore) {
		    bestScore = temp;
		    vbest = currentPoint;
		    bestj = j;
		} 
		if (temp < before) {
		    before = temp;
		    currj = j;
		    vcurrj = currentPoint;
		}
		currentPoint[i] = currentPoint[i] - stepSize[i]*candidate[j];
	    } // j

	    if ( (currj != -1) && (candidate[currj] != 0) ) {
		currentPoint = vcurrj;
		sschange[i] = stepSize[i] * candidate[currj];   // record the ith change
		curri = i;
	    }
	    if (bestj != -1) {
		besti = i;
	    }
	    once.push_back(currentPoint);
	    currentPoint = point;
	} // i

	if (curri != -1) {
	    currentPoint = once[curri];
	    stepSize[curri] = sschange[curri];
	    printf("x: %d; i: %d; y: %5.4f\n", x, curri, bestScore);
	}
	for (int i = 0; i < 30; ++i) {
	    sschange[i] = 0;
	    once.pop_back();
	}
    }  // x

    return vbest;
} 

/*
http://en.wikipedia.org/wiki/Hill_climbing

Continuous Space Hill Climbing Algorithm
   currentPoint = initialPoint;    // the zero-magnitude vector is common
   stepSize = initialStepSizes;    // a vector of all 1's is common
   acceleration = someAcceleration; // a value such as 1.2 is common
   candidate[0] = -acceleration;
   candidate[1] = -1 / acceleration;
   candidate[2] = 0;
   candidate[3] = 1 / acceleration;
   candidate[4] = acceleration;
   loop do
      before = EVAL(currentPoint);
      for each element i in currentPoint do
         best = -1;
         bestScore = -INF;
         for j from 0 to 4         // try each of 5 candidate locations
            currentPoint[i] = currentPoint[i] + stepSize[i] * candidate[j];
            temp = EVAL(currentPoint);
            currentPoint[i] = currentPoint[i] - stepSize[i] * candidate[j];
            if(temp > bestScore)
                 bestScore = temp;
                 best = j;
         if candidate[best] is not 0
            currentPoint[i] = currentPoint[i] + stepSize[i] * candidate[best];
            stepSize[i] = stepSize[i] * candidate[best]; // accelerate
      if (EVAL(currentPoint) - before) < epsilon 
         return currentPoint;
*/
