

#ifndef TREE_H
#define TREE_H


class TREE
{
 private:
  struct node
  {
    int row;
    int column;
    node* prev;
    node* left;
    node* down;
    node* right;
    node* up;
  };
  typedef node* TreePtr;
  TreePtr rootPtr;
  
  struct node2
  {
    int r;
    int c;
    TreePtr ptr;
    node2* next;
   };
   typedef node2* ListPtr;
   ListPtr start;

 public:
  TREE();

  void AddRoot(int x, int y);
  void AddNode_left(int x, int y);
  void AddNode_down(int x, int y);
  void AddNode_right(int x, int y);
  void AddNode_up(int x, int y);
  int parentX(int x, int y);
  int parentY(int x, int y);
  void findPath(int x, int y);

  TreePtr SearchNode(int x, int y);
};

#endif
