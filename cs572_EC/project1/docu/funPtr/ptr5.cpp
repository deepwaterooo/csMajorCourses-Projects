#include <stdlib.h>
#include <stdio.h>

void Memberfun1( void (* f2)( ) ) { f2( ) ;} //ԭ��Ա����1���ó�Ա����//2��  
void Memberfun2( ) { printf("%s \n","Calling Test3::Memberfun2 OK");} //ԭ��Ա����2��  
void Memberfun3( ) { Memberfun1( Memberfun2);}  

int main( ) {  
    Memberfun3 ();  
    return 0;  
}

/*
  class Test3  {  
  public:  
  void Memberfun1( void (* f2)( ) ) { f2( ); }  //��Ա����1���ó�Ա����//2��  
  void Memberfun2( ) { printf("%s \n","Calling Test3::Memberfun2 OK"); } //��Ա����2��  

  void Memberfun3( ) { Memberfun1( Memberfun2); } // �������
  // no matching function for call to ��Test3::Memberfun1(<unresolved overloaded function type>)��
  // ptr5.cpp:8:48: candidate is:
  // ptr5.cpp:6:10: void Test3::Memberfun1(void (*)())
    
  // ptr5.cpp:6:10: no known conversion for argument 1
  // from ��<unresolved overloaded function type>�� to ��void (*)()��
  };  

  int main( ) {  
  Test3 t3;  
  t3.Memberfun3(); //���ó�Ա������  
  return 0;  
  } 
*/

