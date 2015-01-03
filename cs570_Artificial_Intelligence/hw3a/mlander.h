// CS570 Project 3a
// Heyan Huang      April 3, 2013

#ifndef hw_h
#define hw_h

#include "hw.h"
#include <ctime>
#include <cstdlib>

using namespace std;


float ACCELERATION = 2.0;  // but should be varied
float WIND = 1; // but randomized below
const float MAX_SAFE_LANDING_SPEED = 4.0;
const float MIN_SAFE_X = -0.2;
const float MAX_SAFE_X = 0.2;

class lander{
   public:
      lander(void);
      bool landed_test(void){return landed;}
      void update(void);
      void print(void);
      void draw(void);
      void test(void);
      void landedDraw(void);
      void control(void);
      float lrand(void);
   private:
      float height;
      float xPosition;
      float Yvelocity;
      float Xvelocity;
      int landed;  // 0- no, 1- yes, 2- crashed
      float fuel;
      float burn;
      float thrust;
};

#endif


