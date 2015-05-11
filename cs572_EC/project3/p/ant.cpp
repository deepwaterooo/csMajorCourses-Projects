#include <iostream>
#include <fstream>
#include "ant.h"
using namespace std;

ant::ant() {
    x = 0;
    y = 0;

    ifstream file;
    file.open("santafeTrail.txt");
    while(!file.eof()) {
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                file >> board[i][j];
            }
        }
    }
    val = board[0][0];
    dir = 0;
    fitness = 0;
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            tmpbd[i][j] = board[i][j];
            cout << board[i][j] << " ";
        }
        cout << endl;
    }
}

void ant::getAnt() {
    ofstream myout;
    myout.open("ant.txt");
    for( int i = 0; i < m; ++i)  {
        for (int j = 0; j < n; ++j) {
            myout << tmpbd[i][j];
            myout << " ";
        }
        myout << endl;
    }
    myout.close();
}

void ant::left() {
    int a = x, b = y;
    switch(dir) {
    case 0:
        a -= 1;
        dir = 3;
        break;
    case 1:
        b += 1;
        dir = 0;
        break;
    case 2:
        a += 1;
        dir = 1;
        break;
    case 3:
        b -= 1;
        dir = 2;
        break;
    }
    if (a < 0)
        a = m-1;
    else if (a > m-1)
        a = 0;
    if (b < 0)
        b = n-1;
    else if (b > n-1)
        b = 0;
    if (tmpbd[x][y]=='X')  {
        tmpbd[x][y] = '@';
        fitness += 1;
    } else
        tmpbd[x][y] = '/';
    x = a;
    y = b;
}

void ant::right() {
    int a = x, b = y;
    switch(dir) {
    case 0:
        a += 1;
        dir = 1;
        break;
    case 1:
        b -= 1;
        dir = 2;
        break;
    case 2:
        a -= 1;
        dir = 3;
        break;
    case 3:
        b += 1;
        dir = 0;
        break;
    }
    if (a < 0)
        a = m-1;
    else if (a > m-1)
        a = 0;
    if (b < 0)
        b = n-1;
    else if (b > n-1)
        b = 0;
    if (tmpbd[x][y]=='X')  {
        tmpbd[x][y] = '@';
        fitness += 1;
    } else
        tmpbd[x][y] = '/';
    x = a;
    y = b;
}

void ant::forward() {
    int a = x, b = y;
    switch(dir) {
    case 0:
        b += 1;
        break;
    case 1:
        a += 1;
        break;
    case 2:
        b -= 1;
        break;
    case 3:
        a -= 1;
        break;
    }
    if (a < 0)
        a = m-1;
    else if (a > m-1)
        a = 0;
    if (b < 0)
        b = n-1;
    else if (b > n-1)
        b = 0;
    if (tmpbd[x][y]=='X')  {
        tmpbd[x][y] = '@';
        fitness += 1;
    } else
        tmpbd[x][y] = '/';
    x = a;
    y = b;
}

bool ant::isFoodAhead() {
    int a = x, b = y;
    switch(dir) {
    case 0:
        b += 1;
        break;
    case 1:
        a += 1;
        break;
    case 2:
        b -= 1;
        break;
    case 3:
        a -= 1;
        break;
    }
    if (a < 0)
        a = m-1;
    else if (a > m-1)
        a = 0;
    if (b < 0)
        b = n-1;
    else if (b > n-1)
        b = 0;
    if (tmpbd[a][b] == 'X') {    
        return true;
    }
    else return false;
}

void ant::reset() {
    x = 0;
    y = 0;
    val = board[0][0];
    dir = 0;  // towards right
    fitness = 0;
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            tmpbd[i][j] = board[i][j];
        }
    }
}

