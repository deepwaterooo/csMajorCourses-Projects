#include<iostream>
#include<cstdlib>
#include "node.h"
using namespace std;

const double CONST_LIMIT = 10.0;

void node::copy(node *source){  // parent pointer?
    type = source->type;
    const_value = source->const_value;

    if (type < NUM_NON_TERMS) {   // always true
        for(int i =0; i < MAX_ARITY; i++){
            if(source->branches[i] != NULL){		
                branches[i] = new node;
                branches[i]->copy(source->branches[i]);
            } else            
                branches[i] = NULL;
        }
    }
}

void node::copy(node* dst, node *source){  // parent pointer?
    dst->type = source->type;
    dst->const_value = source->const_value;
    if (dst->type < NUM_NON_TERMS) {   // always true
        for(int i =0; i < MAX_ARITY; i++){
            if(source->branches[i] != NULL){		
                dst->branches[i] = new node;
                copy(dst->branches[i], source->branches[i]);
            } else            
                dst->branches[i] = NULL;
        }
    }
}

void node::erase(void){
    if(type<NUM_NON_TERMS){
        for(int i = 0; i < MAX_ARITY; i++)
            if(branches[i] != NULL)
                branches[i]->erase();
    }
    delete this;
}

void node::full(int depth, int max, node *p){  
    parent = p;      
    if(depth >= max) 
        type = NUM_NON_TERMS + rand() % NUM_TERMS;
    else {            
        type=rand() % NUM_NON_TERMS;
        switch (type){
        case add:	
        case subtract:	
            for(int i =0; i < 2; i++){
                branches[i] = new node;
                branches[i]->full(depth+1,max,this);
            }
            for(int i=2;i<MAX_ARITY;i++)  // initially make all branches NULL
                branches[i] = NULL;
            break;
        case multiply:
            for(int i =0; i < 2; i++){
                branches[i] = new node;
                branches[i]->full(depth+1,max,this);
            }
            for(int i=2;i<MAX_ARITY;i++)  // initially make all branches NULL
                branches[i] = NULL;
            break;
        case divide:
            for(int i =0; i < 2; i++){
                branches[i] = new node;
                branches[i]->full(depth+1,max,this);
            }
            for(int i=2;i<MAX_ARITY;i++)  // initially make all branches NULL
                branches[i] = NULL;
            break;
            /*
        case constt:
            for(int i=0; i < MAX_ARITY;i++)  // initially make all branches NULL
                branches[i] = NULL;
            break;
            */
        default:
            cout << "Unknown case in full"  << endl;
        }
    }
    if(type == constt) 
    {
        const_value = double(rand()%10000/10000.0 * 2.0 * CONST_LIMIT) - (CONST_LIMIT/2.0);    
    }
}


double node::evaluate(double X){
	double l,r;
	switch(type) {
    case add:    
        l=branches[0] -> evaluate(X);
        r=branches[1] -> evaluate(X);
        return l+r;
    case subtract:
        l=branches[0] -> evaluate(X);
        r=branches[1] -> evaluate(X);
        return(l-r);
    case multiply:   
        l=branches[0] -> evaluate(X);
        r=branches[1] -> evaluate(X);
        return l*r;
    case divide: 
        l=branches[0] -> evaluate(X);
        r=branches[1] -> evaluate(X);
        float result;
        if ( r < 0.00001 && r > -0.00001 )
            result = -1.0;
        else
            result = l/r;
        return result;
    case inputX: // X
        return X;
    case constt:
        return(const_value);
    default:
        cout << "Error, unknown instruction " << type << endl;
	}
}

void node::calc_size(int &terms, int &non_terms){
	if(type >= NUM_NON_TERMS){	// count size
		++terms;
		return;
	} else {
        ++non_terms;
		for(int i=0;i<MAX_ARITY;++i){
			if(branches[i] != NULL){
				branches[i]->calc_size(terms,non_terms);
			}
		}
	}
}
