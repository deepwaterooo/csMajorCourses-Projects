class A {
public:
    virtual int Afunc() {return 2; };
};

class B {
public: 
    int Bfunc() {return 3; };
};

// C是个单一继承类，它只继承于A
class C: public A {
public: 
    int Cfunc() {return 4; };
};

// D 类使用了多重继承
class D: public A, public B {
public: 
    int Dfunc() {return 5; };
};
