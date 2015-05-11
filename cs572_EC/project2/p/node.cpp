#include<iostream>
#include<cstdlib>
#include<cmath>
#include "node.h"
using namespace std;

const double CONST_LIMIT = 10.0;

void node::copy(node *source){  // parent pointer?
    type = source->type;
    const_value = source->const_value;
    //parent = source->parent;

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
    if (source != NULL) 
    {
        //cout << "source address: " << source << endl;
        
        dst->type = source->type;   // segmentation fault here
        
        dst->const_value = source->const_value;

        //        cout << "node copy: " << endl;
    
        if (dst->type < NUM_NON_TERMS) {   // always true
            for(int i =0; i < MAX_ARITY; i++){
                if(source->branches[i] != NULL){		
                    dst->branches[i] = new node;
                    dst->branches[i]->parent = dst;  // modified here
                    copy(dst->branches[i], source->branches[i]);
                } else 
                    dst->branches[i] = NULL;
            }
        } else if (dst->type >= NUM_NON_TERMS)  // here and followed
            for (int i = 0; i < MAX_ARITY; ++i)
                dst->branches[i] = NULL;
    }
}

void node::erase(void){
    //cout << "node erase: " << endl;
    
    if(type < NUM_NON_TERMS){
        //            cout << "node erase B: " << endl;
    
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
        case multiply:
        case divide:
            for(int i =0; i < 2; i++){
                branches[i] = new node;
                branches[i]->full(depth+1,max,this);
            }
            for(int i=2;i<MAX_ARITY;i++)  // initially make all branches NULL
                branches[i] = NULL;
            break;
        case mypow:
        case mysin:
        case mycos:
        case mylog:
            branches[0] = new node;
            branches[0]->full(depth+1,max,this);
            for(int i=1;i<MAX_ARITY;i++)  // initially make all branches NULL
                branches[i] = NULL;
            break;
        case myif: // less than or equal to
            for(int i =0; i < MAX_ARITY; i++){
                branches[i] = new node;
                branches[i]->full(depth+1,max,this);
            }
            break;
        default:
            cout << "Unknown case in full"  << endl;
        }
    }
    if(type == constt) 
    {
        const_value = double(drand48() * 2.0 * CONST_LIMIT) - (CONST_LIMIT/2.0);    
    }
}

double node::evaluate(double X){
	double l,r,t,f;
    /*
    if (this) 
    {
    */
    //cout << "node evaluate: " << endl;
    
        switch(type) {
            //                cout << "node evaluate B: " << endl;
    
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
        case mypow:
            l = branches[0]->evaluate(X);
            return pow(l, 2);
        case mysin:
            l = branches[0]->evaluate(X);
            return sin(l);
        case mycos:
            l = branches[0]->evaluate(X);
            return cos(l);
        case mylog:
            l = branches[0]->evaluate(X);
            if (l - 0.005 > 0.0001) return log(l);
            else if (l -0.005 < 0.0001) return log(-l);
            else return 0;
        case myif:
            l=branches[0] -> evaluate(X);
            r=branches[1] -> evaluate(X);
            if (l - r <= 0.00001)
                return branches[2]->evaluate(X);
            else
                return branches[3]->evaluate(X);
        case inputX: // X
            return X;
        case constt:
            return const_value;
        default:
            cout << "Error, unknown instruction " << type << endl;
        }
        //  }
}

void node::calc_size(int &terms, int &non_terms){
    //cout << "Node type: " << type << endl;
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

