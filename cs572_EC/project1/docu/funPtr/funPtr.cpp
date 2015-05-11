#include <iostream>
 
class Test; //一个未定义的类。
 
class Test2 
{
    int i;
public:
	void foo(){ }
};
 
class Test3 
{
	int i;
public:
    void foo(){ }
};
 
class Test4:public Test2 , public Test3    //多继承的类 
{
	int i;
public:
    void foo(  ) { }
};
 
class Test5:virtual public Test4      //虚继承的类 
{
	int i;
public:
    void foo(  ) { }
};
 
int main()
{ 
    std::cout <<"Test3类成员函数指针长度="<<sizeof(void(Test3::*)()) <<'\n';
    std::cout <<"Test4类成员函数指针长度="<<sizeof(void(Test4::*)()) <<'\n';
    std::cout <<"Test5类成员函数指针长度="<<sizeof(void(Test5::*)()) <<'\n';	 
    std::cout <<"Test类成员函数指针长度="<<sizeof(void(Test::*)()) <<'\n';
 
    //以下可以打开IDE的反汇编（Disassembly）窗口观察成员函数指针的赋值与调用
    Test5 a;                                                             //定义一个实例
    void (Test5::* pfunc)()=&Test5::foo;                //定义类成员函数指针并赋值

    // compile error here followed 3 lines
    //pfunc=&Test5::Test2::foo;
    //pfunc=&Test2::foo;
    //pfunc=&Test5::Test3::foo;
 
    (a.*pfunc)();  //调用类成员函数指针，同时使用了虚基表（vbtbl）索引值与this指针调整值
}
