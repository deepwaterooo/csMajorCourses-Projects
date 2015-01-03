#pragma once
#include "FuzzyReasoner.h"
#include "FuzzyRule.h"
#include "FuzzyRuleToken.h"
#include "LinguisticVariable.h"
#include "LinguisticValue.h"
#include "FuzzyInput.h"
#include <hash_map>

using namespace stdext;
/*
* Author: Sašo Maðariæ
*/

namespace FuzzyLogic{
	typedef pair <string, CLinguisticVariable*> LinguisticVariable_Pairs;
	class CExperiments
	{
		//CFuzzyReasoner instance
		CFuzzyReasoner* fr;
		CFuzzyRuleToken* outputToken;
		hash_map <string, CLinguisticVariable*> h_linguisticVariablesHashMap;
	public:

		CExperiments(void)
		{
			//Creating
			fr = new CFuzzyReasoner();
		}

		~CExperiments(void)
		{
			//Releasing
			delete fr;
		}


		void AddFuzzyRule(CFuzzyRule* rule){fr->AddFuzzyRule(rule);}

		double  CalculateFuzzyRules(hash_map <string, CFuzzyInput*> h_fuzzyInputs)
		{
			outputToken = fr->CalculateFuzzyRules(h_fuzzyInputs);
			assert(outputToken != NULL);

			return fr->Defuzzy(outputToken);
		}

		void ResetTokenValues()
		{
			//Set all linguistic values to -1
			hash_map <string, CLinguisticVariable*> :: const_iterator iterator;
			iterator = h_linguisticVariablesHashMap.begin();
			while(iterator != h_linguisticVariablesHashMap.end())
			{
				//Repeat until the end
				CLinguisticVariable* temp = (CLinguisticVariable*)iterator->second;
				temp->ResetLinguisticValues();
				iterator++;
			}
		}

		double GetA_ByName(string variableName, string valueName)
		{
			CLinguisticVariable* temp = FindLinguisticVariableByName(variableName);
			return temp->FindLinguisticValueByName(valueName)->GetA();
		}

		double GetB_ByName(string variableName, string valueName)
		{
			CLinguisticVariable* temp = FindLinguisticVariableByName(variableName);
			return temp->FindLinguisticValueByName(valueName)->GetB();
		}

		double GetC_ByName(string variableName, string valueName)
		{
			CLinguisticVariable* temp = FindLinguisticVariableByName(variableName);
			return temp->FindLinguisticValueByName(valueName)->GetC();
		}

		double GetD_ByName(string variableName, string valueName)
		{
			CLinguisticVariable* temp = FindLinguisticVariableByName(variableName);
			return temp->FindLinguisticValueByName(valueName)->GetD();
		}

		double GetLinguisticVariableValue(string variableName, string valueName)
		{
			CLinguisticVariable* temp1 = FindLinguisticVariableByName(variableName);
			assert(temp1 != NULL);
			return temp1->FindLinguisticValueByName(valueName)->GetLinguisticValue();
		}

		void BuildCruiseControlRules()
		{
			//Method for building necessary rules for Cruise Control
			CLinguisticVariable *distance = new CLinguisticVariable(false,"Distance");
			CLinguisticVariable *approaching = new CLinguisticVariable(false,"Approaching");
			CLinguisticVariable *speed = new CLinguisticVariable(false,"Speed");
			CLinguisticVariable *signal = new CLinguisticVariable(true,"Signal");

			distance->AddLinguisticValue(new LinguisticValue("Low",0,0,1,2));
			distance->AddLinguisticValue(new LinguisticValue("Average",1,2,3,4));
			distance->AddLinguisticValue(new LinguisticValue("High",3,4,5,5));

			approaching->AddLinguisticValue(new LinguisticValue("Slow",0,0,10,20));
			approaching->AddLinguisticValue(new LinguisticValue("Average",10,20,30,40));
			approaching->AddLinguisticValue(new LinguisticValue("Fast",30,40,50,50));

			speed->AddLinguisticValue(new LinguisticValue("Slow",-50,-50,-10,0));
			speed->AddLinguisticValue(new LinguisticValue("Acceptable",-10,0,0,10));
			speed->AddLinguisticValue(new LinguisticValue("Fast",0,10,50,50));

			signal->AddLinguisticValue(new LinguisticValue("Brake",-5,-5,-2,-1));
			signal->AddLinguisticValue(new LinguisticValue("Maintain",-2,-1,1,2));
			signal->AddLinguisticValue(new LinguisticValue("Accelerate",1,2,5,5));

			//Rule1
			//IF distance=low AND approaching!=slow THEN signal=breake
			CFuzzyRule* rule1 = new CFuzzyRule();
			rule1->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, distance,"Low"));
			rule1->AddTokenToRule(new CFuzzyRuleToken(true,AND, approaching,"Slow"));
			rule1->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, signal,"Brake"));

			//Rule2
			CFuzzyRule* rule2 = new CFuzzyRule();
			rule2->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, distance,"Average"));
			rule2->AddTokenToRule(new CFuzzyRuleToken(false,AND, approaching,"Fast"));
			rule2->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, signal,"Brake"));

			//Rule3
			CFuzzyRule* rule3 = new CFuzzyRule();
			rule3->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, speed,"Fast"));
			rule3->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, signal,"Brake"));
			//Rule4
			CFuzzyRule* rule4 = new CFuzzyRule();
			rule4->AddTokenToRule(new CFuzzyRuleToken(true,EMPTY, distance,"Low"));
			rule4->AddTokenToRule(new CFuzzyRuleToken(false,AND, approaching,"Average"));
			rule4->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, signal,"Maintain"));
			//Rule5
			CFuzzyRule* rule5 = new CFuzzyRule();
			rule5->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, distance,"High"));
			rule5->AddTokenToRule(new CFuzzyRuleToken(true,AND, approaching,"Fast"));
			rule5->AddTokenToRule(new CFuzzyRuleToken(false,AND, speed,"Acceptable"));
			rule5->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, signal,"Maintain"));
			//Rule6
			CFuzzyRule* rule6 = new CFuzzyRule();
			rule6->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, distance,"Average"));
			rule6->AddTokenToRule(new CFuzzyRuleToken(false,AND, speed,"Slow"));
			rule6->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, signal,"Maintain"));
			//Rule7
			CFuzzyRule* rule7 = new CFuzzyRule();
			rule7->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, distance,"High"));
			rule7->AddTokenToRule(new CFuzzyRuleToken(false,AND, speed,"Slow"));
			rule7->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, signal,"Accelerate"));

			fr->AddFuzzyRule(rule1);
			fr->AddFuzzyRule(rule2);
			fr->AddFuzzyRule(rule3);
			fr->AddFuzzyRule(rule4);
			fr->AddFuzzyRule(rule5);
			fr->AddFuzzyRule(rule6);
			fr->AddFuzzyRule(rule7);

			AddLinguisticVariables(distance);
			AddLinguisticVariables(approaching);
			AddLinguisticVariables(speed);
			AddLinguisticVariables(signal);
		}


		void BuildBasketballPlayersRules()
		{
			//Method for building necessary rules for Basketball players
			CLinguisticVariable *height = new CLinguisticVariable(false,"Height");
			CLinguisticVariable *age = new CLinguisticVariable(false,"Age");
			CLinguisticVariable *basketball_player = new CLinguisticVariable(true,"Basketball_player");

			//Add linguistic values to variable
			height->AddLinguisticValue(new LinguisticValue("Low_height",150,150,170,180));
			height->AddLinguisticValue(new LinguisticValue("Average_height",170,180,185,190));
			height->AddLinguisticValue(new LinguisticValue("Tall",185,195,210,210));

			age->AddLinguisticValue(new LinguisticValue("Young",10,10,25,30));
			age->AddLinguisticValue(new LinguisticValue("Average_young",25,35,40,45));
			age->AddLinguisticValue(new LinguisticValue("Old",50,60,80,80));
			age->AddLinguisticValue(new LinguisticValue("Average_old",40,45,50,55));
				
			basketball_player->AddLinguisticValue(new LinguisticValue("Suitable",0.5,0.6,1,1));
			basketball_player->AddLinguisticValue(new LinguisticValue("Unsuitable ",0,0,0.4,0.5));

			//Rule1
			//IF age = Young AND height = Tall THEN basketball_player = "Suitable"
			CFuzzyRule* rule1 = new CFuzzyRule();
			rule1->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, age,"Young"));
			rule1->AddTokenToRule(new CFuzzyRuleToken(false,AND, height,"Tall"));
			rule1->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, basketball_player,"Suitable"));

			//Rule2
			//IF age = "Old" THEN basketball_player = "Unsuitable"
			CFuzzyRule* rule2 = new CFuzzyRule();
			rule2->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, age,"Old"));
			rule2->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, basketball_player,"Unsuitable "));

			//Add rules
			fr->AddFuzzyRule(rule1);
			fr->AddFuzzyRule(rule2);

			//Add linguistic variables, if you want to obtain more informations about fuzzy calculations
			AddLinguisticVariables(height);
			AddLinguisticVariables(age);
			AddLinguisticVariables(basketball_player);
		}

		void BuildSkiJumperRules()
		{
			CLinguisticVariable *height = new CLinguisticVariable(false,"Height");
			CLinguisticVariable *weight = new CLinguisticVariable(false,"Weight");
			CLinguisticVariable *ski_jumper = new CLinguisticVariable(true,"Ski_jumper");

			height->AddLinguisticValue(new LinguisticValue("Low_height",100,100,160,175));
			height->AddLinguisticValue(new LinguisticValue("Average_height",160,175,185,200));
			height->AddLinguisticValue(new LinguisticValue("Tall",185,200,220,220));

			weight->AddLinguisticValue(new LinguisticValue("Low_weight",50,50,60,70));
			weight->AddLinguisticValue(new LinguisticValue("Average_weight",60,70,80,90));
			weight->AddLinguisticValue(new LinguisticValue("High_weight",80,90,120,120));
				
			ski_jumper->AddLinguisticValue(new LinguisticValue("Unsuitable ",0,0,1,2));
			ski_jumper->AddLinguisticValue(new LinguisticValue("Very_unsuitable",1,2,4,5));
			ski_jumper->AddLinguisticValue(new LinguisticValue("Suitable",4,5,7,9));
			ski_jumper->AddLinguisticValue(new LinguisticValue("Very_suitable",7,9,10,10));

			//Rule1
			CFuzzyRule* rule1 = new CFuzzyRule();
			rule1->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, height,"Tall"));
			rule1->AddTokenToRule(new CFuzzyRuleToken(false,AND, weight,"High_weight"));
			rule1->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, ski_jumper,"Unsuitable "));

			//Rule2
			CFuzzyRule* rule2 = new CFuzzyRule();
			rule2->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, height,"Low_height"));
			rule2->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, ski_jumper,"Unsuitable "));

			//Rule3
			CFuzzyRule* rule3 = new CFuzzyRule();
			rule3->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, height,"Average_height"));
			rule3->AddTokenToRule(new CFuzzyRuleToken(true,AND, weight,"Low_weight"));
			rule3->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, ski_jumper,"Very_unsuitable"));

			//Rule4
			CFuzzyRule* rule4 = new CFuzzyRule();
			rule4->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, height,"Average_height"));
			rule4->AddTokenToRule(new CFuzzyRuleToken(false,AND, weight,"Low_weight"));
			rule4->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, ski_jumper,"Suitable"));

			//Rule5
			CFuzzyRule* rule5 = new CFuzzyRule();
			rule5->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, height,"Tall"));
			rule5->AddTokenToRule(new CFuzzyRuleToken(false,AND, weight,"Average_weight"));
			rule5->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, ski_jumper,"Suitable"));

			//Rule6
			CFuzzyRule* rule6 = new CFuzzyRule();
			rule6->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, height,"Tall"));
			rule6->AddTokenToRule(new CFuzzyRuleToken(false,AND, weight,"Low_weight"));
			rule6->AddTokenToRule(new CFuzzyRuleToken(false,EMPTY, ski_jumper,"Very_suitable"));
			
			fr->AddFuzzyRule(rule1);
			fr->AddFuzzyRule(rule2);
			fr->AddFuzzyRule(rule3);
			fr->AddFuzzyRule(rule4);
			fr->AddFuzzyRule(rule5);
			fr->AddFuzzyRule(rule6);

			AddLinguisticVariables(height);
			AddLinguisticVariables(weight);
			AddLinguisticVariables(ski_jumper);

		}

		void AddLinguisticVariables(CLinguisticVariable* p_linguisticVariable)
		{
			h_linguisticVariablesHashMap.insert(LinguisticVariable_Pairs(p_linguisticVariable->ToString(), p_linguisticVariable));
		}

		CLinguisticVariable* FindLinguisticVariableByName(string variableName)
		{
			hash_map <string, CLinguisticVariable*> :: const_iterator iterator;
			iterator = h_linguisticVariablesHashMap.find(variableName);
			return (CLinguisticVariable*)iterator->second;
		}
	};
}