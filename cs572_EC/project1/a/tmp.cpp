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
const float EPISINON = 0.000000001;
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

float getsch(vf x) {
    float y = 0;
    for (int i = 0; i < 30; ++i) {
	printf("I got here\n" );

	if (x[i] <= -EPISINON)
	    y += x[i]*sin(-x[i]);
	else 
	    y += x[i]*sin(x[i]);
    }
    //y += csch;
    return y;
}

vf sasch(vf point) {
    vf currentPoint;
    bestScore = INF;
    int factor = 100;

    float curr;
    float temp;
    float prob, pp;
    float accelerate = 1.5;


    float before = getsch(currentPoint);
    printf("before getsch: %5.5f\n", before);

    currentPoint = point;

    for (int t = 100; t > 0; --t) {
	int xi = rand() % 30;
	float delta = rand() % factor;
	printf("delta: %5.4f\n", delta);
	currentPoint[xi] = currentPoint[xi] + delta;
	temp = getsch(currentPoint);

	if (temp < bestScore)
	    bestScore = temp;
	if (temp > before) {
	    //prob = getprob(before, temp, t, accelerate);
	    //pp = genRan();  
	    /*	    if (prob < pp)  // reject change
		currentPoint[xi] = currentPoint[xi] - delta;  */
	}
	printf("current vector: \n");
	//printVector(currentPoint);
	printf("\n");
    }
    return currentPoint;
}

int main() {
    float x2[] = {-420.9687, -420.9687, -420.9687, -420.9687, -420.9687, 
		  -420.9687, -420.9687, -420.9687, -420.9687, -420.9687, 
		  -420.9687, -420.9687, -420.9687, -420.9687, -420.9687, 
		  -420.9687, -420.9687, -420.9687, -420.9687, -420.9687, 
		  -420.9687, -420.9687, -420.9687, -420.9687, -420.9687, 
		  -420.9687, -420.9687, -420.9687, -420.9687, -420.9687 
    };

    vf vx2;
    vector<float>::iterator it;
    for (int i = 0; i < 30; ++i) 
	vx2.push_back(x2[i]);

    //printf("sch Original: %4.8f\n", getsch(vx2));

    vf vfschc = sasch(vx2);
    //printVector(vfschc);
    printf("Minimum Value: %5.8f\n\n", bestScore);

    return 0;
}

