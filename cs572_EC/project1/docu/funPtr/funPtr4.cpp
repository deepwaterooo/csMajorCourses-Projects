#include "stdafx.h"  
#include <iostream>  
#include <typeinfo.h>

class Test;         //һ��δ������ࡣ  
class Test2 {  };   //һ�����ࡣ  

class Test3 {       //һ���ж�����ࡣ  
��public:  
    void (* memberfun)();  
    void Memberfun1( void (* f2)( ) ) { f2( ); } //��Ա����1���ó�Ա����//2��  
    void Memberfun2( );     //��Ա����2��  
};  

class Test4: virtual Test3, Test2 { //һ����virtual�̳е��ࣨderivative class����  
��public:  
    void Memberfun1( void (* f2)( ) ) { f2( ); }   
};  

class Test5: Test3,Test2 { //һ���̳��ࣨderivative class����  
��public:  
    void Memberfun1( void (* f2)( ) ) { f2( ); }   
};  
 
int main() {  
    ��std::cout << "һ�㺯��ָ�볤��= " << sizeof(void(*)())  <<  '\n';  

    ��std::cout << "-��ĳ�Ա����ָ�볤��-" << '\n' << '\n';  
    ��std::cout << "Test3���Ա����ָ�볤��=" << sizeof(void(Test3::*)()) << '\n' << '\n';  
    ��std::cout << "Test5���Ա����ָ�볤��=" << sizeof(void (Test5:: *)()) << '\n';  
    ��std::cout << "Test4���Ա����ָ�볤��=" << sizeof(void (Test4:: *)()) << '\n';  
    ��std::cout << "Test���Ա����ָ�볤��=" << sizeof(void(Test::*)())  << '\n';  
    ��return 0;  
} 

class Test2 {  
    int static __cdecl Compare(const void* elem1, const void* elem2); //��Ա������  
    //��������  
};


class Test3 {  
��public:  
    void static __cdecl Helper(Test3* test3) {  
        ��test3->Memberfun2();  
    }  
    void Memberfun1( void (* f2)(Test3*)) { f2(this); } //��������Ϣ����Helper������  
    void Memberfun2( ) {printf("%s \n","Calling Test3::Memberfun2 OK"); } //��Ա����2��  
    void Memberfun3( ) { Memberfun1( Helper);}   
}; 




class Test3;  
void __cdecl Helper(Test3* test3);

class Test3 {  
��public:  
    void Memberfun1( void (* f2)(Test3*)) { f2(this) ;} //��Ա����1���ó�Ա����//2��  
    void Memberfun2( ) {printf("%s \n","Calling Test3::Memberfun2 OK"); } //��Ա����2��  
    void Memberfun3( ) { Memberfun1( Helper);}   
};  
 
void __cdecl Helper(Test3* test3) {  
    test3->Memberfun2();  
}; 
