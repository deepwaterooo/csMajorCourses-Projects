/* CS570 Project-1a   Sanqing Yuan
   Feb 2, 2012
*/

#include <iostream>
#include <string>
#include <fstream>
#include "tree.h"
#include "queueL.h"
#include "listQ.h"

using namespace std;

int search(int x, int y, int s1, int s2, int x1, int x2, TREE T, Queue Q, char A[100][100], char B[100][100], int c, int r);
void printMap(int x1, int y1, int x2, int y2, int c, int r, TREE T, char A[100][100] );


int main()
{
  int map_x, map_y;
  int start_x, start_y;
  int goal_x, goal_y;
  string inputfile;
  string line;

  ifstream in_file;
  cout << "Enter your map file name: ";
  cin >> inputfile;
  in_file.open(inputfile.c_str());
  in_file >> map_x >> map_y;
  in_file >> start_x >> start_y >> goal_x >> goal_y;

  int row = map_y;
  int column = map_x;
  char map[100][100];  // store original map
  char visit_map[100][100]; // store visited cells, water and the path
 
  for (int i=0; i<row; i++)
    {
      in_file >> line;
      for(int j=0; j<column; j++)
	{
	  map[i][j] = line[j];
	}
    }

  for (int i=0; i<row; i++)
    {
      for(int j=0; j<column; j++)
	{
	  visit_map[i][j] = 'U';
	}
    }

  for (int i=0; i<row; i++)
    {
      for(int j=0; j<column; j++)
	{
	  if(map[i][j] == 'W')
	  visit_map[i][j] = 'W';
	}
    }


  Queue frontier;
  TREE TreeMap;

  if(start_x == goal_x && start_y == goal_y)
    {
      TreeMap.AddRoot(start_x, start_y);
    }
  else
    {
     
      TreeMap.AddRoot(start_x, start_y);
      visit_map[start_y][start_x] = 'V';

      search(start_x, start_y, start_x, start_y, goal_x, goal_y, TreeMap, frontier, map, visit_map, column, row);
    }

  return 0;
}
  


int search(int x, int y, int s1, int s2, int x1, int x2, TREE T, Queue Q, char A[100][100], char B[100][100], int c, int r)
{
   //cout << x << " " << y << endl;
  if((x-1)== x1 && y == x2)  // go left
    {
      T.AddNode_left(x, y);
      printMap(s1, s2, x1, x2, c, r, T, B);
      return 0;
    }
  else if((x-1)>=0 && A[y][x-1] != 'W' && B[y][x-1] != 'V')
    {
      T.AddNode_left(x, y); 
      Q.Insert(x-1, y);
      B[y][x-1] = 'V';
    }
  else {;}

  if(x== x1 && (y+1) == x2)  // go down
    { 
      T.AddNode_down(x, y);
      printMap(s1, s2, x1, x2, c, r, T, B);
      return 0;
    }
  else if((y+1)<=r && A[y+1][x] != 'W' && B[y+1][x] != 'V')
    {
      T.AddNode_down(x, y);
      Q.Insert(x, y+1);
      B[y+1][x] = 'V';
    }
  else {;}

   if((x+1)== x1 && y == x2)  // go right
    { 
      T.AddNode_right(x, y); 
      printMap(s1, s2, x1, x2, c, r, T, B);
      return 0;
    }
  else if((x+1)<=c && A[y][x+1] != 'W' && B[y][x+1] != 'V')
    {
      T.AddNode_right(x, y);
      Q.Insert(x+1, y);
      B[y][x+1] = 'V';
    }
  else {;}   

   if(x== x1 && (y-1) == x2) // go up
     { 
       T.AddNode_up(x, y);
       printMap(s1, s2, x1, x2, c, r, T, B);
       return 0;
     }
   else if((y-1)>=0 && A[y-1][x] != 'W' && B[y-1][x] != 'V')
     {
       T.AddNode_up(x, y);
       Q.Insert(x, y-1);
       B[y-1][x] = 'V';
     }
   else {;}

   if(Q.IsEmpty() == 0) 
    {
      cout << "search fails!" << endl;
      return 1;
    }

 
   int a1 = Q.Column();
   int a2 = Q.Row();
   Q.Delete();

//cout << "---------------"<< endl;
//T.findPath(a1, a2);

   search(a1, a2, s1, s2, x1, x2, T, Q, A, B, c,r);
}



void printMap(int x1, int y1, int x2, int y2, int c, int r, TREE T, char A[100][100] )
{
  A[y1][x1] = 'S';
    int a1 = T.parentX(x2, y2);
  int a2 = T.parentY(x2, y2);
    
  int b1, b2;
  while (A[a2][a1] != 'S')
  {
    A[a2][a1] = 'p';
    b1 = a1; b2 = a2;
    a1 = T.parentX(b1, b2);
    a2 = T.parentY(b1, b2);
  }
  
  A[y2][x2] = 'G';
  cout << endl;
  cout << "Here is the map after breadth first search (U=unvisited, p=path, V=visited, W = water, S=start, G=goal):" << endl;
  cout << endl;
  for (int i=0; i<r; i++)
    {
      for(int j=0; j<c; j++)
	{
	  cout << A[i][j];
	}
      cout << endl;
    }
  cout << endl;
  int number_of_visited_cells = 0;
  int path_steps = -1;

  for (int i=0; i<r; i++)
    {
      for(int j=0; j<c; j++)
	{
	  if (A[i][j]== 'V') number_of_visited_cells++;
	  if (A[i][j]== 'p') path_steps++;
	}
    }

  cout << "There are " << number_of_visited_cells << " visited cells in the map." << endl;
  cout << "There are " << path_steps << " steps of the path." << endl << endl;
}
