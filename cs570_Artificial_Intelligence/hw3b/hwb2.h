// CS570             Project 3b
// Heyan Huang       April 15, 2013

//#pragma once

#include<iostream>
#include<cstdlib>
#include<string>
#include<vector>
#include<cassert>
#include<cmath>
#include<sstream>

//#include<hash_map>
//using namespace std;

#include<unordered_map>

using namespace std;


namespace FuzzyLogic 
{
class FuzzyInput      // input variable and input value manipulation
{
  std::string variableName; 
  double inputValue;
public: 
  FuzzyInput(std::string nVariableName, double nInputValue)
  {
    variableName = nVariableName;
    inputValue = nInputValue;
  }
  ~FuzzyInput(void)
  {}

  // setters
  void SetInputValues(double newval) {inputValue = newval;}
  std::string GetVariableName(){return variableName; }
  double GetInputValue(){return inputValue; }
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
  std::string s_valueName;     //Linguistic value name
  double linguisticValue;   //Value
public:
  LinguisticValue(std::string nValueName, double nA, double nB, double nC, double nD)    //Constructor
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
  std::string ToString(){return s_valueName;}
};


//*********************************************************************************************
//Typedef for linguistic values hash map.   
typedef std::pair<std::string, LinguisticValue*> LinguisticValue_Pairs;
class LinguisticVariable
{
private:
  std::string variableName;  //Variable name
  bool b_output; //Is variable input or output
  unordered_map <std::string, LinguisticValue*> h_linguisticValuesHashMap;
public:
  LinguisticVariable(bool nOutput, std::string nVariableName)  //Default constructor
  {
    b_output = nOutput;
    variableName = nVariableName;
  }
  ~LinguisticVariable(void)  //Destructor
  {
    //Release all LinguisticValue objects
    unordered_map<std::string, LinguisticValue*> :: const_iterator iterator;
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
  //Method add Linguistic value to hash map
  void AddLinguisticValue(LinguisticValue* p_linguisticValue)
  {
    h_linguisticValuesHashMap.insert(LinguisticValue_Pairs(p_linguisticValue->ToString(), p_linguisticValue));
  }

  void ResetLinguisticValues()
  {
    //Just for reseting linguistic values
    unordered_map <string, LinguisticValue*> :: const_iterator iterator;
    iterator = h_linguisticValuesHashMap.begin();
    while(iterator != h_linguisticValuesHashMap.end())
      {
	//Repeat until the end
	LinguisticValue* temp = (LinguisticValue*)iterator->second;
	temp->SetLinguisticValue(-1);    // by default it is -1, LinguisticValue class
	iterator++;
      }
  }

  LinguisticValue* FindLinguisticValueByNames(std::string name)
  {
    //Define iterator
    unordered_map <string, LinguisticValue*> :: const_iterator iterator;
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

  std::vector<LinguisticValue*> GetLinguisticValuesList()
  {
    vector<LinguisticValue*> linguisticValuesList;
    unordered_map <std::string, LinguisticValue*> :: const_iterator iterator;
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

  double CalculateLinguisticValueByName(std::string name, double input)
  {
    LinguisticValue* value = FindLinguisticValueByNames(name);    // defined previously
    return value->CalculateLinguisticValue(input);
  }

  //Update Linguistic value by name
  void UpdateLinguisticValueByName(std::string name, double newVal)
  {
    //Find LinguisticValue
    LinguisticValue* value = FindLinguisticValueByNames(name);

    //If there is value, we should perform operator OR     ********************************************** this is the part I need to modify to better satisfy mine
    if(value->GetLinguisticValue() != -1)
      value->SetLinguisticValue(FuzzyCalculator::OR(value->GetLinguisticValue(), newVal));
      //      value->SetLinguisticValue(FuzzyCalculator::AND(value->GetLinguisticValue(), newVal));
    else
      value->SetLinguisticValue(newVal); //There is no value, just set newVal
  }

  //Getters
  bool IsOutputVariable(){return b_output;}
  std::string ToString(){return variableName;}
};


enum Operation{
  AND,OR,EMPTY
};

//****************************************************** FuzzyRuleToken *******************************************************************************
class FuzzyRuleToken
{
  Operation operation;   //Is there operator before token
  bool b_negation;       //Is there negation for this token
  LinguisticVariable* p_linguisticVariable;  //Pointer to linguistic variable
  std::string linguisticValueName; //Name of Linguistic value
public:
  FuzzyRuleToken(bool nNegation, 
		  Operation nOperation, 
		  LinguisticVariable* nLinguisticVariable, 
		  std::string nLinguisticValueId)
  {
    b_negation = nNegation;
    operation = nOperation;
    p_linguisticVariable = nLinguisticVariable;
    linguisticValueName = nLinguisticValueId;
  }
  ~FuzzyRuleToken(void){}
  
  //Calculate token value
  double CalculateTokenOutputValue(unordered_map <std::string, FuzzyInput*> h_fuzzyInputHashMap)
  {
    unordered_map <std::string, FuzzyInput*>::const_iterator iterator;
    iterator = h_fuzzyInputHashMap.find(p_linguisticVariable->ToString()); //Find linguistic variableName
     FuzzyInput* temp = iterator -> second; 
    //FuzzyInput* temp = iterator -> second;     
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
  std::string GetLinguisticValueName(){return linguisticValueName;}
  LinguisticVariable* GetLinguisticVariable(){return p_linguisticVariable;}

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

//****************************************************** FuzzyRule *******************************************************************************
class FuzzyRule
{
  //Rule tokens
  vector<FuzzyRuleToken*> v_fuzzyRuleTokens;
public:
  //Constructor
  FuzzyRule(){}
  ~FuzzyRule(void)
  {
    //Delete all tokens -> no memory leaks :)
    for(unsigned int i = 0; i < v_fuzzyRuleTokens.size(); i++)
      delete v_fuzzyRuleTokens[i];
  }

  void AddTokenToRule(FuzzyRuleToken* fuzzyRuleToken)
  {
    v_fuzzyRuleTokens.push_back(fuzzyRuleToken);
  }
  //Return fuzzy tokens
  vector<FuzzyRuleToken*> GetFuzzyRuleTokens(){return v_fuzzyRuleTokens;}
};

//****************************************************** FuzzyReasoner *******************************************************************************
class FuzzyReasoner
{
  //Vector of Fuzzy rules
  vector<FuzzyRule*> v_fuzzyRulesVector; 
public:
  //Constructor
  FuzzyReasoner(void){}
  ~FuzzyReasoner(void)
  {
    //We don't like memory leaks, so release all rules
    for(unsigned int i = 0; i < v_fuzzyRulesVector.size(); i++)
      delete (FuzzyRule*)v_fuzzyRulesVector[i];
  }

  //Add fuzzy rule
  void AddFuzzyRule(FuzzyRule* p_fuzzyRule)
  {
    v_fuzzyRulesVector.push_back(p_fuzzyRule);
  }

  //Start reasoner for fuzzy rulles
  FuzzyRuleToken* CalculateFuzzyRules(unordered_map <std::string, FuzzyInput*> h_fuzzyInputs)
  {
    //Reset all values
    FuzzyRuleToken* outputObject;
    //Calculate all fuzzy rules
    for(unsigned int i = 0; i < v_fuzzyRulesVector.size(); i++)
      {
	//Glede na izhodno vrednost izhodne spremeljivke naredi update izhodnega objekta
	outputObject = FuzzyRuleReasoner((FuzzyRule*)v_fuzzyRulesVector[i], h_fuzzyInputs);
      }
    return outputObject;   //Return output object
  }

  //Start fuzzy rule reasoner
  FuzzyRuleToken* FuzzyRuleReasoner(FuzzyRule* fuzzyRule, unordered_map <std::string, FuzzyInput*> h_fuzzyInputs)
  {
    double resultVal = 0;
    for(unsigned int i = 0; i < fuzzyRule->GetFuzzyRuleTokens().size(); i++)
      {
	//Get fuzzy rule token
	FuzzyRuleToken* token = fuzzyRule->GetFuzzyRuleTokens()[i];
	if(token->IsOutput()){
	  //Update output object
	  token->UpdateTokenValue(resultVal);
	  //Return result token
	  return token;
	} else {
	  double tokenVal = token->CalculateTokenOutputValue(h_fuzzyInputs);
	  token->UpdateTokenValue(tokenVal);
	  if(token->IsNegated())
	    tokenVal = 1 - tokenVal;	//Negate value
	  if(i == 0)
	    resultVal = tokenVal;		//Set value
	  else if(token->IsOrOperator())
	    resultVal = FuzzyCalculator::OR(resultVal, tokenVal); //OR operator
	  else if(token->IsAndOperator())
	    resultVal = FuzzyCalculator::AND(resultVal, tokenVal); //AND operator
	}
      }
    //This won't happends saso
    assert(NULL);
    return NULL;
  }

  //Defuzzyfication
  double Defuzzy(FuzzyRuleToken *outputToken)
  {
    //For every output value
    LinguisticVariable* lVar = outputToken->GetLinguisticVariable();
    vector<LinguisticValue*> valuesList = lVar->GetLinguisticValuesList();

    double upEqualation = 0;
    double downEqualation = 0;
    //Calculating defuzzy value
    for(unsigned int i = 0; i < valuesList.size(); i++)
      {
	LinguisticValue* val = valuesList.at(i);
	upEqualation += val->GetLinguisticValue()
	  * CalculateTrapezoidBalance(val->GetA(), val->GetB(), val->GetC(), val->GetD()); 
	downEqualation += val->GetLinguisticValue();
      }
    //Return output value of system
    if(downEqualation == 0)
      return 0;
    return upEqualation / downEqualation;
  }

  //Calculating surface of trapezoid 
  double CalculateTrapezoidBalance(double A, double B, double C, double D)
  {
    return ((1 / (B - A)) * (2 * pow(B,3) - 3 * A * pow(B,2) + pow(A,3)) + 
	    3 * (pow(C,2) - pow(B,2)) + (1 / (D-C)) * (2 * pow(C,3) - 3 * D * pow(C,2) + pow(D,3)))
      / (3 * (B - A) + 6 * (C - B) + 3 * (D - C));
  }
};


typedef pair <std::string, LinguisticVariable*> LinguisticVariable_Pairs;
class Experiments
{
  //FuzzyReasoner instance
  FuzzyReasoner* fr;
  FuzzyRuleToken* outputToken;
  unordered_map <std::string, LinguisticVariable*> h_linguisticVariablesHashMap;
public:
  Experiments(void)
  {
    fr = new FuzzyReasoner();  //Creating
  }
  ~Experiments(void)
  {
    delete fr; //Releasing
  }

  void AddFuzzyRule(FuzzyRule* rule){fr->AddFuzzyRule(rule);}
  double CalculateFuzzyRules(unordered_map <std::string, FuzzyInput*> h_fuzzyInputs)
  {
    outputToken = fr->CalculateFuzzyRules(h_fuzzyInputs);
    assert(outputToken != NULL);
    return fr->Defuzzy(outputToken);
  }

  void ResetTokenValues()
  {
    //Set all linguistic values to -1
    unordered_map <std::string, LinguisticVariable*> :: const_iterator iterator;
    iterator = h_linguisticVariablesHashMap.begin();
    while(iterator != h_linguisticVariablesHashMap.end())
      {
	//Repeat until the end
	LinguisticVariable* temp = (LinguisticVariable*)iterator->second;
	temp->ResetLinguisticValues();
	iterator++;
      }
  }

  double GetA_ByName(std::string variableName, std::string valueName){
    LinguisticVariable* temp = FindLinguisticVariableByName(variableName);
    return temp->FindLinguisticValueByNames(valueName)->GetA();
  }
  double GetB_ByName(std::string variableName, std::string valueName){
    LinguisticVariable* temp = FindLinguisticVariableByName(variableName);
    return temp->FindLinguisticValueByNames(valueName)->GetB();
  }

  double GetC_ByName(std::string variableName, std::string valueName) {
    LinguisticVariable* temp = FindLinguisticVariableByName(variableName);
    return temp->FindLinguisticValueByNames(valueName)->GetC();
  }
  double GetD_ByName(std::string variableName, std::string valueName) {
    LinguisticVariable* temp = FindLinguisticVariableByName(variableName);
    return temp->FindLinguisticValueByNames(valueName)->GetD();
  }

  double GetLinguisticVariableValue(std::string variableName, std::string valueName){
    LinguisticVariable* temp1 = FindLinguisticVariableByName(variableName);
    assert(temp1 != NULL);
    return temp1->FindLinguisticValueByNames(valueName)->GetLinguisticValue();
  }

  // void BuildCruiseControlRules() 
  void BuildMoonLanderBurnRules()
  {
    //Method for building necessary rules for Cruise Control
    LinguisticVariable *height = new LinguisticVariable(false,"height");
    LinguisticVariable *yvelocity = new LinguisticVariable(false,"yvelocity");
    LinguisticVariable *burn = new LinguisticVariable(true,"burn");

    height->AddLinguisticValue(new LinguisticValue("Low",     0, 0, 5, 6));
    height->AddLinguisticValue(new LinguisticValue("Average", 5, 6, 60, 75));
    height->AddLinguisticValue(new LinguisticValue("High",    60, 75, 100,100));

    yvelocity->AddLinguisticValue(new LinguisticValue("Slow",     0, 0, 2, 2.5));
    yvelocity->AddLinguisticValue(new LinguisticValue("Middle",   2, 2.5, 6.5, 7));
    yvelocity->AddLinguisticValue(new LinguisticValue("Fast",     6.5, 7.5, 10, 10));

    burn->AddLinguisticValue(new LinguisticValue("NoBurn",     0,   0, 1.5, 2));
    burn->AddLinguisticValue(new LinguisticValue("SlightBurn", 1.5, 2.5, 3.2, 3.5));
    burn->AddLinguisticValue(new LinguisticValue("HardBurn",   3.2, 3.5, 4.5, 5));

    /*     // Height      Yvelocity        Burn 
	   IF Low Height AND Slow Yvelocity THEN NoBurn
	   IF Low Height AND Middle Yvelocity THEN NoBurn
	   IF Low Height AND Fast Yvelocity THEN SlightBurn

	   IF Average Height AND slow Yvelocity THEN NoBurn
	   IF Average Height AND Middle Yvelocity THEN SlightBurn
	   IF Average Height AND fast Yvelocity THEN HardBurn

	   IF High Height AND slow Yvelocity THEN  SlightBurn
	   IF High Height AND relative slow Yvelocity THEN HardBurn
	   IF High Height AND fast Yvelocity THEN HardBurn           */

    // Rule1: IF Low Height AND Slow Yvelocity THEN NoBurn
    FuzzyRule* rule1 = new FuzzyRule();
    rule1->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"Low"));
    rule1->AddTokenToRule(new FuzzyRuleToken(false,AND, yvelocity,"Slow"));       // the first argument
    rule1->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, burn,"NoBurn"));

    // Rule2: IF Low Height AND Middle Yvelocity THEN NoBurn
    FuzzyRule* rule2 = new FuzzyRule();
    rule2->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"Low"));
    rule2->AddTokenToRule(new FuzzyRuleToken(false,AND, yvelocity,"Middle"));
    rule2->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, burn,"NoBurn"));

    // Rule3: IF Low Height AND Fast Yvelocity THEN SlightBurn
    FuzzyRule* rule3 = new FuzzyRule();
    rule3->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"Low"));
    rule3->AddTokenToRule(new FuzzyRuleToken(false,AND, yvelocity,"Fast"));
    rule3->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, burn,"SlightBurn"));

    // Rule4: IF Average Height AND slow Yvelocity THEN NoBurn
    FuzzyRule* rule4 = new FuzzyRule();
    rule4->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"Average"));
    rule4->AddTokenToRule(new FuzzyRuleToken(false,AND, yvelocity,"Slow"));
    rule4->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, burn,"NoBurn"));

    // Rule5: IF Average Height AND Middle Yvelocity THEN SlightBurn
    FuzzyRule* rule5 = new FuzzyRule();
    rule5->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"Average"));
    rule5->AddTokenToRule(new FuzzyRuleToken(false,AND, yvelocity,"Middle"));
    rule5->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, burn,"SlightBurn"));
       
    // Rule6: IF Average Height AND fast Yvelocity THEN HardBurn
    FuzzyRule* rule6 = new FuzzyRule();
    rule6->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"Average"));
    rule6->AddTokenToRule(new FuzzyRuleToken(false,AND, yvelocity,"Fast"));
    rule6->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, burn,"HardBurn"));

    // Rule7: IF High Height AND slow Yvelocity THEN  SlightBurn
    FuzzyRule* rule7 = new FuzzyRule();
    rule7->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"High"));
    rule7->AddTokenToRule(new FuzzyRuleToken(false,AND, yvelocity,"Slow"));
    rule7->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, burn,"SlightBurn"));

    // Rule8: IF High Height AND relative slow Yvelocity THEN HardBurn
    FuzzyRule* rule8 = new FuzzyRule();
    rule8->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"High"));
    rule8->AddTokenToRule(new FuzzyRuleToken(false,AND, yvelocity,"Middle"));
    rule8->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, burn,"HardBurn"));

    // Rule9: IF High Height AND fast Yvelocity THEN HardBurn           
    FuzzyRule* rule9 = new FuzzyRule();
    rule9->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"High"));
    rule9->AddTokenToRule(new FuzzyRuleToken(false,AND, yvelocity,"Fast"));
    rule9->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, burn,"HardBurn"));

    fr->AddFuzzyRule(rule1);
    fr->AddFuzzyRule(rule2);
    fr->AddFuzzyRule(rule3);
    fr->AddFuzzyRule(rule4);
    fr->AddFuzzyRule(rule5);
    fr->AddFuzzyRule(rule6);
    fr->AddFuzzyRule(rule7);
    fr->AddFuzzyRule(rule8);
    fr->AddFuzzyRule(rule9);

    AddLinguisticVariables(height);
    AddLinguisticVariables(yvelocity);
    AddLinguisticVariables(burn);
  }

  void BuildMoonLanderThrustRules()
  {
    //Method for building necessary rules for Cruise Control
    LinguisticVariable *xposition = new LinguisticVariable(false,"xposition");
    LinguisticVariable *xvelocity = new LinguisticVariable(false,"xvelocity");
    LinguisticVariable *thrust = new LinguisticVariable(true,"thrust");

    xposition->AddLinguisticValue(new LinguisticValue("Left",  -0.2, -0.15, -0.035, -0.03));
    xposition->AddLinguisticValue(new LinguisticValue("Middle",-0.038, -0.025, 0.04, 0.05));
    xposition->AddLinguisticValue(new LinguisticValue("Right", 0.04, 0.05, 0.2, 0.2));

    xvelocity->AddLinguisticValue(new LinguisticValue("Slow",     -5, -5, -0.5, -0.3));
    xvelocity->AddLinguisticValue(new LinguisticValue("Middle",   -0.5, -0.3, 0.3, 0.5));
    xvelocity->AddLinguisticValue(new LinguisticValue("Fast",     0.3, 0.5, 5, 5));

    thrust->AddLinguisticValue(new LinguisticValue("NoThrust",     0, 0, 0.25, 0.3));
    thrust->AddLinguisticValue(new LinguisticValue("SlightThrust", 0.26, 0.32, 0.75, 0.78));
    thrust->AddLinguisticValue(new LinguisticValue("HardThrust",   0.76, 0.8, 1, 1));

    /* // position     xvelocity      thrust

       IF Left position AND Slow xvelocity THEN NoThrust
       IF Left position AND Middle xvelocity THEN NoThrust
       IF Left position AND Fast xvelocity THEN SlightThrust

       IF Middle position AND Slow xvelocity THEN NoThrust
       IF Middle position AND Middle xvelocity THEN SlightThrust
       IF Middle position AND Fast xvelocity THEN HardThrust

       IF Right position AND Slow xvelocity THEN SlightThrust
       IF Right position AND Middle xvelocity THEN HardThrust
       IF Right position AND Fast xvelocity THEN HardThrust                 */

    // Rule1: IF Left position AND Slow xvelocity THEN NoThrust
    FuzzyRule* rule1 = new FuzzyRule();
    rule1->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, xposition,"Left"));
    rule1->AddTokenToRule(new FuzzyRuleToken(false,AND, xvelocity,"Slow")); 
    rule1->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, thrust,"NoThrust"));

    // Rule2: IF Left position AND Middle xvelocity THEN NoThrust
    FuzzyRule* rule2 = new FuzzyRule();
    rule2->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, xposition,"Left"));
    rule2->AddTokenToRule(new FuzzyRuleToken(false,AND, xvelocity,"Middle")); 
    rule2->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, thrust,"NoThrust"));

    // Rule3: IF Left position AND Fast xvelocity THEN SlightThrust
    FuzzyRule* rule3 = new FuzzyRule();
    rule3->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, xposition,"Left"));
    rule3->AddTokenToRule(new FuzzyRuleToken(false,AND, xvelocity,"Fast")); 
    rule3->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, thrust,"SlightThrust"));

    // Rule4: IF Middle position AND Slow xvelocity THEN NoThrust
    FuzzyRule* rule4 = new FuzzyRule();
    rule4->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, xposition,"Middle"));
    rule4->AddTokenToRule(new FuzzyRuleToken(false,AND, xvelocity,"Slow")); 
    rule4->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, thrust,"NoThrust"));

    // Rule5: IF Middle position AND Middle xvelocity THEN SlightThrust
    FuzzyRule* rule5 = new FuzzyRule();
    rule5->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, xposition,"Middle"));
    rule5->AddTokenToRule(new FuzzyRuleToken(false,AND, xvelocity,"Middle")); 
    rule5->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, thrust,"SlightThrust"));

    // Rule6: IF Middle position AND Fast xvelocity THEN HardThrust
    FuzzyRule* rule6 = new FuzzyRule();
    rule6->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, xposition,"Middle"));
    rule6->AddTokenToRule(new FuzzyRuleToken(false,AND, xvelocity,"Fast")); 
    rule6->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, thrust,"HardThrust"));
       
    // Rule7: IF Right position AND Slow xvelocity THEN SlightThrust
    FuzzyRule* rule7 = new FuzzyRule();
    rule7->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, xposition,"Right"));
    rule7->AddTokenToRule(new FuzzyRuleToken(false,AND, xvelocity,"Slow")); 
    rule7->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, thrust,"SlightThrust"));

    // Rule8: IF Right position AND Middle xvelocity THEN HardThrust
    FuzzyRule* rule8 = new FuzzyRule();
    rule8->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, xposition,"Right"));
    rule8->AddTokenToRule(new FuzzyRuleToken(false,AND, xvelocity,"Middle")); 
    rule8->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, thrust,"HardThrust"));

    // Rule9: IF Right position AND Fast xvelocity THEN HardThrust                 
    FuzzyRule* rule9 = new FuzzyRule();
    rule9->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, xposition,"Right"));
    rule9->AddTokenToRule(new FuzzyRuleToken(false,AND, xvelocity,"Fast")); 
    rule9->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, thrust,"HardThrust"));

    fr->AddFuzzyRule(rule1);
    fr->AddFuzzyRule(rule2);
    fr->AddFuzzyRule(rule3);
    fr->AddFuzzyRule(rule4);
    fr->AddFuzzyRule(rule5);
    fr->AddFuzzyRule(rule6);
    fr->AddFuzzyRule(rule7);
    fr->AddFuzzyRule(rule8);
    fr->AddFuzzyRule(rule9);
 
    AddLinguisticVariables(xposition);
    AddLinguisticVariables(xvelocity);
    AddLinguisticVariables(thrust);
  }

  void AddLinguisticVariables(LinguisticVariable* p_linguisticVariable)
  {
    h_linguisticVariablesHashMap.insert(LinguisticVariable_Pairs(p_linguisticVariable->ToString(), p_linguisticVariable));
  }

  LinguisticVariable* FindLinguisticVariableByName(std::string variableName)
  {
    unordered_map <std::string, LinguisticVariable*> :: const_iterator iterator;
    iterator = h_linguisticVariablesHashMap.find(variableName);
    return (LinguisticVariable*)iterator->second;
  }
};
}

