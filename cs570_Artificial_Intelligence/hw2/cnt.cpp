// CS570          Project 2
// Heyan Huang    Feb 18, 2013 Sunday

#include <iostream>
#include <string>
#include <cstdlib>
using namespace std; 
struct point{
  int row; 
  int col;
};
struct scopos{
  int col; 
  int sco; 
};

// global constants
const char X = 'X'; 
const char O = 'O';
const char EMPTY = ' ';
const char TIE = 'T';
const char NO_ONE = 'N';
char Board[6][7];   
const int MAX_DEPTH = 3;
const int INT_MAX = 2147483647;

// function prototypes
void instruction();
void PrintBoard( char A[6][7] );
char humanPiece();
char askYesNo(string question);
char opponent(char piece);
int askNumber(string question, char player);
bool isLegal(int move, char A[6][7]);
int findRow(char A[6][7], int col); 
point humanMove(char A[][7], char human); // return row number
int drop_piece(char A[6][7], char player, int col);

int CheckVertical(char A[6][7], char player, int cnt, point curr); // int cnt for later use
int CheckHorizontal(char A[6][7], char player, int cnt, point curr); 
int CheckUpLeftDiagonal(char A[6][7], char player, int cnt, point curr); 
int CheckUpRightDiagonal(char A[6][7], char player, int cnt, point curr); 
bool CheckWin(char A[6][7], char player, int cnt, point curr);
bool CheckWin_board(char A[6][7], char player, int cnt);
bool CheckTie(char A[6][7]);
int ScoreVertical(char A[6][7], char player, point curr);
int ScoreHorizontal(char A[6][7], char player, point curr);
int ScoreUpLeftDiagonal(char A[6][7], char player, point curr);
int ScoreUpRightDiagonal(char A[6][7], char player, point curr);

// functions still needed
int evaluate_move(char A[6][7], char player, int row, int col); // evaluate current position for the player
int evaluate_board(char A[6][7], char player); // evaluate the board score for the player
int evaluate_bestMove(char A[6][7], int player, int level, int alpha, int beta);
//int evaluate(char A[6][7], char player, int col); // evaluate current position for the player
//int bestMove_minmax(char A[][7], int depth, int alpha, int beta, char player); // recursive
scopos bestMove_minmax(char A[][7], int depth, int alpha, int beta, char player);
scopos bestMove_max(char A[6][7], char player, int level, int alpha, int beta);
scopos bestMove_min(char A[6][7], char player, int level, int alpha, int beta);

/**************************************************************/
/*** main function ********************************************/
/**************************************************************/
int main()
{
  instruction();
  for(int i = 5; i >= 0; i--) // initial Board matrix
    {
      for(int j = 0; j < 7; j++ )
	Board[i][j] = EMPTY;
    }
  PrintBoard(Board);

  char fstply = humanPiece();
  char latter = opponent(fstply);
  point move;  
  char turn, human, computer;
  if (fstply = X){
    turn = X;
    human = X;
    move = humanMove(Board, fstply);   
  } else {
    turn = O;
    computer = O;
    Board[0][3] = O;
    move.row = 0; 
    move.col = 3;
  }

  while (!CheckWin(Board, turn, 4, move)) 
    {
      turn = opponent(turn);

      if (turn == X)
	move = humanMove(Board, turn);
      else {
	//	move.col = evaluate_bestMove(Board, turn, MAX_DEPTH, -65535, -65535);
	int moves= bestMove_minmax(Board, 0, -INT_MAX, INT_MAX, turn);
	move.col = moves.col;
	int row = findRow(Board, move.col);
	Board[row][move.col] = O;
	PrintBoard(Board);
	if (CheckTie(Board))
	  break;
      }
    }
  return 0;
}

/**************************************************************/
/*** Functions ************************************************/
/**************************************************************/

int bestMove_minmax(char A[][7], int depth, int alpha, int beta, char player)
{
  int maxScore = -INT_MAX;
  int score;
  int j = 0;
  for(int i = 0; i < 7; i++)
    {
      if (A[5][i] != EMPTY){
	continue;
      } else {
	int row = findRow(A, i);
	A[row][i] = player; 
	PrintBoard(A);
	score = -bestMove_min(A, opponent(player), depth+1, -beta, -alpha);    // this step may be wrong
	cout << "score: " << score << " col: " << score.col << endl;
	if(maxScore < -score.sco)
	  {
	    maxScore = -score.sco;
	    j = i; 
	  }
	A[row][i] = EMPTY; 
      } 
    }
  return alpha; 
}

/*
scopos bestMove_minmax(char A[][7], int depth, int alpha, int beta, char player)
{
  int maxScore = -INT_MAX;
  scopos score, sp;
  int j = 0;
  for(int i = 0; i < 7; i++)
    {
      if (A[5][i] != EMPTY){
	continue;
      } else {
	int row = findRow(A, i);
	A[row][i] = player; 
	PrintBoard(A);
	score = bestMove_min(A, opponent(player), depth+1, -beta, -alpha);    // this step may be wrong
	cout << "min score: " << score.sco << " col: " << score.col << endl;
	if(maxScore < -score.sco)
	  {
	    maxScore = -score.sco;
	    j = i; 
	  }
	A[row][i] = EMPTY; 
      } 
    }
  sp.sco = maxScore; 
  sp.col = j;
  return sp; 
}
*/

scopos bestMove_max(char A[6][7], char player, int level, int alpha, int beta)
{
  int maxScore = -INT_MAX; 
  scopos score;
  int j = 0, sco=-INT_MAX; 
  scopos sp; 
  int maxab = alpha; 

  if (CheckWin_board(A, opponent(player), 4)){
    CheckWin_board(A, opponent(player), 4);
    exit(-1);
  } else if( CheckTie(A)){  
    CheckTie(A);
    exit(-1);
  } else if (level == MAX_DEPTH) {
    for(int x = 0; x < 7; x++)
      {
	if (A[5][x] != EMPTY){
	  continue;
	} else {
	  int row = findRow(A, x);
	  drop_piece(A, player, x);
	  PrintBoard(A);
	  sco = evaluate_board(A, player);     
	  if(maxScore < sco)
	    {
	      maxScore = sco; 
	      j = x;
	    }
	  A[row][x] = EMPTY;
	}
      }
    sp.sco = maxScore;
    sp.col = j;
    return sp; 
  } else {
    for(int i = 0; i < 7; i++)
      {
	if (A[5][i] != EMPTY){
	  continue;
	} else {
	  int row = findRow(A, i);
	  drop_piece(A, player, i);
	  PrintBoard(A);
	  score = bestMove_min(A, opponent(player), level+1, -beta, -alpha); 
	  if(-score.sco > maxScore)
	    {
	      maxScore = -score.sco;
	      j = i;
	    }
	  A[row][i] = EMPTY;
	}
      }
    sp.col = j; 
    sp.sco = score.sco;
  }
  return sp;  
}

scopos bestMove_min(char A[6][7], char player, int level, int alpha, int beta)
{
  int minScore = INT_MAX;
  scopos score, sp;
  int j = 0; 
  if (CheckWin_board(A, opponent(player), 4)){
    CheckWin_board(A, opponent(player), 4);
    exit(-1);
  } else if( CheckTie(A)){  
    CheckTie(A);
    exit(-1);
  } else if (level == MAX_DEPTH) {
    for(int x = 0; x < 7; x++)
      {
	if (A[5][x] != EMPTY){
	  continue;
	} else {
	  int row = findRow(A, x);
	  A[row][x] = player; 
	  //	  PrintBoard(A);
	  int sco= evaluate_board(A, player);     
	  if(sco < minScore)
	    {
	      minScore = sco;
	      j = x;
	    }
	  A[row][x] = EMPTY;	  
	}
      }
    sp.col = j; 
    sp.sco = minScore;
    return sp; 
  } else {
    for(int i = 0; i < 7; i++)
      {
	if (A[5][i] != EMPTY){
	  continue;
	} else {
	  int row = findRow(A, i);
	  A[row][i] = player; 
	  //	  PrintBoard(A);
	  // score = evaluate(A, player, i);    // put somewhere else
	  score = bestMove_max(A, opponent(player), level+1, -beta, -alpha); 

	  if(score.sco < minScore)
	    {
	      minScore = score.sco;
	      j = i;
	    }
	  A[row][i] = EMPTY; 
	}
      }
    sp.col = j; 
    sp.sco = score.sco;
  } 
  return sp;  
}

int evaluate_move(char A[6][7], char player, int row, int col) // evaluate current position for the player
{
  //int row = findRow(A, col);
  point curr; 
  curr.row = row; 
  curr.col = col; 
  int result = 0;
  result = ScoreVertical(A, player, curr) + ScoreHorizontal(A, player, curr) + ScoreUpLeftDiagonal(A, player, curr) + ScoreUpRightDiagonal(A, player, curr);
  return result; 
}

int evaluate_board(char A[6][7], char player) // evaluate the board score for the player
{
  int score = 0;
  int my_value = 0, op_value = 0;
  int temp = 0, x = 0, y = 0;
  for(int i = 0; i < 7; i++) {
    for (int j = 0; j < 6; j++) {
      if(A[i][j] != EMPTY) 
	{
	  temp = evaluate_move(A, player, x, y);
	  if(A[i][j]== player)
	    my_value += temp;
	  else
	    op_value += temp;
	}
    }
  } 
  cout << "evaluate_board: " << (my_value - op_value) << endl; 
  return (my_value - op_value);
}
  
int evaluate_bestMove(char A[6][7], int player, int level, int alpha, int beta)
{
  if (CheckWin_board(A, opponent(player), 4) )
    return CheckWin_board(A, opponent(player), 4);
  else if( CheckTie(A))  
    return CheckTie(A);
  else if (level == MAX_DEPTH) 
    return evaluate_board(A, player);     
  else {
    int best_col = 0;
    for(int i = 0; i < 7; i++)
      {  // Assume it is the other player's turn. 
        int best = -(INT_MAX);
        int maxab = alpha;
	if (A[5][i] != EMPTY){
	  continue; // The column is full. 
	} else {
	  int row = findRow(A, i);
	  A[row][i] =opponent(player); 
	  int score = evaluate_bestMove(A, opponent(player), level+1, -beta, -maxab);    // this step may be wrong
	  if(score > best)
	    {
	      best = score;
	      if (best > maxab)
		maxab = best;
            }
	  if (best > beta)
	    break;
	}
	// What's good for the other player is bad for this one. 
	return -best;
      }
  }
}

bool CheckWin(char A[6][7], char player, int cnt, point curr)
{
  if ( (CheckVertical(A, player, cnt, curr)
	+CheckHorizontal(A, player, cnt, curr)
	+CheckUpLeftDiagonal(A, player, cnt, curr)
	+CheckUpRightDiagonal(A, player, cnt, curr)) > 0 ) {
    /*	 cout << ( CheckVertical(A, player, cnt, curr)
	 +CheckHorizontal(A, player, cnt, curr)
	 +CheckUpLeftDiagonal(A, player, cnt, curr)
	 +CheckUpRightDiagonal(A, player, cnt, curr))  << endl;
	 cout << CheckVertical(A, player, cnt, curr) << endl;
	 cout << CheckHorizontal(A, player, cnt, curr) << endl;
	 cout << CheckUpLeftDiagonal(A, player, cnt, curr) << endl;
	 cout << CheckUpRightDiagonal(A, player, cnt, curr) << endl;         */
    cout << "Congratulations! You win! Your drop is " << player << ". " << endl;
    return true; 
  } else 
    return false;
}

bool CheckWin_board(char A[6][7], char player, int cnt)
{
  for(int i = 0; i < 7; i++)
    {
      int row = findRow(A, i);
      point curr; 
      curr.row = row; 
      curr.col = i;
      if ( (CheckVertical(A, player, cnt, curr)
	    +CheckHorizontal(A, player, cnt, curr)
	    +CheckUpLeftDiagonal(A, player, cnt, curr)
	    +CheckUpRightDiagonal(A, player, cnt, curr)) > 0 )
	{
	  cout << "Congratulations! You win! Your drop is " << player << ". " << endl;
	  return true; 
	}
      else 
	return false;
    }
}

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

bool isLegal(int move, char A[6][7])
{
  return (A[5][move] == EMPTY);
}

int ScoreVertical(char A[6][7], char player, point curr)
{
  int row = curr.row; 
  int col = curr.col;
  int result = 0; 

  //  char oppo = opponent(player);

  // if(CheckVertical(A, oppo, 3, curr)==0)

  if(CheckVertical(A, player, 3, curr)==0)
    {
      if(CheckVertical(A, player, 2, curr)==0)
	{
	  result += 5*CheckVertical(A, player, 1, curr);
	}
      else 
	result += 100*CheckVertical(A, player, 2, curr);
    }
  else
    result += 1000*CheckVertical(A, player, 3, curr);

  return result; 
}

int ScoreHorizontal(char A[6][7], char player, point curr)
{
  int row = curr.row; 
  int col = curr. col;
  int result = 0; 
   
  if(CheckHorizontal(A, player, 3, curr)==0)
    {
      if(CheckHorizontal(A, player, 2, curr)==0)
	{
	  result += 5*CheckHorizontal(A, player, 1, curr);
	}
      else 
	result += 100*CheckHorizontal(A, player, 2, curr);
    }
  else
    result += 1000*CheckHorizontal(A, player, 3, curr);

  return result; 
}

int ScoreUpLeftDiagonal(char A[6][7], char player, point curr)
{
  int row = curr.row; 
  int col = curr. col;
  int result = 0; 
   
  if(CheckUpLeftDiagonal(A, player, 3, curr)==0)
    {
      if(CheckUpLeftDiagonal(A, player, 2, curr)==0)
	{
	  result += 5*CheckUpLeftDiagonal(A, player, 1, curr);
	}
      else 
	result += 100*CheckUpLeftDiagonal(A, player, 2, curr);
    }
  else
    result += 1000*CheckUpLeftDiagonal(A, player, 3, curr);

  return result; 
}

int ScoreUpRightDiagonal(char A[6][7], char player, point curr)
{
  int row = curr.row; 
  int col = curr. col;
  int result = 0; 
   
  if(CheckUpRightDiagonal(A, player, 3, curr)==0)
    {
      if(CheckUpRightDiagonal(A, player, 2, curr)==0)
	{
	  result += 5*CheckUpRightDiagonal(A, player, 1, curr);
	}
      else 
	result += 100*CheckUpRightDiagonal(A, player, 2, curr);
    }
  else
    result += 1000*CheckUpRightDiagonal(A, player, 3, curr);

  return result; 
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

int findRow(char A[6][7], int col)      // return 9
{
  for(int i = 0; i < 6; i++)
    {
      if (A[i][col]==EMPTY)
	return i;
    }
  return 0;
}

 point humanMove(char A[][7], char player)
 {
   int col = askNumber("Please select the column you want to drop, ", player);
   while( !isLegal(col, A) )
     {
       cout << "\nInvalid selection. That column is already occupied, foolish human.\n";
       col = askNumber("Please select the column you want to drop, ", player);
     }
   int row = findRow(A, col); 
   A[row][col] = player;
   PrintBoard(A);
   point curr; 
   curr.row = row; 
   curr.col = col;
   return curr;
 }

 int drop_piece(char A[6][7], char player, int col)
 {
   int row = findRow(A, col);
   A[row][col] = player; 
   return 0;
 }

 
