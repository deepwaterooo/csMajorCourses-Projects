#include<iostream>
#include<cstdlib>
#include<cmath>
#include "ant.h"
#include "node.h"
using namespace std;
const double CONST_LIMIT = 10.0;

ant node::ant1 = ant();

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
    if (source != NULL)  {
        dst->type = source->type;   // segmentation fault here
        dst->const_value = source->const_value;
        if (dst->type < NUM_NON_TERMS) {   // always true
            switch(dst->type) {
            case 0:
            case 2:
                for(int i =0; i < 2; i++){
                    if(source->branches[i] != NULL){		
                        dst->branches[i] = new node;
                        dst->branches[i]->parent = dst;  // modified here
                        copy(dst->branches[i], source->branches[i]);
                    }
                }
                break;
            case 1:                
                for(int i =0; i < MAX_ARITY; i++){
                    if(source->branches[i] != NULL){		
                        dst->branches[i] = new node;
                        dst->branches[i]->parent = dst;  // modified here
                        copy(dst->branches[i], source->branches[i]);
                    } else 
                        dst->branches[i] = NULL;
                }
                break;
            }
        } else if (dst->type >= NUM_NON_TERMS)  // here and followed
            for (int i = 0; i < MAX_ARITY; ++i)
                dst->branches[i] = NULL;   
    }
}

void node::erase(void){
    if(this != NULL) {
        if(type < NUM_NON_TERMS){
            switch(type) {
            case 0:
            case 2:
                for(int i = 0; i < 2; i++)
                    branches[i]->erase();
                break;
            case 1:
                for(int i = 0; i < 3; i++)
                    branches[i]->erase();
                break;
            }
        }
        delete this;
    }
}

void node::full(int depth, int max, node *p){  
    parent = p;      
    if(depth >= max) 
        type = NUM_NON_TERMS + rand() % NUM_TERMS;
    else {            
        type=rand() % NUM_NON_TERMS;
        switch (type){
        case pro2:
        case isFoodAhead:
            for(int i=0;i<2;i++) {
                branches[i] = new node;
                branches[i]->full(depth+1,max,this);
            }
            for(int i=2;i<MAX_ARITY;i++)
                branches[i] = NULL;
            break;
        case pro3:
            for(int i =0; i < MAX_ARITY; i++){
                branches[i] = new node;
                branches[i]->full(depth+1,max,this);
            }
            break;
        default:
            cout << "Unknown case in full"  << endl;
        }
    }
    if (type == 3 ) {
        for (int i = 0; i < MAX_ARITY; ++i)
            branches[i] = NULL;
        ant1.left();
    } else if (type == 4) {
        for (int i = 0; i < MAX_ARITY; ++i)
            branches[i] = NULL;
        ant1.right();
    } else if (type == 5) {
        for (int i = 0; i < MAX_ARITY; ++i)
            branches[i] = NULL;
        ant1.forward();
    }
}

int node::evaluate(int &step){
    if (this != NULL) {    
        switch(type) {
        case 0:    
            branches[0] -> evaluate(step);
            branches[1] -> evaluate(step);
            break;
        case 1:
            branches[0] -> evaluate(step);
            branches[1] -> evaluate(step);
            branches[2] -> evaluate(step);
            break;
        case 2:
            branches[0] -> evaluate(step);
            branches[1] -> evaluate(step);
            break;
        case 3: // left
            ant1.left();
            --step;
            if (step == 0) return 0;
            break;
        case 4: // right
            ant1.right();
            --step;
            if (step == 0) return 0;
            break;
        case 5: // forward
            ant1.forward();
            --step;
            if (step == 0) return 0;
            break;
        default:
            cout << "Error, unknown instruction " << type << endl;
        }
    }
    return step;
}

void node::calc_size(int &terms, int &non_terms){
    if (this != NULL) {        
        if(type >= NUM_NON_TERMS) {	// count size
            ++terms;
            return;
        } else {
            ++non_terms;
            switch(type) {
            case 0:
            case 2:
                for(int i = 0; i < 2; i++)
                    branches[i]->calc_size(terms, non_terms);
                break;
            case 1:
                for(int i = 0; i < 3; i++)
                    branches[i]->calc_size(terms, non_terms);
                break;
            }
        }
    }
}

