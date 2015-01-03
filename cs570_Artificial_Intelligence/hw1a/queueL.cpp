/*  queueL.cpp
 *
 *  Definition file for the ADT queue.
 *  Implementation uses a list.
 */

#include "queueL.h"
#include "listQ.h"


Queue::Queue()
{
    //  default constructor
}

Queue::Queue( const Queue& q ) : L(q.L)
{
    //  copy constructor
}

Queue::~Queue()
{
    //  destructor
}

void Queue::Insert( int x, int y )
{
    L.AddNode(x, y);
}

int Queue::Row()
{
    return L.FirstNode_y();
}

int Queue::Column()
{
    return L.FirstNode_x();
}


void Queue::Delete()
{
    L.DeleteNode();
}


int Queue::IsEmpty()
{
    return L.Size();
    
}

void Queue::Print()
{
    L.PrintNodes();
}


