#ifndef FITNESS_H
#define FITNESS_H

#include <iostream>
#include <math.h>
#include <cstdio>
#include <cstring>
#include "fitness.h"

using namespace std;

const float INF = (float)((1<<30)-1);

const float sphl = -5.12; 
const float sphh = 5.12; 

const float rosl = -2.048;
const float rosh = 2.048;

const float rasl = -5.12;
const float rash = 5.12;
const float PI = 3.1415926;

const float schl = -512.0300; 
const float schh = 511.9700; 

const float ackl = -30.0;
const float ackh = 30.0;
const float E = 2.71828;

const float gril = -600.0;
const float grih = 600.0;

void pf(string s, double x);

void swap(int& a, int& b);

float getRosFitness(float* x, int p) ;

float getAckFitness(float* x, int p) ;

float getGriFitness(float* x, int p) ;

float getSphFitness(float x) ;

float getRasFitness(float x);

float getSchFitness(float x);
   
#endif
