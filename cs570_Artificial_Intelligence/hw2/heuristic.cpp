
int Heuristic(char arr[6][7])
{
  int u,o,x,y,j,score;
  int gh=0,hg=0;
  char thn[6][7];
  score=0;
  
  for (x=0;x<7;x++)
    {
      for (y=0;y<6;y++)
	{
	  thn[y][x]=' ';
	}
    }
  
  for (y=0;y<6;y++)
    {
      for (x=0;x<7;x++)
	{
	  if (arr[y][x]==' '){score=score+checkhole(arr,thn, x,y); }
	  if (y>0)
	    {
	      if ((thn[y][x]=='O')&&(arr[y-1][x]!=' '))gh++;
	      if ((thn[y][x]=='X')&&(arr[y-1][x]!=' ')){hg++;score=score-4000;}
	    }
	  else
	    {
	      if (thn[y][x]=='O')gh++;
	      if (thn[y][x]=='X'){hg++;score=score-4000;}
	    }
	}
    }
  if (gh>1)score=score+(gh-1)*500;
  if (gh==1)score=score-100;
  if (hg>1)score=score-(hg-1)*500;
  
  for (x=0;x<7;x++)
    {
      gh=0;
      for (y=1;y<6;y++)
	{
	  if ((thn[y][x]=='O')&&(thn[y-1][x]=='O'))
	    {
	      u=0;j=0;
	      for (o=y-1;o>-1;o--)
		{
		  if (thn[o][x]=='X')u=1;
		  if (arr[o][x]==0)j++;
		}
	      if (u==0)score=score+1300-j*7;
	      if (u==1)score=score+300;
	    }
	  
	  if ((thn[y][x]=='X')&&(thn[y-1][x]=='X'))
	    {
	      u=0;j=0;
	      for (o=y-1;o>-1;o--)
		{
		  if (thn[o][x]=='O')u=1;
		  if (arr[o][x]==0)j++;
		}
	      if (u==0)score=score-1500+j*7;
	      if (u==1)score=score-300;
	    }
	  if (thn[y][x]=='X')
	    {
	      u=0;
	      for (o=y-1;o>-1;o--)
		{
		  if (thn[o][x]=='O')u=1;
		}
	      if (u==1)score=score+30;}
	  if (thn[y][x]=='O')
	    {
	      u=0;
	      for (o=y-1;o>-1;o--)
		{
		  if (thn[o][x]=='X')u=1;
		}
	      if (u==1)score=score-30;}
	}
    }
  //cout << endl << score << endl;
  return score;
}

int checkhole(char arr[6][7], char thn[6][7], int x,int y)
{
  int score=0;
  int max,min;
  int d0=0,d1=0,d2=0,d3=0;
  if (((x+1)<7)&&((y-1)>-1))
    {
      if (arr[y-1][x+1]=='O')
	{
	  d1++;
	  if (((x+2)<7)&&((y-2)>-1))
	    {
	      if (arr[y-2][x+2]=='O')
		{
		  d1++;
		  if (((x+3)<7)&&((y-3)>-1))
		    {
		      if (arr[y-3][x+3]=='O')d1++;}}}}
    }
  if (((x-1)>-1)&&((y+1)<6))
    {
      if (arr[y+1][x-1]=='O')
	{
	  d1++;
	  if (((x-2)>-1)&&((y+2)<6))
	    {
	      if (arr[y+2][x-2]=='O')
		{
		  d1++;
		  if (((x-3)>-1)&&((y+3)<6))
		    {
		      if (arr[y+3][x-3]=='O')d1++;}}}}
    }
  if (((x-1)>-1)&&((y-1)>-1))
    {
      if (arr[y-1][x-1]=='O')
	{
	  d2++;
	  if (((x-2)>-1)&&((y-2)>-1))
	    {
	      if (arr[y-2][x-2]=='O')
		{
		  d2++;
		  if (((x-3)>-1)&&((y-3)>-1))
		    {
		      if (arr[y-3][x-3]=='O')d2++;}}}}
    }
  if (((x+1)<7)&&((y+1)<6))
    {
      if (arr[y+1][x+1]=='O')
	{
	  d2++;
	  if (((x+2)<7)&&((y+2)<6))
	    {
	      if (arr[y+2][x+2]=='O')
		{
		  d2++;
		  if (((x+3)<7)&&((y+3)<6))
		    {
		      if (arr[y+3][x+3]=='O')d2++;}}}}
    }
  if ((y-1)>-1)if (arr[y-1][x]=='O')
		 {
		   d0++;
		   if ((y-2)>-1)if (arr[y-2][x]=='O')
				  {
				    d0++;
				    if ((y-3)>-1)if (arr[y-3][x]=='O')d0++;}
		 }
  if (x-1>-1)
    {
      if (arr[y][x-1]=='O')
	{
	  d3++;
	  if (x-2>-1)
	    {
	      if (arr[y][x-2]=='O')
		{
		  d3++;
		  if (x-3>-1)if (arr[y][x-3]=='O')d3++;}}}
    }
  if (x+1<7)
    {
      if (arr[y][x+1]=='O')
	{
	  d3++;
	  if (x+2<7)
	    {
	      if (arr[y][x+2]=='O')
		{
		  d3++;
		  if (x+3<7)if (arr[y][x+3]=='O')d3++;}}}
    }
  max=d0;
  if (d1>max)max=d1;
  if (d2>max)max=d2;
  if (d3>max)max=d3;
  if (max==2)score=score+5;
  if (max>2)
    {
      score=score+71;thn[y][x]='O';
      if ((d1<3)&&(d2<3)&&(d3<3))score=score-10;}
  
  if (((x+1)<7)&&((y-1)>-1))
    {
      if (arr[y-1][x+1]=='X')
	{
	  d1++;
	  if (((x+2)<7)&&((y-2)>-1))
	    {
	      if (arr[y-2][x+2]=='X')
		{
		  d1++;
		  if (((x+3)<7)&&((y-3)>-1))
		    {
		      if (arr[y-3][x+3]=='X')d1++;}}}}
    }
  if (((x-1)>-1)&&((y+1)<6))
    {
      if (arr[y+1][x-1]=='X')
	{
	  d1++;
	  if (((x-2)>-1)&&((y+2)<6))
	    {
	      if (arr[y+2][x-2]=='X')
		{
		  d1++;
		  if (((x-3)>-1)&&((y+3)<6))
		    {
		      if (arr[y+3][x-3]=='X')d1++;}}}}
    }
  if (((x-1)>-1)&&((y-1)>-1))
    {
      if (arr[y-1][x-1]=='X')
	{
	  d2++;
	  if (((x-2)>-1)&&((y-2)>-1))
	    {
	      if (arr[y-2][x-2]=='X')
		{
		  d2++;
		  if (((x-3)>-1)&&((y-3)>-1))
		    {
		      if (arr[y-3][x-3]=='X')d2++;}}}}
    }
  if (((x+1)<7)&&((y+1)<6))
    {
      if (arr[y+1][x+1]=='X')
	{
	  d2++;
	  if (((x+2)<7)&&((y+2)<6))
	    {
	      if (arr[y+2][x+2]=='X')
		{
		  d2++;
		  if (((x+3)<7)&&((y+3)<6))
		    {
		      if (arr[y+3][x+3]=='X')d2++;}}}}
    }
  if ((y-1)>-1)if (arr[y-1][x]=='X')
		 {
		   d0++;
		   if ((y-2)>-1)if (arr[y-2][x]=='X')
				  {
				    d0++;
				    if ((y-3)>-1)if (arr[y-3][x]=='X')d0++;}
		 }
  if (x-1>-1)
    {
      if (arr[y][x-1]=='X')
	{
	  d3++;
	  if (x-2>-1)
	    {
	      if (arr[y][x-2]=='X')
		{
		  d3++;
		  if (x-3>-1)if (arr[y][x-3]=='X')d3++;}}}
    }
  if (x+1<7)
    {
      if (arr[y][x+1]=='X')
	{
	  d3++;
	  if (x+2<7)
	    {
	      if (arr[y][x+2]=='X')
		{
		  d3++;
		  if (x+3<7)if (arr[y][x+3]=='X')d3++;}}}
    }
  min=d0;
  if (d1>min)min=d1;
  if (d2>min)min=d2;
  if (d3>min)min=d3;
  if (min==2)score=score-4;
  if (min>2)
    {
      score=score-70;thn[y][x]='X';
      if ((d1<3)&&(d2<3)&&(d3<3))score=score+10;}
  
  return score;
}
 
