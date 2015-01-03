class fuzzy
{
public:
	double value;
	double fuzzylow;
	double fuzzymedium;
	double fuzzyhigh;
	double bounds[8];
	void fuzzification();
	void input(double);
	fuzzy(double[]);
};