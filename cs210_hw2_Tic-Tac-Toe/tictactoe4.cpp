///|||--------------------------------------|||\\\
// 	EE104 HW10									\\
//	Matrix Calculator v7.5.2.9					\\
//	G

#include<stdio.h>

int main()
{
	int sum=1,i,n;
	printf("sayi gir\n");
	scanf("%d",&n);
	for(i=1;i<=n;i++)
	{
		sum=sum*i;
	}
	printf("%d\n",sum);
} ...

#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<string.h>
#include<math.h>

int main()
{
	int x,y,count=0;
	srand(time(0));
	x=rand()%10000;
	printf("%d\n",x);
		
	while(x!=y)
	{   
		printf("Enter the number\n");
		scanf("%d",&y);
		if(x<y) 
		printf("GREATER THAN YOU CHOSE\n");
		count++;
		if(x>y)
		printf("LESS THAN YOU CHOSE\n");
		count++;
	}
		if(x=y)
		printf("YOU WON\n");
		printf("IN %d STEPS\n",(count/2));


	
}

#include<stdio.h>
#include<time.h>

int main()
{
	int i,j,array[10][10],temp;
	srand(time(0));
	
	for(i=0;i<10;i++)
	{
		
		for(j=0;j<10;j++)
		{
			temp=rand()%3;
			array[i][j]=temp;
				if(0==array[i][j]) 
					printf(" X - ",array[i][j]);
				else
					printf(" %d - ",array[i][j]);
		}
		printf("\n");
	}

} ...


