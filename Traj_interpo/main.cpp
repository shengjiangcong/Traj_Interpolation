#include<stdio.h>
#include "Quintic_Spline.h"
#include "Cubic_Spline.h"

int main()
{
	printf("helloworld\n");
	int time = 8;//单位s
	float start_degree = 0;//单位°
	float end_degree = 50;//单位°
	float start_velocity = 0;
	float end_velocity = 0;

	float aa = 0;


	CubicSpline traj;
	aa = traj.getTraj_Cubic_2points(time, start_degree, end_degree, start_velocity, end_velocity);
	printf("%f\n", aa);
}