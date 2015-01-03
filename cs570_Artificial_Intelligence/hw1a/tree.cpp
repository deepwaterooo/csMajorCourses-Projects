
#include <iostream>
#include <string>
#include "tree.h"

using namespace std;

TREE::TREE()
{
  rootPtr = NULL;
  start = NULL;
}

void TREE::AddRoot(int x, int y)
{
  TreePtr newPtr;
  ListPtr p;
  newPtr = new node;
  p = new node2;
  newPtr->row = y;
  p->r = y;
  newPtr->column = x;
  p->c = x;
  p->ptr = newPtr;

  newPtr->left = NULL;
  newPtr->down = NULL;
  newPtr->right = NULL;
  newPtr->up = NULL;
  
  start = p;
  start->next = NULL;  

  rootPtr = newPtr;
}

void TREE::AddNode_left(int x, int y)
{
  TreePtr newPtr, n;
  newPtr = new node;
  newPtr->row = y;
  newPtr->column = x-1;

  newPtr->left = NULL;
  newPtr->down = NULL;
  newPtr->right = NULL;
  newPtr->up = NULL;

  ListPtr p;
  p = new node2;
  p->r = y;
  p->c = x-1;
  p->ptr = newPtr;
  
  p->next = start;
  start = p;

  n = SearchNode(x, y);
  n->left = newPtr;
  newPtr->prev = n;  

}      

void TREE::AddNode_down(int x, int y)
{
  TreePtr newPtr, n;
  newPtr = new node;
  newPtr->row = y+1;
  newPtr->column = x;

  newPtr->left = NULL;
  newPtr->down = NULL;
  newPtr->right = NULL;
  newPtr->up = NULL;

  ListPtr p;
  p = new node2;
  p->r = y+1;
  p->c = x;
  p->ptr = newPtr;
  
  p->next = start;
  start = p;
  
  n = SearchNode(x, y);
  n->down = newPtr;
  newPtr->prev = n;  
}

void TREE::AddNode_right(int x, int y)
{
  TreePtr newPtr, n;
  newPtr = new node;
  newPtr->row = y;
  newPtr->column = x+1;

  newPtr->left = NULL;
  newPtr->down = NULL;
  newPtr->right = NULL;
  newPtr->up = NULL;
  
  ListPtr p;
  p = new node2;
  p->r = y;
  p->c = x+1;
  p->ptr = newPtr;
  
  p->next = start;
  start = p;

  n = SearchNode(x, y);
  n->right = newPtr;
  newPtr->prev = n;  
}

void TREE::AddNode_up(int x, int y)
{
  TreePtr newPtr, n;
  newPtr = new node;
  newPtr->row = y-1;
  newPtr->column = x;

  newPtr->left = NULL;
  newPtr->down = NULL;
  newPtr->right = NULL;
  newPtr->up = NULL;

  ListPtr p;
  p = new node2;
  p->r = y-1;
  p->c = x;
  p->ptr = newPtr;
  
  p->next = start;
  start = p;

  n = SearchNode(x, y);
  n->up = newPtr;
  newPtr->prev = n;  
}

int TREE::parentX(int x, int y)
{
  TreePtr p;
  p = SearchNode(x, y);
  return p->prev->column;
}

int TREE::parentY(int x, int y)
{
  TreePtr p;
  p = SearchNode(x, y);
  return p->prev->row;
}


TREE::TreePtr
TREE::SearchNode(int x, int y)
{
  ListPtr p=start;
  while (p != NULL)
  {
    if(p->r == y && p->c == x) return p->ptr;
    else p = p->next;
  }
  return NULL;
}
  

void TREE::findPath(int x, int y)
{
  TreePtr n;
  n = SearchNode(x, y);
  while(n != rootPtr)
    {
      cout << n->column << " " << n->row << endl;
      n = n->prev;
    }
  cout << n->column << " " << n->row << endl;
}


