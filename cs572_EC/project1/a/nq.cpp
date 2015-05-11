/*
 * NQueen.cpp
 *
 *  Created on: 2013��12��23��
 *      Author: nerohwang
 */
// �β�rowCurrent��ʾ��ǰ����������
#include<iostream>
#include<fstream>
#include<iomanip>
#include<stdlib.h>
using namespace std;

bool Check(int rowCurrent,int *&NQueen);                         //�жϺ���
void Print(ofstream &os,int n,int *&NQueen);                                  //��ӡ����
void Solve(int rowCurrent,int *&NQueen,int n,int &count, ofstream &os);           //N�ʺ����⴦������indexһ���ֵΪ0

//�жϺ��������Ǻ����г�ͻ������б�����г�ͻ������FALSE
bool Check(int rowCurrent,int * &NQueen) {
    int i = 0;
    while(i < rowCurrent) {    
        if(NQueen[i] == NQueen[rowCurrent] || (abs(NQueen[i]-NQueen[rowCurrent]) == abs(i-rowCurrent)) )
            return false;
        i++;
    }
    return true;
}

//�����п��ܳ��ֵĽ������ı��ĵ�
void Print(ofstream &os,int n,int *&NQueen) {
    os<<"һ�ε���\n";
    for (int i = 0;i < n;i++) {
        for(int j = 0 ; j < n; j++)
        {
            os<<(NQueen[i]==j?1:0);
            os<<setw(2);
        }
        os<<"\n";
    }
    os<<"\n";
}
//���ĺ������ݹ���N�ʺ����⣬��������д�ӡ
void Solve(int rowCurrent,int *&NQueen,int n,int &count, ofstream &os) {
    if(rowCurrent == n)  //��ǰ�������ף��������һ�����󣬽������
    {
        Print(os,n,NQueen);
        count++;
    }
    for(int i = 0;  i < n; i++)
    {
        NQueen[rowCurrent] = i;                     //row��i����һ��
        if(Check(rowCurrent,NQueen))
        {
            Solve(rowCurrent+1,NQueen,n,count,os);  //������һ��
        }
    }
}

int main()
{
    int n;           //�����ģ
    int count = 0;   //��ļ���
    cout<<"����������Ĺ�ģN"<<endl;
    cin>>n;
    if(n<4)
    {
        cerr<<"�����ģ�������4"<<endl;
        return 0;
    }
    int *NQueen = new int[n];
    ofstream os;
    os.open("result.txt");
    Solve(0,NQueen,n,count,os);
    cout<<"there are " << count <<" solutions." << endl;
    os.close();
    return 0;
}
