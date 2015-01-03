// FuzzyLogicDSL.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "FuzzyLanguageParser.h"
#include "FuzzyReasoner.h"
#include "FuzzyRule.h"
#include "FuzzyRuleToken.h"
#include "LinguisticVariable.h"
#include "LinguisticValue.h"
#include "FuzzyInput.h"
#include <hash_map>
#include "Experiments.h"

using namespace stdext;
using namespace FuzzyLogic;
typedef pair <string, CFuzzyInput*> CFuzzyInput_Pairs;

using namespace FuzzyLogic;
int _tmain(int argc, _TCHAR* argv[])
{
	CExperiments* experiment = new CExperiments();
	CFuzzyLanguageParser* p = new CFuzzyLanguageParser(experiment);
	p->Parse("rules.txt");
	//Create instance of CExperiments.

	//Hash_map for storing inputs
	hash_map <string, CFuzzyInput*> h_fuzzyInputs;
	
	//Put some values to inputs
	CFuzzyInput* inputRazdalja = new CFuzzyInput("Distance", 1.8);
	CFuzzyInput* inputPriblizevanje = new CFuzzyInput("Approaching", 15);
	CFuzzyInput* inputHitrost = new CFuzzyInput("Speed", -8);
	
	//Insert inputs to the hash_map
	h_fuzzyInputs.insert(CFuzzyInput_Pairs(inputRazdalja->GetVariableName(), inputRazdalja));
	h_fuzzyInputs.insert(CFuzzyInput_Pairs(inputPriblizevanje->GetVariableName(), inputPriblizevanje));
	h_fuzzyInputs.insert(CFuzzyInput_Pairs(inputHitrost->GetVariableName(), inputHitrost));

	//Calculate fuzzy Logic output signal
	double outputSignal = experiment->CalculateFuzzyRules(h_fuzzyInputs);
	experiment = new CExperiments();
	p->fuzzyInterface = experiment;
	p->Parse("rules.txt");

	outputSignal = experiment->CalculateFuzzyRules(h_fuzzyInputs);
	//Get some additional informations from fuzzy logic 
	double t = experiment->GetC_ByName("Distance","Average");
	double v1 = experiment->GetLinguisticVariableValue("Signal","Brake");
	double v2 = experiment->GetLinguisticVariableValue("Signal","Maintain");
	double v3 = experiment->GetLinguisticVariableValue("Signal","Accelerate");

	double v4 = experiment->GetLinguisticVariableValue("Distance","Low");
	double v5 = experiment->GetLinguisticVariableValue("Distance","Average");
	double v6 = experiment->GetLinguisticVariableValue("Distance","High");

	double v7 = experiment->GetLinguisticVariableValue("Approaching","Slow");
	double v8 = experiment->GetLinguisticVariableValue("Approaching","Average");
	double v9 = experiment->GetLinguisticVariableValue("Approaching","Fast");

	double v10 = experiment->GetLinguisticVariableValue("Speed","Slow");
	double v11 = experiment->GetLinguisticVariableValue("Speed","Acceptable");
	double v12 = experiment->GetLinguisticVariableValue("Speed","Fast");

	//YOU HAVE TO RESET TOKEN VALUES BEFORE NEW CALCULATIONS!!!
	experiment->ResetTokenValues();
	delete experiment;

	return 0;
}

