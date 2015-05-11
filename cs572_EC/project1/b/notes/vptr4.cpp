#include <iostream>

using namespace std;

typedef void(*Fun)(void);

class Base1 {
public:
    int ibase1;
    Base1():ibase1(10) {}
    virtual void f() { cout << "Base1::f()" << endl; }
    virtual void g() { cout << "Base1::g()" << endl; }
    virtual void h() { cout << "Base1::h()" << endl; }
 
};
 
class Base2 {
public:
    int ibase2;
    Base2():ibase2(20) {}
    virtual void f() { cout << "Base2::f()" << endl; }
    virtual void g() { cout << "Base2::g()" << endl; }
    virtual void h() { cout << "Base2::h()" << endl; }
};
 
class Base3 {
public:
    int ibase3;
    Base3():ibase3(30) {}
    virtual void f() { cout << "Base3::f()" << endl; }
    virtual void g() { cout << "Base3::g()" << endl; }
    virtual void h() { cout << "Base3::h()" << endl; }
};
 
 
class Derive : public Base1, public Base2, public Base3 {
public:
    int iderive;
    Derive():iderive(100) {}
    virtual void f() { cout << "Derive::f()" << endl; }
    virtual void g1() { cout << "Derive::g1()" << endl; }
};


int main() {

    Derive d;
    int** pVtab = (int**)&d;
 
    cout << "[0] Base1::_vptr->" << endl;
    Fun pFun = (Fun)pVtab[0][0];
    cout << "     [0] ";
    pFun();
 
    pFun = (Fun)pVtab[0][1];
    cout << "     [1] ";pFun();
 
    pFun = (Fun)pVtab[0][2];
    cout << "     [2] ";pFun();
 
    pFun = (Fun)pVtab[0][3];
    cout << "     [3] "; pFun();
 
    pFun = (Fun)pVtab[0][4];
    cout << "     [4] "; cout<<pFun<<endl;
 
    cout << "[1] Base1.ibase1 = " << (int)pVtab[1] << endl;
 
 
    int s = sizeof(Base1)/4;
 
    cout << "[" << s << "] Base2::_vptr->"<<endl;
    pFun = (Fun)pVtab[s][0];
    cout << "     [0] "; pFun();
 
    pFun = (Fun)pVtab[s][1];
    cout << "     [1] "; pFun();
 
    pFun = (Fun)pVtab[s][2];
    cout << "     [2] "; pFun();
 
    pFun = (Fun)pVtab[s][3];
    cout << "     [3] ";
    cout<<pFun<<endl;
 
    cout << "["<< s+1 <<"] Base2.ibase2 = " << (int)pVtab[s+1] << endl;
 

    s = s + sizeof(Base2)/4;

    cout << "[" << s << "] Base3::_vptr->"<<endl;
    pFun = (Fun)pVtab[s][0];
    cout << "     [0] "; pFun();
 
    pFun = (Fun)pVtab[s][1];
    cout << "     [1] "; pFun();
 
    pFun = (Fun)pVtab[s][2];
    cout << "     [2] "; pFun();
 
    pFun = (Fun)pVtab[s][3];
    cout << "     [3] ";
    cout<<pFun<<endl;

    
    s++;
    cout << "["<< s <<"] Base3.ibase3 = " << (int)pVtab[s] << endl;
    s++;
    cout << "["<< s <<"] Derive.iderive = " << (int)pVtab[s] << endl;

    return 0;
}

/*
jenny@jenny-G50VT ~/docu/572/b $ g++ vptr4.cpp
jenny@jenny-G50VT ~/docu/572/b $ ./a.out
[0] Base1::_vptr->
     [0] Derive::f()
     [1] Base1::g()
     [2] Base1::h()
     [3] Derive::g1()
     [4] 1
[1] Base1.ibase1 = 10
[2] Base2::_vptr->
     [0] Derive::f()
     [1] Base2::g()
     [2] Base2::h()
     [3] 1
[3] Base2.ibase2 = 20
[4] Base3::_vptr->
     [0] Derive::f()
     [1] Base3::g()
     [2] Base3::h()
     [3] 0
[5] Base3.ibase3 = 30
[6] Derive.iderive = 100

1）  每个父类都有自己的虚表。
2）  子类的成员函数被放到了第一个父类的表中。
3）  内存布局中，其父类布局依次按声明顺序排列。
4）  每个父类的虚表中的f()函数都被overwrite成了子类的f()。这样做就是为了解决不同的父类类型的指针指向同一个子类实例，而能够调用到实际的函数。
 */
