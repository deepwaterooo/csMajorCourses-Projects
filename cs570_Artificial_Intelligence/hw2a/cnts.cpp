/* CS570		Project 2a
   Sanqing Yuan		Feb 25, 2012
*/

#include <iostream>

using namespace std;

int find_row(int x, char a[6][7]);
int check_win(int x, int y, char a[6][7], char c);
int check_draw(char a[6][7]);
void print_board(char a[6][7]);


int main()
{
  char A[6][7];
  int x, y;
  int i, j;

  for(i=0;i<6;i++)
    {
      for(j=0;j<7;j++)
	{
	  A[i][j] = ' ';
	}
    }

  cout<<"the board before playing:"<<endl<<endl;;
  print_board(A);

  while(1)
    {
      cout<< "Please select the column you want to drop (your drop is X): ";
      cin >> x;
      while(x<0 || x>6 || find_row(x, A) == -1) 
	{
	  cout << "This column is full or your drop is out of board, please drop at another column: ";
	  cin >> x;
	}
      y = find_row(x,A);
      A[y][x]='X';
      print_board(A);

      if(check_win(x,y,A,'X')==1) 
	{
	  cout<< "You win!"<<endl;
	  return 0;
	}
      if(check_draw(A)==1) 
	{
	  cout<<"It is a draw!"<<endl;
	  return 0;
	}

      cout<< "Please select the column you want to drop (your drop is O): ";
      cin >> x;
      while(x<0 || x>6 || find_row(x, A) == -1) 
	{
	  cout << "This column is full or your drop is out of board, please drop at another column: ";
	  cin >> x;
	}
      y = find_row(x,A);
      A[y][x]='O';
      print_board(A);
      if(check_win(x,y,A,'O')==1) 
	{
	  cout<< "You win!"<<endl;
	  return 0;
	}
      if(check_draw(A)==1) 
	{
	  cout<<"It is a draw!"<<endl;
	  return 0;
	}
    }
}

int find_row(int x, char a[6][7])
{
  for(int i=0; i<6; i++)
    {
      if (a[i][x] != ' ') return i-1;
    }
  if(a[5][x]==' ') return 5;
}


int check_win(int x, int y, char a[6][7], char c)
{
  int i,j,count;
  if(x<=3)
    {
      for(i=0;i<=x;i++)
	{
	  count = 0;
	  for(j=0;j<4;j++)
	    {
	      if(a[y][i+j]==c) count++;
	    }
	  if(count==4) return 1;
	}
    }
  else
    {
      for(i=x-3;i<=3;i++)
	{
	  count = 0;
	  for(j=0;j<4;j++)
	    {
	      if(a[y][i+j]==c) count++;
	    }
	  if(count==4) return 1;

	}
    }

  if(y<=3)
    {
      for(i=0;i<=y;i++)
	{
	  count = 0;
	  for(j=0;j<4;j++)
	    {
	      if(a[i+j][x]==c) count++;
	    }
	  if(count==4) return 1;

	}
    }
  else
    {
      for(i=y-3;i<=2;i++)
	{
	  count = 0;
	  for(j=0;j<4;j++)
	    {
	      if(a[i+j][x]==c) count++;
	    }
	  if(count==4) return 1;
	}
    }

  if(y-1>=0 && x+1<=6 && a[y-1][x+1] == c)
    {
      if(y-2>=0 && x+2<=6 && a[y-2][x+2] == c)
	{
	  if(y-3>=0 && x+3<=6 && a[y-3][x+3] == c) return 1;

	  else if((y-3>=0 && x+3<=6 && a[y-3][x+3] != c) || y-3<0 || x+3>6)
	    {
	      if(y+1<=5 && x-1>=0 && a[y+1][x-1] == c) return 1;
	    }
	}
      else if((y-2>=0 && x+2<=6 && a[y-2][x+2] != c) || y-2<0 || x+2>6)
	{
	  if(y+1<=5 && x-1>=0 && a[y+1][x-1] == c)
	    {
	      if(y+2<=5 && x-2>=0 && a[y+2][x-2] == c) return 1;
	    }
	}
    }
  else if((y-1>=0 && x+1<=6 && a[y-1][x+1] != c) || y-1<0 || x+1>6)
    {
      if(y+1<=5 && x-1>=0 && a[y+1][x-1] == c)
	{
	  if(y+2<=5 && x-2>=0 && a[y+2][x-2] == c)
	    {
	      if(y+3<=5 && x-3>=0 && a[y+3][x-3] == c) return 1;
	    }
	}
    }
	
  if(y-1>=0 && x-1>=0 && a[y-1][x-1] == c)
    {
      if(y-2>=0 && x-2>=0 && a[y-2][x-2] == c)
	{
	  if(y-3>=0 && x-3>=0 && a[y-3][x-3] == c) return 1;
	  else if((y-3>=0 && x-3>=0 && a[y-3][x-3] != c) || y-3<0 || x-3<0)
	    {
	      if(y+1<=5 && x+1<=6 && a[y+1][x+1] == c) return 1;
	    }
	}
      else if((y-2>=0 && x-2>=0 && a[y-2][x-2] != c) || y-2<0 || x-2<0)
	{
	  if(y+1<=5 && x+1<=6 && a[y+1][x+1] == c)
	    {
	      if(y+2<=5 && x+2<=6 && a[y+2][x+2] == c) return 1;
	    }
	}
    }
  else if((y-1>=0 && x-1>=0 && a[y-1][x-1] != c) || y-1<0 || x-1<0)
    {
      if(y+1<=5 && x+1<=6 && a[y+1][x+1] == c)
	{
	  if(y+2<=5 && x+2<=6 && a[y+2][x+2] == c)
	    {
	      if(y+3<=5 && x+3<=6 && a[y+3][x+3] == c) return 1;
	    }
	}
    }	
  return 0;
}

int check_draw(char a[6][7])
{
  int i,j;
  for(i=0;i<6;i++)
    {
      for(j=0;j<7;j++)
	{
	  if(a[i][j] == ' ') return 0;
	}
    }
  return 1;
}

void print_board(char a[6][7])
{
  int i,j;
  cout << "  0 1 2 3 4 5 6" << endl;
  for(i=0;i<6;i++)
    {
      cout<<i<<" ";
      for(j=0;j<7;j++)
	{
	  cout << a[i][j] << " ";
	}
      cout << endl;
    }
}
