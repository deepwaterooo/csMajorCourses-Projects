// CS570     Project 2a
// Heyan Huang    Feb 16, 2013     Saturday

#include <iostream>
#include <string>
using namespace std; 

struct point{
  int row; 
  int col;
};

// global constants
const char X = 'X'; 
const char O = 'O';
const char EMPTY = ' ';
const char TIE = 'T';
const char NO_ONE = 'N';
char Board[6][7];   // available for the whole program

// function prototypes
void instruction();
void PrintBoard( char A[6][7] );
char humanPiece();
char askYesNo(string question);
char opponent(char piece);
int askNumber(string question, char player);
inline bool isLegal(int move, char A[6][7]);
point humanMove(char A[][7], char human); // return row number

int CheckVertical(char A[6][7], char player, int cnt, point curr); // int cnt for later use
int CheckHorizontal(char A[6][7], char player, int cnt, point curr); // int cnt for later use
int CheckUpLeftDiagonal(char A[6][7], char player, int cnt, point curr); // int cnt for later use
int CheckUpRightDiagonal(char A[6][7], char player, int cnt, point curr); // int cnt for later use
int CheckWin(char A[6][7], char player, int cnt, point curr);
bool CheckTie(char A[6][7]);

/**************************************************************/
/*** main function ********************************************/
/**************************************************************/
int main()
{
  instruction();
  for(int i = 5; i >= 0; i--) // initial Board matrix
    {
      for(int j = 0; j < 7; j++ )
	{
	  Board[i][j] = EMPTY;
	}
    }

  char human = humanPiece();
  char othhum = opponent(human);
  char turn = human;
  point move; 
  PrintBoard(Board);

  move = humanMove(Board, human);   
  //cout << "x" << CheckWin(Board, turn, 4, move) << endl; 

  while (CheckWin(Board, turn, 4, move) < 1)
    {
      turn = opponent(turn);
      move = humanMove(Board, turn);

      if (CheckTie(Board))
	{
	  break;
	}
    }
  
  return 0;
}

/**************************************************************/
/*** Functions ************************************************/
/**************************************************************/

bool CheckTie(char A[6][7])
{
  for (int i = 0; i < 7; i++)
    {
      if (A[5][i] == EMPTY)
	{
	  return false; 
	}
    }
  cout << "It is a Tie. " << endl;
  return true; 
}

void instruction()
{
  cout << "\nWelcome to the ultimate human-human showdown: Connect 4 !!!\n";
  cout << "--where human brain is pit against human brain\n"; 
  cout << "make your move by typing the column number you want to drop: 0-6\n"; 
  cout << "prepare yourself, human. the battle is about to begin. \n\n"; 
}

void PrintBoard( char A[6][7] )
{
  for(int i = 5; i >= 0; i--) // Print initial Board
    {
      cout << "  |---------------------------|" << endl;
      cout << i << " ";
      for(int j = 0; j < 7; j++ )
	  cout << "| " << Board[i][j] << " ";
      cout << "|" << endl;
    }
  cout << "  |---------------------------|" << endl;
  cout << "  ";
  for(int j = 0; j < 7; j++)
    cout << "  " << j << " " ; 
  cout << endl;
}

char humanPiece()
{
  char go_first = askYesNo("Do you require the first move?"); 
  if (go_first == 'y') {
    cout << "\nThen take the first move. You will need it. \n"; 
    return X;
  } else {
    cout << "\n Your bravery will be your undoing... I will go first. \n"; 
    return O;
  }
}

char askYesNo(string question)
{
  char response; 
  do {
    cout << question << "(y/n): ";
    cin >> response; 
  } while (response != 'y' && response != 'n'); 
  return response; 
}

char opponent(char piece)
{
  if (piece == X)
    return O;
  else 
    return X;
}

int askNumber(string question, char player)
{
  int number; 
  do {
    cout << question << "your drop is " << player << ", (0 - 6): " << endl; 
    cin >> number;
  } while (number > 6 || number < 0); 
  return number; 
}

point humanMove(char A[][7], char player)
{
  int col = askNumber("Please select the column you want to drop, ", player);
  while( !isLegal(col, A) )
    {
      cout << "\nInvalid selection. That column is already occupied, foolish human.\n";
      col = askNumber("Please select the column you want to drop, ", player);
    }

  int row = 0; 
  for(row = 0; row <6; row++)
    {
      if (A[row][col] == EMPTY)                                                          
	break;
    }
  A[row][col] = player;
  PrintBoard(A);

  point curr; 
  curr.row = row; 
  curr.col = col;
  return curr;
}

inline bool isLegal(int move, char A[6][7])
{
  return (A[5][move] == EMPTY);
}

int CheckVertical(char A[6][7], char player, int cnt, point curr) // int cnt for later use
{
  int count=0;
  int row = curr.row; 
  int col = curr.col; 

  if(row < cnt-1)
      return 0;
  else if (row == cnt-1) {
    for(int i = 0; i <= row; i++)
      {
	if (A[i][col] != player)
	  return 0;
      }
    return 1;
  } else {
    for(int i = row; i >= row-cnt+1; i--)
      {
	if (A[i][col] != player)
	  return 0;
	else 
	  count++;
      }
    if (count==cnt)
      return 1;
  }
}

int CheckHorizontal(char A[6][7], char player, int cnt, point curr) // int cnt for later use
{
  int countL=0, countR=0, counter = 0; 
  int row = curr.row; 
  int col = curr.col; 

  for(int i = col-1; i >= 0; i-- )
    {
      if (A[row][i] != player)
	break;
      countL++;
    }

  for(int i = col+1; i <= 6; i++)
    {
      if (A[row][i] != player)
	break;
      countR++;
    }
  
  if (countL >= cnt -1 ) 
    counter += 1;
  if (countR >= cnt -1 )
    counter += 1;
  if ( (countL < cnt -1 ) && (countR < cnt -1 ) && (countL + countR + 1 > cnt) )
    counter += 1;
  return counter; 
}

int CheckUpLeftDiagonal(char A[6][7], char player, int cnt, point curr) // int cnt for later use
{
  int countU=0, countD=0, counter = 0; 

  int row = curr.row; 
  int col = curr.col; 
  while(row >= 0 && col >= 0)
    {
      if (A[row][col] == player) {
	countU++;
	row--;
	col--;
      } else {
	break; 
      }
    }

  row = curr.row; 
  col = curr.col; 
  while(row <= 5 && col <= 6)
    {
      if (A[row][col] == player) {
	countD++;
	row++;
	col++;
      } else{
	break;
      }
    }
  
  if (countU >= cnt ) 
    counter += 1;
  if (countD >= cnt )
    counter += 1;
  if ( (countU < cnt) && (countD < cnt ) && (countU + countD - 1 >= cnt) )
    counter += 1;
  return counter; 
} 

int CheckUpRightDiagonal(char A[6][7], char player, int cnt, point curr) // int cnt for later use
{
  int countU =0, countD=0, counter = 0; 

  int row = curr.row; 
  int col = curr.col; 
  while(row >= 0 && col <= 6)
    {
      if (A[row][col] == player) {
	countU++;
	row--;
	col++;
      } else {
	break; 
      }
    }

  row = curr.row; 
  col = curr.col; 
  while(row <= 5 && col >= 0)
    {
      if (A[row][col] == player) {
	countD++;
	row++;
	col--;
      } else {
	break;
      }
    }

  if (countU >= cnt ) 
    counter += 1;
  if (countD >= cnt )
    counter += 1;
  if ( (countU < cnt) && (countD < cnt ) && (countU + countD - 1 > cnt) )
    counter += 1;

  return counter; 
} 

int CheckWin(char A[6][7], char player, int cnt, point curr)
{
  if ( (CheckVertical(A, player, cnt, curr)
	+CheckHorizontal(A, player, cnt, curr)
	+CheckUpLeftDiagonal(A, player, cnt, curr)
	+CheckUpRightDiagonal(A, player, cnt, curr)) > 0 )
    {
      /*
	cout << ( CheckVertical(A, player, cnt, curr)
	+CheckHorizontal(A, player, cnt, curr)
	+CheckUpLeftDiagonal(A, player, cnt, curr)
	+CheckUpRightDiagonal(A, player, cnt, curr))  << endl;

	cout << CheckVertical(A, player, cnt, curr) << endl;
	cout << CheckHorizontal(A, player, cnt, curr) << endl;
	cout << CheckUpLeftDiagonal(A, player, cnt, curr) << endl;
	cout << CheckUpRightDiagonal(A, player, cnt, curr) << endl;
      */
      cout << "Congratulations! You win! Your drop is " << player << ". " << endl;
      return 1; 
    }
  else 
    return 0;
}
