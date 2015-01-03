// http://read.pudn.com/downloads112/sourcecode/app/469009/ANN-2-main/BackProp.cpp__.htm

#include "BackProp.h"
#include <ctime>
#include <cstdlib>

using namespace std;

//	initializes and allocates memory on heap
CBackProp::CBackProp(int nl,int *sz,float b,float a):beta(b),alpha(a)
{
  //	set no of layers and their sizes
  numl=nl;
  lsize=new int[numl];
  int i;
  for(i=0;i<numl;i++){
    lsize[i]=sz[i];
  }

  //	allocate memory for output of each neuron
  out = new float*[numl];
  for( i=0;i<numl;i++){
    out[i]=new float[lsize[i]];
  }

  //	allocate memory for delta
  delta = new float*[numl];
  for(i=1;i<numl;i++){
    delta[i]=new float[lsize[i]];
  }

  //	allocate memory for weights
  weight = new float**[numl];
  for(i=1;i<numl;i++){
    weight[i]=new float*[lsize[i]];
  }
  for(i=1;i<numl;i++){
    for(int j=0;j<lsize[i];j++){
      weight[i][j]=new float[lsize[i-1]+1];
    }
  }

  //	allocate memory for previous weights
  prevDwt = new float**[numl];
  for(i=1;i<numl;i++){
    prevDwt[i]=new float*[lsize[i]];

  }
  for(i=1;i<numl;i++){
    for(int j=0;j<lsize[i];j++){
      prevDwt[i][j]=new float[lsize[i-1]+1];
    }
  }

  //	seed and assign random weights
  srand((unsigned)(time(NULL)));
  for(i=1;i<numl;i++)
    for(int j=0;j<lsize[i];j++)
      for(int k=0;k<lsize[i-1]+1;k++)
	weight[i][j][k]=(float)(rand())/(RAND_MAX/2) - 1;//32767
    
  //	initialize previous weights to 0 for first iteration
  for(i=1;i<numl;i++)
    for(int j=0;j<lsize[i];j++)
      for(int k=0;k<lsize[i-1]+1;k++)
	prevDwt[i][j][k]=(float)0.0;
}

// adjust initial weight
float*** CBackProp::AdjIniWeiB()
{
  for(int i = 1; i < numl; i++){
    for(int j = 0; j < lsize[i]; j++){
      weight[i][j][0]= 0.01;//xPosition
      weight[i][j][1]=0.3;  //height
      weight[i][j][2]=0.05; // xvelocity
      weight[i][j][3]=-0.4; //yvelocity
      weight[i][j][4]=0.03; // wind 
      weight[i][j][5]=0.6; //fuel
      weight[i][j][6]= 0.5; //bias
    }
  }
  return weight;
}

float*** CBackProp::AdjIniWeiT()
{
  for(int i = 1; i < numl; i++){
    for(int j = 0; j < lsize[i]; j++){
      weight[i][j][0]= 0.4;//xPosition
      weight[i][j][1]=0.3;  //height
      weight[i][j][2]=-0.6; // xvelocity
      weight[i][j][3]=0.3; //yvelocity
      weight[i][j][4]=-0.8; // wind 
      weight[i][j][5]=0.6; //fuel
      weight[i][j][6]= 0.5; //bias
    }
  }
  return weight;
}

// sigmoid function
float CBackProp::sigmoid(float in)
{
  return (float)(1/(1+exp(-in)));
}

// mean square error
float CBackProp::mse(float *tgt) const
{
  float mse=0;
  for(int i=0;i<lsize[numl-1];i++){
    mse+=(tgt[i]-out[numl-1][i])*(tgt[i]-out[numl-1][i]);
  }
  return mse/2;
}


// returns i'th output of the net
float CBackProp::Out(int i) const
{
  return out[numl-1][i];
}

// feed forward one set of input
void CBackProp::ffwd(float *in)
{
  float sum;
  int i;
  //	assign content to input layer
  for(i=0;i<lsize[0];i++)
    out[0][i]=in[i];  // output_from_neuron(i,j) Jth neuron in Ith Layer

  //	assign output(activation) value 
  //	to each neuron usng sigmoid func
  for(i=1;i<numl;i++){				// For each layer
    for(int j=0;j<lsize[i];j++){		// For each neuron in current layer
      sum=0.0;
      for(int k=0;k<lsize[i-1];k++){		// For input from each neuron in preceeding layer
	sum+= out[i-1][k]*weight[i][j][k];	// Apply weight to inputs and add to sum
      }
      sum+=weight[i][j][lsize[i-1]];     // Apply bias
      out[i][j]=sigmoid(sum);				// Apply sigmoid function
    }
  }
}

// backpropogate errors from output layer uptill the first hidden layer
void CBackProp::bpgt(float *in,float *tgt)
{
  float sum;

  //	update output values for each neuron
  ffwd(in);

  //	find delta for output layer
  int i;
  for(i=0;i<lsize[numl-1];i++){
    delta[numl-1][i]=out[numl-1][i]*(1-out[numl-1][i])*(tgt[i]-out[numl-1][i]);
  }

  //	find delta for hidden layers	
  for(i=numl-2;i>0;i--){
    for(int j=0;j<lsize[i];j++){
      sum=0.0;
      for(int k=0;k<lsize[i+1];k++){
	sum+=delta[i+1][k]*weight[i+1][k][j];
      }
      delta[i][j]=out[i][j]*(1-out[i][j])*sum;
    }
  }

  //	apply momentum ( does nothing if alpha=0 )
  for(i=1;i<numl;i++){
    for(int j=0;j<lsize[i];j++){
      for(int k=0;k<lsize[i-1];k++){
	weight[i][j][k]+=alpha*prevDwt[i][j][k];
      }
      weight[i][j][lsize[i-1]]+=alpha*prevDwt[i][j][lsize[i-1]];
    }
  }

  //	adjust weights usng steepest descent	
  for(i=1;i<numl;i++){
    for(int j=0;j<lsize[i];j++){
      for(int k=0;k<lsize[i-1];k++){
	prevDwt[i][j][k]=beta*delta[i][j]*out[i-1][k];
	weight[i][j][k]+=prevDwt[i][j][k];
      }
      prevDwt[i][j][lsize[i-1]]=beta*delta[i][j];
      weight[i][j][lsize[i-1]]+=prevDwt[i][j][lsize[i-1]];
    }
  }
}

CBackProp::~CBackProp()
{
  //	free out
  int i;
  for(i=0;i<numl;i++)
    delete[] out[i];
  delete[] out;

  //	free delta
  for(i=1;i<numl;i++)
    delete[] delta[i];
  delete[] delta;

  //	free weight
  for(i=1;i<numl;i++)
    for(int j=0;j<lsize[i];j++)
      delete[] weight[i][j];
  for(i=1;i<numl;i++)
    delete[] weight[i];
  delete[] weight;

  //	free prevDwt
  for(i=1;i<numl;i++)
    for(int j=0;j<lsize[i];j++)
      delete[] prevDwt[i][j];
  for(i=1;i<numl;i++)
    delete[] prevDwt[i];
  delete[] prevDwt;

  //	free layer info
  delete[] lsize;
}
