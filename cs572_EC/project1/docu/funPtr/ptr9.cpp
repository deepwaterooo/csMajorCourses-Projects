using namespace fastdelegate;

int main(void)
{
    printf("-- FastDelegate demo --\nA no-parameter 
delegate is declared using FastDelegate0\n\n");
    FastDelegate0 noparameterdelegate(&SimpleVoidFunction);

    noparameterdelegate(); 
    //调用委托，这一句调用SimpleVoidFunction()

    printf("\n-- Examples using two-parameter delegates (int, char *) --\n\n");

    typedef FastDelegate2 MyDelegate;

    MyDelegate funclist[12]; // 委托初始化，其目标为空
    CBaseClass a("Base A");
    CBaseClass b("Base B");
    CDerivedClass d;
    CDerivedClass c;

    // 绑定一个成员函数
    funclist[0].bind(&a, &CBaseClass::SimpleMemberFunction);
    // 你也可以绑定一个静态（全局）函数
    funclist[1].bind(&SimpleStaticFunction);
    // 绑定静态成员函数
    funclist[2].bind(&CBaseClass::StaticMemberFunction);
    // 绑定const型的成员函数
    funclist[3].bind(&a, &CBaseClass::ConstMemberFunction);
    // 绑定虚拟成员函数
    funclist[4].bind(&b, &CBaseClass::SimpleVirtualFunction);

    // 你可以使用"="来赋值
    funclist[5] = MyDelegate(&CBaseClass::StaticMemberFunction);

    funclist[6].bind(&d, &CBaseClass::SimpleVirtualFunction);

    //最麻烦的情况是绑定一个抽象虚拟函数（abstract virtual function）
    funclist[7].bind(&c, &CDerivedClass::SimpleDerivedFunction);
    funclist[8].bind(&c, &COtherClass::TrickyVirtualFunction);

    funclist[9] = MakeDelegate(&c, &CDerivedClass::SimpleDerivedFunction);

    // 你也可以使用构造函数来绑定
    MyDelegate dg(&b, &CBaseClass::SimpleVirtualFunction);

    char *msg = "Looking for equal delegate";
    for (int i=0; i<12; i++) {
        printf("%d :", i);
        // 可以使用"=="
        if (funclist[i]==dg) { msg = "Found equal delegate"; };
        //可以使用"!"来判应一个空委托
        if (!funclist[i]) {
            printf("Delegate is empty\n");
        } else {
            // 调用生成的经过优化的汇编代码
            funclist[i](i, msg);
        }
    }
}
