// http://www.codeproject.com/Articles/7101/Connect4-Using-the-Alpha-Beta-Search-Algorithm

#include<iostream>
using namespace std; 

int thn[7,6];
int tops[7];
int plyer,computer,endt=0; 
int plr=1,cpu=2,rec=3,turn=1;
int plrcoin,cpucoin;
int lin;

int Think()
{
  int i;
  i=rec;
  return check(i,-9999999,9999999);
}

void turncheck()
{
  int temp;
  char[] toto=new char[20];
  temp=checkwin();
  if (temp==plr){MessageBox.Show("You win..");endt=1;return;}
  if (temp==cpu){MessageBox.Show("You lose..");endt=1;return;}
  if (temp==0)
    {
      for(t=0;t<=6;t++)
	if (tops[t]<6)temp=1;
      if (temp==0)
	{
	  //drawn();
	  endt=1;
	  return;
	}
    }
}

int check(int i, int alpha, int beta)  // alpha beta pruning, i for depth
{
  int co,score,t,g,j=0,p;
  i--;
  if (i==-1){score=position();return score;}

  if (i%2==0)
    {
      int max=0,k;
      j=0;co=0;
      for (t=0;t<7;t++)
	{
	  g=add(t,cpu);
	  if (g==0)
	    {
	      if (checkwin()==cpu){sub(t);if (i==rec-1)return t;else return 9000;}
	      k=check(i,alpha,999999);
	      if(k>alpha)alpha=k;
	      sub(t);
	      if(k>beta)return k;
	      if (co==0){max=k;co=1;j=t;}
	      if (k==max){p=(random.Next(6))+1;if (p>4)j=t;}
	      if (k>max){max=k;j=t;}						
	    }
	}
      score=max;
    }
  else
    {
      int min=0,k=0;
      co=0;
      for (t=0;t<7;t++)
	{
	  g=add(t,plr);
	  if (g==0)
	    {
	      if (checkwin()==plr){sub(t);/*if (i==rec-1)return t; else*/ return -10000;}
	      k=check(i,-99999,beta);
	      if(k<beta)beta=k;
	      sub(t);
	      if(k<alpha)return k;
	      if (co==0){min=k;co=1;j=t;}
	      if (k<min){min=k;j=t;}						
	    }
	}
      score=min;
    }
  if (i==rec-1)return j;
  return score;
}


int add(int c,int coin)
{
  if (tops[c]<6){arr[c,tops[c]]=coin;tops[c]++;return 0;}
  return 1;
}

int sub(int c)
{
  tops[c]--;
  arr[c,tops[c]]=0;
  return 0;
}

int position()
{
  int u,o,x,y,j,score;
  int gh=0,hg=0;
  score=0;

  //Empty the think array, initiate the thn to be all zeros
  for (x=0;x<7;x++)
    {
      for (y=0;y<6;y++)
	thn[x][y]=0;
    }

  //Sum the score of every opportunity to the score
  for (y=0;y<6;y++)   //for rows
    {
      for (x=0;x<7;x++)  // for cols
	{
	  if (arr[x][y]==0)  score=score+checkhole(x,y);
	  if (y>0) {
	    if ((thn[x][y]==cpu)&&(arr[x][y-1]!=0))  gh++;
	    if ((thn[x][y]==plr)&&(arr[x][y-1]!=0)) 
	      {
		hg++;
		score=score-4000;
	      }
	  } else {
	    if (thn[x][y]==cpu)  gh++;
	    if (thn[x][y]==plr) 
	      {
		hg++;
		score=score-4000;
	      }
	  }
	}
    }

  if (gh>1)  score=score+(gh-1)*500;
  if (gh==1) score=score-100;
  if (hg>1)  score=score-(hg-1)*500;

  for (x=0;x<7;x++)
    {
      gh=0;
      for (y=1;y<6;y++)
	{
	  if ((thn[x][y]==cpu)&&(thn[x][y-1]==cpu))
	    {
	      u=0;j=0;
	      for (o=y-1;o>-1;o--)
		{
		  if (thn[x][o]==plr)  u=1;
		  if (arr[x][o]==0)    j++;
		}
	      if (u==0)  score=score+1300-j*7;
	      if (u==1)  score=score+300;
	    }

	  if ((thn[x][y]==plr)&&(thn[x][y-1]==plr))
	    {
	      u=0;j=0;
	      for (o=y-1;o>-1;o--)
		{
		  if (thn[x][o]==cpu)
		    u=1;
		  if (arr[x][o]==0)
		    j++;
		}
	      if (u==0) score=score-1500+j*7;
	      if (u==1) score=score-300;
	    }

	  if (thn[x][y]==plr)
	    {
	      u=0;
	      for (o=y-1;o>-1;o--)
		{
		  if (thn[x][o]==cpu)
		    u=1;
		}
	      if (u==1)
		score=score+30;
	    }

	  if (thn[x][y]==cpu)
	    {
	      u=0;
	      for (o=y-1;o>-1;o--)
		{
		  if (thn[x][o]==plr)
		    u=1;
		}
	      if (u==1)
		score=score-30;
	    }
	}
    }
  return score;
}


int checkhole(int x,int y)
{
  int score=0;
  int max,min;
  int d0=0,d1=0,d2=0,d3=0;
  if (((x+1)<7)&&((y-1)>-1))
    {
      if (arr[x+1][y-1]==cpu)
	{
	  d1++;
	  if (((x+2)<7)&&((y-2)>-1))
	    {
	      if (arr[x+2][y-2]==cpu)
		{
		  d1++;
		  if (((x+3)<7)&&((y-3)>-1))
		    {
		      if (arr[x+3,y-3]==cpu)d1++;}}}}
    }
  if (((x-1)>-1)&&((y+1)<6))
    {
      if (arr[x-1,y+1]==cpu)
	{
	  d1++;
	  if (((x-2)>-1)&&((y+2)<6))
	    {
	      if (arr[x-2,y+2]==cpu)
		{
		  d1++;
		  if (((x-3)>-1)&&((y+3)<6))
		    {
		      if (arr[x-3,y+3]==cpu)d1++;}}}}
    }
  if (((x-1)>-1)&&((y-1)>-1))
    {
      if (arr[x-1,y-1]==cpu)
	{
	  d2++;
	  if (((x-2)>-1)&&((y-2)>-1))
	    {
	      if (arr[x-2,y-2]==cpu)
		{
		  d2++;
		  if (((x-3)>-1)&&((y-3)>-1))
		    {
		      if (arr[x-3,y-3]==cpu)d2++;}}}}
    }
  if (((x+1)<7)&&((y+1)<6))
    {
      if (arr[x+1,y+1]==cpu)
	{
	  d2++;
	  if (((x+2)<7)&&((y+2)<6))
	    {
	      if (arr[x+2,y+2]==cpu)
		{
		  d2++;
		  if (((x+3)<7)&&((y+3)<6))
		    {
		      if (arr[x+3,y+3]==cpu)d2++;}}}}
    }
  if ((y-1)>-1)if (arr[x,y-1]==cpu)
		 {
		   d0++;
		   if ((y-2)>-1)if (arr[x,y-2]==cpu)
				  {
				    d0++;
				    if ((y-3)>-1)if (arr[x,y-3]==cpu)d0++;}
		 }
  if (x-1>-1)
    {
      if (arr[x-1,y]==cpu)
	{
	  d3++;
	  if (x-2>-1)
	    {
	      if (arr[x-2,y]==cpu)
		{
		  d3++;
		  if (x-3>-1)if (arr[x-3,y]==cpu)d3++;}}}
    }
  if (x+1<7)
    {
      if (arr[x+1,y]==cpu)
	{
	  d3++;
	  if (x+2<7)
	    {
	      if (arr[x+2,y]==cpu)
		{
		  d3++;
		  if (x+3<7)if (arr[x+3,y]==cpu)d3++;}}}
    }
  max=d0;
  if (d1>max)max=d1;
  if (d2>max)max=d2;
  if (d3>max)max=d3;
  if (max==2)score=score+5;
  if (max>2)
    {
      score=score+71;thn[x,y]=cpu;
      if ((d1<3)&&(d2<3)&&(d3<3))score=score-10;}

  if (((x+1)<7)&&((y-1)>-1))
    {
      if (arr[x+1][y-1]==plr)
	{
	  d1++;
	  if (((x+2)<7)&&((y-2)>-1))
	    {
	      if (arr[x+2][y-2]==plr)
		{
		  d1++;
		  if (((x+3)<7)&&((y-3)>-1))
		    {
		      if (arr[x+3][y-3]==plr)d1++;}}}}
    }
  if (((x-1)>-1)&&((y+1)<6))
    {
      if (arr[x-1,y+1]==plr)
	{
	  d1++;
	  if (((x-2)>-1)&&((y+2)<6))
	    {
	      if (arr[x-2,y+2]==plr)
		{
		  d1++;
		  if (((x-3)>-1)&&((y+3)<6))
		    {
		      if (arr[x-3,y+3]==plr)d1++;}}}}
    }
  if (((x-1)>-1)&&((y-1)>-1))
    {
      if (arr[x-1,y-1]==plr)
	{
	  d2++;
	  if (((x-2)>-1)&&((y-2)>-1))
	    {
	      if (arr[x-2,y-2]==plr)
		{
		  d2++;
		  if (((x-3)>-1)&&((y-3)>-1))
		    {
		      if (arr[x-3,y-3]==plr)d2++;}}}}
    }
  if (((x+1)<7)&&((y+1)<6))
    {
      if (arr[x+1,y+1]==plr)
	{
	  d2++;
	  if (((x+2)<7)&&((y+2)<6))
	    {
	      if (arr[x+2,y+2]==plr)
		{
		  d2++;
		  if (((x+3)<7)&&((y+3)<6))
		    {
		      if (arr[x+3,y+3]==plr)d2++;}}}}
    }
  if ((y-1)>-1)if (arr[x,y-1]==plr)
		 {
		   d0++;
		   if ((y-2)>-1)if (arr[x,y-2]==plr)
				  {
				    d0++;
				    if ((y-3)>-1)if (arr[x,y-3]==plr)d0++;}
		 }
  if (x-1>-1)
    {
      if (arr[x-1,y]==plr)
	{
	  d3++;
	  if (x-2>-1)
	    {
	      if (arr[x-2,y]==plr)
		{
		  d3++;
		  if (x-3>-1)if (arr[x-3,y]==plr)d3++;}}}
    }
  if (x+1<7)
    {
      if (arr[x+1,y]==plr)
	{
	  d3++;
	  if (x+2<7)
	    {
	      if (arr[x+2,y]==plr)
		{
		  d3++;
		  if (x+3<7)if (arr[x+3,y]==plr)d3++;}}}
    }
  min=d0;
  if (d1>min)min=d1;
  if (d2>min)min=d2;
  if (d3>min)min=d3;
  if (min==2)score=score-4;
  if (min>2)
    {
      score=score-70;thn[x,y]=plr;
      if ((d1<3)&&(d2<3)&&(d3<3))score=score+10;}

  return score;
}

int checkwin()
{
  int r,x,y;
  r=0;
  for(y=2;y>-1;y--)
    {
      for(x=0;x<7;x++)
	{
	  checku(x,y,ref r);
	}
    }
  for(y=0;y<6;y++)
    {
      for(x=0;x<4;x++)
	{
	  check2r(x,y,ref r);
	}
    }
  for(y=2;y>-1;y--)
    {
      for(x=0;x<4;x++)
	{
	  checkr(x,y,ref r);
	}
    }
  for(y=2;y>-1;y--)
    {
      for(x=3;x<7;x++)
	{
	  checkl(x,y,ref r);
	}
    }
  return r;
}

void checku(int x,int y,ref int r)
{
  if ((arr[x,y]==2)&&(arr[x,y+1]==2)&&(arr[x,y+2]==2)&&(arr[x,y+3]==2))r=2;
  if ((arr[x,y]==1)&&(arr[x,y+1]==1)&&(arr[x,y+2]==1)&&(arr[x,y+3]==1))r=1;
}

void check2r(int x,int y,ref int r)
{
  if ((arr[x,y]==2)&&(arr[x+1,y]==2)&&(arr[x+2,y]==2)&&(arr[x+3,y]==2))r=2;
  if ((arr[x,y]==1)&&(arr[x+1,y]==1)&&(arr[x+2,y]==1)&&(arr[x+3,y]==1))r=1;
}

void checkr(int x,int y,ref int r)
{
  if ((arr[x,y]==2)&&(arr[x+1,y+1]==2)&&(arr[x+2,y+2]==2)&&(arr[x+3,y+3]==2))r=2;
  if ((arr[x,y]==1)&&(arr[x+1,y+1]==1)&&(arr[x+2,y+2]==1)&&(arr[x+3,y+3]==1))r=1;
}

void checkl(int x,int y,ref int r)
{
  if ((arr[x,y]==2)&&(arr[x-1,y+1]==2)&&(arr[x-2,y+2]==2)&&(arr[x-3,y+3]==2))r=2;
  if ((arr[x,y]==1)&&(arr[x-1,y+1]==1)&&(arr[x-2,y+2]==1)&&(arr[x-3,y+3]==1))r=1;
}

