
/* Defines the indiv class.  Each individual has a fitness,
size, number of terminals (terms), number of non-terminals,
and a pointer to the root node of the actual tree.

Many of the functions simply call functions in the node class.
*/
#ifndef INDIVIDUAL_H
#define INDIVIDUAL_H

#include "node.h"

class Individual : public node {
public:
    Individual& operator=(Individual& rhs);
    
	float getFitness(void) {return fitness;}
	int getSize(void)    {calc_size();return size;}
	void evaluate(void);
	void evaluate_print(void);
	void calc_size(void);
	void generate(int);
    void print(node* p, int depth) ;
    void erase(void);
    node* getNodePtr(){node* tmp = the_indiv; return tmp;}
    Individual copy();

	float fitness;  // fitness of the individual    
 	node *the_indiv; // pointer to the root of the 'program' tree
 private:
	int size;       // total number of nodes in the tree
	int terms;      // total number of terminals in the tree
	int non_terms;  // total number of non-terminals in the tree

};

#endif
