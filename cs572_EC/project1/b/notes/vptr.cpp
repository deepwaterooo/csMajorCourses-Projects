#include <iostream>
using namespace std;


class Base {
public:
    virtual void f() { cout << "Base::f" << endl; }
    virtual void g() { cout << "Base::g" << endl; }
    virtual void h() { cout << "Base::h" << endl; }
};

typedef void(*Fun)(void);

int main() {
    Base b;
 
    Fun pFun = NULL;

    // c++ compiler ensures that vptr (virtual table pointer) is saved the very first place of
    // object instance. 
    cout << "Address of virtual functions table: " << (int*)(&b) << endl;

    cout << "\n" << *(int*)(&b) << endl;
    cout << "\n" << (int*)(*(int*)(&b)) << endl;
    
    cout << "Address of 1st function in virtual function table: " << (int*)*(int*)(&b) << endl;

    cout << "\n" << *((int*)*(int*)(&b)) << endl;
    cout << "\n" << (Fun)*((int*)*(int*)(&b)) << endl;

    // Invoke the first virtual function 
    //pFun = (Fun)*((int*)*(int*)(&b)+0); // Base::f
    //pFun = (Fun)*((int*)*(int*)(&b)+1); // Base::g

    cout << "\n" << *((int*)*(int*)(&b)) << endl;
    cout << "\n" << (Fun)*((int*)*(int*)(&b)) << endl;
    
    pFun  =  (Fun)*((int*)*(int*)(&b)+2); // Base::h
    pFun();

    return 0;
}
	/*
(Fun)*((int*)*(int*)(&b)+0);  // Base::f()
(Fun)*((int*)*(int*)(&b)+1);  // Base::g()
(Fun)*((int*)*(int*)(&b)+2);  // Base::h()
	*/
