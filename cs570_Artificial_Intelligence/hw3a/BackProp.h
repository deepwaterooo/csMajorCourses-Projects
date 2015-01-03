// BackProp.h

#ifndef backprop_h
#define backprop_h

#include<cassert>
#include<iostream>
#include<cstdio>
#include<cmath>
using namespace std;

class CBackProp{
	float **out;     // output of each neuron
	float **delta;   // data error value for each neuron
	float ***weight; // vector of weights for each neuron
	int numl;        // no of layers in net including input layer#
	int *lsize;      // vector of numl elements for size of each layer
	float beta;      // learning rate
	float alpha;     // momentum parameter
	float ***prevDwt;// storage for weight-change made in previous epoch
	float sigmoid(float in);   //	squashing function
public:
	CBackProp(int nl,int *sz,float b,float a);  //	initializes and allocates memory
	~CBackProp(); 
	float mse(float *tgt) const;	            //	returns mean square error of the net
	float Out(int i) const;                     //	returns i'th output of the net
	void ffwd(float *in);                       //	feed forwards activations for one set of inputs
	void bpgt(float *in,float *tgt);            //	backpropogates error for one set of input
	float*** AdjIniWeiB();    // try to adjust the initial weight
        float*** AdjIniWeiT();    // try to adjust the initial weight
};

#endif
