/**************************
 * Includes
 *
 **************************/


#include "lander.h"
#include "fuzzylogic.h"


using namespace std;
/**************************
 * Function Declarations
 *
 **************************/

float lrand(void);  // random 0-1


LRESULT CALLBACK WndProc (HWND hWnd, UINT message,
WPARAM wParam, LPARAM lParam);
void EnableOpenGL (HWND hWnd, HDC *hDC, HGLRC *hRC);
void DisableOpenGL (HWND hWnd, HDC hDC, HGLRC hRC);


/**************************
 * WinMain
 *
 **************************/

int WINAPI WinMain (HINSTANCE hInstance,
                    HINSTANCE hPrevInstance,
                    LPSTR lpCmdLine,
                    int iCmdShow)
{
    WNDCLASS wc;
    HWND hWnd;
    HDC hDC;
    HGLRC hRC;        
    MSG msg;
    BOOL bQuit = FALSE;
    float theta = 0.0f;

    /* register window class */
    wc.style = CS_OWNDC;
    wc.lpfnWndProc = WndProc;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = 0;
    wc.hInstance = hInstance;
    wc.hIcon = LoadIcon (NULL, IDI_APPLICATION);
    wc.hCursor = LoadCursor (NULL, IDC_ARROW);
    wc.hbrBackground = (HBRUSH) GetStockObject (BLACK_BRUSH);
    wc.lpszMenuName = NULL;
    wc.lpszClassName = "GLSample";
    RegisterClass (&wc);
srand(time(NULL));
lander l;
    /* create main window */
    hWnd = CreateWindow (
      "GLSample", "OpenGL Sample", 
      WS_CAPTION | WS_POPUPWINDOW | WS_VISIBLE,
      0, 0, 400, 700,
      NULL, NULL, hInstance, NULL);

    /* enable OpenGL for the window */
    EnableOpenGL (hWnd, &hDC, &hRC);

    /* program main loop */
    while (!bQuit)
    {
        /* check for messages */
        if (PeekMessage (&msg, NULL, 0, 0, PM_REMOVE))
        {
            /* handle or dispatch messages */
            if (msg.message == WM_QUIT)
            {
                bQuit = TRUE;
            }
            else
            {
                TranslateMessage (&msg);
                DispatchMessage (&msg);
            }
        }
        else
        {
            /* OpenGL animation code goes here */
            if(!l.landed_test()){  // if it hasn't landed
               l.update();  // update position and velocity
               glClearColor (0.0f, 0.0f, 0.0f, 0.0f);
               glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); // clear the screen
               l.draw();   // draw/print position
               SwapBuffers(hDC);
               l.test();    // test for landing/crash
            }
            else {
               glClearColor (0.0f, 0.0f, 0.0f, 0.0f);
               glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);  // clear the screen
               l.landedDraw(); // draw crash or landing
               SwapBuffers(hDC);
            }
            Sleep (200);
        }
    }

    /* shutdown OpenGL */
    DisableOpenGL (hWnd, hDC, hRC);

    /* destroy the window explicitly */
    DestroyWindow (hWnd);

    return msg.wParam;
}


/********************
 * Window Procedure
 *
 ********************/

LRESULT CALLBACK WndProc (HWND hWnd, UINT message,
                          WPARAM wParam, LPARAM lParam)
{

    switch (message)
    {
    case WM_CREATE:
        return 0;
    case WM_CLOSE:
        PostQuitMessage (0);
        return 0;

    case WM_DESTROY:
        return 0;

    case WM_KEYDOWN:
        switch (wParam)
        {
        case VK_ESCAPE:
            PostQuitMessage(0);
            return 0;
        }
        return 0;

    default:
        return DefWindowProc (hWnd, message, wParam, lParam);
    }
}


/*******************
 * Enable OpenGL
 *
 *******************/

void EnableOpenGL (HWND hWnd, HDC *hDC, HGLRC *hRC)
{
    PIXELFORMATDESCRIPTOR pfd;
    int iFormat;

    /* get the device context (DC) */
    *hDC = GetDC (hWnd);

    /* set the pixel format for the DC */
    ZeroMemory (&pfd, sizeof (pfd));
    pfd.nSize = sizeof (pfd);
    pfd.nVersion = 1;
    pfd.dwFlags = PFD_DRAW_TO_WINDOW | 
      PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER;
    pfd.iPixelType = PFD_TYPE_RGBA;
    pfd.cColorBits = 24;
    pfd.cDepthBits = 16;
    pfd.iLayerType = PFD_MAIN_PLANE;
    iFormat = ChoosePixelFormat (*hDC, &pfd);
    SetPixelFormat (*hDC, iFormat, &pfd);

    /* create and enable the render context (RC) */
    *hRC = wglCreateContext( *hDC );
    wglMakeCurrent( *hDC, *hRC );

}


/******************
 * Disable OpenGL
 *
 ******************/

void DisableOpenGL (HWND hWnd, HDC hDC, HGLRC hRC)
{
    wglMakeCurrent (NULL, NULL);
    wglDeleteContext (hRC);
    ReleaseDC (hWnd, hDC);
}


float lrand(void){
      return(rand()/float(RAND_MAX));
}





void lander::control(void){
     // calculates the burn - vertical adjustments
     // and the thrust - horizontal adjustments
     // both use fuel

//	burn=1;
//	thrust=0;
	
	double hbounds[]={10,15,17,20,25,30,40,50};//good{10,15,20,25,30,35,40,50};//{2,5,10,15,30,40,50,60};
	double Yvbounds[]={1,3,5,11,13,15,17,19};//good{5,7,9,11,13,15,17,19};//{5,10,12,15,18,20,22,24};//{1,3,5,7,9,11,13,15};
	double Xbounds[]={-0.2,-0.13,-0.07,-0.0001,0.0001,0.07,0.13,0.2};
	double Xvbounds[]={-0.1,-0.07,-0.05,-0.0001,0.0001,0.05,0.07,0.1};
	fuzzy Y(hbounds);
	fuzzy Yv(Yvbounds);
	fuzzy X(Xbounds);
	fuzzy Xv(Xvbounds);
	Y.input(height);
	Yv.input(Yvelocity);
	X.input(xPosition);
	Xv.input(Xvelocity);
	Y.fuzzification();
	Yv.fuzzification();
	X.fuzzification();
	Xv.fuzzification();
	double maxburn[3],mediumburn[3],noburn[3];
	double maxthrust[3],mediumthrust[3],nothrust[3];
	burn=0;
	thrust=0;
	//if heightlow AND YvMedium THEN maxburn 
	
		maxburn[0]=min(Y.fuzzylow,Yv.fuzzymedium);
		maxburn[1]=min(Y.fuzzylow,Yv.fuzzyhigh);
		maxburn[2]=min(Y.fuzzymedium,Yv.fuzzyhigh);
		mediumburn[0]=min(Y.fuzzymedium,Yv.fuzzymedium);
		mediumburn[1]=min(Y.fuzzyhigh,Yv.fuzzyhigh);
		mediumburn[2]=min(Y.fuzzyhigh,Yv.fuzzymedium);
		noburn[0]=min(Y.fuzzylow,Yv.fuzzylow);
		noburn[1]=min(Y.fuzzymedium,Yv.fuzzylow);
		noburn[2]=min(Y.fuzzyhigh,Yv.fuzzylow);


		burn=((maxburn[0]+maxburn[1]+maxburn[2])*4
			+(mediumburn[0]+mediumburn[1]+mediumburn[2])*1.8/*
			+(noburn[0]==1?0:(noburn[0]==0?0:1-noburn[0]))
			+(noburn[1]==1?0:(noburn[1]==0?0:1-noburn[1]))
			+(noburn[2]==1?0:(noburn[2]==0?0:1-noburn[2]))*/)
			/(maxburn[0]+maxburn[1]+maxburn[2]+mediumburn[0]+mediumburn[1]+mediumburn[2]
			+noburn[0]+noburn[1]+noburn[2]);


			maxthrust[0]=min(X.fuzzyhigh,Xv.fuzzyhigh);
			maxthrust[1]=min(X.fuzzymedium,Xv.fuzzyhigh);
			maxthrust[2]=-min(X.fuzzylow,Xv.fuzzylow);
			nothrust[0]=min(X.fuzzymedium,Xv.fuzzymedium);
			nothrust[1]=min(X.fuzzyhigh,Xv.fuzzylow);
			nothrust[2]=min(X.fuzzylow,Xv.fuzzyhigh);
			mediumthrust[0]=min(X.fuzzyhigh,Xv.fuzzymedium);
			mediumthrust[1]=-min(X.fuzzylow,Xv.fuzzymedium);
			mediumthrust[2]=-min(X.fuzzymedium,Xv.fuzzylow);

			thrust=((maxthrust[0]+maxthrust[1]+maxthrust[2])*0.15
				+(mediumthrust[0]+mediumthrust[1]+mediumthrust[2])*0.07
				+(nothrust[0]==1?0:nothrust[0]*0.002)+(nothrust[1]==1?0:nothrust[1]*0.002)
				+(nothrust[0]==1?0:nothrust[0]*0.002))/(maxthrust[0]+maxthrust[1]+maxthrust[2]
				+mediumthrust[0]+mediumthrust[1]+mediumthrust[2]+nothrust[0]+nothrust[1]+nothrust[2]);

				for(int i=0;i<3;i++)
				{
					fprintf(out,"maxburn[%d]: %.4f, mediumburn[%d]: %.4f, noburn[%d]: %.4f, maxthrust[%d]: %.4f, mediumthrust[%d]: %.4f, nothrust[%d]: %.4f\n"
						,i,maxburn[i],i,mediumburn[i],i,noburn[i],i,maxthrust[i],i,mediumthrust[i],i,nothrust[i]);
				}
				fprintf(out,"burn=%f\n",burn);
				fprintf(out,"thrust=%f\n",thrust);
    
}


void lander::test(void){
     // Test for landing 
     if(height > 0) // haven't landed yet
         return;
     if(Yvelocity > MAX_SAFE_LANDING_SPEED || xPosition < MIN_SAFE_X || xPosition > MAX_SAFE_X)
         landed = 2;
     else
         landed = 1;

}

lander::lander(void){
    flagend=true;
	out=fopen("landdata.txt","w");
	if(out==NULL)
		exit(1);
	round=0;
    height = 100.0;  // starting height
    Yvelocity = 10.0 * lrand();  // random starting velocity (0~10)
    landed = 0;  // haven't landed yet
    fuel = 100.0;   // starting fuel
    ACCELERATION = 2.0;  // but should be changed
    xPosition = 0;
    Xvelocity = 0;
    WIND=0;//WIND = 0.2 * (lrand()-0.5);  // random wind (-0.1~+0.1)

}
lander::~lander(void)
{
	fclose(out);
}
void lander::update(void){
    // update the lander's altitude 
    Yvelocity+=ACCELERATION;  // apply acceleration
	round++;
	fprintf(out,"Round %d:\n",round);
	fprintf(out,"Height: %.4f, Yvelocity: %.4f, xPosition: %.4f, Xvelocity: %.4f\n",height,Yvelocity,xPosition,Xvelocity);
    control();  // calculate burn and thrust
    if(fuel < burn)   // if insuficient fuel, use the rest for burn
        burn = fuel;
    fuel -= fabs(burn);  // subtract fuel
    Yvelocity-=burn;  // apply burn 
    if(fuel < thrust)   // if insuficient fuel, use the rest for thrust
        thrust = fuel;
    fuel -= fabs(thrust);  // subtract fuel
    Xvelocity-=thrust;    // apply thrust
    
    height -= (Yvelocity);  //  subtract because moving down
    xPosition += (Xvelocity + WIND);  //  wind 
}



void lander::print(void){
     /*  For command line version
     cout << "Height: " << height << "  "; 
     cout << "Y-Velocity: " << Yvelocity << "  ";     
     cout << "Position: " << xPosition << "  ";
     cout << "X-Velocity: " << Xvelocity << "   ";
     cout << "Fuel: " << fuel<< endl;
     */
}

//  Drawing functions ---------------------------------------------------------------

void lander::draw(void){
     float red=0,green=0;
     if(Yvelocity <= MAX_SAFE_LANDING_SPEED && Yvelocity >= 0.0)
         green = 0.5+0.5*(MAX_SAFE_LANDING_SPEED-Yvelocity)/MAX_SAFE_LANDING_SPEED;
     if(Yvelocity < 0.0)
         green =1.0;
     if(Yvelocity > MAX_SAFE_LANDING_SPEED)
         red = 0.5+0.5*((Yvelocity-MAX_SAFE_LANDING_SPEED)/MAX_SAFE_LANDING_SPEED);
     if(red > 1.0)
         red = 1.0;
     glColor3f(red,green,0.1);
     float drawHeight = height;
     if(drawHeight < 0.0)
         drawHeight = 0;
     glBegin(GL_POLYGON);  //lander
        glVertex3f(xPosition-0.06,drawHeight/50.0-0.98,0);
        glVertex3f(xPosition+0.0,drawHeight/50.0-0.98,0.02);
        glVertex3f(xPosition+0.0,((drawHeight/50.0)-0.99)+.08,0);
     glEnd();
     glColor3f(red-0.2,green-0.2,0.0);
     glBegin(GL_POLYGON);  //lander
        glVertex3f(xPosition+0.0,drawHeight/50.0-0.98,0);
        glVertex3f(xPosition+0.06,drawHeight/50.0-0.98,0);
        glVertex3f(xPosition+0.0,((drawHeight/50.0)-0.99)+.08,0.02);
     glEnd();
          
     glColor3f(1.0, 0.2, 0.2);
     glBegin(GL_POLYGON);  // fuel bar
        glVertex3f(-1.0,fuel/50.0-1.0,0);
        glVertex3f(-0.95,fuel/50.0-1.0,0);
        glVertex3f(-0.95,-1.0,0);
        glVertex3f(-1.0,-1.00,0);
     glEnd();
     
     glColor3f(0.2, 0.2, 0.2);
     glBegin(GL_POLYGON);  // ground
        glVertex3f(-1.0,-1.0,0);
        glVertex3f(1.0,-1.0,0);
        glVertex3f(1.0,-0.99,0);
        glVertex3f(-1.0,-0.99,0);
     glEnd();
     glColor3f(0.2, 1.0, 0.2);
     glBegin(GL_POLYGON);  // target
        glVertex3f(MIN_SAFE_X,-1.0,0);
        glVertex3f(MAX_SAFE_X,-1.0,0);
        glVertex3f(MAX_SAFE_X,-0.99,0);
        glVertex3f(MIN_SAFE_X,-0.99,0);
     glEnd();
     
     glColor3f(1.0,0,0);
     if(fuel!=0 && !landed){
        glBegin(GL_POLYGON);  // rocket flame
           glVertex3f(xPosition-0.02,drawHeight/50.0-0.98,0);
           glVertex3f(xPosition+0.02,drawHeight/50.0-0.98,0);
           glVertex3f(xPosition+0.0,((drawHeight/50.0)-1.0)-((burn)/20.0),0);
        glEnd();
     }
}


void lander::landedDraw(void){
     if(flagend)
     {
                flagend=false;
     if(landed ==2)
         printf("The spaceship crashed...\n");
     else if(landed == 1)
         printf("The spaceship safely landed...\n");
     }
      float drawHeight= 0;
      glColor3f(0.2, 0.2, 0.2);
     glBegin(GL_POLYGON);  // ground
        glVertex3f(-1.0,-1.0,0);
        glVertex3f(1.0,-1.0,0);
        glVertex3f(1.0,-0.99,0);
        glVertex3f(-1.0,-0.99,0);
     glEnd();
     glColor3f(0.2, 1.0, 0.2);
     glBegin(GL_POLYGON);  // target
        glVertex3f(MIN_SAFE_X,-1.0,0);
        glVertex3f(MAX_SAFE_X,-1.0,0);
        glVertex3f(MAX_SAFE_X,-0.99,0);
        glVertex3f(MIN_SAFE_X,-0.99,0);
     glEnd();
      if(landed == 1){  // safe landing
         // draw rocket
         glColor3f(0.0,1.0,0.0);
         glBegin(GL_POLYGON);  
            glVertex3f(xPosition+0.045,drawHeight/50.0-0.98,0);
            glVertex3f(xPosition+0.04,drawHeight/50.0-0.98,0);
            glVertex3f(xPosition+0.04,drawHeight/50.0-1.0,0);
            glVertex3f(xPosition+0.045,drawHeight/50.0-1.08,0);
         glEnd();
         glBegin(GL_POLYGON);  
            glVertex3f(xPosition-0.045,drawHeight/50.0-0.98,0);
            glVertex3f(xPosition-0.04,drawHeight/50.0-0.98,0);
            glVertex3f(xPosition-0.04,drawHeight/50.0-1.0,0);
            glVertex3f(xPosition-0.045,drawHeight/50.0-1.08,0);
         glEnd();
          
         glColor3f(0.3,0.3,0.3);
         glBegin(GL_POLYGON);  // draw flag pole
            glVertex3f(xPosition-0.1,-1.0,0);
            glVertex3f(xPosition-0.09,-1.0,0);
            glVertex3f(xPosition-0.09,-0.85,0);
            glVertex3f(xPosition-0.1,-0.85,0);
         glEnd();   
         glColor3f(0.0,0.9,0.4);
         glBegin(GL_POLYGON);  // draw flag 
            glVertex3f(xPosition-0.09,-0.85,0);
            glVertex3f(xPosition+0.02,-0.85,0);
            glVertex3f(xPosition+0.02,-0.88,0);
            glVertex3f(xPosition+-0.09,-0.88,0);
         glEnd();             
         draw();
      }
      else{  // crash, random flames
         for(int i=0; i < 50; i++){
           glColor3f(0.5+lrand()*0.5,0.0,0.0);
           glBegin(GL_POLYGON);   
              glVertex3f(xPosition-0.005,drawHeight/50.0-1.0,0);
              glVertex3f(xPosition+0.005,drawHeight/50.0-1.0,0);
              glVertex3f(xPosition+lrand()*.3-0.15,drawHeight/50.0-1.0+lrand()*.5,0);      
              glVertex3f(xPosition+lrand()*.3-0.15,drawHeight/50.0-1.0+lrand()*.5,0);
           glEnd();
         }       
      }     
}
