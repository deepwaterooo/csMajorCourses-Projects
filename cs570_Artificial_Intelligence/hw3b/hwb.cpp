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


//*********************************************************************************************
//Typedef for linguistic values hash map.   
typedef pair <string, LinguisticValue*> LinguisticValue_Pairs;
class LinguisticVariable
{
private:
  string variableName;  //Variable name
  bool b_output; //Is variable input or output
  //Hash table of linguistic values
  hash_map <string, LinguisticValue*> h_linguisticValuesHashMap;
public:
  LinguisticVariable(bool nOutput, string nVariableName)  //Default constructor
  {
    b_output = nOutput;
    variableName = nVariableName;
  }
  ~LinguisticVariable(void)  //Destructor
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
  //Method add Linguistic value to hash map
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
	temp->SetLinguisticValue(-1);    // by default it is -1, LinguisticValue class
	iterator++;
      }
  }

  LinguisticValue* FindLinguisticValueByNames(string name)
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
    LinguisticValue* value = FindLinguisticValueByName(name);    // defined previously
    return value->CalculateLinguisticValue(input);
  }

  //Update Linguistic value by name
  void UpdateLinguisticValueByName(string name, double newVal)
  {
    //Find LinguisticValue
    LinguisticValue* value = FindLinguisticValueByName(name);

    //If there is value, we should perform operator OR     ********************************************** this is the part I need to modify to better satisfy mine
    if(value->GetLinguisticValue() != -1)
      value->SetLinguisticValue(FuzzyCalculator::OR(value->GetLinguisticValue(), newVal));
    else
      value->SetLinguisticValue(newVal); //There is no value, just set newVal
  }

  //Getters
  bool IsOutputVariable(){return b_output;}
  string ToString(){return variableName;}
};


enum Operation{
  AND,OR,EMPTY
};


class FuzzyRuleToken
{
  //Is there operator before token
  Operation operation;
  //Is there negation for this token
  bool b_negation;
  //Pointer to linguistic variable
  LinguisticVariable* p_linguisticVariable;
  //Name of Linguistic value
  string linguisticValueName;
public:
  //Constructor
  FuzzyRuleToken(bool nNegation, 
		  Operation nOperation, 
		  LinguisticVariable* nLinguisticVariable, 
		  string nLinguisticValueId)
  {
    b_negation = nNegation;
    operation = nOperation;
    p_linguisticVariable = nLinguisticVariable;
    linguisticValueName = nLinguisticValueId;
  }
  ~FuzzyRuleToken(void){}
  
  //Calculate token value
  double CalculateTokenOutputValue(hash_map <string, FuzzyInput*> h_fuzzyInputHashMap)
  {
    hash_map <string, CFuzzyInput*> :: const_iterator iterator;
    //Find linguistic variable
    iterator = h_fuzzyInputHashMap.find(p_linguisticVariable->ToString());
    FuzzyInput* temp = (FuzzyInput*)iterator->second;
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

  void AddTokenToRule(CFuzzyRuleToken* fuzzyRuleToken)
  {
    v_fuzzyRuleTokens.push_back(fuzzyRuleToken);
  }
  //Return fuzzy tokens
  vector<FuzzyRuleToken*> GetFuzzyRuleTokens(){return v_fuzzyRuleTokens;}
};


class FuzzyReasoner
{
  //Vector of Fuzzy rules
  vector<CFuzzyRule*> v_fuzzyRulesVector; 
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
  FuzzyRuleToken* CalculateFuzzyRules(hash_map <string, FuzzyInput*> h_fuzzyInputs)
  {
    //Reset all values
    FuzzyRuleToken* outputObject;
    //Calculate all fuzzy rules
    for(unsigned int i = 0; i < v_fuzzyRulesVector.size(); i++)
      {
	//Glede na izhodno vrednost izhodne spremeljivke naredi update izhodnega objekta
	outputObject = FuzzyRuleReasoner((FuzzyRule*)v_fuzzyRulesVector[i], h_fuzzyInputs);
      }
    //Return output object
    return outputObject;
  }

  //Start fuzzy rule reasoner
  FuzzyRuleToken* FuzzyRuleReasoner(FuzzyRule* fuzzyRule, hash_map <string, FuzzyInput*> h_fuzzyInputs)
  {
    double resultVal = 0;
    for(unsigned int i = 0; i < fuzzyRule->GetFuzzyRuleTokens().size(); i++)
      {
	//Get fuzzy rule token
	FuzzyRuleToken* token = fuzzyRule->GetFuzzyRuleTokens()[i];

	if(token->IsOutput())
	  {
	    //Update output object
	    token->UpdateTokenValue(resultVal);
	    //Return result token
	    return token;
	  }
	else
	  {
	    double tokenVal = token->CalculateTokenOutputValue(h_fuzzyInputs);
	    token->UpdateTokenValue(tokenVal);
	    if(token->IsNegated())
	      tokenVal = 1 - tokenVal;	//Negate value
	    if(i == 0)
	      resultVal = tokenVal;		//Set value
	    else if(token->IsOrOperator())
	      resultVal = CFuzzyCalculator::OR(resultVal, tokenVal); //OR operator
	    else if(token->IsAndOperator())
	      resultVal = CFuzzyCalculator::AND(resultVal, tokenVal); //AND operator

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



typedef pair <string, CLinguisticVariable*> LinguisticVariable_Pairs;
class Experiments
{
  //FuzzyReasoner instance
  FuzzyReasoner* fr;
  FuzzyRuleToken* outputToken;
  hash_map <string, CLinguisticVariable*> h_linguisticVariablesHashMap;
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
  double CalculateFuzzyRules(hash_map <string, FuzzyInput*> h_fuzzyInputs)
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

  double GetA_ByName(string variableName, string valueName){
    CLinguisticVariable* temp = FindLinguisticVariableByName(variableName);
    return temp->FindLinguisticValueByName(valueName)->GetA();
  }
  double GetB_ByName(string variableName, string valueName){
    CLinguisticVariable* temp = FindLinguisticVariableByName(variableName);
    return temp->FindLinguisticValueByName(valueName)->GetB();
  }

  double GetC_ByName(string variableName, string valueName) {
    CLinguisticVariable* temp = FindLinguisticVariableByName(variableName);
    return temp->FindLinguisticValueByName(valueName)->GetC();
  }
  double GetD_ByName(string variableName, string valueName) {
    CLinguisticVariable* temp = FindLinguisticVariableByName(variableName);
    return temp->FindLinguisticValueByName(valueName)->GetD();
  }

  double GetLinguisticVariableValue(string variableName, string valueName){
    CLinguisticVariable* temp1 = FindLinguisticVariableByName(variableName);
    assert(temp1 != NULL);
    return temp1->FindLinguisticValueByName(valueName)->GetLinguisticValue();
  }

  void BuildCruiseControlRules()  // BuildMoonLanderRules
  {
    //Method for building necessary rules for Cruise Control
    LinguisticVariable *distance = new CLinguisticVariable(false,"Distance");
    LinguisticVariable *approaching = new CLinguisticVariable(false,"Approaching");
    LinguisticVariable *speed = new CLinguisticVariable(false,"Speed");
    LinguisticVariable *signal = new LinguisticVariable(true,"Signal");

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
    FuzzyRule* rule1 = new FuzzyRule();
    rule1->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, distance,"Low"));
    rule1->AddTokenToRule(new FuzzyRuleToken(true,AND, approaching,"Slow"));
    rule1->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, signal,"Brake"));

    //Rule2
    FuzzyRule* rule2 = new FuzzyRule();
    rule2->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, distance,"Average"));
    rule2->AddTokenToRule(new FuzzyRuleToken(false,AND, approaching,"Fast"));
    rule2->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, signal,"Brake"));

    //Rule3
    FuzzyRule* rule3 = new FuzzyRule();
    rule3->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, speed,"Fast"));
    rule3->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, signal,"Brake"));
    //Rule4
    FuzzyRule* rule4 = new FuzzyRule();
    rule4->AddTokenToRule(new FuzzyRuleToken(true,EMPTY, distance,"Low"));
    rule4->AddTokenToRule(new FuzzyRuleToken(false,AND, approaching,"Average"));
    rule4->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, signal,"Maintain"));
    //Rule5
    FuzzyRule* rule5 = new FuzzyRule();
    rule5->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, distance,"High"));
    rule5->AddTokenToRule(new FuzzyRuleToken(true,AND, approaching,"Fast"));
    rule5->AddTokenToRule(new FuzzyRuleToken(false,AND, speed,"Acceptable"));
    rule5->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, signal,"Maintain"));
    //Rule6
    FuzzyRule* rule6 = new FuzzyRule();
    rule6->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, distance,"Average"));
    rule6->AddTokenToRule(new FuzzyRuleToken(false,AND, speed,"Slow"));
    rule6->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, signal,"Maintain"));
    //Rule7
    FuzzyRule* rule7 = new FuzzyRule();
    rule7->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, distance,"High"));
    rule7->AddTokenToRule(new FuzzyRuleToken(false,AND, speed,"Slow"));
    rule7->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, signal,"Accelerate"));

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
    LinguisticVariable *height = new LinguisticVariable(false,"Height");
    LinguisticVariable *age = new LinguisticVariable(false,"Age");
    LinguisticVariable *basketball_player = new LinguisticVariable(true,"Basketball_player");

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
    FuzzyRule* rule1 = new FuzzyRule();
    rule1->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, age,"Young"));
    rule1->AddTokenToRule(new FuzzyRuleToken(false,AND, height,"Tall"));
    rule1->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, basketball_player,"Suitable"));

    //Rule2
    //IF age = "Old" THEN basketball_player = "Unsuitable"
    FuzzyRule* rule2 = new FuzzyRule();
    rule2->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, age,"Old"));
    rule2->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, basketball_player,"Unsuitable "));

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
    LinguisticVariable *height = new LinguisticVariable(false,"Height");
    LinguisticVariable *weight = new LinguisticVariable(false,"Weight");
    LinguisticVariable *ski_jumper = new LinguisticVariable(true,"Ski_jumper");

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
    FuzzyRule* rule1 = new FuzzyRule();
    rule1->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"Tall"));
    rule1->AddTokenToRule(new FuzzyRuleToken(false,AND, weight,"High_weight"));
    rule1->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, ski_jumper,"Unsuitable "));

    //Rule2
    FuzzyRule* rule2 = new FuzzyRule();
    rule2->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"Low_height"));
    rule2->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, ski_jumper,"Unsuitable "));

    //Rule3
    FuzzyRule* rule3 = new FuzzyRule();
    rule3->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"Average_height"));
    rule3->AddTokenToRule(new FuzzyRuleToken(true,AND, weight,"Low_weight"));
    rule3->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, ski_jumper,"Very_unsuitable"));

    //Rule4
    FuzzyRule* rule4 = new FuzzyRule();
    rule4->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"Average_height"));
    rule4->AddTokenToRule(new FuzzyRuleToken(false,AND, weight,"Low_weight"));
    rule4->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, ski_jumper,"Suitable"));

    //Rule5
    FuzzyRule* rule5 = new FuzzyRule();
    rule5->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"Tall"));
    rule5->AddTokenToRule(new FuzzyRuleToken(false,AND, weight,"Average_weight"));
    rule5->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, ski_jumper,"Suitable"));

    //Rule6
    FuzzyRule* rule6 = new FuzzyRule();
    rule6->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, height,"Tall"));
    rule6->AddTokenToRule(new FuzzyRuleToken(false,AND, weight,"Low_weight"));
    rule6->AddTokenToRule(new FuzzyRuleToken(false,EMPTY, ski_jumper,"Very_suitable"));
			
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

  void AddLinguisticVariables(LinguisticVariable* p_linguisticVariable)
  {
    h_linguisticVariablesHashMap.insert(LinguisticVariable_Pairs(p_linguisticVariable->ToString(), p_linguisticVariable));
  }

  LinguisticVariable* FindLinguisticVariableByName(string variableName)
  {
    hash_map <string, LinguisticVariable*> :: const_iterator iterator;
    iterator = h_linguisticVariablesHashMap.find(variableName);
    return (LinguisticVariable*)iterator->second;
  }
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


  //Create instance of Experiments.
  Experiments* experiment = new Experiments();
  //Create rules
  experiment->BuildCruiseControlRules();

  //Hash_map for storing inputs
  hash_map <string, FuzzyInput*> h_fuzzyInputs;
	
  //Put some values to inputs
  FuzzyInput* inputRazdalja = new FuzzyInput("Distance", 1.8);
  FuzzyInput* inputPriblizevanje = new FuzzyInput("Approaching", 15);
  FuzzyInput* inputHitrost = new FuzzyInput("Speed", -8);
	
  //Insert inputs to the hash_map
  h_fuzzyInputs.insert(FuzzyInput_Pairs(inputRazdalja->GetVariableName(), inputRazdalja));
  h_fuzzyInputs.insert(FuzzyInput_Pairs(inputPriblizevanje->GetVariableName(), inputPriblizevanje));
  h_fuzzyInputs.insert(FuzzyInput_Pairs(inputHitrost->GetVariableName(), inputHitrost));

  //Calculate fuzzy Logic output signal
  double outputSignal = experiment->CalculateFuzzyRules(h_fuzzyInputs);
	
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





}
