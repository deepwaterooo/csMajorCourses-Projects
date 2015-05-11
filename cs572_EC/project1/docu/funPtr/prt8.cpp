// Borland (缺省设置) 和 Watcom C++. 
struct {
    FunctionPointer m_func_address;
    int m_delta;
    int m_vtable_index; //如果不是虚拟继承，这个值为0。
};

// Metrowerks CodeWarrior使用了稍微有些不同的方式。
// 即使在不允许多重继承的Embedded C++的模式下，它也使用这样的结构！
struct {
    int m_delta;
    int m_vtable_index; // 如果不是虚拟继承，这个值为-1。
    FunctionPointer m_func_address;
};

// 一个早期的SunCC版本显然使用了另一种规则： 
struct {
    int m_vtable_index; //如果是一个非虚拟函数（non-virtual function）,这个值为0。
    FunctionPointer m_func_address; //如果是一个虚拟函数（virtual function）,这个值为0。
    int m_delta;
};

// 下面是微软的编译器在未知继承类型的情况下或者使用/vmg选项时使用的方法：
struct {
    FunctionPointer m_func_address;
    int m_delta;
    int m_vtordisp;
    int m_vtable_index; // 如果不是虚拟继承，这个值为0
};

// AIX (PowerPC)上IBM的XLC编译器：
struct {
    FunctionPointer m_func_address; // 对PowerPC来说是64位
    int m_vtable_index; 
    int m_delta; 
    int m_vtordisp;
};

// GNU g++使用了一个机灵的方法来进行空间优化
struct {
    union {
        FunctionPointer m_func_address; // 其值总是4的倍数
        int m_vtable_index_2; // 其值被2除的结果总是奇数
    };
    int m_delta;
};


adjustedthis = *(this + vindex -1) + delta // 如果vindex!=0
adjustedthis = this + delta // 如果vindex=0
