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
// global constants
const char X = 'X'; 
const char O = 'O';
const char EMPTY = ' ';
const char TIE = 'T';
const char NO_ONE = 'N';
char Board[6][7];   
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
int bestMove_minmax(char A[][7], int depth, int alpha, int beta, char player);
int bestMove_max(char A[6][7], char player, int level, int alpha, int beta);
int bestMove_min(char A[6][7], char player, int level, int alpha, int beta);
int Heuristic(char arr[6][7]);
int checkhole(char arr[6][7], char thn[6][7], int x,int y);
int score_pos(char A[6][7], point curr, char player);

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
	int col= bestMove_minmax(Board, 2, -INT_MAX, INT_MAX, turn);
	int row = findRow(Board, col);
	Board[row][col] = O;
	cout <<"AI col#: " << col << endl;
	PrintBoard(Board);
	move.row = row; 
	move.col = col;
      }
      if (CheckTie(Board))
	break;
    }
  return 0;
}

/**************************************************************/
/*** Functions ************************************************/
/**************************************************************/
int bestMove_minmax(char A[][7], int depth, int alpha, int beta, char player)
{
  int score, j;
  for(int i = 0; i < 7; i++)
    {
      if (A[5][i] != EMPTY){
	continue;
      } else {
	int row = findRow(A, i);
	A[row][i] = player; 
	cout <<"Max col: " << i << endl;
	PrintBoard(A);
	score = bestMove_min(A, opponent(player), depth-1, alpha, beta);    
	A[row][i] = EMPTY; 

	cout << "Max Col " << i << " score: " << score << endl;
	if(alpha < score)
	  {
	    alpha = score;
	    cout << "ROOT max alpha update: " << alpha << endl;
	    j = i;
	  }
      }
    }
  return j; 
}

int bestMove_max(char A[6][7], char player, int level, int alpha, int beta)
{
  int score;
  if (CheckWin_board(A, player, 4)){
      if(player==X)
      return -INT_MAX;
    else
      return INT_MAX;
  } else if( CheckTie(A)){  
    cout <<"Max tie!" << endl;
    return 0;
  } else if (level == 0) {
    for(int x = 0; x < 7; x++)
      {
	if (A[5][x] != EMPTY){
	  continue;
	} else {
	  int row = findRow(A, x);
	  drop_piece(A, player, x);
	  PrintBoard(A);
	  score = Heuristic(A);
	  //score = evaluate_board(A, player);     
	  cout << "Max Col " << x << " score: " << score << endl;
	  if(alpha < score)
	    {
	    alpha = score; 
	    cout << "max alpha update: " << alpha << endl;
	    }
	  A[row][x] = EMPTY;
	  if (alpha >= beta)
	    break;
	}
      }
    cout << "Return from Max score: " << alpha << endl;
    return alpha;
  } else {
    for(int i = 0; i < 7; i++)
      {
	if (A[5][i] != EMPTY){
	  continue;
	} else {
	  int row = findRow(A, i);
	  drop_piece(A, player, i);
	  PrintBoard(A);
	  cout << "Max col: " << i << endl;
	  score = bestMove_min(A, opponent(player), level-1, alpha, beta); 
	  cout << "Max Col " << i << " score: " << score << endl;
	  A[row][i] = EMPTY;
	  if(alpha < score)
	    {
	    alpha = score; 
	    cout << "max alpha update: " << alpha << endl;
	    }
	  if (alpha >= beta)
	    break;
	}
      }
  }
  cout << "Return from Max score: " << alpha << endl;
  return alpha;  
}

int bestMove_min(char A[6][7], char player, int level, int alpha, int beta)
{
  int score;
  if (CheckWin_board(A, player, 4)){    
      if(player==X)
      return -INT_MAX;
    else
      return INT_MAX;
  } else if( CheckTie(A)){  
    cout <<"Min tie!" << endl;
    return 0;
  } else if (level == 0) {
    for(int x = 0; x < 7; x++)
      {
	if (A[5][x] != EMPTY){
	  continue;
	} else {
	  int row = findRow(A, x);
	  A[row][x] = player; 
	  cout << "Min col: " << x << endl;
	  PrintBoard(A);
	  //score = evaluate_board(A, player);     
	  // score  = score_pos(A, curr, player);
	  point curr; 
	  curr.row = row; 
	  curr.col = x;
	  score = Heuristic(A);
	  cout << "Min col " << x << ": " << score << endl;
	  A[row][x] = EMPTY;	  
	  if(score < beta)
	    {
	      beta = score;
	      cout << "min beta update: " << beta << endl;
	    }
	  if (beta <= alpha)
	    break;
	}
      }
    cout << "Return from Min score: " << beta << endl;
    return beta;
  } else {
    for(int i = 0; i < 7; i++)
      {
	if (A[5][i] != EMPTY){
	  continue;
	} else {
	  int row = findRow(A, i);
	  A[row][i] = player; 
	  cout << "Min col: " << i << endl;
	  PrintBoard(A);
	  score = bestMove_max(A, opponent(player), level-1, alpha, beta); 
	  cout << "Min col " << i << ": " << score << endl;
	  A[row][i] = EMPTY; 
	  if(score < beta)
	    {
	      beta = score;
	      cout << "min beta update: " << beta << endl;
	    }
	  if (beta <= alpha)
	    break;
	}
      }
 cout << "Return from Min score: " << score << endl;
 return beta;  
  }
}

int evaluate_move(char A[6][7], char player, int row, int col) 
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
  for(int i = 0; i < 6; i++) {
    for (int j = 0; j < 7; j++) {
      int i = findRow(A,j);
      if(A[i][j] != EMPTY) 
	{
	  temp = evaluate_move(A, player, x, y);
	  point a; 
	  a.row = i;
	  a.col = j; 
	  // temp = score_pos(A, a, player);

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
 
int score_pos(char A[6][7], point curr, char player)
{
  int score = 0; 
   char a = A[curr.row][curr.col];
   char oppo = opponent(a);
  if ( (CheckVertical(A, player, 4, curr)+CheckHorizontal(A, player, 4, curr)+CheckUpLeftDiagonal(A, player, 4, curr)+CheckUpRightDiagonal(A, player, 4, curr))>0 )
    score += (CheckVertical(A, player, 4, curr)+CheckHorizontal(A, player, 4, curr)+CheckUpLeftDiagonal(A, player, 4, curr)+CheckUpRightDiagonal(A, player, 4, curr))* 1000;
  else {
    A[curr.row][curr.col] = oppo;
    if ((CheckVertical(A, oppo, 4, curr)+CheckHorizontal(A, oppo, 4, curr)+CheckUpLeftDiagonal(A, oppo, 4, curr)+CheckUpRightDiagonal(A, oppo, 4, curr))> 0)
      score += (CheckVertical(A, oppo, 4, curr)+CheckHorizontal(A, oppo, 4, curr)+CheckUpLeftDiagonal(A, oppo, 4, curr)+CheckUpRightDiagonal(A, oppo, 4, curr))*10000;
    A[curr.row][curr.col] = a;

    if ( (CheckVertical(A, player, 3, curr)+CheckHorizontal(A, player, 3, curr)+CheckUpLeftDiagonal(A, player, 3, curr)+CheckUpRightDiagonal(A, player, 3, curr))>0 )
      score += (CheckVertical(A, player, 4, curr)+CheckHorizontal(A, player, 4, curr)+CheckUpLeftDiagonal(A, player, 4, curr)+CheckUpRightDiagonal(A, player, 4, curr))*16;
    else if ((CheckVertical(A, player, 2, curr)+CheckHorizontal(A, player, 2, curr)+CheckUpLeftDiagonal(A, player, 2, curr)+CheckUpRightDiagonal(A, player, 2, curr))>0)
      score += (CheckVertical(A, player, 2, curr)+CheckHorizontal(A, player, 2, curr)+CheckUpLeftDiagonal(A, player, 2, curr)+CheckUpRightDiagonal(A, player, 2, curr))*4;
    else
      score += (CheckVertical(A, player, 1, curr)+CheckHorizontal(A, player, 1, curr)+CheckUpLeftDiagonal(A, player, 1, curr)+CheckUpRightDiagonal(A, player, 1, curr))*1;
  }
  
  A[curr.row][curr.col] = oppo;
  score += (CheckVertical(A, oppo, 3, curr)+CheckHorizontal(A, oppo, 3, curr)+CheckUpLeftDiagonal(A, oppo, 3, curr)+CheckUpRightDiagonal(A, oppo, 3, curr))*100;
  A[curr.row][curr.col] = a;

  cout << "! Score: " << score << endl;
  return score; 	
}
 
// max_depth
int evaluate_bestMove(char A[6][7], int player, int level, int alpha, int beta)
{
  if (CheckWin_board(A, opponent(player), 4) )
    return CheckWin_board(A, opponent(player), 4);
  else if( CheckTie(A))  
    return CheckTie(A);
  else if (level == 0) 
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
    /*    cout << ( CheckVertical(A, player, cnt, curr)
	  +CheckHorizontal(A, player, cnt, curr)
	  +CheckUpLeftDiagonal(A, player, cnt, curr)
	  +CheckUpRightDiagonal(A, player, cnt, curr))  << endl;

	  cout << CheckVertical(A, player, cnt, curr) << endl;
	  cout << CheckHorizontal(A, player, cnt, curr) << endl;
	  cout << CheckUpLeftDiagonal(A, player, cnt, curr) << endl;
	  cout << CheckUpRightDiagonal(A, player, cnt, curr) << endl;         */
    if (player == X)
      cout << "Congratulations! You win! Your drop is " << player << ". " << endl;
    else 
      cout << "Haha, I win! I am Computer Intelligence! You can NOT BEAT me!!!" << endl;
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
	  // cout << "Congratulations! You win! Your drop is " << player << ". " << endl;    ****************************************************************
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

//************************************************************************************* need to do some modification here **********************************
int ScoreVertical(char A[6][7], char player, point curr)
{
  int row = curr.row; 
  int col = curr.col;
  int result = 0; 
  if(CheckVertical(A, player, 3, curr)==0) {
    if(CheckVertical(A, player, 2, curr)==0) {
      result += CheckVertical(A, player, 1, curr);
    } else 
      result += 10*CheckVertical(A, player, 2, curr);
  } else
    result += 40*CheckVertical(A, player, 3, curr);
  return result; 
}

int ScoreHorizontal(char A[6][7], char player, point curr)
{
  int row = curr.row; 
  int col = curr. col;
  int result = 0; 
  if(CheckHorizontal(A, player, 3, curr)==0) {
    if(CheckHorizontal(A, player, 2, curr)==0) {
      result += CheckHorizontal(A, player, 1, curr);
    } else 
      result += 10*CheckHorizontal(A, player, 2, curr);
  } else
    result += 40*CheckHorizontal(A, player, 3, curr);
  return result; 
}

int ScoreUpLeftDiagonal(char A[6][7], char player, point curr)
{
  int row = curr.row; 
  int col = curr. col;
  int result = 0; 
  if(CheckUpLeftDiagonal(A, player, 3, curr)==0) {
    if(CheckUpLeftDiagonal(A, player, 2, curr)==0) {
      result += CheckUpLeftDiagonal(A, player, 1, curr);
    } else 
      result += 10*CheckUpLeftDiagonal(A, player, 2, curr);
  } else
    result += 40*CheckUpLeftDiagonal(A, player, 3, curr);
  return result; 
}

int ScoreUpRightDiagonal(char A[6][7], char player, point curr)
{
  int row = curr.row; 
  int col = curr. col;
  int result = 0; 
  if(CheckUpRightDiagonal(A, player, 3, curr)==0) {
    if(CheckUpRightDiagonal(A, player, 2, curr)==0) {
      result += CheckUpRightDiagonal(A, player, 1, curr);
    } else 
      result += 10*CheckUpRightDiagonal(A, player, 2, curr);
  } else
    result += 40*CheckUpRightDiagonal(A, player, 3, curr);
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
 
