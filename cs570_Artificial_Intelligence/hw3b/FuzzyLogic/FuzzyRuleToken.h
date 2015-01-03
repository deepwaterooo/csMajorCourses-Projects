#pragma once
#include "LinguisticVariable.h"
#include "FuzzyInput.h"
#include <hash_map>

using namespace stdext;
/*
* Author: Sašo Maðariæ
*/

namespace FuzzyLogic{

	//ENUM operation
	enum Operation{
		AND,OR,EMPTY
	};
	class CFuzzyRuleToken
	{
		//Is there operator before token
		Operation operation;
		//Is there negation for this token
		bool b_negation;
		//Pointer to linguistic variable
		CLinguisticVariable* p_linguisticVariable;
		//Name of Linguistic value
		string linguisticValueName;

	public:

		//Constructor
		CFuzzyRuleToken(bool nNegation, 
			Operation nOperation, 
			CLinguisticVariable* nLinguisticVariable, 
			string nLinguisticValueId)
		{
			b_negation = nNegation;
			operation = nOperation;
			p_linguisticVariable = nLinguisticVariable;
			linguisticValueName = nLinguisticValueId;
		}

		~CFuzzyRuleToken(void)
		{
			
		}

		//Calculate token value
		double CalculateTokenOutputValue(hash_map <string, CFuzzyInput*> h_fuzzyInputHashMap)
		{
			hash_map <string, CFuzzyInput*> :: const_iterator iterator;
			//Find linguistic variable
			iterator = h_fuzzyInputHashMap.find(p_linguisticVariable->ToString());
			CFuzzyInput* temp = (CFuzzyInput*)iterator->second;
			double input = temp->GetInputValue();
			//Calculate linguistic value
			return p_linguisticVariable->CalculateLinguisticValueByName(linguisticValueName, input);
		}

		void UpdateTokenValue(double newVal)
		{
			//Just update token value
			p_linguisticVariable->UpdateLinguisticValueByName(linguisticValueName, newVal);
		}

		//GETTERS
		string GetLinguisticValueName(){return linguisticValueName;}
		CLinguisticVariable* GetLinguisticVariable(){return p_linguisticVariable;}

		bool IsOutput(){ return p_linguisticVariable->IsOutputVariable();}
		bool IsNegated(){return b_negation;}
		bool IsFirst(){
			if(operation == EMPTY) 
				return true;
			return false;
		}

		bool IsAndOperator(){
			if(operation == AND) 
				return true;
			return false;
		}

		bool IsOrOperator(){
			if(operation == OR) 
				return true;
			return false;
		}
	};
}