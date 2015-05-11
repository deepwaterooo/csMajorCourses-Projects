// Borland (ȱʡ����) �� Watcom C++. 
struct {
    FunctionPointer m_func_address;
    int m_delta;
    int m_vtable_index; //�����������̳У����ֵΪ0��
};

// Metrowerks CodeWarriorʹ������΢��Щ��ͬ�ķ�ʽ��
// ��ʹ�ڲ��������ؼ̳е�Embedded C++��ģʽ�£���Ҳʹ�������Ľṹ��
struct {
    int m_delta;
    int m_vtable_index; // �����������̳У����ֵΪ-1��
    FunctionPointer m_func_address;
};

// һ�����ڵ�SunCC�汾��Ȼʹ������һ�ֹ��� 
struct {
    int m_vtable_index; //�����һ�������⺯����non-virtual function��,���ֵΪ0��
    FunctionPointer m_func_address; //�����һ�����⺯����virtual function��,���ֵΪ0��
    int m_delta;
};

// ������΢���ı�������δ֪�̳����͵�����»���ʹ��/vmgѡ��ʱʹ�õķ�����
struct {
    FunctionPointer m_func_address;
    int m_delta;
    int m_vtordisp;
    int m_vtable_index; // �����������̳У����ֵΪ0
};

// AIX (PowerPC)��IBM��XLC��������
struct {
    FunctionPointer m_func_address; // ��PowerPC��˵��64λ
    int m_vtable_index; 
    int m_delta; 
    int m_vtordisp;
};

// GNU g++ʹ����һ������ķ��������пռ��Ż�
struct {
    union {
        FunctionPointer m_func_address; // ��ֵ����4�ı���
        int m_vtable_index_2; // ��ֵ��2���Ľ����������
    };
    int m_delta;
};


adjustedthis = *(this + vindex -1) + delta // ���vindex!=0
adjustedthis = this + delta // ���vindex=0