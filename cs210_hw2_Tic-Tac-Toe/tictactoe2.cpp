#include<graphics.h>
#include<stdlib.h>
#include<conio.h>
#include<stdio.h>
int board[9],win=0;
int i;
int gdriver = DETECT, gmode;
init()
{
for(i=0;i<9;i++)
board[i]=1;
}

void main()
{
 int x,y;
 initgraph(&gdriver, &gmode, "");
 clrscr();
 init();
 display();
 while(1)
 {
  gotoxy(0,0);
  coin(400,200,1);
  outtextxy(415,200," Player");
  coin(400,230,2);
  outtextxy(415,230," System");
  printf("\n\nEnter your move (row/column) : ");
  scanf("%d %d",&x,&y);
  if (board[3*(x-1)+(y-1)]==1)
  {
   board[3*(x-1)+(y-1)]=3;
   clrscr();
   display();
   check();
   getch();
   move();
   clrscr();
   display();
   check();
   if(win==-1)
   {
    settextstyle(5,0,4);
    outtextxy(200,400,"MATCH DRAW");
    break;
   }
  }
  else
  printf("\nMove Not Allowed\n");
 }
 getch();
}

coin(int x,int y,int s)
{
 if(s==1)
 {
  setfillstyle(1,2);
  fillellipse(x,y,10,10);
 }
 else
 {
  setfillstyle(1,14);
  fillellipse(x,y,10,10);
 }
}

display()
{
int l;
cleardevice();
outtextxy(220,10,"TIC TAC TOE");
outtextxy(370,300,"Designed By K.Shyam Srinivas");
outtextxy(370,320,"Email : seenu_4321@yahoo.co.in");
outtextxy(370,340,"Website : www.seenu.bravehost.com");
setbkcolor(0);
rectangle(199,199,351,351);
rectangle(196,196,354,354);

setfillstyle(8,4);
bar3d(200,200,250,250,0,0);
bar3d(300,200,350,250,0,0);
bar3d(250,250,300,300,0,0);
bar3d(200,300,250,350,0,0);
bar3d(300,300,350,350,0,0);

setfillstyle(8,1);
bar3d(250,200,300,250,0,0);
bar3d(200,250,250,300,0,0);
bar3d(300,250,350,300,0,0);
bar3d(250,300,300,350,0,0);

if (board[0]==3) coin(225,225,1);
if (board[0]==9) coin(225,225,2);
if (board[1]==3) coin(275,225,1);
if (board[1]==9) coin(275,225,2);
if (board[2]==3) coin(325,225,1);
if (board[2]==9) coin(325,225,2);

if (board[3]==3) coin(225,275,1);
if (board[3]==9) coin(225,275,2);
if (board[4]==3) coin(275,275,1);
if (board[4]==9) coin(275,275,2);
if (board[5]==3) coin(325,275,1);
if (board[5]==9) coin(325,275,2);

if (board[6]==3) coin(225,325,1);
if (board[6]==9) coin(225,325,2);
if (board[7]==3) coin(275,325,1);
if (board[7]==9) coin(275,325,2);
if (board[8]==3) coin(325,325,1);
if (board[8]==9) coin(325,325,2);

return;
}

move()
{
 int maxrt=0,maxpos=-1,rt;
 for(i=0;i<9;i++)
 {
  if(board[i]==1)
  {
   board[i]=9;
   if(board[0]+board[1]+board[2]==27) win=2;
   if(board[3]+board[4]+board[5]==27) win=2;
   if(board[6]+board[7]+board[8]==27) win=2;
   if(board[0]+board[3]+board[6]==27) win=2;
   if(board[1]+board[4]+board[7]==27) win=2;
   if(board[2]+board[5]+board[8]==27) win=2;
   if(board[0]+board[4]+board[8]==27) win=2;
   if(board[2]+board[4]+board[6]==27) win=2;
   if (win!=2) board[i]=1;
   else break;
  }
 }
 if(win==2) return;
 for(i=0;i<9;i++)
 {
  if(board[i]==1)
  {
   board[i]=3;
   rt=rate();

   if (maxrt<rt)
   {
    maxrt=rt;
    maxpos=i;
   }
   board[i]=1;
  }
 }
 if(maxpos==-1)
 {
  outtextxy(200,400,"MATCH DRAW");
  win=-1;
 }
 else board[maxpos]=9;
}

int rate()
{
 int rating=0;
 if(board[0]+board[1]+board[2]==7) rating++;
 if(board[0]+board[1]+board[2]==9) rating+=8;

 if(board[3]+board[4]+board[5]==7) rating++;
 if(board[3]+board[4]+board[5]==9) rating+=8;

 if(board[6]+board[7]+board[8]==7) rating++;
 if(board[6]+board[7]+board[8]==9) rating+=8;

 if(board[0]+board[3]+board[6]==7) rating++;
 if(board[0]+board[3]+board[6]==9) rating+=8;

 if(board[1]+board[4]+board[7]==7) rating++;
 if(board[1]+board[4]+board[7]==9) rating+=8;

 if(board[2]+board[5]+board[8]==7) rating++;
 if(board[2]+board[5]+board[8]==9) rating+=8;

 if(board[0]+board[4]+board[8]==7) rating++;
 if(board[0]+board[4]+board[8]==9) rating+=8;

 if(board[2]+board[4]+board[6]==7) rating++;
 if(board[2]+board[4]+board[6]==9) rating+=8;

 return rating;
}


check()
{
 if(board[0]+board[1]+board[2]==9) win=1;
 if(board[3]+board[4]+board[5]==9) win=1;
 if(board[6]+board[7]+board[8]==9) win=1;
 if(board[0]+board[3]+board[6]==9) win=1;
 if(board[1]+board[4]+board[7]==9) win=1;
 if(board[2]+board[5]+board[8]==9) win=1;
 if(board[0]+board[4]+board[8]==9) win=1;
 if(board[2]+board[4]+board[6]==9) win=1;

 if(board[0]+board[1]+board[2]==27) win=2;
 if(board[3]+board[4]+board[5]==27) win=2;
 if(board[6]+board[7]+board[8]==27) win=2;
 if(board[0]+board[3]+board[6]==27) win=2;
 if(board[1]+board[4]+board[7]==27) win=2;
 if(board[2]+board[5]+board[8]==27) win=2;
 if(board[0]+board[4]+board[8]==27) win=2;
 if(board[2]+board[4]+board[6]==27) win=2;

 if(win==1)
 {
  settextstyle(5,0,4);
  outtextxy(200,400,"Player wins");
  getch();
  exit(0);
 }
 if(win==2)
 {
  settextstyle(5,0,4);
  outtextxy(200,400,"System wins");
  getch();
  exit(0);
 }
} ...
