// bitboard explain for TicTacToe and Connect 4

// http://stackoverflow.com/questions/7044670/how-to-determine-game-end-in-tic-tac-toe/7046415#7046415

// bitboard structure: 
/*
6 14 22 30 38 46 54
5 13 21 29 37 45 53
4 12 20 28 36 44 52
3 11 19 27 35 43 51
2 10 18 26 34 42 50
1  9 17 25 33 41 49
0  8 16 24 32 40 48
*/
// If the player occupies a position in the game board, then the associated bit would be 1 otherwise 0.
// notice that bits 7, 15, 23, ... are 0.

bool haswon(int64_t board)
{
    int64_t y = board & (board >> 7);
    if (y & (y >> 2 * 7)) // check \ diagonal
        return true;
    y = board & (board >> 8);
    if (y & (y >> 2 * 8)) // check horizontal -
        return true;
    y = board & (board >> 9);
    if (y & (y >> 2 * 9)) // check / diagonal
        return true;
    y = board & (board >> 1);
    if (y & (y >> 2))     // check vertical |
        return true;
    return false;
}

// example used to explain this

/*
6 14 22 30 38 46 54
5 13 21 29 37 45 53
4 12 20 28 36 44 52
3 11 19 27 35 43 51
2 10 18 26 34 42 50
1  9 17 25 33 41 49
0  8 16 24 32 40 48
*/

// The following bitboard of one player includes beside vertical and diagonal wins a winning combination in the first row.
//0000000
0101010
1110111
0111011
1101110
0001000
1010101
0011110 ... four occupied positions --> winning board

// The steps for the horizontal check are:

// y = board & (board >> 8)

0101010   0010101   0000000
1110111   0111011   0110011
0111011   0011101   0011001
1101110 & 0110111 = 0100110
0001000   0000100   0000000
1010101   0101010   0000000
0011110   0001111   0001110

//  y & (y >> 2 * 8)

0000000   0000000   0000000
0110011   0001100   0000000
0011001   0000110   0000000
0100110 & 0001001 = 0000000
0000000   0000000   0000000
0000000   0000000   0000000
0001110   0000011   0000010
