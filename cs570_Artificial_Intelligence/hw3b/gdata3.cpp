// CS570 Project 3a
// Heyan Huang          April 1, 2013

#include<iostream>
#include<cstdlib>
#include<cmath>
#include<cassert>
#include<cstdio>
#include "BackProp.h"

using namespace std; 

int test(int ht, int Yv, int MaxS, int xP, int MinX, int MaxX);
float lrand();
const int DATA_SIZE = 500000;
int fuel = 100; 

int main()
{
  float xPosition, height, Xvelocity, fuel,Yvelocity, wind;
  float ACCELERATION = 2.0;
  float burn, thrust;
  float** data = new float*[DATA_SIZE];

  for(int q=0; q<DATA_SIZE; q++)
    {
      data[q]=new float[8];  // 9 variables
    } 
  float temp[500][8];   // why
  int count=0, b = 1;
  long long totcnt = 0;
  
  //  for(float acce = 1.0; acce < 3.0; acce += 0.1)  // 20 values 
  //    {
  for(float v=0;v < 10.0; v += 0.04) // 100 values
    { 
      for(float w=-0.1;w < 0.1;w+= 0.004)  // 20 values
	{
	  b=1;
	  int n2 = 0;
	  while(b==1) 
	    {
	      wind = w;
	      Yvelocity = v;
	      xPosition = 0;
	      height = 100.0;  
	      Xvelocity = 0;
	      fuel = 100.0;
	      int a = 1, n1=0;
	      while (a==1)
		{
		  // burn
		  if(Yvelocity>4) burn = 2.0 + lrand();
		  else if(Yvelocity>0) burn = lrand();
		  else if (fuel==0) burn = 0;
		  else burn = lrand();
		  // thrust
		  if(wind>0 && xPosition>0) thrust= 0.2*lrand();
		  else if(wind<0 && xPosition<0) thrust=-0.2*lrand();
		  else if (fuel==0) thrust = 0;
		  else thrust=0.2*(lrand()-0.5);
		  // one observation
		  temp[n1][0]=xPosition; temp[n1][1]=height; temp[n1][2]=Xvelocity; temp[n1][3]=Yvelocity; 
		  temp[n1][4]=wind; temp[n1][5]=fuel;// temp[n1][6]=acce; 
		  temp[n1][6]=burn; temp[n1][7]=thrust;
		  n1++;
		  totcnt++;

		  Yvelocity+= ACCELERATION;  
		  if(fuel < burn)  burn = fuel;
		  fuel -= fabs(burn);  
		  Yvelocity-=burn;  
		  if(fuel < thrust) thrust = fuel;
		  fuel -= fabs(thrust);  
		  Xvelocity-=thrust;   
		  height -= (Yvelocity); 
		  xPosition += (Xvelocity + wind);
		  // int test(int ht, int Yv, int MaxS, int xP, int MinX, int MaxX);
		  if(test(height, Yvelocity, 4.0, xPosition, -0.2, 0.2)==2) a = 0;
		  else if(test(height, Yvelocity, 4.0, xPosition, -0.2, 0.2)==1)   // land successfully
		    { 
		      for(int i=0;i<n1;i++)
			{ 
			  for(int j=0;j<8;j++) { data[i+count][j] = temp[i][j]; }
			}
		      a = 0;
		      n2 = n2 + n1;
		      count = count + n1;
		      //		      if(n2 > 10) b=0;   // reset to initiate, get rid of this restriction
		      b = 0;
		    }
		  else wind = 0.2 * (lrand()-0.5);
		} // end of while
	    }
	}
    } 

  int numLayers = 3, lSz[3] = {6,4,2};
  //int numLayers = 4, lSz[4] = {6,6,6,2};
  double beta = 0.3, alpha = 0.1, Thresh =  0.000001;
  //double beta = 0.6, alpha = 0.4, Thresh =  0.0000001;
  cout << "The number of training data: "<< count << endl;
  
  // using different weight for two output variables
  CBackProp *bp = new CBackProp(numLayers, lSz, beta, alpha);   // build a neural network
  bp->AdjIniWeiB();
  CBackProp *bp1 = new CBackProp(numLayers, lSz, beta, alpha);   // build a neural network
  bp1->AdjIniWeiT();
  
  cout<< endl <<  "Training the network:" << endl;	
  long i;

  // BURN: using bp to train BURN
  cout << endl << endl << "trainging the BURN output: " << endl;
 
  float mse = 0; 
  for(int x = 0; x < 10; x++){
    for (i=0; i<count ; i++)
      {
	bp->bpgt(data[i], &data[i][6]);
	if ( i%(count/10) == 0 )
	  cout<<  endl <<  "MSE:  " << bp->mse(&data[i][6]) << "... Training..." << endl;
	if( bp->mse(&data[i][6]) < Thresh) {
	  cout << endl << "Network Trained. Threshold value achieved in " << i << " iterations." << endl;
	  cout << "MSE:  " << bp->mse(&data[i][6]) <<  endl <<  endl;
	  break;
	}
      }
    if ( i == count )
      cout << endl << i << " iterations completed..." << "MSE: " << bp->mse(&data[i-1][6]) << endl; 
  } 	

  // THRUST: using bp1 to train THRUST
  cout << endl << endl << "trainging the THRUST output: " << endl;
  for(int x = 0; x < 10; x++){
    for (i=0; i<count ; i++)
      {
	bp1->bpgt(data[i], &data[i][7]);
	if( bp1->mse(&data[i][7]) < Thresh) {
	  cout << endl << "Network Trained. Threshold value achieved in " << i << " iterations." << endl;
	  cout << "MSE:  " << bp->mse(&data[i][7]) <<  endl <<  endl;
	  break;
	}
	if ( i%(count/10) == 0 )
	  cout<<  endl <<  "MSE:  " << bp1->mse(&data[i][7]) << "... Training..." << endl;
      }
    if ( i == count )
      cout << endl << i << " iterations completed..."  << "MSE: " << bp->mse(&data[i-1][7]) << endl;  	
  }

  xPosition = 0;
  height = 100.0;  
  Xvelocity = 0;
  fuel = 100.0; int n0=0;
  float testData[210000][6];
  
  for(float v=0.0;v < 10.0; v+=0.04)   // these dataset has been used already, need to generate new ones
    { 
      for(float w=-0.1;w < 0.1;w+=0.004)
	{
	  n0++;
	  testData[n0][0]=xPosition; testData[n0][1]= height; testData[n0][2]=Xvelocity; testData[n0][3]=v; testData[n0][4]=w; testData[n0][5]=fuel;
	}
    }

  cout<< endl << endl << "Now using the trained network to make predctions on test data...." << endl << endl;
  float testData1[1][6];	
  float Ecount=0;
  int a = 0;
  long long totcnt2 = 0;
  //  int procnt; 
  
  for ( i = 0 ; i < n0 ; i++ )
    {
	xPosition=testData[i][0]; height=testData[i][1]; Xvelocity=testData[i][2]; 
	Yvelocity=testData[i][3]; wind=testData[n0][4]; fuel=testData[n0][5];  
	bp->ffwd(testData[a]);
	bp1->ffwd(testData[a]);
	burn = bp->Out(0); //cout << burn << endl;
	thrust = bp1->Out(1); //cout << thrust << endl;
	int p=1; 
	//	procnt = 1;
	while(p==1)
	  {
	    Yvelocity+=ACCELERATION;           // 
	    if(fuel < burn)  burn = fuel;
	    fuel -= fabs(burn);  
	    Yvelocity-=burn;  
	    if(fuel < thrust) thrust = fuel;
	    fuel -= fabs(thrust);  
	    Xvelocity-=thrust;   
	    height -= (Yvelocity); 
	    xPosition += (Xvelocity + wind);
	    totcnt2++;
	    //	    procnt++;

	    if(test(height, Yvelocity, 4.0, xPosition, -0.2, 0.2)==2) 
	      p = 0;  //Ecount++;}
	    else if(test(height, Yvelocity, 4.0, xPosition, -0.2, 0.2)==1)
	      { //cout << "the value of procnt is " << procnt << endl;
		//		Ecount = Ecount + procnt;  b = 0; // p=0;
		Ecount++; 
	      }
	    else {
	      wind = 0.2 * (lrand()-0.5);
	      testData1[1][0]=xPosition; testData1[1][1]= height; testData1[1][2]=Xvelocity; testData1[1][3]=Yvelocity; testData1[1][4]=wind; testData1[1][5]=fuel;
	      bp->ffwd(testData1[1]);
	      bp1->ffwd(testData1[1]);
	      burn = bp->Out(0);
	      thrust = bp1->Out(1);
	    }
	  } // end of while
    }

  cout << endl << "for generating training data: " << endl; 
  float SucLanRate = count / totcnt;
  cout << "the value of successfully landed count is " << count << endl;
  cout << "the value of total number of trials(updates) is " << totcnt << endl;
  cout << "The successfully landing rate is " << SucLanRate << endl << endl;

  cout << "for Testing the NN model: " << endl; 
  float SucLanRate2 = Ecount / totcnt2;
  cout << "the value of successfully landed test count is " << Ecount << endl;
  cout << "the value of total number of trials(updates) is " << totcnt2 << endl;
  cout << "The successfully landing rate is " << SucLanRate2 << endl << endl;

  cout << "the value of n0 is " << n0 << endl;
  float Success_rate = Ecount/n0;
  cout << "The success rate of the ANN is: "<< Ecount<<"/"<< n0 <<"="<< Success_rate <<endl;
  
  return 0;
}

int test(int ht, int Yv, int MaxS, int xP, int MinX, int MaxX)
{
  if(ht > 0)
    return 0;
  else if(Yv > MaxS || xP < MinX || xP > MaxX)
    return 2;
  else
    return 1;
}

float lrand()
{
  return (rand()/float(RAND_MAX));
}
