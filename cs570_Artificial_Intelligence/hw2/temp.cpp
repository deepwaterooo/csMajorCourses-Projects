int check(int i, int alpha, int beta)  // alpha beta pruning
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
