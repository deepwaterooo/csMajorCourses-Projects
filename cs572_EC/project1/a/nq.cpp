/*
 * NQueen.cpp
 *
 *  Created on: 2013年12月23日
 *      Author: nerohwang
 */
// 形参rowCurrent表示当前所到的行数
#include<iostream>
#include<fstream>
#include<iomanip>
#include<stdlib.h>
using namespace std;

bool Check(int rowCurrent,int *&NQueen);                         //判断函数
void Print(ofstream &os,int n,int *&NQueen);                                  //打印函数
void Solve(int rowCurrent,int *&NQueen,int n,int &count, ofstream &os);           //N皇后问题处理函数，index一般初值为0

//判断函数，凡是横竖有冲突，或是斜线上有冲突，返回FALSE
bool Check(int rowCurrent,int * &NQueen) {
    int i = 0;
    while(i < rowCurrent) {    
        if(NQueen[i] == NQueen[rowCurrent] || (abs(NQueen[i]-NQueen[rowCurrent]) == abs(i-rowCurrent)) )
            return false;
        i++;
    }
    return true;
}

//将所有可能出现的结果输出文本文档
void Print(ofstream &os,int n,int *&NQueen) {
    os<<"一次调用\n";
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
//核心函数。递归解决N皇后问题，触底则进行打印
void Solve(int rowCurrent,int *&NQueen,int n,int &count, ofstream &os) {
    if(rowCurrent == n)  //当前行数触底，即完成了一个矩阵，将它输出
    {
        Print(os,n,NQueen);
        count++;
    }
    for(int i = 0;  i < n; i++)
    {
        NQueen[rowCurrent] = i;                     //row行i列试一试
        if(Check(rowCurrent,NQueen))
        {
            Solve(rowCurrent+1,NQueen,n,count,os);  //移向下一行
        }
    }
}

int main()
{
    int n;           //问题规模
    int count = 0;   //解的计数
    cout<<"请输入问题的规模N"<<endl;
    cin>>n;
    if(n<4)
    {
        cerr<<"问题规模必须大于4"<<endl;
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
