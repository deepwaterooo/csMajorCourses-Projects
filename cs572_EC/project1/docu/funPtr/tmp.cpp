#include <iostream>
#include <cstring>
#include <string.h>
using namespace std;

class A
{
public:
    A(int a,char* b)
    {
        i = a;
        name = new char[strlen(b) + 1];
        strcpy(name,b);
    }
    ~A()
    {
        delete [] name;
        name = NULL;
    }
    void disp()
    {
        cout << i << '\t' << name << endl;
    }
private:
    int i;
    char *name;
};

class B
{
public:
    B(int a,char* b)
    {
        i = a;
        strcpy(name,b);
    }
    void disp()
    {
        cout << i << '\t' << name << endl;
    }
private:
    int i;
    char name[20];
};

int main()
{
    B b1(1,"sss"),b2(5,"ddd"),b3(9,"ccc");
    A a1(2,"qqq"),a2(4,"www"),a3(8,"zzz");
    B b[3] = {b1,b2,b3};
    A a[3] = {a1,a2,a3}; // 问题出在这一句！为什么上一句没问题这一句就不行了？？？

    for (int i = 0; i < 3; ++i)
        a[i].disp();
    
    return 0;
}
