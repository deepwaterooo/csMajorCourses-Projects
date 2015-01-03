#include <iostream>
#include <string>
#include <fstream>
#include "listQ.h"
#include "queueL.h"

using namespace std;


int main()
{
	Queue test;
	test.Insert(1, 1);
	test.Insert(1, 2);
	test.Insert(1, 3);
	test.Print();
	cout << endl;
	test.Delete();
	test.Print();
	return 0;
}
	
