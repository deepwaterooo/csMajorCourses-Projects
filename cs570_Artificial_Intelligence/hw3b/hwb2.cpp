// CS570             Project 3b
// Heyan Huang       April 15, 2013

#include<iostream>
#include<hasp_map>
using namespace std; 


class FuzzyInput      // input variable and input value manipulation
{
  string varname; 
  double inputvalue;
public: 
  FuzzyInput(string nvarname, double nsetvalue)
  {
    varname = nvarname;
    inputvalue = nsetvalue;
  }
  ~FuzzyInput(void)
  {}

  // setters
  void SetInputValues(double newval) {inputvalue = newval;}
  string GetVariableName(){return varname; }
  double GetInputValue()   {return setvalue; }
};


class FuzzyCalculator      //Implementation of fuzzy operators
{
public:
  static double AND(double a, double b)  //Operator AND
  {
    if(a < b)
      return a;
    return b;
  }
  static double OR(double a, double b)  //Operator OR
  {
    if(a > b)
      return a;
    return b;
  }
};


class LinguisticValue     // define sets and get the linguistic values for specific input value
{
private:
  //Trapezoid borders
  double A;
  double B;
  double C;
  double D;
  string s_valueName;     //Linguistic value name
  double linguisticValue;   //Value
public:
  LinguisticValue(string nValueName, double nA, double nB, double nC, double nD)    //Constructor
  {
    A = nA;
    B = nB;
    C = nC;
    D = nD;
    //We don't want to div x / 0 right?
    if(A == B)
      A += -0.0001;
    if(C == D)
      D +=  0.0001;
    s_valueName = nValueName;
    linguisticValue = -1;
  }
  ~LinguisticValue(void){}     //Destructor
    
  double CalculateLinguisticValue(double input)
  {
    //Normalize variables
    if(input < A)
      input = A;
    else if(input > D)
      input = D;
    //Calculating Trapezoidal function
    if ((input <= A)|| (input > D ))
      return 0;
    else if ((A < input) && (input < B))
      return (input - A) / (B - A);
    else if ((B <= input) && (input <= C))
      return 1;
    else 
      return (D - input) / (D - C);
  }

  void SetLinguisticValue(double nLinguisticValue)    //Setters
  {linguisticValue = nLinguisticValue;}

  double GetLinguisticValue()    //Getters
  {      
    if(linguisticValue == -1)
      linguisticValue = 0;
    return linguisticValue;
  }
  double GetA(){return A;}
  double GetB(){return B;}
  double GetC(){return C;}
  double GetD(){return D;}
  string ToString(){return s_valueName;}
};



int main()
{

  // define fuzzy set
  FuzzySet* height = new FuzzySet(3, [0,0,25,40, 30,45,70,80, 75,90,100,100]);              // low, medium, high
  FuzzySet* yvelocity = new FuzzySet(4,[0,0,2,2.5, 2,2.5,4.5,5, 4.5,5,7,7.5, 7,7.5,10,10]); // slow, relative slow, relative fast, fast

  FuzzySet* position = new FuzzySet(3, [-0.3,-0.3,-0.1,-0.05, -0.1,-0.05,0.05,0.1, 0.05,0.1,0.3,0.3]); // left, middle, right
  FuzzySet* xvelocity = new FuzzySet(4,[-5,-5,-2,-1.5, -2,-1.5,1.5,2, 1.5,2,3,3.5, 3,3.5,5,5]);   // slow, relative slow, relative fast, fast

  FuzzySet* burn = new FuzzySet(3, [0,0,1,1.5, 1,1.5,2,2.5, 2,2.5,3,3]);   // no burn, slight burn, hard burn
  FuzzySet* thrust = new FuzzySet(3, [0,0,0.1,0.15, 0.1,0.15,0.45,0.5, 0.45,0.5,1,1]);   // no thrust, slight thrust, hard thrust

  // define fuzzy ruless
  /*     Height      Yvelocity        Burn 
IF low Height AND slow Yvelocity THEN no Burn
IF low Height AND relative slow Yvelocity THEN slight Burn
IF low Height AND relative fast Yvelocity THEN no Burn
IF low Height AND fast Yvelocity THEN no Burn

IF medium Height AND slow Yvelocity THEN slight Burn
IF medium Height AND relative slow Yvelocity THEN slight Burn
IF medium Height AND relative fast Yvelocity THEN no Burn
IF medium Height AND fast Yvelocity THEN no Burn

IF high Height AND slow Yvelocity THEN hard Burn
IF high Height AND relative slow Yvelocity THEN slight Burn
IF high Height AND relative fast Yvelocity THEN no Burn
IF high Height AND fast Yvelocity THEN no Burn                         */

  




}
