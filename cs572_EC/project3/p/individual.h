/* Defines the indiv class.  Each individual has a fitness,
size, number of terminals (terms), number of non-terminals,
and a pointer to the root node of the actual tree.

Many of the functions simply call functions in the node class.
*/
#ifndef INDIVIDUAL_H
#define INDIVIDUAL_H

#include "node.h"

typedef struct twosPtr {
    node* prt;
    node* cld;
} twoPtr;

class Individual {
public:
    Individual& operator=(Individual& rhs);
    
	void generate(int);
    void print(node* p, int depth) ;
    void print1(node* p, int depth) ;
    void erase(node* p);

    void calc_size(void);
	int getSize(void)      {calc_size();return size;}
    int getFitness();
    node* getNodePtr(){node* tmp = the_indiv; return tmp;}
    
	int evaluate(int );
	void evaluate_print(void);

    Individual copy();
    void copy(Individual& dst); // copy to destination
    void copy(node* src);  // copy subtree to individual
    bool condition(int cnt, int& ori);
    
    twoPtr myTraverse(node* tmp, int cnt, int& match, int& p);
    twoPtr getPtrs(int x);
    
    void getTermNodePtr(node* tmp, int &terms, int& cnt) ;
    void getNonTermNodePtr(node* tmp, int &terms, int& cnt) ;
    void getNodePtr(node* tmp, int &cnt, int& idx);
    
    void mutate(int mutRate, int gennum);     // mutate individual    
    void mutate();
    void mutate(node* tmp, float mutRate);

	int fitness;  // fitness of the individual    
 	node *the_indiv; // pointer to the root of the 'program' tree

    twoPtr pair[5];
    
    twoPtr term[100];
    twoPtr nonterm[100];
    twoPtr together[200];
    int step;
	int terms;      // total number of terminals in the tree
	int non_terms;  // total number of non-terminals in the tree
	int size;       // total number of nodes in the tree
 private:
    bool doneFlag;
};

#endif
