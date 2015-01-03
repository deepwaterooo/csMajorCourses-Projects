
#include <windows.h>
#include <gl/GL.h>
#include<ctime>
#include<cmath>
#include<cstdio>
#include<cstdlib>
#pragma comment(lib, "opengl32.lib")
#pragma comment(lib, "glu32.lib")

float ACCELERATION;  // but should be varied
float WIND; // but randomized below
const float MAX_SAFE_LANDING_SPEED = 4.0;
const float MIN_SAFE_X = -0.2;
const float MAX_SAFE_X = 0.2;


       
class lander{
   public:
      lander(void);
	  ~lander(void);
      bool landed_test(void){return landed;}
      void update(void);
      void print(void);
      void draw(void);
      void test(void);
      void landedDraw(void);
      void control(void);
      

      
   private:
      float height;
      float xPosition;
      float Yvelocity;
      float Xvelocity;
      int landed;  // 0- no, 1- yes, 2- crashed
      float fuel;
      float burn;
      float thrust;
      bool flagend;

	  FILE* out;
	  int round;
};

