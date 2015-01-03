/*  QueueL.h
 *
 *  Interface file for the ADT queue.
 *  Implementation uses a list.
 */

#ifndef QUEUEL_H
#define QUEUEL_H

#include "listQ.h"

class Queue
{
private:
    LinkedList  L;   //  list of queue items

public:
    Queue();
    Queue( const Queue& q );
    ~Queue();
    
    void Insert( int x, int y );
    int Row();
    int Column();
    void Delete();

    int IsEmpty();
    
    void Print();
};

#endif
