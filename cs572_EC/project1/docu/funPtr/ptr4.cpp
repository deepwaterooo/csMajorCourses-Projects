#include <stdlib.h>
#include <stdio.h>

class Test2  {  
private:   
    int data[2];   
public:  
    int __cdecl Compare(const void* elem1, const void* elem2) { //��Ա������  
        printf("%s \n","Calling Test2::Memberfun OK");  
        return *((int*)elem1) - *((int*)elem2);   
    };

    void Memberfun() {       
        data[0]=2; data[1]=5;  
        qsort( data, 2, sizeof(int), Compare); //��׼�⺯�����ó�Ա�������������
        // cannot convert 'Test2::Compare' from type 'int (Test2::)(const void*, const void*)'
        // to type '__compar_fn_t {aka int (*)(const void*, const void*)}'
    };
};  

int main( )  {  
    Test2 t2;  
    t2.Memberfun(); //���ó�Ա������  
    return 0;  
}  
