#include <iostream>
#include <cstdlib>

using namespace std;

class time
{
public:
    time(int a,int b,int c):hour(a),minute(b),sec(c){};
    void settime();
    void showtime();
public:
    int hour,minute,sec;
};

void time::settime()
{
    cin>>hour;
    cin>>minute;
    cin>>sec;
}

void time::showtime()
{ cout<<hour<<":"<<minute<<":"<<sec<<endl;
};

int main()
{
    time t1[2]={time(12,30,1),time(12,30,2)};//����������鲢��ʼ��
    time *p[2]={0};//����ָ�����飬��ʽΪ���� *ָ����,Ϊָ�븳nullֵ
    int i;
    for(i=0;i<2;i++)
    {
        p[i]=&t1[i];
    };
    //t1.settime();
    t1[0].showtime();
    t1[1].showtime();
    return 0;
}
