/*  listQ.h
 *
 *  This is a class for a linked list of integers
 *  used in queues.
 */

#ifndef LISTQ_H
#define LISTQ_H

#include <iostream>


class LinkedList
{
private:

  struct node
  {
     int row, column;
     node * next;
  };

  typedef node * nodeptr;

  nodeptr start;    //  pointer to front
  nodeptr end;      //  pointer to end

  int count;

public:

       // Constructor
   LinkedList()
   {
      start = NULL;
      end   = start;
      count = 0;
   }

       // Destructor

   ~LinkedList()
   {
      nodeptr p = start, n;
 
      while (p != NULL)
      {
         n = p;
         p = p->next;
         delete n;
      }
   }    

    // Put a node at the end of the linked list.

   void AddNode(int x, int y);

    //  Delete the first node in the list.

   void DeleteNode();

    //  Return the first or last node.
    
   int  FirstNode_x();
   int  FirstNode_y();
   
    //  Output the values in the nodes, one integer per line.

   void PrintNodes();


    //  Return a count of the number of nodes in the list.
 
   int Size();
};

#endif
