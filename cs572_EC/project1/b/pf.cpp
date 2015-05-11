// pf.cpp

#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include "pf.h"

using namespace std;

void pf(string s, double x) {
    const char * a = s.c_str();
    printf("%s: %5.5f\n", a, x);
}

