#include<iostream>
#include<cmath>
using namespace std;
#include"individual.h"

const int NUM_POINTS = 5;
float inputs[NUM_POINTS] = {1,2,3,4,5};
float outputs[NUM_POINTS] = {1,4,9,16,25};

Individual& Individual::operator=(Individual &rhs) {
    /*
    if (this != &rhs) 
    {
        fitness = rhs.fitness;
        size = rhs.size;
        terms = rhs.terms;
        non_terms = rhs.non_terms;

        //the_indiv = rhs.the_indiv;
        node* newPtr = the_indiv;
        node* tmp = rhs.the_indiv;
        node::copy(newPtr, tmp);
    }
    */
    return *this;
}

void Individual::erase(void){
	the_indiv -> erase();
}

Individual Individual::copy() 
{
    Individual newtree;
    newtree.fitness = fitness;
    newtree.size = size;
    newtree.terms = terms;
    newtree.non_terms = non_terms;
    //cout << "newtree the_indv: " << newtree.the_indiv << endl;

    newtree.the_indiv = new node;
    //cout << "root address: " << newtree.the_indiv << endl;

    node* newPtr = newtree.the_indiv;
    node * tmp = the_indiv;
    node::copy(newPtr, tmp);
    return newtree;
}

void Individual::generate(int max_depth){
	the_indiv = new node;
	the_indiv->full(0,max_depth,NULL);
}

string genTab(int cnt) 
{
    string s = "";
    for (int i = 0; i < cnt; ++i)
        s.append("\t");
    return s;
}

void Individual::print(node* p, int depth) 
{
    string s;
    if (p != NULL) 
    {
        s = genTab(depth);
        //cout << "p->type: " << p->type << endl;
        
        switch(p->type) 
        {
        case add:
            cout << s << "+" << p->type << endl;
            break;
        case subtract:
            cout << s << "-" << p->type << endl;
            break;
        case multiply:
            cout << s << "*" << p->type << endl;
            break;
        case divide:
            cout << s << "/" << p->type << endl;
            break;
        case inputX:
            cout << s << "X" << p->type << endl;
            break;
        case constt:
            cout << s << p->getVal() << endl;
            break;
        }
        for (int i = 0; i < MAX_ARITY; ++i)
            print(p->branches[i], depth+1);
    }
}

void Individual::calc_size(void){
	terms = 0;
	non_terms = 0;
	size = 0;
    //cout << "Individual the_indiv->type: " << the_indiv->type << endl;
    //cout << "(*the_indiv).type: " << (*the_indiv).type << endl;
    
	//the_indiv->calc_size(terms,non_terms);
    node* tmp = the_indiv;
    tmp->calc_size(terms,non_terms);
    
	size += (terms + non_terms);
    //cout << "calc size: " << size << endl;
}

void Individual::evaluate(void){  
	fitness = 0;
	float output;
	for(int j=0; j < NUM_POINTS; j++){
		output = the_indiv-> evaluate(inputs[j]);
		fitness += (pow((output-outputs[j]),2));
	}
	fitness = sqrt(fitness);
}

void Individual::evaluate_print(void){
	fitness = 0;
	float output;
	for(int j=0; j < NUM_POINTS; j++){
		output = the_indiv-> evaluate(inputs[j]);
		fitness += (pow((outputs[j]-output),2));
		cout << inputs[j] << "," << output << "," << outputs[j] << " , " ;
	}
	fitness = sqrt(fitness);
	cout << endl << "Fitness = " << fitness << "\t size: " << getSize() << endl;
}
