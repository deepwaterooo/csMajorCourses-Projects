#pragma once
/*
* Author: Sašo Maðariæ
*/
namespace FuzzyLogic
{
	class CFuzzyCalculator
	{
	public:
		//Implementation of fuzzy operators

		//Operator AND
		static double AND(double a, double b)
		{
			if(a < b)
				return a;
			return b;
		}

		//Operator OR
		static double OR(double a, double b)
		{
			if(a > b)
				return a;
			return b;
		}
	};
}