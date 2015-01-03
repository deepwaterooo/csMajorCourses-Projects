// CS570		Project 2
// Sanqing Yuan		March 15, 2012

#include <iostream>
using namespace std;

int find_row(int x, char a[6][7]);
int check_win(int x, int y, char a[6][7], char c);
int check_draw(char a[6][7]);
void print_board(char a[6][7]);
int Alpha_Beta_Search(char a[6][7]);
int Max_Value(char array[6][7], int a, int b, int d);
int Min_Value(char array[6][7], int a, int b, int d);
int Max_Value1(char array[6][7], int a, int b, int d);
int Min_Value1(char array[6][7], int a, int b, int d);
int Heuristic(char arr[6][7]);
int checkhole(char arr[6][7], char thn[6][7], int x,int y);
int count_piece(char a[6][7]);

int main()
{
  char A[6][7], c;
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
  cout << endl << endl;
  cout<<"Please decide if you want to play first (Y or N): ";
  cin >> c;
  while(c!='Y'&& c!='N'&& c!='y'&& c!='n')
    {
      cout<<"Invalid input! Please enter again (Y or N): ";		
      cin >> c;
    }
  
  if(c=='Y'||c=='y')
    {
      while(1)
	{
	  cout<< "Please select the column (0-6) you want to drop (your drop is X): ";
	  cin >> x;
	  while(x<0 || x>6 || find_row(x, A) == -1) 
	    {
	      cout << "This column is full or your drop is out of board, please drop at another column: ";
	      cin >> x;
	    }
	  y = find_row(x,A);
	  A[y][x]='X';
	  print_board(A);
	  cout << endl;
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

	  cout << "Computer's turn:"<<endl;
	  x =  Alpha_Beta_Search(A);
	  y = find_row(x,A);
	  A[y][x]='O';
	  print_board(A);
	  cout << endl;
	  if(check_win(x,y,A,'O')==1) 
	    {
	      cout<< "Computer win!"<<endl;
	      return 0;
	    }
	  if(check_draw(A)==1) 
	    {
	      cout<<"It is a draw!"<<endl;
	      return 0;
	    }
	}
    }
  else
    {
      while(1)
	{
	  x =  Alpha_Beta_Search(A);
	  y = find_row(x,A);
	  A[y][x]='O';
	  cout << "Computer's turn:" << endl;
	  print_board(A);
	  if(check_win(x,y,A,'O')==1) 
	    {
	      cout<< "Computer win!"<<endl;
	      return 0;
	    }
	  if(check_draw(A)==1) 
	    {
	      cout<<"It is a draw!"<<endl;
	      return 0;
	    }
	  
	  cout<< "Please select the column (0-6) you want to drop (your drop is X): ";
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

int Alpha_Beta_Search(char a[6][7])
{
  char b[6][7];
  for(int l=0;l<6;l++)
    {
      for(int j=0;j<7;j++)
	{
	  b[l][j]=a[l][j];
	}
    }
  int n_pieces=count_piece(a);
  int utility = Max_Value(b, -65535, 65535, n_pieces);
  for(int i=0;i<7;i++)
    {
      for(int l=0;l<6;l++)
	{
	  for(int j=0;j<7;j++)
	    {
	      b[l][j]=a[l][j];
	    }
	}		
      int row = find_row(i, b);
      if(row!=-1)
	{
	  b[row][i]='O';
	  int n_pieces1 = count_piece(b);			
	  if(utility==Min_Value1(b, -65535, 65535, n_pieces1)) return i;
	}
    }
}


int Max_Value(char array[6][7], int a, int b, int d)
{
  char temp[6][7];
  int v1;
  if(count_piece(array) == d+6) return Heuristic(array);
  else
    {
      v1 = -65535;
      for(int i=0;i<7;i++)
	{
	  for(int l=0;l<6;l++)
	    {
	      for(int j=0;j<7;j++)
		{
		  temp[l][j]=array[l][j];
		}
	    }
	  int row = find_row(i, array);
          if(row!=-1)
	    {
	      temp[row][i]='O';
	      int h1=Min_Value(temp, a,b,d);
	      if(h1>v1) v1=h1;
	      if(v1>=b) return v1;
	      if(v1>a) a=v1;
	    }
	}
    }
  return v1;
}

int Min_Value(char array[6][7], int a, int b, int d)
{
  char temp[6][7];
  int v2;
  if(count_piece(array) == d+6) return Heuristic(array);
  else
    {
      v2 = 65535;
      for(int i=0;i<7;i++)
	{
	  for(int l=0;l<6;l++)
	    {
	      for(int j=0;j<7;j++)
		{
		  temp[l][j]=array[l][j];
		}
	    }
	  int row = find_row(i, array);
          if(row!=-1)
	    {
	      temp[row][i]='X';
	      int h2=Max_Value(temp, a,b,d);
	      if(h2<v2) v2=h2;
	      if(v2<=a) return v2;
	      if(v2<b) b=v2;
	    }
	}
    }
  return v2;
}

int Max_Value1(char array[6][7], int a, int b, int d)
{
  char temp[6][7];
  int v1;
  if(count_piece(array) == d+5) return Heuristic(array);
  else
    {
      v1 = -65535;
      for(int i=0;i<7;i++)
	{
	  for(int l=0;l<6;l++)
	    {
	      for(int j=0;j<7;j++)
		{
		  temp[l][j]=array[l][j];
		}
	    }
	  int row = find_row(i, array);
          if(row!=-1)
	    {
	      temp[row][i]='O';
	      int h1=Min_Value1(temp, a,b,d);
	      if(h1>v1) v1=h1;
	      if(v1>=b) return v1;
	      if(v1>a) a=v1;
	    }
	}
    }
  return v1;
}

int Min_Value1(char array[6][7], int a, int b, int d)

{
  char temp[6][7];
  int v2;
  if(count_piece(array) == d+5) return Heuristic(array);
  else
    {
      v2 = 65535;
      for(int i=0;i<7;i++)
	{
	  for(int l=0;l<6;l++)
	    {
	      for(int j=0;j<7;j++)
		{
		  temp[l][j]=array[l][j];
		}
	    }
	  int row = find_row(i, array);
          if(row!=-1)
	    {
	      temp[row][i]='X';
	      int h2=Max_Value1(temp, a,b,d);
	      if(h2<v2) v2=h2;
	      if(v2<=a) return v2;
	      if(v2<b) b=v2;
	    }
	}
    }
  return v2;
}

int Heuristic(char arr[6][7])
{
  int u,o,x,y,j,score;
  int gh=0,hg=0;
  char thn[6][7];
  score=0;
  
  for (x=0;x<7;x++)
    {
      for (y=0;y<6;y++)
	{
	  thn[y][x]=' ';
	}
    }
  
  for (y=0;y<6;y++)
    {
      for (x=0;x<7;x++)
	{
	  if (arr[y][x]==' '){score=score+checkhole(arr,thn, x,y); }
	  if (y>0)
	    {
	      if ((thn[y][x]=='O')&&(arr[y-1][x]!=' '))gh++;
	      if ((thn[y][x]=='X')&&(arr[y-1][x]!=' ')){hg++;score=score-4000;}
	    }
	  else
	    {
	      if (thn[y][x]=='O')gh++;
	      if (thn[y][x]=='X'){hg++;score=score-4000;}
	    }
	}
    }
  if (gh>1)score=score+(gh-1)*500;
  if (gh==1)score=score-100;
  if (hg>1)score=score-(hg-1)*500;
  
  for (x=0;x<7;x++)
    {
      gh=0;
      for (y=1;y<6;y++)
	{
	  if ((thn[y][x]=='O')&&(thn[y-1][x]=='O'))
	    {
	      u=0;j=0;
	      for (o=y-1;o>-1;o--)
		{
		  if (thn[o][x]=='X')u=1;
		  if (arr[o][x]==0)j++;
		}
	      if (u==0)score=score+1300-j*7;
	      if (u==1)score=score+300;
	    }
	  
	  if ((thn[y][x]=='X')&&(thn[y-1][x]=='X'))
	    {
	      u=0;j=0;
	      for (o=y-1;o>-1;o--)
		{
		  if (thn[o][x]=='O')u=1;
		  if (arr[o][x]==0)j++;
		}
	      if (u==0)score=score-1500+j*7;
	      if (u==1)score=score-300;
	    }
	  if (thn[y][x]=='X')
	    {
	      u=0;
	      for (o=y-1;o>-1;o--)
		{
		  if (thn[o][x]=='O')u=1;
		}
	      if (u==1)score=score+30;}
	  if (thn[y][x]=='O')
	    {
	      u=0;
	      for (o=y-1;o>-1;o--)
		{
		  if (thn[o][x]=='X')u=1;
		}
	      if (u==1)score=score-30;}
	}
    }
  //cout << endl << score << endl;
  return score;
}
 
int checkhole(char arr[6][7], char thn[6][7], int x,int y)
{
  int score=0;
  int max,min;
  int d0=0,d1=0,d2=0,d3=0;
  if (((x+1)<7)&&((y-1)>-1))
    {
      if (arr[y-1][x+1]=='O')
	{
	  d1++;
	  if (((x+2)<7)&&((y-2)>-1))
	    {
	      if (arr[y-2][x+2]=='O')
		{
		  d1++;
		  if (((x+3)<7)&&((y-3)>-1))
		    {
		      if (arr[y-3][x+3]=='O')d1++;}}}}
    }
  if (((x-1)>-1)&&((y+1)<6))
    {
      if (arr[y+1][x-1]=='O')
	{
	  d1++;
	  if (((x-2)>-1)&&((y+2)<6))
	    {
	      if (arr[y+2][x-2]=='O')
		{
		  d1++;
		  if (((x-3)>-1)&&((y+3)<6))
		    {
		      if (arr[y+3][x-3]=='O')d1++;}}}}
    }
  if (((x-1)>-1)&&((y-1)>-1))
    {
      if (arr[y-1][x-1]=='O')
	{
	  d2++;
	  if (((x-2)>-1)&&((y-2)>-1))
	    {
	      if (arr[y-2][x-2]=='O')
		{
		  d2++;
		  if (((x-3)>-1)&&((y-3)>-1))
		    {
		      if (arr[y-3][x-3]=='O')d2++;}}}}
    }
  if (((x+1)<7)&&((y+1)<6))
    {
      if (arr[y+1][x+1]=='O')
	{
	  d2++;
	  if (((x+2)<7)&&((y+2)<6))
	    {
	      if (arr[y+2][x+2]=='O')
		{
		  d2++;
		  if (((x+3)<7)&&((y+3)<6))
		    {
		      if (arr[y+3][x+3]=='O')d2++;}}}}
    }
  if ((y-1)>-1)if (arr[y-1][x]=='O')
		 {
		   d0++;
		   if ((y-2)>-1)if (arr[y-2][x]=='O')
				  {
				    d0++;
				    if ((y-3)>-1)if (arr[y-3][x]=='O')d0++;}
		 }
  if (x-1>-1)
    {
      if (arr[y][x-1]=='O')
	{
	  d3++;
	  if (x-2>-1)
	    {
	      if (arr[y][x-2]=='O')
		{
		  d3++;
		  if (x-3>-1)if (arr[y][x-3]=='O')d3++;}}}
    }
  if (x+1<7)
    {
      if (arr[y][x+1]=='O')
	{
	  d3++;
	  if (x+2<7)
	    {
	      if (arr[y][x+2]=='O')
		{
		  d3++;
		  if (x+3<7)if (arr[y][x+3]=='O')d3++;}}}
    }
  max=d0;
  if (d1>max)max=d1;
  if (d2>max)max=d2;
  if (d3>max)max=d3;
  if (max==2)score=score+5;
  if (max>2)
    {
      score=score+71;thn[y][x]='O';
      if ((d1<3)&&(d2<3)&&(d3<3))score=score-10;}
  
  if (((x+1)<7)&&((y-1)>-1))
    {
      if (arr[y-1][x+1]=='X')
	{
	  d1++;
	  if (((x+2)<7)&&((y-2)>-1))
	    {
	      if (arr[y-2][x+2]=='X')
		{
		  d1++;
		  if (((x+3)<7)&&((y-3)>-1))
		    {
		      if (arr[y-3][x+3]=='X')d1++;}}}}
    }
  if (((x-1)>-1)&&((y+1)<6))
    {
      if (arr[y+1][x-1]=='X')
	{
	  d1++;
	  if (((x-2)>-1)&&((y+2)<6))
	    {
	      if (arr[y+2][x-2]=='X')
		{
		  d1++;
		  if (((x-3)>-1)&&((y+3)<6))
		    {
		      if (arr[y+3][x-3]=='X')d1++;}}}}
    }
  if (((x-1)>-1)&&((y-1)>-1))
    {
      if (arr[y-1][x-1]=='X')
	{
	  d2++;
	  if (((x-2)>-1)&&((y-2)>-1))
	    {
	      if (arr[y-2][x-2]=='X')
		{
		  d2++;
		  if (((x-3)>-1)&&((y-3)>-1))
		    {
		      if (arr[y-3][x-3]=='X')d2++;}}}}
    }
  if (((x+1)<7)&&((y+1)<6))
    {
      if (arr[y+1][x+1]=='X')
	{
	  d2++;
	  if (((x+2)<7)&&((y+2)<6))
	    {
	      if (arr[y+2][x+2]=='X')
		{
		  d2++;
		  if (((x+3)<7)&&((y+3)<6))
		    {
		      if (arr[y+3][x+3]=='X')d2++;}}}}
    }
  if ((y-1)>-1)if (arr[y-1][x]=='X')
		 {
		   d0++;
		   if ((y-2)>-1)if (arr[y-2][x]=='X')
				  {
				    d0++;
				    if ((y-3)>-1)if (arr[y-3][x]=='X')d0++;}
		 }
  if (x-1>-1)
    {
      if (arr[y][x-1]=='X')
	{
	  d3++;
	  if (x-2>-1)
	    {
	      if (arr[y][x-2]=='X')
		{
		  d3++;
		  if (x-3>-1)if (arr[y][x-3]=='X')d3++;}}}
    }
  if (x+1<7)
    {
      if (arr[y][x+1]=='X')
	{
	  d3++;
	  if (x+2<7)
	    {
	      if (arr[y][x+2]=='X')
		{
		  d3++;
		  if (x+3<7)if (arr[y][x+3]=='X')d3++;}}}
    }
  min=d0;
  if (d1>min)min=d1;
  if (d2>min)min=d2;
  if (d3>min)min=d3;
  if (min==2)score=score-4;
  if (min>2)
    {
      score=score-70;thn[y][x]='X';
      if ((d1<3)&&(d2<3)&&(d3<3))score=score+10;}
  
  return score;
}
 
int count_piece(char a[6][7])
{
  int n = 0;
  for(int l=0;l<6;l++)
    {
      for(int j=0;j<7;j++)
	{
	  if (a[l][j]!=' ') n++;
	}
    }
  return n;
}
