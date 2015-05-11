/* Defines the node class used to build individual's trees.
The initial typedef and define statements define the 
'language' used by the tree.
For the simple symbolic regression problem there are two non-temrinals:
+ and - (add and subtract) and two terminals: X (which references a global)
and constt, which stores mutatable constant value.
*/

#ifndef NODE_H
#define NODE_H

// Names in typdef modified to avoid key words
typedef enum command{add,subtract, multiply, divide,
                     mypow, mysin, mycos, mylog,
                     myif,
                     inputX,constt} command;

// add and subtract, multiply, divide
#define NUM_NON_TERMS 9

// X, constants
#define NUM_TERMS 2

// Total ops are the sum of the previous 2
#define TOTAL_OPS 11  

// max arity of any of the functions, can be changed
// unused branches point to NULL 
// 4 in case you want to add conditionals
#define MAX_ARITY 4


class node {
 public:
    /*
    typedef struct twosPtr
    {
        node* prt;
        node* cld;
    } twoPtr;
    */
	void full(int,int,node *); // generate random full trees
	double evaluate(double);   // calculates fitness
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
    // private:
    node *parent;           // pointer to parent node
};	


#endif
