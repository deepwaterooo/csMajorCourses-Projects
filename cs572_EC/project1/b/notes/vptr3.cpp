#include <iostream>

using namespace std;

typedef void(*Fun)(void);

class Parent {
public:
    int iparent;
    Parent ():iparent (10) {}
    virtual void f() { cout << " Parent::f()" << endl; }
    virtual void g() { cout << " Parent::g()" << endl; }
    virtual void h() { cout << " Parent::h()" << endl; }
 
};
 
class Child : public Parent {
public:
    int ichild;
    Child():ichild(100) {}
    virtual void f() { cout << "Child::f()" << endl; }
    virtual void g_child() { cout << "Child::g_child()" << endl; }
    virtual void h_child() { cout << "Child::h_child()" << endl; }
};
 
class GrandChild : public Child{
public:
    int igrandchild;
    GrandChild():igrandchild(1000) {}
    virtual void f() { cout << "GrandChild::f()" << endl; }
    virtual void g_child() { cout << "GrandChild::g_child()" << endl; }
    virtual void h_grandchild() { cout << "GrandChild::h_grandchild()" << endl; }
};

int main() {
    GrandChild gc;
    int** pVtab = (int**)&gc;
 
    cout << "[0] GrandChild::_vptr->" << endl;
    for (int i=0; (Fun)pVtab[0][i]!=NULL; i++){
	Fun pFun = (Fun)pVtab[0][i];
	cout << "    ["<<i<<"] ";
	pFun();
    }
    cout << "[1] Parent.iparent = " << (int)pVtab[1] << endl;
    cout << "[2] Child.ichild = " << (int)pVtab[2] << endl;
    cout << "[3] GrandChild.igrandchild = " << (int)pVtab[3] << endl;

    return 0;
}

/*
  jenny@jenny-G50VT ~/docu/572/b $ g++ vptr3.cpp
  jenny@jenny-G50VT ~/docu/572/b $ ./a.out
  [0] GrandChild::_vptr->
  [0] GrandChild::f()
  [1]  Parent::g()
  [2]  Parent::h()
  [3] GrandChild::g_child()
  [4] Child::h_child()
  [5] GrandChild::h_grandchild()
  [1] Parent.iparent = 10
  [2] Child.ichild = 100
  [3] GrandChild.igrandchild = 1000
*/
