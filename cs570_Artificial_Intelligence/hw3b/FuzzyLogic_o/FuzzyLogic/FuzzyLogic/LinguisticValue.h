#pragma once
#include <stdlib.h>
#include <sstream>

using namespace std;

/*
* Author: Sašo Maðariæ
*/
namespace FuzzyLogic{
	class LinguisticValue
	{
	private:
		//Trapezoid borders
		double A;
		double B;
		double C;
		double D;
		//Linguistic value name
		string s_valueName;
		//Value
		double linguisticValue; 
	public:
		//Constructor
		LinguisticValue(string nValueName, double nA, double nB, double nC, double nD)
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

		//Destructor
		~LinguisticValue(void)
		{

		}

		double CalculateLinguisticValue(double input)
		{
			//Normalize variables
			if(input < A)
				input = A;
			else if(input > D)
				input = D;
			//Calculating Trapezoidal function
			if ((input <= A)
				|| (input > D ))
				return 0;
			else if ((A < input) && (input < B))
				return (input - A) / (B - A);
			else if ((B <= input) && (input <= C))
				return 1;
			else 
				return (D - input) / (D - C);
		}


		//Setters
		void SetLinguisticValue(double nLinguisticValue){linguisticValue = nLinguisticValue;}
		//Getters
		double GetLinguisticValue(){
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
}