//comments
//const

#include <iostream>
#include <cstring>
using namespace std;

class TicTacToe
{
	private:
		char ttt[3][3];
		char board[10][19];
		
		void printBoard();
		//void move();		
		bool check(int, int);
		bool wins(char);
		
	public:
		TicTacToe();
		void play();
};

TicTacToe::TicTacToe()
{
	strcpy(board[0],"*  1     2     3  ");
	strcpy(board[1],"      |     |     ");
	strcpy(board[2],"1     |     |     ");
	strcpy(board[3]," _____|_____|_____");
	strcpy(board[4],"      |     |     ");
	strcpy(board[5],"2     |     |     ");
	strcpy(board[6]," _____|_____|_____");
	strcpy(board[7],"      |     |     ");
	strcpy(board[8],"3     |     |     ");
	strcpy(board[9],"      |     |     ");
	
	for(int i=0;i<3;++i)
	{
		for(int j=0;j<3;++j)
		{
			ttt[i][j] = ' ';
		}
	}
}

void TicTacToe::printBoard()
{
	for(int i=0;i<10;++i)
	{
		cout << board[i] << endl;
	}
}

void TicTacToe::play()
{
	bool win = false;
	int row, column;
	
	printBoard();
	
	while(!win)
	{
		cout << "Player X enter move: " << endl;
		cin >> row;
		cin >> column;
		if(check(row-1, column-1))
		{
			ttt[row-1][column-1] = 'X';
			board[3*row-1][6*column-3] = 'X';
			printBoard();
			if(wins('X'))
			{
				win = true;
			}
			else
			{
				cout << "Player O enter move: " << endl;
				cin >> row;
				cin >> column;
				if(check(row-1, column-1))
				{
					ttt[row-1][column-1] = 'O';
					board[3*row-1][6*column-3] = 'O';
					printBoard();
					if(wins('O'))
					{
						win = true;
					}
				}
				else
				{
					cerr << "Invalid input.\n";
					exit(1);
				}
			}
		}
		else
		{
			cerr << "Invalid input.\n";
			exit(1);
		}
		
		
	}
}

bool TicTacToe::check(int r, int c)
{
	if(ttt[r][c] == 'X' || ttt[r][c] == 'O')
	{
		return false;
	}
	else
	{
		return true;
	}
}

bool TicTacToe::wins(char ch)
{
	int count = 0, flag = 0;
	bool win = false;
	
	for(int j=0;j<3;++j)
	{
		for(int k=0;k<3;++k)
		{
			if(ttt[j][k] == ch)
			{
				flag++;
			}
		}
		
		if(flag == 3)
		{
			win = true;
			break;
		}
		else
		{
			flag = 0;
		}
	}
	
	for(int j=0;j<3;++j)
	{
		for(int k=0;k<3;++k)
		{
			if(ttt[k][j] == ch)
			{
				flag++;
			}
		}
		
		if(flag == 3)
		{
			win = true;
			break;
		}
		else
		{
			flag = 0;
		}
	}
	
	if((ttt[0][0] == ch && ttt[1][1] == ch && ttt[2][2] == ch) || 
		(ttt[0][2] == ch && ttt[1][1] == ch && ttt[2][0] == ch))
	{
		win = true;
	}
	
	for(int i=0;i<3;++i)
	{
		for(int j=0;j<3;++j)
		{
			if(ttt[i][j] != ' ')
				count++;
		}
	}	
		
	if(win)
	{
		cout << "Player " << ch << " wins!\n";
		return true;
	}	
	else if(!win && count == 9)
	{
		cout << "This game is a draw!" << endl;
		return true;
	}
	else
	{
		return false;
	}
}

int main()
{
	TicTacToe game;
	game.play();
	
	return 0;
}
 ...
