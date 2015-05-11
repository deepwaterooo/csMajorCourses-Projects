#include <cstdio> 
#include <math.h> 
#include <vector> 
#include <stdlib.h> 
#include <time.h>
#include <algorithm>
using namespace std; 

typedef vector<double> vf; 
typedef vector< vector<double> > vvf; 
typedef double(*fptr)(vf f); 
const int INT_MAX = 1 << 31 -1; 
const double csch = 418.9829 * 30; 
const double INF = (5.12*5.12*30 > csch+30*512.03 ? 5.12*5.12*30 : csch+30*512.03); 
const double schl = -512.0300; 
const double schh = 511.9700; 
const double sphl = -5.12; 
const double sphh = 5.12; 
const double initialStepSizes[] = { 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0,
				   5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0,
				   5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0
};

struct myclass {
    bool operator() (int i, int j) {return (i < j);}
} myobject;



double bestScore = INF; 
vf vbest, vcurri, vcurrj; 
double getsph(vf x); 
double getsch(vf x); 
void printVector(vf x); 
double getprob(double x, 
	      double y, int T, double z); 
vf hcsph(vf point); 
vf hcsch(vf point); 
vf sasph(vf point); 
vf sasch(vf point); 
double genRan(); 
double getsphSeparate(double x);
double getschSeparate(double x);
double hillClimbingSch(double point);

int main() {
    double x1[] = {-4.5, 1.3, 0.45, 2.055, 2.012,
		  -3.5, 2.3, 2.45, -3.055, 5.012,
		  -2.5, 3.3, 0.45, -1.055, -5.012,
		  -1.5, 4.3, 0.45, 5.055, 4.012,
		  5.05, -5.0, 4.45, 1.055, 3.012,
		  -4.5, -5.12, -5.05, 3.055, -1.012
    };
    double x2[] = {-412.02, 435, 47, 511.0, 176,
		  -112.0, 235, 447, 509.0, 476,
		  -512.0, 135, 347, 209.0, 511.96,
		  -312.0, 335, 147, 309.0, 376,
		  -412.0, 435, 247, 509.0, 276,
		  311.0, 135, 397, 409.0, 476
    };
    vector<double> vx1 (x1, x1+30);
    vector<double> vx2 (x2, x2+30);
    /*
    printf("\n\nsph: %5.8f\n\n", getsph(vx1));
    vf vfsph = hcsph(vx1);
    printVector(vfsph);
    printf("Minimum Value hcsph %5.8f\n\n", getsph(vfsph));

    vf vfsphc = sasph(vx2); 
    printVector(vfsphc);
    printf("Minimum Value sasph: %5.8f\n\n", getsph(vfsphc));

    
    printf("\n\n\nsch Original: %4.8f\n\n", getsch(vx2));
    vf vfsch = hcsch(vx2);
    printVector(vfsch);
    printf("Minimum Value hcsch: %5.8f\n\n", getsch(vfsch));

    vf vfschc = sasch(vx2);
    printVector(vfschc);
    printf("Minimum Value sasch: %5.8f\n\n", getsch(vfschc));
    */

    double point = hillClimbingSch(-420.96);
    printf("point: %5.8f\n", point);

    return 0;
}

double hillClimbingSch(double point) {
    double delta, temp, currFit, newFit;
    double diff = 100.0;
    currFit = getschSeparate(point);
    
    //srand( (unsigned)time( NULL ) );
    for (int i = 0; i < 1000000; ++i) {
	delta = rand() % 1000/1000.0;
	printf("delta: %5.3f\n", delta);
	
	if (genRan() < 0.5)
	    temp = point + delta;
	else
	    temp = point - delta;
	while (temp < schl || temp > schh) {
	    delta = (rand() % 100000) / 100000.0;
	    if (genRan() < 0.5)
		temp = point + delta;
	    else
		temp = point - delta;
	}
	newFit = getschSeparate(temp);
	if ( currFit > newFit ) {
	    currFit = newFit;
	    point = temp;
	} 
    }
    printf("fitness: %5.8f\n", getschSeparate(point));
    return point;
}

vf sasph(vf point) {
    vf currentPoint = point; // the zero-magnitude vector is common
    double before = getsph(currentPoint); // previous fitness
    double temp, delta, temp2;                          // current fitness
    double prob, pp;

    int midx[15] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    vf newPoint;     // records best point
    int j;
    double accelerate = 1.2;
    double r = 0.99995;

    for (int T = 100; T > 0;) {
	before = getsph(currentPoint);
	j = 0;
	// decide which ones to mutate
	for (int i = 0; i < 15; ++i) 
	    midx[i] = rand() % 30;
	std::sort(midx, midx+15);

	for (int i = 0; i < 30; ++i) {
	    if (i != midx[j])    // not mutated
		newPoint.push_back(currentPoint[i]);
	    else {   // need to mutate this point
		delta = ( rand() % 10000 ) / 10000.0;
		while (currentPoint[i]-delta < sphl || currentPoint[i]+delta > sphh) {
		    delta = ( rand() % 10000 ) / 10000.0;
		    if (genRan() < 0.5)   // pos
			temp2 = currentPoint[i] + delta;
		    else                  // neg
			temp2 = currentPoint[i] - delta;
		} // while
		++j;
		newPoint.push_back(temp2);
	    } // else
	} // for

	temp = getsph(newPoint);
	if(temp < before)  {
	    currentPoint = newPoint;
	    //before = temp;
	} else {
	    prob = getprob(before, temp, T, accelerate);
	    pp = genRan();
	    if (prob > pp) {   // accept change
		currentPoint = newPoint;
		//before = temp;
	    }
	    for (int i = 0; i < 15; ++i) {
		newPoint.pop_back();
		newPoint.pop_back();
	    } // for
	} // else
	T = r*T;
    }
    return currentPoint;
} 

vf sasch(vf point) {
    vf currentPoint = point; // the zero-magnitude vector is common

    double before = getsch(currentPoint); // previous fitness
    double temp, delta, temp2;                          // current fitness
    double prob, pp;

    int midx[15] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    double best = INF;
    vf bestPoint, newPoint;     // records best point, & mutated point
    int j;
    double accelerate = 2.5;
    double r = 0.99995;

    bestPoint = currentPoint;
    for (int T = 100; T > 0;) {
	before = getsch(currentPoint);
	j = 0;
	// decide which ones to mutate
	for (int i = 0; i < 15; ++i) 
	    midx[i] = rand() % 30;
	std::sort(midx, midx+15);

	for (int i = 0; i < 30; ++i) {
	    if (i != midx[j])    // not mutated
		newPoint.push_back(currentPoint[i]);
	    else {   // need to mutate this point
		delta = ( rand() % 10000 ) / 10000.0;
		while (currentPoint[i]-delta < schl || currentPoint[i]+delta > schh) {
		    delta = ( rand() % 10000 ) / 10000.0;
		    if (genRan() < 0.5)   // pos
			temp2 = currentPoint[i] + delta;
		    else                  // neg
			temp2 = currentPoint[i] - delta;
		} // while
		++j;
		newPoint.push_back(temp2);
	    } // else
	} // for

	temp = getsch(newPoint);
	if(temp < before) {
	    if (temp < best) {
		for (int i = 0; i < 30; ++i)
		    bestPoint.pop_back();
		bestPoint = newPoint;
		best = temp;
	    }
	    currentPoint = newPoint;
	} else {
	    prob = getprob(before, temp, T, accelerate);
	    pp = genRan();
	    if (prob > pp)   // accept change
		currentPoint = newPoint;
	    for (int i = 0; i < 15; ++i) {
		newPoint.pop_back();
		newPoint.pop_back();
	    } // for
	} // else
	T = r*T;
    }
    return bestPoint;
} 

vf hcsch(vf point) {
    vf currentPoint = point; // the zero-magnitude vector is common
    double before = getsch(currentPoint); // previous fitness
    double temp, delta, temp2;                          // current fitness
    int midx[15] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    vf newPoint;   
    int j;

    for (int x = 0; x < 10000; ++x) {
	j = 0;
	for (int i = 0; i < 15; ++i) 
	    midx[i] = rand() % 30;
	std::sort(midx, midx+15);

	double delta = ( rand() % 1000 ) / 1000.0;
	for (int i = 0; i < 30; ++i) {
	    if (i != midx[j])    // not mutated
		newPoint.push_back(currentPoint[i]);
	    else {   // need to mutate this point
		delta = ( rand() % 10000 ) / 10000.0;
		while (currentPoint[i] - delta < schl || currentPoint[i]+delta > schh) {
		    delta = ( rand() % 10000 ) / 10000.0;
		    if (genRan() < 0.5)   // pos
			temp2 = currentPoint[i] + delta;
		    else                  // neg
			temp2 = currentPoint[i] - delta;
		} // while
		++j;
		newPoint.push_back(temp2);
	    } // else
	} // for

	temp = getsch(newPoint);
	if(temp < before) {
	    currentPoint = newPoint;
	    before = temp;
	} else {
	    for (int i = 0; i < 15; ++i) {
		//midx.pop_back();
		newPoint.pop_back();
		newPoint.pop_back();
	    }
	}
    }
    return currentPoint;
} 

vf hcsph(vf point) {
    vf currentPoint = point; // the zero-magnitude vector is common
    double before = getsph(currentPoint); // previous fitness
    double temp, delta, temp2;                          // current fitness
    int midx[15] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    vf newPoint;     // records best point
    int j;

    for (int x = 0; x < 1000000; ++x) {
	j = 0;
	for (int i = 0; i < 15; ++i)
	    midx[i] = rand() % 30;
	std::sort(midx, midx+15);

	double delta = ( rand() % 100000 ) / 100000.0;

	for (int i = 0; i < 30; ++i) {
	    if (i != midx[j])    // not mutated
		newPoint.push_back(currentPoint[i]);
	    else {   // need to mutate this point
		delta = ( rand() % 10000 ) / 10000.0;
		while (currentPoint[i] - delta < sphl || currentPoint[i]+delta > sphh) {
		    delta = ( rand() % 10000 ) / 10000.0;

		    if (genRan() < 0.5)   // pos
			temp2 = currentPoint[i] + delta;
		    else                  // neg
			temp2 = currentPoint[i] - delta;
		} // while
		++j;
		newPoint.push_back(temp2);
	    } // else
	} // for

	temp = getsph(newPoint);
	if(temp < before) {
	    before = temp;
	    currentPoint = newPoint;
	} else {
	    for (int i = 0; i < 15; ++i) {
		newPoint.pop_back();
		newPoint.pop_back();
	    }
	}
    }
    return currentPoint;
} 


void printVector(vf x) {
    for (int i = 0; i < 30; ++i) {
	printf("%5.4f ", x[i]);
	if (i % 5 == 4) printf(" ");
	if (i % 10 == 9) printf("\n");
    }
    printf("\n");
}

double genRan() {
    double d;
    d = (double)(rand()%10000)/10000.0;
    return d;
}

double getsph(vf x){
    double y = 0;
    for (int i = 0; i < 30; ++i) {
	y += pow(x[i], 2);
    }
    return y;
}

double getsch(vf x) {
    double y = 0;
    for (int i = 0; i < 30; ++i) {
	if (x[i] < 0.000001) {
	    y += x[i]*sin(-x[i]);
	} else
	    y += x[i]*sin(x[i]);
    }
    y += csch;
    return y;
}

double getsphSeparate(double x){
    return pow(x, 2);
}

double getschSeparate(double x) {
    double y = 418.9829;
    if (x < 0.000000000001) {
	    y += x*sin(-x);
	} else
	    y += x*sin(x);
    return y;
}

double getprob(double x, double y, int T, double z) {
    double diff = -z*(x - y) / T;
    return exp(diff);
}

