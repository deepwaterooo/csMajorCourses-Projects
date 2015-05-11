#include <stdio.h>

class SomeClass {
public: 
    virtual void some_member_func(int x, char *p) {
        printf("In SomeClass");
    };
};

class DerivedClass : public SomeClass {
public:
    // ��������һ�е�ע������������ line (*)����һ�л���ִ���
    // virtual void some_member_func(int x, char *p){printf("In DerivedClass");};
};

int main() {
    //����SomeClass�ĳ�Ա����ָ��
    typedef void (SomeClass::*SomeClassMFP)(int, char *);
    
    SomeClassMFP my_memfunc_ptr;
    my_memfunc_ptr = &DerivedClass::some_member_func;  // ---- line (*)
    // error: cannot convert ��void (DerivedClass::*)(int, char*)�� to
    // ��SomeClassMFP {aka void (SomeClass::*)(int, char*)}�� in assignment

    return 0;
}


class SomeClass;
typedef void (SomeClass::*SomeClassFunction)(void);

void Invoke(SomeClass *pClass, SomeClassFunction funcptr) {
    (pClass->*funcptr)();
};
