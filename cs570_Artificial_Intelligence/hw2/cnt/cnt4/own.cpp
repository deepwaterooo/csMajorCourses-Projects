// Connect4Board.cpp

/********************************************************************************/		
// the position score function here
/********************************************************************************/		

int arr[6][7];
int thn[6][7];
int plr=1,cpu=2,rec=3,turn=1; // player, computer

int position()
{
  int u,o,x,y,j,score;
  int gh=0,hg=0;
  score=0;

  //Empty the think array, initiate the thn to be all zeros
  for (x=0;x<7;x++)
    {
      for (y=0;y<6;y++)
	{
	  thn[x][y]=0;
	}
    }

  //Sum the score of every opportunity to the score
  for (y=0;y<6;y++)   //for rows
    {
      for (x=0;x<7;x++)  // for cols
	{
	  if (arr[x][y]==0) 
	    score=score+checkhole(x,y);
	  if (y>0) {
	    if ((thn[x][y]==cpu)&&(arr[x][y-1]!=0)) 
	      gh++;
	    if ((thn[x][y]==plr)&&(arr[x][y-1]!=0)) 
	      {
		hg++;
		score=score-4000;
	      }
	  } else {
	    if (thn[x][y]==cpu) 
	      gh++;
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
	  /*if(gh==0)
	    if((thn[x][y]>0)&&(arr[x][y-1]==0)){
	    gh=1;
	    }*/
	  if ((thn[x][y]==cpu)&&(thn[x][y-1]==cpu))
	    {
	      u=0;j=0;
	      for (o=y-1;o>-1;o--)
		{
		  if (thn[x][o]==plr)
		    u=1;
		  if (arr[x][o]==0)
		    j++;
		}
	      if (u==0)
		score=score+1300-j*7;
	      if (u==1)
		score=score+300;
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
	      if (u==0)
		score=score-1500+j*7;
	      if (u==1)
		score=score-300;
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
