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
	float trajpoints[500][4] = { 0 };//最多支持500个点
	bool Traj_Cubic_2points;

	CubicSpline traj;
	Traj_Cubic_2points = traj.getTraj_Cubic_2points(time, start_degree, end_degree, start_velocity, end_velocity, *trajpoints);
	if (Traj_Cubic_2points == false)
		printf("Error:trajectory points need to be less than 500!\n");
	else if (Traj_Cubic_2points == true)
	{
		for (int t = 0; t <= time * 10; t++)
		{
			printf("Time:%f		degree:%f	velocity:%f		accel:%f\n", trajpoints[t][0], trajpoints[t][1], trajpoints[t][2], trajpoints[t][3]);
		}
	}
		
}