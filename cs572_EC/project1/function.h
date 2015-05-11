#ifndef FUNCTION_H
#define FUNCTION_H

#include <iostream>
#include "fitness.h"

typedef float (*funPtrSep)(float);
typedef float (*funPtrNSe)(float*, int);

class Function 
{
 public:
    Function(float l, float h, funPtrSep ptr, bool flag);
    Function(float l, float h, funPtrNSe ptr, bool flag);
    
    Function(Function* funptr);
    Function(const Function& orig);
    
    virtual ~Function();
    
    float getFitness(float x);
    float getFitness(float* x, int p);
    
    float low;
    float high;
    float fitness;
    bool sepaFlag;
    
    funPtrSep sepPtr;
    funPtrNSe nsePtr;
};
    
#endif
