#include <stdlib.h>

typedef void (*Function1)( ); //定义一个函数指针类型。
Function1 f1;

class Test1 {  
　public:   
    //…被调用的成员函数。  
    void Memberfun1( ) { printf("%s \n","Calling Test3::Memberfun2 OK");};   
    void Memberfun2( ) {      
        f1 = reinterpret_cast<Function1>(Memberfun1);//将成员函数指针赋予f1。编译出错。  
        f1();  
    }  
    //…  
};

int main() {  
    Test1 t1;  
    t1.Memberfun2();  
    return 0;  
} 
