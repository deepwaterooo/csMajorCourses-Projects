#include <iostream>
using namespace std;

class X {
public:
    void mf1(char* s) 
    {
        cout << "X::mf1" << s << endl;
    }
    void mf2(int i)     
    {
        cout << "X::mf2" << i << endl;
    }
};

class Y {
public:
    int mf3(char* s) 
    {
        cout << "Y::mf3" << s << endl;
        return 1;
    }
};

void main() {
    void (X::*pmf_char_x)(char*);
    pmf_char_x = &X::mf1;   //&

    X x1;
    (x1.*pmf_char_x)("hello");

    void (X::*pmf_int_x)(int);
    pmf_int_x = X::mf2;
    (x1.*pmf_int_x)(10);

    int (Y::*pmf_char_y)(char*);
    pmf_char_y = Y::mf3;
    Y y1;
    int k = (y1.*pmf_char_y)("world");
}


    
 
