#ifndef ANT_H
#define ANT_H

const int m = 31;
const int n = 32;

class ant {
 public:
    int x;  // index of row
    int y;  // index of column
    char val; // char value of specified position
    int dir;  // direction at each position
    int fitness; // keep updating # of food eaten
    char board[m][n]; // original board, never changed
    char tmpbd[m][n]; // updates for each individual's evaluation, got reset for every individual
    ant();    // constructor for initialization
    void reset();     // reset to original default value for each individual

    void getAnt();    // write the trail my ant has moved when reach certain fitness
    void left();      // move left
    void right();     // move right
    void forward();   // move forward
    bool isFoodAhead();  // check if there is food ahead
};

#endif
