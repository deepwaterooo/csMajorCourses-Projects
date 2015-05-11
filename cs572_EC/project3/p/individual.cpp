#include<iostream>
#include<cmath>
#include<cstdlib>
#include <fstream>
#include "node.h"
#include "ant.h"
#include "individual.h"
using namespace std;

const double CONST_LIMIT = 10.0;

const int NUM_POINTS = 5;
float inputs[NUM_POINTS] = {1,2,3,4,5};
float outputs[NUM_POINTS] = {1,4,9,16,25};

static float avgTgt;
float evoOut[NUM_POINTS];

float genNum = 10.0;

Individual& Individual::operator=(Individual &rhs) {
    return *this;
}

bool Individual::condition(int cnt, int& ori) {
    if (ori < cnt)
        return true;
    else
        return false;
}

void getAvgTarget() {
    float sum = 0;
    for (int i = 0; i < NUM_POINTS; ++i)
        sum += outputs[i];
    avgTgt = sum / NUM_POINTS;
}

int Individual::evaluate(int cnt){
    the_indiv->ant1.reset();
    int cnnt = cnt;
    int tmp = the_indiv->evaluate(cnnt);
    while(tmp > 0) {
        cnnt = the_indiv->evaluate(tmp);
        tmp = cnnt;
    }
    //cout << "tmp: " << tmp << endl;
    fitness = the_indiv->ant1.fitness;
    return the_indiv->ant1.fitness;
}

int Individual::getFitness() {
    int cnt = step;
    calc_size();
    evaluate(cnt);
    //cout << "ant1.fitness: " << the_indiv->ant1.fitness << endl;
    return fitness;
}

void Individual::evaluate_print(void){
	fitness = 0;
	fitness = sqrt(fitness);
    return;
}

void Individual::mutate(node* tmp, float mutRate) {
    int type;
    if (!tmp) {
        if (tmp && rand()% 100/100.0 < mutRate)  {
            if (tmp->type < NUM_NON_TERMS )  {
                type = rand() % NUM_NON_TERMS;
                while (type == tmp->type)               
                    type = rand() % NUM_NON_TERMS; 
                tmp->type = type;
                for (int i = 0; i < MAX_ARITY; ++i)
                    mutate(tmp->branches[i], mutRate);
            } else {
                type = NUM_NON_TERMS + rand() % NUM_TERMS;
                while ( type == tmp->type)
                    type = NUM_NON_TERMS + rand() % NUM_TERMS;
                tmp->type = type;
            }
        } else if (tmp) {    
            switch(tmp->type) {
            case 0: //pro2:
            case 2: // ifFoodAhead:
                for (int i = 0; i < 2; ++i)
                    mutate(tmp->branches[i], mutRate);
                break;
            case 1: // pro3:
                for (int i = 0; i < MAX_ARITY; ++i)
                    mutate(tmp->branches[i], mutRate);
                break;
            }
        }
    }
    int cnt = step;
    the_indiv->evaluate(cnt);
}

void Individual::erase(node* p){
    if (p != NULL)  {
        if (p->type < NUM_NON_TERMS) {
            switch(p->type) {
            case 0:
            case 2:
                for(int i = 0; i < 2; i++)
                    p->branches[i]->erase();
                break;
            case 1:
                for(int i = 0; i < 3; i++)
                    p->branches[i]->erase();
                break;
            }
        }
        if (p == the_indiv);
        else
            delete p;
    }
}

void Individual::copy(node* src)  {
    the_indiv = NULL;  // added here
    the_indiv = new node;
    the_indiv->parent = NULL;
    node* newPtr = the_indiv;
    node * tmp = src;
    the_indiv->copy(newPtr, tmp);
}

void Individual::copy(Individual& dst)  {
    if (this != &dst)  {
        dst.fitness = fitness;
        dst.size = size;
        dst.terms = terms;
        dst.non_terms = non_terms;
        node* newPtr = dst.the_indiv;
        node * tmp = the_indiv;
        (dst.the_indiv)->copy(newPtr, tmp); // segmentation fault
    }
}

Individual Individual::copy()  {
    Individual newtree;
    newtree.fitness = fitness;
    newtree.size = size;
    newtree.terms = terms;
    newtree.non_terms = non_terms;

    newtree.the_indiv = new node;
    node* newPtr = newtree.the_indiv;
    node * tmp = the_indiv;
    the_indiv->copy(newPtr, tmp);
    return newtree;
}

void Individual::generate(int max_depth){
    the_indiv->ant1.reset();
    step = 600;
	the_indiv = new node;
    the_indiv->parent = NULL;
	the_indiv->full(0, max_depth,NULL);
}

string genTab(int cnt)  {
    string s = "";
    for (int i = 0; i < cnt; ++i)
        s.append("\t");
    return s;
}

void Individual::print(node* p, int depth)  {
    string s;
    if (p != NULL)  {    
        s = genTab(depth);
        switch(p->type) {
        case 0:
            cout << s << "P2->" << p->type << endl;
            for (int i = 0; i < 2; ++i)
                print(p->branches[i], depth+1);
            break;            
        case 1:
            cout << s << "P3->" << p->type << endl;
            for (int i = 0; i < 3; ++i)
                print(p->branches[i], depth+1);
            break;            
        case 2:
            cout << s << "iFA->" << p->type << endl;
            for (int i = 0; i < 2; ++i)
                print(p->branches[i], depth+1);
            break;            
        case 3: //left:
            cout << s << "L->" << p->type << endl;
            break;            
        case 4: // right:
            cout << s << "R->" << p->type << endl;
            break;            
        case 5: // forward:
            cout << s << "F->" << p->type << endl;
            break;            
        }
        /*
        for (int i = 0; i < MAX_ARITY; ++i)
            print(p->branches[i], depth+1);
        */
    }
}

void Individual::calc_size(void){
	terms = 0;
	non_terms = 0;
	size = 0;
    node* tmp = the_indiv;
    tmp->calc_size(terms,non_terms);
	size += (terms + non_terms);
}

void Individual::getTermNodePtr(node* tmp, int &myterm, int& cnt)  {
    twoPtr pair;
    if (tmp != NULL) {
        if(tmp->type >= NUM_NON_TERMS){	// count size
            if (myterm == 0)  {
                pair.cld = tmp;
                pair.prt = tmp->parent;
                term[cnt] = pair;
                cnt++;
            }
            --myterm;
        } else {
            switch(tmp->type) {
            case 0:
            case 2:
                for(int i = 0; i < 2; i++)
                    getTermNodePtr(tmp->branches[i], myterm, cnt);
                break;
            case 1:
                for(int i = 0; i < 3; i++)
                    getTermNodePtr(tmp->branches[i], myterm, cnt);
                break;
            }
        }
    }
}

void Individual::getNonTermNodePtr(node* tmp, int &mynonterm, int& cnt)  {
    twoPtr pair;
    if (tmp != NULL) {    
        if(tmp->type >= NUM_NON_TERMS){	// count size
            ;
        } else {
            if (mynonterm == 0)  {
                pair.cld = tmp;
                pair.prt = tmp->parent;
                nonterm[cnt] = pair;
                cnt++;
            }
            --mynonterm;
            switch(tmp->type) {
            case 0:
            case 2:
                for(int i = 0; i < 2; i++)
                    getNonTermNodePtr(tmp->branches[i], mynonterm, cnt);
                break;
            case 1:
                for(int i = 0; i < 3; i++)
                    getNonTermNodePtr(tmp->branches[i], mynonterm, cnt);
                break;
            }
        }
    }
}

void Individual::getNodePtr(node* tmp, int &myterm, int& cnt) {
    twoPtr pair;
    if (!tmp) {
        if(tmp->type >= NUM_NON_TERMS){	// count size
            if (myterm == 0)  {
                pair.cld = tmp;
                pair.prt = tmp->parent;
                together[cnt] = pair;
                cnt++;
            }
            --myterm;
        } else {
            if (myterm == 0) 
            {
                //cout << "non-term tmp: " << tmp << endl;
                pair.cld = tmp;
                pair.prt = tmp->parent;
                together[cnt] = pair;
                cnt++;
                //return tmp;
            }
            switch(tmp->type) {
            case 0:
            case 2:
                for(int i = 0; i < 2; i++)
                    getTermNodePtr(tmp->branches[i], myterm, cnt);
                break;
            case 1:
                for(int i = 0; i < 3; i++)
                    getTermNodePtr(tmp->branches[i], myterm, cnt);
                break;
            }
        }
    }
}

