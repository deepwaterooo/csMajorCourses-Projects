//main.cpp ����Ҫ�κ�����ı���ѡ��

#include <iostream>

using namespace std;

class Test;                                         //һ��forward declaration��δ�������
 
typedef void(Test::*NULLFUNCPTR)(); //δ֪�̳е����Ա����ָ������Ͷ���

extern Test  var;                                 //�ⲿ�����ȫ�ֶ���
extern  NULLFUNCPTR pfunc;           //�ⲿ��������Ա����ָ��ı���

void set();                                      //�ⲿ����Ķ����Ա����ָ��pfunc��ʼ��
 
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
