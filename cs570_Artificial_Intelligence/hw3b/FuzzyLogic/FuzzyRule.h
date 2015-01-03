#pragma once
#include <stdlib.h>
#include <sstream>
#include <vector>
#include "FuzzyRuleToken.h"
using namespace std;
/*
* Author: Sašo Maðariæ
*/
namespace FuzzyLogic{
	class CFuzzyRule
	{
		//Rule tokens
		vector<CFuzzyRuleToken*> v_fuzzyRuleTokens;
	public:

		//Constructor
		CFuzzyRule()
		{
			
		}

		~CFuzzyRule(void)
		{
			//Delete all tokens -> no memory leaks :)
			for(unsigned int i = 0; i < v_fuzzyRuleTokens.size(); i++)
				delete v_fuzzyRuleTokens[i];
		}

		void AddTokenToRule(CFuzzyRuleToken* fuzzyRuleToken)
		{
			v_fuzzyRuleTokens.push_back(fuzzyRuleToken);
		}
		//Return fuzzy tokens
		vector<CFuzzyRuleToken*> GetFuzzyRuleTokens(){return v_fuzzyRuleTokens;}
	};
}