using namespace fastdelegate;

int main(void)
{
    printf("-- FastDelegate demo --\nA no-parameter 
delegate is declared using FastDelegate0\n\n");
    FastDelegate0 noparameterdelegate(&SimpleVoidFunction);

    noparameterdelegate(); 
    //����ί�У���һ�����SimpleVoidFunction()

    printf("\n-- Examples using two-parameter delegates (int, char *) --\n\n");

    typedef FastDelegate2 MyDelegate;

    MyDelegate funclist[12]; // ί�г�ʼ������Ŀ��Ϊ��
    CBaseClass a("Base A");
    CBaseClass b("Base B");
    CDerivedClass d;
    CDerivedClass c;

    // ��һ����Ա����
    funclist[0].bind(&a, &CBaseClass::SimpleMemberFunction);
    // ��Ҳ���԰�һ����̬��ȫ�֣�����
    funclist[1].bind(&SimpleStaticFunction);
    // �󶨾�̬��Ա����
    funclist[2].bind(&CBaseClass::StaticMemberFunction);
    // ��const�͵ĳ�Ա����
    funclist[3].bind(&a, &CBaseClass::ConstMemberFunction);
    // �������Ա����
    funclist[4].bind(&b, &CBaseClass::SimpleVirtualFunction);

    // �����ʹ��"="����ֵ
    funclist[5] = MyDelegate(&CBaseClass::StaticMemberFunction);

    funclist[6].bind(&d, &CBaseClass::SimpleVirtualFunction);

    //���鷳������ǰ�һ���������⺯����abstract virtual function��
    funclist[7].bind(&c, &CDerivedClass::SimpleDerivedFunction);
    funclist[8].bind(&c, &COtherClass::TrickyVirtualFunction);

    funclist[9] = MakeDelegate(&c, &CDerivedClass::SimpleDerivedFunction);

    // ��Ҳ����ʹ�ù��캯������
    MyDelegate dg(&b, &CBaseClass::SimpleVirtualFunction);

    char *msg = "Looking for equal delegate";
    for (int i=0; i<12; i++) {
        printf("%d :", i);
        // ����ʹ��"=="
        if (funclist[i]==dg) { msg = "Found equal delegate"; };
        //����ʹ��"!"����Ӧһ����ί��
        if (!funclist[i]) {
            printf("Delegate is empty\n");
        } else {
            // �������ɵľ����Ż��Ļ�����
            funclist[i](i, msg);
        }
    }
}
