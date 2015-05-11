#include <iostream>
using namespace std;

class p_example 
{
    int num;
public:
    void set_num(int val) 
    {
        num = val;
    }
    void show_num();
};

void p_example::show_num() 
{
    cout << num << endl;
}

void main() 
{
    p_example ob, *p; //说明对象指针*p
    ob.set_num(1);    
    ob.show_num();
    p = &ob;          //用地址运算符获取对象地址
    p->show_num();    //调用成员函数
}

int main() 
{
    p_example ob[2], *p; //声明对象数组和指针
    ob[0].set_num(10);
    ob[1].set_num(20);
    p = &ob[0];
    p->show_num();
    p++;           //对象指针的移动
    p->show_num();
    p--;
    p->show_num();
    return 0;
}

class A {
    int a;
public:
    int b;
    int c;
};

int A::*p_A_int = &A::a;
int A::*p_A = &A::b;
A a1;

a1.*p_A = 2;
p_A_int = &A::c;
a1.*p_A_int = 3;

A *pA = &a1;
pA->*p_A_int = 4;


class X {
public:
    int mf1(char*);
    int mf2(int);
};

int (X::*pmf_int_cp) (char*);
pmf_int_cp = &X::mf1;

X x1;
int p1 = (x1.*pmf_int_cp)("hello");

pmf_int_cp = &X::mf2;    // error
 

    

    
