#include <iostream>
 
class Test; //һ��δ������ࡣ
 
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
 
class Test4:public Test2 , public Test3    //��̳е��� 
{
	int i;
public:
    void foo(  ) { }
};
 
class Test5:virtual public Test4      //��̳е��� 
{
	int i;
public:
    void foo(  ) { }
};
 
int main()
{ 
    std::cout <<"Test3���Ա����ָ�볤��="<<sizeof(void(Test3::*)()) <<'\n';
    std::cout <<"Test4���Ա����ָ�볤��="<<sizeof(void(Test4::*)()) <<'\n';
    std::cout <<"Test5���Ա����ָ�볤��="<<sizeof(void(Test5::*)()) <<'\n';	 
    std::cout <<"Test���Ա����ָ�볤��="<<sizeof(void(Test::*)()) <<'\n';
 
    //���¿��Դ�IDE�ķ���ࣨDisassembly�����ڹ۲��Ա����ָ��ĸ�ֵ�����
    Test5 a;                                                             //����һ��ʵ��
    void (Test5::* pfunc)()=&Test5::foo;                //�������Ա����ָ�벢��ֵ

    // compile error here followed 3 lines
    //pfunc=&Test5::Test2::foo;
    //pfunc=&Test2::foo;
    //pfunc=&Test5::Test3::foo;
 
    (a.*pfunc)();  //�������Ա����ָ�룬ͬʱʹ���������vbtbl������ֵ��thisָ�����ֵ
}
