#include <iostream>
#include <math.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include "fitness.h"

using namespace std;

void pf(string s, double x) {
    const char * a = s.c_str();
    printf("%s: %5.5f\n", a, x);
}

void swap(int& a, int& b)  {
    int temp = a;
    a = b;
    b = temp;
}

float getRosFitness(float* x, int p) {
    float y = 0.0;
    for (int i = 0; i < p-2; ++i) 
        y += 100*pow((x[i+1]-pow(x[i], 2)), 2) + pow((x[i]-1), 2);
    return y;
}

float getAckFitness(float* x, int p)  {
    float y = 0.0, z = 0.0;
    for (int i = 0; i < p; ++i)  {
        y += pow(x[i], 2);
        z += cos(2*PI*x[i]);
    }
    y += 20 + E - 20*pow(E, -0.2*sqrt((float)(y/p))) - pow(E, (float)(z/p));
    return y;
}

float getGriFitness(float* x, int p)  {
    float y = 0.0, z = 1.0;
    for (int i = 0; i < p; ++i)  {
        y += pow(x[i], 2);
        z *= cos((float)(x[i]/sqrt(i+1)));
    }
    y += 1 + y/4000.0 - z;
    return y;
}

float getSphFitness(float x)  {
    return pow(x, 2);
}

float getRasFitness(float x) {
    float y = 10.0;
    y += pow(x, 2) - 10*cos(2*PI*x);
    return y;
}

float getSchFitness(float x) {
    float y = 418.9829;
    if (x - 0.0 < 0.000000001) 
	    y = y + x*sin(sqrt(-x));
    else
	    y += x*sin(sqrt(x));
    return y;
}
