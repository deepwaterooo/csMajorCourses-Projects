/* Defines the node class used to build individual's trees.
The initial typedef and define statements define the 
'language' used by the tree.
For the simple symbolic regression problem there are two non-temrinals:
+ and - (add and subtract) and two terminals: X (which references a global)
and constt, which stores mutatable constant value.
*/

#ifndef NODE_H
#define NODE_H

#include "ant.h"

// Names in typdef modified to avoid key words
typedef enum command{
    pro2, pro3, isFoodAhead,
    left, right, forward
} command;

// add and subtract, multiply, divide
#define NUM_NON_TERMS 3

// X, constants
#define NUM_TERMS 3

// Total ops are the sum of the previous 2
#define TOTAL_OPS 6

// max arity of any of the functions, can be changed
// unused branches point to NULL 
// 4 in case you want to add conditionals
#define MAX_ARITY 3

class node {
 public:
    static ant ant1;
	void full(int,int,node *); // generate random full trees
	int evaluate(int &);   // calculates fitness
	void calc_size(int&,int&); // pass by reference is for terms, non_terms
	void copy(node *);         // copies trees
    void copy(node*, node *);  // copies trees
	void erase(void);          // recursively erases/frees trees
    int getType()            {return type;}
    void setType(int newType){type = newType;}
    double getVal()          {return const_value;}

	node *branches[MAX_ARITY];  // pointers to branches
    int type;         // stores the terminal or non-terminal
	double const_value;     // stores the constant, if any
    node *parent;           // pointer to parent node
};	


#endif
