#include "fuzzylogic.h"

fuzzy::fuzzy(double input[])
{
	for(int i=0;i<8;i++)
		bounds[i]=input[i];
	fuzzylow=0;
	fuzzymedium=0;
	fuzzyhigh=0;
}
void fuzzy::input(double n)
{
	value=n;
}
void fuzzy::fuzzification()
{
	if(value<=bounds[0])
		fuzzylow=1;
	else if(value>bounds[0]&&value<bounds[2])
		fuzzylow=-(1/(bounds[2]-bounds[0]))*value+bounds[2]/(bounds[2]-bounds[0]);
	else
		fuzzylow=0;

	if(value<=bounds[1])
		fuzzymedium=0;
	else if(value>bounds[1]&&value<bounds[3])
		fuzzymedium=(1/(bounds[3]-bounds[1]))*value-bounds[1]/(bounds[3]-bounds[1]);
	else if(value>=bounds[3]&&value<=bounds[4])
		fuzzymedium=1;
	else if(value>bounds[4]&&value<=bounds[6])
		fuzzymedium=(1/(bounds[4]-bounds[6]))*value-bounds[6]/(bounds[4]-bounds[6]);
	else
		fuzzymedium=0;

	if(value<=bounds[5])
		fuzzyhigh=0;
	else if(value>bounds[5]&&value<bounds[7])
		fuzzyhigh=(1/(bounds[7]-bounds[5]))*value-bounds[5]/(bounds[7]-bounds[5]);
	else fuzzyhigh=1;

}