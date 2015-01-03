/* CS570			Project 3a
   Sanqing Yuan		April 5, 2012
*/

#include <iostream>
#include <cstdlib>
#include <cmath>
#include <cassert>
#include <cstdio>
#include "BackProp.h"

using namespace std;

int test(int ht, int Yv, int MaxS, int xP, int MinX, int MaxX);
float lrand();

int main()
{
	
  float xPosition, height, Xvelocity, fuel,Yvelocity, wind;
  float ACCELERATION = 2.0;
  float burn, thrust;
  float** data = new float*[500000];
  for(int q=0;q<500000;q++)
    {
      data[q]=new float[8];
    }
  float temp[500][8];
  int count=0, b = 1;
  
  for(float v=0;v <=10.0; v+=0.1)
    { 
      for(float w=-0.1;w<=0.1;w+=0.01)
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
		  if(Yvelocity>4) burn = 2.0 + lrand();
		  else if(Yvelocity>0) burn = lrand();
		  else burn = lrand();
		  
		  if(wind>0 && xPosition>0) thrust= 0.2*lrand();
		  else if(wind<0 && xPosition<0) thrust=-0.2*lrand();
		  else thrust=0.2*(lrand()-0.5);
		  
		  temp[n1][0]=xPosition; temp[n1][1]=height; temp[n1][2]=Xvelocity; temp[n1][3]=Yvelocity; 
		  temp[n1][4]=wind; temp[n1][5]=fuel; temp[n1][6]=burn; temp[n1][7]=thrust;
		  n1++;
		  
		  Yvelocity+=ACCELERATION;  
		  if(fuel < burn)  burn = fuel;
		  fuel -= fabs(burn);  
		  Yvelocity-=burn;  
		  if(fuel < thrust) thrust = fuel;
		  fuel -= fabs(thrust);  
		  Xvelocity-=thrust;   
		  height -= (Yvelocity); 
		  xPosition += (Xvelocity + wind);
		  
		  if(test(height, Yvelocity, 4.0, xPosition, -0.2, 0.2)==2) a = 0;
		  else if(test(height, Yvelocity, 4.0, xPosition, -0.2, 0.2)==1)
		    { 
		      for(int i=0;i<n1;i++)
			{ 
			  for(int j=0;j<8;j++) {data[i+count][j] = temp[i][j]; }
			}
		      a = 0;
		      n2 = n2 + n1;
		      count = count + n1;
		      if(n2 > 10) b=0;
		    }
		  else wind = 0.2 * (lrand()-0.5);
		}
	    }
	}
    } 
  
  int numLayers = 3, lSz[4] = {6,2,2};
  double beta = 0.3, alpha = 0.1, Thresh =  0.00001;
  cout << "The number of training data: "<< count << endl;
  
  CBackProp *bp = new CBackProp(numLayers, lSz, beta, alpha);
  
  cout<< endl <<  "Now training the network...." << endl;	
  long i;
  for (i=0; i<count ; i++)
    {
      bp->bpgt(data[i], &data[i][6]);
      
      if( bp->mse(&data[i][6]) < Thresh) {
	cout << endl << "Network Trained. Threshold value achieved in " << i << " iterations." << endl;
	cout << "MSE:  " << bp->mse(&data[i][6]) 
	     <<  endl <<  endl;
	break;
      }
      if ( i%(count/10) == 0 )
	cout<<  endl <<  "MSE:  " << bp->mse(&data[i][6]) 
	    << "... Training..." << endl;
    }
  
  if ( i == count )
    cout << endl << i << " iterations completed..." 
	 << "MSE: " << bp->mse(&data[i-1][6]) << endl;  	
  
  for (i=0; i<count ; i++)
    {
      bp->bpgt(data[i], &data[i][7]);
      
      if( bp->mse(&data[i][7]) < Thresh) {
	cout << endl << "Network Trained. Threshold value achieved in " << i << " iterations." << endl;
	cout << "MSE:  " << bp->mse(&data[i][7]) 
	     <<  endl <<  endl;
	break;
      }
      if ( i%(count/10) == 0 )
	cout<<  endl <<  "MSE:  " << bp->mse(&data[i][7]) 
	    << "... Training..." << endl;
    }
  
  if ( i == count )
    cout << endl << i << " iterations completed..." 
	 << "MSE: " << bp->mse(&data[i-1][7]) << endl;  	
  
  xPosition = 0;
  height = 100.0;  
  Xvelocity = 0;
  fuel = 100.0; int n0=0;
  float testData[2100][6];
  for(float v=0;v <=10.0; v+=0.1)
    { 
      for(float w=-0.1;w<=0.1;w+=0.01)
	{
	  n0++;
	  testData[n0][0]=xPosition; testData[n0][1]= height; testData[n0][2]=Xvelocity; testData[n0][3]=v; testData[n0][4]=w; testData[n0][5]=fuel;
	}
    }

  
  cout<< "Now using the trained network to make predctions on test data...." << endl << endl;
  float testData1[1][6];	
  float Ecount=0;
  for ( i = 0 ; i < n0 ; i++ )
    {
      xPosition=testData[i][0]; height=testData[i][1]; Xvelocity=testData[i][2]; 
      Yvelocity=testData[i][3]; wind=testData[n0][4]; fuel=testData[n0][5];
      bp->ffwd(testData[i]);
      burn = bp->Out(0); //cout << burn << endl;
      thrust = bp->Out(1); //cout << thrust << endl;
      int p=1;
      while(p==1)
	{
	  Yvelocity+=ACCELERATION;  
	  if(fuel < burn)  burn = fuel;
	  fuel -= fabs(burn);  
	  Yvelocity-=burn;  
	  if(fuel < thrust) thrust = fuel;
	  fuel -= fabs(thrust);  
	  Xvelocity-=thrust;   
	  height -= (Yvelocity); 
	  xPosition += (Xvelocity + wind);
	  
	  if(test(height, Yvelocity, 4.0, xPosition, -0.2, 0.2)==2) {p = 0; Ecount++;}
	  else if(test(height, Yvelocity, 4.0, xPosition, -0.2, 0.2)==1)
	    { 
	      p = 0;
	      Ecount++;
	    }
	  else wind = 0.2 * (lrand()-0.5);
	  testData1[1][0]=xPosition; testData1[1][1]= height; testData1[1][2]=Xvelocity; testData1[1][3]=Yvelocity; testData1[1][4]=wind; testData1[1][5]=fuel;
	  bp->ffwd(testData1[1]);
	  burn = bp->Out(0);
	  thrust = bp->Out(1);
	}
    }
  float Success_rate = Ecount/n0;
  cout << "The success rate of the ANN is: "<< Ecount<<"/"<<n0<<"="<<Success_rate<<endl;
  
  
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
