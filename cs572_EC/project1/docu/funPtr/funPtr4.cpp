#include "stdafx.h"  
#include <iostream>  
#include <typeinfo.h>

class Test;         //一个未定义的类。  
class Test2 {  };   //一个空类。  

class Test3 {       //一个有定义的类。  
　public:  
    void (* memberfun)();  
    void Memberfun1( void (* f2)( ) ) { f2( ); } //成员函数1调用成员函数//2。  
    void Memberfun2( );     //成员函数2。  
};  

class Test4: virtual Test3, Test2 { //一个有virtual继承的类（derivative class）。  
　public:  
    void Memberfun1( void (* f2)( ) ) { f2( ); }   
};  

class Test5: Test3,Test2 { //一个继承类（derivative class）。  
　public:  
    void Memberfun1( void (* f2)( ) ) { f2( ); }   
};  
 
int main() {  
    　std::cout << "一般函数指针长度= " << sizeof(void(*)())  <<  '\n';  

    　std::cout << "-类的成员函数指针长度-" << '\n' << '\n';  
    　std::cout << "Test3类成员函数指针长度=" << sizeof(void(Test3::*)()) << '\n' << '\n';  
    　std::cout << "Test5类成员函数指针长度=" << sizeof(void (Test5:: *)()) << '\n';  
    　std::cout << "Test4类成员函数指针长度=" << sizeof(void (Test4:: *)()) << '\n';  
    　std::cout << "Test类成员函数指针长度=" << sizeof(void(Test::*)())  << '\n';  
    　return 0;  
} 

class Test2 {  
    int static __cdecl Compare(const void* elem1, const void* elem2); //成员函数。  
    //其他不变  
};


class Test3 {  
　public:  
    void static __cdecl Helper(Test3* test3) {  
        　test3->Memberfun2();  
    }  
    void Memberfun1( void (* f2)(Test3*)) { f2(this); } //将对象信息传给Helper函数。  
    void Memberfun2( ) {printf("%s \n","Calling Test3::Memberfun2 OK"); } //成员函数2。  
    void Memberfun3( ) { Memberfun1( Helper);}   
}; 




class Test3;  
void __cdecl Helper(Test3* test3);

class Test3 {  
　public:  
    void Memberfun1( void (* f2)(Test3*)) { f2(this) ;} //成员函数1调用成员函数//2。  
    void Memberfun2( ) {printf("%s \n","Calling Test3::Memberfun2 OK"); } //成员函数2。  
    void Memberfun3( ) { Memberfun1( Helper);}   
};  
 
void __cdecl Helper(Test3* test3) {  
    test3->Memberfun2();  
}; 
