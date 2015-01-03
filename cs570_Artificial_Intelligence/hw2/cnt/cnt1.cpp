//  http://stackoverflow.com/questions/8731532/connect-four-program

#include <iostream>
#include <fstream>

using namespace std;

void drawboard(ostream &, char [6][7], int, int);
int humanmove(int player, char board [6][7], int rows, int columns);
int verticalwin(char board[6][7], int rows, int columns, int moverow, int movecolumn);

int main ()
{

    cout<< "Connect Four is a two-player game in which the players first ";
    cout<< " choose a letter   and then take turns dropping their letters from the top into a seven-column,";

    cout<< "    six-row vertically-suspended grid.";

    cout<< " The pieces fall straight down, occupying the next available space within the column. ";

    cout<< " The objective of the game is to connectfour of one's own discs of the same color next to each other vertically,        horizontally, or diagonally before one's opponent can do so. ";

    ofstream outfile;
    outfile.open("gamelog01.txt");
    char board[6][7] = {0};

    int player;
    int row;
    int col;
    int times;
    bool win; 
    int moverow;
    int movecolumn;

    drawboard(cout, board,6,7);

    while (player = 1)
    {
        humanmove(player, board, 6, 7);
        verticalwin(board, 6, 7, moverow, movecolumn);

        player = 2;
        humanmove(player, board, 6, 7);
        verticalwin(board, 6, 7, moverow, movecolumn);
    }

    outfile.close();
    return 0;
}

//-------------------------------------------------------------

void drawboard  (ostream & out, char b[6][7], int r, int c)
{
    out << endl;
    for (int x = r-1; x >= 0; x--)
    {
        out << "  |";

        for (int y = 0; y < c-1; y++)
            out << "----";

        out << "---|" << endl << x << " |";

        for (int y = 0; y < c-1; y++)
            if (b[x][y] == 0)
                out << "   |";
            else
                out << " " << b[x][y] << " |";

        if (b[x][c-1] == 0)
            out << "   |" << endl;
        else
            out << " " << b[x][c-1] << " |" << endl;
    }

    out << "  |";

    for (int y = 0; y < c-1; y++)
        out << "----";

    out << "---|" << endl; 
    out << " ";

    for (int y = 0; y < c; y++)
        out << "   " << y;

    out << endl;
}

int humanmove  (int player, char board[][7], int rows, int columns)
{
    char symbol;

    if(player == 1)
        symbol = 'X';
    else
        symbol = 'O';

    int col;
    cout << "What column would Player " << player << " like to play in?: " ;
    cin >> col;

    while ((col < 0) || (col >= columns))
    {
        cout << "Invalid selection. There aren't that many columns. Please enter a different    column number: ";
        cin >> col;
    }

    int row;
    for(row = 5; row >= 0; row--)
    { 
        if(board[row][col] != 0)
            break;
    }

    board[row+1][col] = symbol;

    if (row == 'X' || row == 'O')
    {
        cout << "Column " << col << " is full. Please choose another: ";
        cin >> col;
    }
    else 
    {
        drawboard(cout, board, 6, 7);
    }
}

int verticalwin  (char board[6][7], int rows, int columns, int moverow, int movecolumn)
{
}
