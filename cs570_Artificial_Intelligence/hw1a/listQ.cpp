/*  ListQ.cpp
 *
 *  Class for a sorted linked list of integers.
 */


#include <iostream>

#include "listQ.h"

using namespace std;


void LinkedList::AddNode(int x, int y)
{
    nodeptr n, nTmp;

    n = new node;
    n->column = x;
    n->row = y;
    n->next = NULL;
    count++;

    if( start == NULL )
    {
        start = n;
        end   = start;
    }
    else
    {
        end->next = n;
        nTmp = end;
        end  = nTmp->next;
    }
}

void LinkedList::DeleteNode()
{
    nodeptr curr;

    if( start != NULL )
    {
        curr = start;
        start = start->next;
        delete curr;
        
        count--;
    }
}

int LinkedList::FirstNode_x()
{
    int  iVal;
    
    if( start != NULL )
        iVal = start->column;
        
    return iVal;
}

int LinkedList::FirstNode_y()
{
    int  iVal;
    
    if( start != NULL )
        iVal = start->row;
        
    return iVal;
}

void LinkedList::PrintNodes()
{
    nodeptr p = start;

    while( p != NULL )
    {
        cout << p->column << " " << p->row << endl;
        p = p->next;
    }

}

int LinkedList::Size()
{
    return count;
}
 
