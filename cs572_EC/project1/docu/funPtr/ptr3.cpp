#include <stdlib.h>

typedef void (*Function1)( ); //����һ������ָ�����͡�
Function1 f1;

class Test1 {  
��public:   
    //�������õĳ�Ա������  
    void Memberfun1( ) { printf("%s \n","Calling Test3::Memberfun2 OK");};   
    void Memberfun2( ) {      
        f1 = reinterpret_cast<Function1>(Memberfun1);//����Ա����ָ�븳��f1�����������  
        f1();  
    }  
    //��  
};

int main() {  
    Test1 t1;  
    t1.Memberfun2();  
    return 0;  
} 