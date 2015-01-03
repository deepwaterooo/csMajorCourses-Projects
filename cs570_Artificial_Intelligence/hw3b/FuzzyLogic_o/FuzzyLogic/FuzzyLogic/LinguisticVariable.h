#pragma once
#include "LinguisticValue.h"
#include <vector>
#include <assert.h>
#include <hash_map>
#include "FuzzyCalculator.h"

using namespace stdext;
/*
* Author: Sašo Maðariæ
* http://msdn.microsoft.com/en-us/library/8zz3703d%28v=vs.80%29.aspx
*/
namespace FuzzyLogic{

	//Typedef for linguistic values hash map.
	typedef pair <string, LinguisticValue*> LinguisticValue_Pairs;

	class CLinguisticVariable
	{
	private:
		//Variable name
		string variableName;

		//Is variable input or output
		bool b_output;

		//Hash table of linguistic values
		hash_map <string, LinguisticValue*> h_linguisticValuesHashMap;
	public:

		//Default constructor
		CLinguisticVariable(bool nOutput, string nVariableName)
		{
			b_output = nOutput;
			variableName = nVariableName;
		}

		//Destructor
		~CLinguisticVariable(void)
		{
			//Release all LinguisticValue objects
			hash_map <string, LinguisticValue*> :: const_iterator iterator;
			iterator = h_linguisticValuesHashMap.begin();
			while(iterator != h_linguisticValuesHashMap.end())
			{
				//Repeat until the end
				LinguisticValue* temp = (LinguisticValue*)iterator->second;
				//Remove item from hash table
				h_linguisticValuesHashMap.erase(iterator);
				//Move to first item of hash table
				iterator = h_linguisticValuesHashMap.begin();
				//Delete LinguisticValue object
				delete temp;
			}
		}

		//Methods
		//Method add Linguistic value to hah map
		void AddLinguisticValue(LinguisticValue* p_linguisticValue)
		{
			h_linguisticValuesHashMap.insert(LinguisticValue_Pairs(p_linguisticValue->ToString(), p_linguisticValue));
		}

		void ResetLinguisticValues()
		{
			//Just for reseting linguistic values
			hash_map <string, LinguisticValue*> :: const_iterator iterator;
			iterator = h_linguisticValuesHashMap.begin();
			while(iterator != h_linguisticValuesHashMap.end())
			{
				//Repeat until the end
				LinguisticValue* temp = (LinguisticValue*)iterator->second;
				temp->SetLinguisticValue(-1);
				iterator++;
			}
		}

		LinguisticValue* FindLinguisticValueByName(string name)
		{
			//Define iterator
			hash_map <string, LinguisticValue*> :: const_iterator iterator;
			//Fint linguistic value by name
			iterator = h_linguisticValuesHashMap.find(name);
			if(iterator == h_linguisticValuesHashMap.end())
			{
				//SASO, this should never happends!!!!!
				assert(NULL);
				return NULL;
			}
			//Return LinguisticValue
			return (LinguisticValue*)iterator->second;
		}

		vector<LinguisticValue*> GetLinguisticValuesList()
		{
			vector<LinguisticValue*> linguisticValuesList;

			hash_map <string, LinguisticValue*> :: const_iterator iterator;
			iterator = h_linguisticValuesHashMap.begin();
			while(iterator != h_linguisticValuesHashMap.end())
			{
				//Repeat until the end
				LinguisticValue* temp = (LinguisticValue*)iterator->second;
				//Remove item from hash table
				linguisticValuesList.push_back(temp);
				iterator++;
			}
			return linguisticValuesList;
		}

		double CalculateLinguisticValueByName(string name, double input)
		{
			LinguisticValue* value = FindLinguisticValueByName(name);
			return value->CalculateLinguisticValue(input);
		}

		//Update Linguistic value by name
		void UpdateLinguisticValueByName(string name, double newVal)
		{
			//Find LinguisticValue
			LinguisticValue* value = FindLinguisticValueByName(name);

			//If there is value, we should perform operator OR
			if(value->GetLinguisticValue() != -1)
				value->SetLinguisticValue(CFuzzyCalculator::OR(value->GetLinguisticValue(), newVal));
			else
				value->SetLinguisticValue(newVal); //There is no value, just set newVal
		}


		//Getters
		bool IsOutputVariable(){return b_output;}
		string ToString(){return variableName;}
	};
}