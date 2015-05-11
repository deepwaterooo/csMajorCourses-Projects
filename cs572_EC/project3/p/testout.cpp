#include <iostream>
#include <fstream>
using namespace std;

int main() 
{
    ifstream myfile;
    myfile.open("ant.txt");
    int m = 31;
    int n = 32;
    char board[m][n];
    int cnt = 0;
    
    for (int i = 0; i < m; ++i)
    {
        for (int j = 0; j < n; ++j)
        {
            myfile >> board[i][j];
            cout << board[i][j] << " ";
            if (board[i][j] == '/' || board[i][j] == '@' )
                ++cnt;
        }
        cout << endl;
    }
    cout << "cnt: " << cnt << endl;
}

