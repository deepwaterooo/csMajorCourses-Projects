class A {
public:
    virtual int Afunc() {return 2; };
};

class B {
public: 
    int Bfunc() {return 3; };
};

// C�Ǹ���һ�̳��࣬��ֻ�̳���A
class C: public A {
public: 
    int Cfunc() {return 4; };
};

// D ��ʹ���˶��ؼ̳�
class D: public A, public B {
public: 
    int Dfunc() {return 5; };
};
