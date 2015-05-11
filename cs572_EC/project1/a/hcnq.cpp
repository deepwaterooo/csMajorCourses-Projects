#include <iostream>
#include <ctime>
#include <cstdlib>
using namespace std;

void RandCreate(int a[ ],int n);    //随机生成初始解
void PrintQueen(int a[ ],int n);    //打印皇后排列
int CheckCliction(int c[ ],int d[ ],int n); //计算当前冲突数
void Diagonal(int a[ ],int c[ ],int d[ ],int n); //查找与两行有关的冲突数

int main()
{
    int i,j,min_clict,clict,clict_2,temp;
    int n,start,finish;
    cin >> n;
    int *a = new int [n];
    int *c = new int [2*n-1];
    int *d = new int [2*n-1];
    start = clock();
    RandCreate(a,n);
    Diagonal(a,c,d,n);
    min_clict = CheckCliction(c,d,n);
    while(min_clict !=0 )
	{
	    for(i=0;i<n;i++)
		{
		    for(j=i+1;j<n;j++)
			{
			    clict = c[i+a[i]] + c[j+a[j]] + d[i-a[i]+n-1] + d[j-a[j]+n-1];
			    c[i+a[i]]--;
			    c[j+a[j]]--;
			    d[i-a[i]+n-1]--;
			    d[j-a[j]+n-1]--;
			    c[i+a[j]]++;
			    c[j+a[i]]++;
			    d[i-a[j]+n-1]++;
			    d[j-a[i]+n-1]++;
			    clict_2 = c[i+a[j]] + c[j+a[i]] + d[i-a[j]+n-1] + d[j-a[i]+n-1];
			    if(clict <= clict_2)
				{
				    c[i+a[i]]++;
				    c[j+a[j]]++;
				    d[i-a[i]+n-1]++;
				    d[j-a[j]+n-1]++;
				    c[i+a[j]]--;
				    c[j+a[i]]--;
				    d[i-a[j]+n-1]--;
				    d[j-a[i]+n-1]--;
				}
			    else
				{
				    temp = a[i];
				    a[i] = a[j];
				    a[j] = temp;
				    i = n+1;
				    j = n+1;
				}
			}
		}
	    if(i == n && j == n)
		{
		    RandCreate(a,n);
		    Diagonal(a,c,d,n);
		}
	    min_clict = CheckCliction(c,d,n);
	    //     cout << "climbed to:" << min_clict << endl;
	}
    finish = clock();
    //   PrintQueen(a,n);
    cout << n << " queens spend:" << (double)(finish - start)/CLOCKS_PER_SEC << "s" << endl;
    delete [ ] a;
    delete [ ] c;
    delete [ ] d;
    return 0;
}

void RandCreate(int a[ ],int n)
{
    int i,j,k,temp;
    srand(time(0));
    for(k=0;k<n;k++)
	a[k] = k;
    for(k=0;k<10*n;k++)
	{
	    i = rand() % n;
	    j = rand() % n;
	    while(j == i)
		j = rand() % n;
	    temp = a[i];
	    a[i] = a[j];
	    a[j] = temp;
	}
}

void PrintQueen(int a[ ],int n)
{
    int i,j;
    for(i=0;i<n;i++)
	{
	    for(j=0;j<a[i];j++)
		cout <<"#";
	    cout <<"Q";
	    for(j=a[i]+1;j<n;j++)
		cout <<"#";
	    cout <<endl;
	}
}

int CheckCliction(int c[ ],int d[ ],int n)
{
    int i;
    int count = 0;
    for(i=0;i<2*n-1;i++)
	{
	    if(c[i] > 0)
		count += c[i]*(c[i]-1)/2;
	    if(d[i] > 0)
		count += d[i]*(d[i]-1)/2;
	}
    return count;
}

void Diagonal(int a[ ],int c[ ],int d[ ],int n)
{
    int i;
    for(i=0;i<2*n-1;i++)
	{
	    c[i] = 0;
	    d[i] = 0;
	}
    for(i=0;i<n;i++)
	{
	    c[i+a[i]]++;
	    d[i-a[i]+n-1]++;
	}
}
