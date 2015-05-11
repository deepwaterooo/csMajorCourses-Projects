//main.cpp 不需要任何特殊的编译选项

#include <iostream>

using namespace std;

class Test;                                         //一个forward declaration、未定义的类
 
typedef void(Test::*NULLFUNCPTR)(); //未知继承的类成员函数指针的类型定义

extern Test  var;                                 //外部定义的全局对象
extern  NULLFUNCPTR pfunc;           //外部定义的类成员函数指针的变量

void set();                                      //外部定义的对类成员函数指针pfunc初始化
 
void Helper(Test &var, NULLFUNCPTR pf)
{
	(var.*pf)();
}
 
int main()
{ 
	size_t ss=sizeof(NULLFUNCPTR);
    set();  
	Helper(var, pfunc  );
}
