// CS570             Project 3b
// Heyan Huang       April 15, 2013

#include<iostream>
#include<cstdio>
#include<cstdlib>
#include<string>
#include<vector>
#include<cassert>
#include<cmath>
#include<sstream>
#include<unordered_map>
#include "hwb2.h"

using namespace std;

typedef pair <std::string, FuzzyLogic::FuzzyInput*> FuzzyInput_Pairs;

float ACCELERATION = 2.0;  // but should be varied
float WIND = 1; // but randomized below
const float MAX_SAFE_LANDING_SPEED = 4.0;
const float MIN_SAFE_X = -0.2;
const float MAX_SAFE_X = 0.2;

float Burn(float hei, float yve);
float Thrust(float xpo, float xve);

int test(int ht, int Yv, int MaxS, int xP, int MinX, int MaxX);
float lrand();
const int DATA_SIZE = 50000;
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

  for(int i=0; i < 2; i++)
    {
      //  for(float v=0;v < 10.0; v += 2) { 
      //    for(float w=-0.1;w < 0.1;w+= 0.1){
      float v = abs( (lrand()-0.5)*10 );
      float w = 0.2*(lrand()-0.5);
      b=1;
      int n2 = 0;
      while(b==1) {
	wind = w;
	Yvelocity = v;
	xPosition = 0;
	height = 100.0;  
	Xvelocity = 0;
	fuel = 100.0;
	int a = 1, n1=0;
	while (a==1){
	  burn = Burn(height, Yvelocity);
	  thrust = Thrust(xPosition, Xvelocity);
	  // one observation
	  temp[n1][0]=xPosition; temp[n1][1]=height; temp[n1][2]=Xvelocity; temp[n1][3]=Yvelocity; 
	  temp[n1][4]=wind; temp[n1][5]=fuel;// temp[n1][6]=acce; 
	  temp[n1][6]=burn; temp[n1][7]=thrust;
	  n1++;
	  totcnt++;
	  //cout << "                         totcnt: " << totcnt << endl;
		  		  
	  Yvelocity+= ACCELERATION;  
	  if(fuel < burn)  burn = fuel;
	  fuel -= fabs(burn);  
	  Yvelocity-=burn;  
	  if(fuel < thrust) thrust = fuel;
	  fuel -= fabs(thrust);  
	  Xvelocity-=thrust;   
	  height -= (Yvelocity); 
	  xPosition += (Xvelocity + wind);

	  if(test(height, Yvelocity, 4.0, xPosition, -0.2, 0.2)==2) a = 0; // fail
	  else if(test(height, Yvelocity, 4.0, xPosition, -0.2, 0.2)==1)   // land successfully
	    { 
	      for(int i=0;i<n1;i++){ 
		for(int j=0;j<8;j++) {data[i+count][j] = temp[i][j]; }
	      }
	      a = 0;
	      n2 = n2 + n1;
	      count = count + n1;
	      b = 0;
	    } else wind = 0.2 * (lrand()-0.5);
	} // end of while inside
      }
    }

	
cout << endl << "for generating training data: " << endl; 
float SucLanRate = count / totcnt;
std::cout << "the value of successfully landed count is " << count << endl;
std::cout << "the value of total number of trials(updates) is " << totcnt << endl;
std::cout << "The successfully landing rate is " << SucLanRate << endl << endl;
  
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

float Burn(float hei, float yve)
{
  FuzzyLogic::Experiments* experiment = new FuzzyLogic::Experiments();
  experiment->BuildMoonLanderBurnRules();
  unordered_map <std::string, FuzzyLogic::FuzzyInput*> h_fuzzyInputs;
  FuzzyLogic::FuzzyInput* inputRazdalja = new FuzzyLogic::FuzzyInput("height", hei);
  FuzzyLogic::FuzzyInput* inputPriblizevanje = new FuzzyLogic::FuzzyInput("yvelocity", yve);
  h_fuzzyInputs.insert(FuzzyInput_Pairs(inputRazdalja->GetVariableName(), inputRazdalja));
  h_fuzzyInputs.insert(FuzzyInput_Pairs(inputPriblizevanje->GetVariableName(), inputPriblizevanje));

  float outputSignal = experiment->CalculateFuzzyRules(h_fuzzyInputs);
  cout << "the value of BURN is " << outputSignal << endl;

  //YOU HAVE TO RESET TOKEN VALUES BEFORE NEW CALCULATIONS!!!
  experiment->ResetTokenValues();
  delete experiment;

  return outputSignal;
}

float Thrust(float xpo, float xve)
{
  FuzzyLogic::Experiments* experiment = new FuzzyLogic::Experiments();
  experiment->BuildMoonLanderThrustRules();
  unordered_map <std::string, FuzzyLogic::FuzzyInput*> h_fuzzyInputs;
  FuzzyLogic::FuzzyInput* inputRazdalja = new FuzzyLogic::FuzzyInput("xposition", xpo);
  FuzzyLogic::FuzzyInput* inputPriblizevanje = new FuzzyLogic::FuzzyInput("xvelocity", xve);
  h_fuzzyInputs.insert(FuzzyInput_Pairs(inputRazdalja->GetVariableName(), inputRazdalja));
  h_fuzzyInputs.insert(FuzzyInput_Pairs(inputPriblizevanje->GetVariableName(), inputPriblizevanje));

  float outputSignal = experiment->CalculateFuzzyRules(h_fuzzyInputs);
  cout << "the value of THRUST is " << outputSignal << endl;

  //YOU HAVE TO RESET TOKEN VALUES BEFORE NEW CALCULATIONS!!!
  experiment->ResetTokenValues();
  delete experiment;

  return outputSignal;
}
