// CS570         Project 4
// Heyan Huang   April 23, 2013

#include <iostream>  
#include <fstream>
#include <sstream>
#include <string>  
#include <vector>  
#include <map>  
#include <algorithm>  
#include <cmath>  
using namespace std;
#define MAXLEN 9
            
int trainobs = 21; 
int testobs = 79;

vector <vector <string> > train(101, vector<string>(9));
vector <vector <string> > state(trainobs+1, vector<string>(9));
vector <vector <string> > test(testobs+1, vector<string>(9));

vector <string> item;
vector <string> attribute_row;
vector <string> remain_attribute; 
vector <string> test_attribute; 

string end("end");
string yes("Yes");  
string no("No");  
string blank("");  

map<string,vector < string > > map_attribute_values;
int tree_size = 0;  
int miscnt = 0;
int testmiscnt = 0;
int binarymis = 0;
int defyes = 0;
int defno = 0;

int PopuCnt = 0; 
string PopuLabel;
int totalcnt = 0;
int rootcnt = 0;

struct Node {
    string attribute;
    string arrived_value;
    vector<Node *> childs;
    bool isLeaf; 
    int cnt;
    double informgain;
    Node(){  attribute = blank;  arrived_value = blank; informgain = 0; isLeaf = false; cnt = 0;}  
};  
typedef Node* nodePtr;
Node * root;  

void Input();
//void ComputeMapFrom2DVector();
void ComputeMapFrom2DVector( vector <vector <string> > state );
double ComputeEntropy(vector <vector <string> > remain_state, string attribute, string value,bool ifparent);
double ComputeGain(vector <vector <string> > remain_state, string attribute);
int FindAttriNumByName(string attri);
bool AllTheSameLabel(vector <vector <string> > remain_state, string label);
string MostCommonLabel(vector <vector <string> > remain_state);
int MisClassifyCnt(vector <vector <string> > remain_state);
Node * BulidDecisionTreeDFS(Node * p, vector <vector <string> > remain_state, vector <string> remain_attribute);
void PrintTree(Node *p, int depth);
void FreeTree(Node *p);
void testDataOnDecisionTree( vector <string> remain_attribute, Node* nodePtr, vector <vector <string> > test, string defaultClass);
void TrainTest();
int returnIndexOfVector( vector <string> stringVector, string value);

//*******************************************************************************
//******************** Main Program *********************************************
//*******************************************************************************
int main(){  
    Input();  
    TrainTest();
    string Example("Example");  
    string FamSit("FamSit");  
    string InaHur("InaHur");  
    string LongDel("LongDel");  
    string SafSit("SafSit");
    string Confident("Confident");
    string SafCriDec("SafCriDec");
    string AskdBef("AskdBef");
    string Decision("Decision");
    attribute_row.push_back(Example);
    attribute_row.push_back(FamSit);  
    attribute_row.push_back(InaHur);  
    attribute_row.push_back(LongDel);  
    attribute_row.push_back(SafSit);  
    attribute_row.push_back(Confident);  
    attribute_row.push_back(SafCriDec);  
    attribute_row.push_back(AskdBef);  
    attribute_row.push_back(Decision);  

    remain_attribute.push_back("FamSit");  
    remain_attribute.push_back("InaHur");  
    remain_attribute.push_back("LongDel");  
    remain_attribute.push_back("SafSit");  
    remain_attribute.push_back("Confident");  
    remain_attribute.push_back("SafCriDec");  
    remain_attribute.push_back("AskdBef"); 

    vector <vector <string> > remain_state;  
    for(unsigned int i = 0; i < state.size(); i++){  
        remain_state.push_back(state[i]);   
    }  
    ComputeMapFrom2DVector(state);  
    //void ComputeMapFrom2DVector( vector <vector <string> > state, map<string,vector < string > > map_attribute_values ){

    root=BulidDecisionTreeDFS(root, remain_state, remain_attribute);
    cout << "the decision tree is: " << endl;
    PrintTree(root, 0);
    //FreeTree(root);
    cout<<endl;  
    test_attribute.push_back("FamSit");  
    test_attribute.push_back("InaHur");  
    test_attribute.push_back("LongDel");  
    test_attribute.push_back("SafSit");  
    test_attribute.push_back("Confident");  
    test_attribute.push_back("SafCriDec");  
    test_attribute.push_back("AskdBef"); 
    vector <vector <string> > test_state;  
    for(unsigned int i = 0; i < state.size(); i++){  
        test_state.push_back(test[i]);   
    }  
    testDataOnDecisionTree(test_attribute, root, test, PopuLabel);
    FreeTree(root);
    cout << "tree_size: " << tree_size << endl;
    cout << "the total observation count is: " << totalcnt << "." << endl;
    cout << "Total number of misclasification for TRAINING data is: " << miscnt << "." << endl;
    cout << "Total number of misclasification for TESTING data is: " << testmiscnt << "." << endl;
    return 0;  
}  

void testDataOnDecisionTree( vector <string> remain_attribute, Node* nodePtr, vector <vector <string> > test, string defaultClass){
    string prediction;
    for(unsigned int i = 1; i < test.size(); i++){
        Node * p = nodePtr;
        while (p->isLeaf != true ) {
            int index = FindAttriNumByName(p->attribute); // find column index from state array
            vector <string> values;
            for (vector <Node *>::iterator it3 = p->childs.begin(); it3 < p->childs.end(); it3++) { 
                values.push_back( (*it3)->arrived_value);
            }
            int childindex = returnIndexOfVector(values, test[i][index]);
            p = p->childs[childindex];
            if (p == NULL) {
                prediction = defaultClass;
                if (prediction != test[i][8])
                    testmiscnt += 1;
                break;
            }
        } // end while
        if (p->attribute != test[i][8]){
            testmiscnt += 1;  
        }
    } 
}

int returnIndexOfVector( vector <string> stringVector, string value) {
    int i;
    for (i = 0; i < stringVector.size(); i++) {
        if (stringVector[i] == value){
            return i;
        }
    }
    return -1;
}

Node * BulidDecisionTreeDFS(Node * p, vector <vector <string> > remain_state, vector <string> remain_attribute){  
    if (p == NULL)  
        p = new Node();  
    if (AllTheSameLabel(remain_state, yes)){  
        p->attribute = yes;  
        p->isLeaf = true;
        p->cnt = remain_state.size()-1;
        if (p->cnt > PopuCnt){
            PopuCnt = p->cnt; 
            PopuLabel = yes;
        } else if (p->cnt == PopuCnt && PopuLabel != yes)
            PopuLabel = "YesNo";
        return p;  
    }  
    if (AllTheSameLabel(remain_state, no)){  
        p->attribute = no;  
        p->isLeaf = true;
        p->cnt = remain_state.size()-1;
        if (p->cnt > PopuCnt){
            PopuCnt = p->cnt; 
            PopuLabel = no;
        } else if (p->cnt == PopuCnt && PopuLabel != no)
            PopuLabel = "YesNo";
        return p;  
    }  
    if(remain_attribute.size() == 0){  // end node with misclassifications
        string label = MostCommonLabel(remain_state);  
        int mis = MisClassifyCnt(remain_state);
        miscnt += mis;
        p->attribute = label;  
        p->isLeaf = true;
        p->cnt = remain_state.size()-1;
        if (p->cnt > PopuCnt){
            PopuCnt = p->cnt; 
            PopuLabel = label;
        } else if (p->cnt == PopuCnt && PopuLabel != label)
            PopuLabel = "YesNo";
        return p;  
    }

    double max_gain = 0, temp_gain; 
    vector <string>::iterator max_it = remain_attribute.begin();  
    vector <string>::iterator it1;  
    for(it1 = remain_attribute.begin(); it1 < remain_attribute.end(); it1++){  
        temp_gain = ComputeGain(remain_state, (*it1));  
        if(temp_gain > max_gain) {  
            max_gain = temp_gain;  
            max_it = it1;  
        }  
    }  
    vector <string> new_attribute;  
    vector <vector <string> > new_state;  
    for( vector <string>::iterator it2 = remain_attribute.begin(); it2 < remain_attribute.end(); it2++){  
        if( (*it2).compare(*max_it) ) new_attribute.push_back(*it2);  
    }  
    p->attribute = *max_it;  
    vector <string> values = map_attribute_values[*max_it];
    int attribue_num = FindAttriNumByName(*max_it);  
    new_state.push_back(attribute_row);  
    for(vector <string>::iterator it3 = values.begin(); it3 < values.end(); it3++) {  
        for(unsigned int i = 1; i < remain_state.size(); i++) {  
            if(!remain_state[i][attribue_num].compare(*it3)) {  
                new_state.push_back(remain_state[i]);  
            }  
        }  
        Node * new_node = new Node();  
        new_node->arrived_value = *it3;  
        if(new_state.size() == 1){
            new_node->attribute = MostCommonLabel(remain_state);  
            //new_node->isLeaf = true;
            new_node->cnt = new_state.size();
        } else   
            BulidDecisionTreeDFS(new_node, new_state, new_attribute);  
        p->childs.push_back(new_node);  
        new_state.erase(new_state.begin()+1,new_state.end());
    }  
    return p;  
}  

int MisClassifyCnt(vector <vector <string> > remain_state){  
    int p = 0, n = 0;  
    for(unsigned i = 0; i < remain_state.size(); i++){  
        if(!remain_state[i][MAXLEN-1].compare(yes)) p++;   // yes cnt
        else n++;                                          // no cnt
    }  
    if(p >= n) return n;   // labeled yes, return no_cnt
    else return p;          // labeded no, return yes_cnt
}  
     
void ComputeMapFrom2DVector( vector <vector <string> > state ){  
    unsigned int i,j,k;  
    bool exited = false;  
    vector<string> values;  
    for(i = 1; i < MAXLEN-1; i++){
        for (j = 1; j < state.size(); j++) {  
            for (k = 0; k < values.size(); k++) {  
                if(!values[k].compare(state[j][i])) exited = true;  
            }  
            if(!exited) {  
                values.push_back(state[j][i]);
            }  
            exited = false;  
        }  
        map_attribute_values[state[0][i]] = values;  
        values.erase(values.begin(), values.end());  
    }     
}  
      
double ComputeEntropy(vector <vector <string> > remain_state, string attribute, string value, bool ifparent){  
    std::vector<int> count (2,0);  
    unsigned int i,j;  
    bool done_flag = false;
    for(j = 1; j < MAXLEN-1; j++){  
        if(done_flag) break;  
        if(!attribute_row[j].compare(attribute)){  
            for(i = 1; i < remain_state.size(); i++){  
                if( ( !ifparent && !remain_state[i][j].compare(value) ) || ifparent ){
                    if(!remain_state[i][MAXLEN - 1].compare(yes)){count[0]++;  }  
                    else count[1]++;  
                }  
            }  
            done_flag = true;  
        }  
    }  
    if(count[0] == 0 || count[1] == 0 ) return 0;
    double sum = count[0] + count[1];  
    double entropy = -count[0]/sum*log(count[0]/sum)/log(2.0) - count[1]/sum*log(count[1]/sum)/log(2.0);  
    return entropy;  
}  
          
double ComputeGain(vector <vector <string> > remain_state, string attribute){  
    unsigned int j,k,m;  
    double parent_entropy = ComputeEntropy(remain_state, attribute, blank, true);  
    double children_entropy = 0;  
  
    vector<string> values = map_attribute_values[attribute];  
    vector<double> ratio;  
    vector<int> count_values;  
    int tempint;  
    for(m = 0; m < values.size(); m++){  
        tempint = 0;  
        for(k = 1; k < MAXLEN - 1; k++)
            {  
                if(!attribute_row[k].compare(attribute))
                    {  
                        for(j = 1; j < remain_state.size(); j++)
                            {  
                                if(!remain_state[j][k].compare(values[m]))
                                    {  
                                        tempint++;  
                                    }  
                            }  
                    }  
            }  
        count_values.push_back(tempint);  
    }  
          
    for(j = 0; j < values.size(); j++){  
        ratio.push_back( (double)count_values[j] / (double)(remain_state.size()-1));  
    }  
    double temp_entropy;  
    for(j = 0; j < values.size(); j++){  
        temp_entropy = ComputeEntropy(remain_state, attribute, values[j], false);  
        children_entropy += ratio[j] * temp_entropy;  
    }  
    return (parent_entropy - children_entropy);   
}  
      
int FindAttriNumByName(string attri){  
    for(int i = 1; i < MAXLEN-1; i++){  
        if(!state[0][i].compare(attri)) 
            return i;  
    }  
    cerr<<"can't find the numth of attribute"<<endl; 
    return 0;  
}  
      
string MostCommonLabel(vector <vector <string> > remain_state){  
    int p = 0, n = 0;  
    for(unsigned i = 0; i < remain_state.size(); i++){  
        if(!remain_state[i][MAXLEN-1].compare(yes)) p++;  
        else n++;  
    }  
    if(p >= n) return yes;  
    else return no;  
}  

bool AllTheSameLabel(vector <vector <string> > remain_state, string label){  
    int count = 0;  
    for(unsigned int i = 1; i < remain_state.size(); i++){  
        if(!remain_state[i][MAXLEN-1].compare(label)) count++;  
    }  
    if(count == remain_state.size()-1) return true;  
    else return false;  
}  
      
void PrintTree(Node *p, int depth){  
    for (int i = 0; i < depth; i++) cout << '\t';        
    if(!p->arrived_value.empty()){  
        cout<<p->arrived_value<<endl;  
        for (int i = 0; i < depth+1; i++) cout << '\t';   
    }  
    cout<<p->attribute;  
    //cout<<p->attribute<< "\t cnt:" << p->cnt << endl; 
    if ( (!p->attribute.compare(yes)) || (!p->attribute.compare(no)) )
		cout << "\t cnt:" << p->cnt << endl;
    else
		cout << endl;
    for (vector<Node*>::iterator it = p->childs.begin(); it != p->childs.end(); it++){  
        PrintTree(*it, depth + 1);  
    }  
}  

void FreeTree(Node *p){  
    if (p == NULL)  
        return;  
    //rootcnt = p->cnt;
    for (vector<Node*>::iterator it = p->childs.begin(); it != p->childs.end(); it++){  
        totalcnt += (*it)->cnt ;
        FreeTree(*it);  
    }  
    delete p;  
    tree_size++;  
}  

void Input() {
    ifstream infile("data1.txt");
    if (infile.is_open()) {
        for(int i = 0; i < 101; ++i){
            for(int j = 0; j < 9; ++j){
                infile>>train[i][j];
            }
        }
        infile.close();
    } else {
        cout << "Error opening file!" << endl;
    }
}

void TrainTest(){
    for(int i = 0; i <= trainobs; ++i){
        for(int j = 0; j < 9; ++j){
            state[i][j] = train[i][j];
        }
    }
    for (int x = 0; x < 9; x++)
        test[0][x] = train[0][x];
    for(int i = 1; i <= testobs; ++i){
        for(int j = 0; j < 9; ++j){
            test[i][j] = train[trainobs+i][j];
        }
    }
}

