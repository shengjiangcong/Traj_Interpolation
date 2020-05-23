#include<stdio.h>
#include "Quintic_Spline.h"
#include "Cubic_Spline.h"

int main()
{
	printf("helloworld\n");
	int time = 10;//单位s
	float trajpoints[500][4] = { 0 };//最多支持500个点
	/********2points*********/
	float start_degree = 0;//单位°
	float end_degree = 50;//单位°
	float start_velocity = 0;//单位°/s
	float end_velocity = 0;//单位°/s
	bool Traj_Cubic_2points;
	/*******manypoints*******/
	bool Traj_Cubic_manypoints;
	float degree_array[6] = { 0, 10, 20, 30, 40, 50};//单位°
	float velocity_array[6] = { 0, 2, 2, 2, 2, 0 };//单位°/s
	unsigned long long array_num = sizeof(degree_array) / sizeof(float);//轨迹点的个数

	CubicSpline traj;
	/*****************三次多项式两点间规划轨迹*****************/
	Traj_Cubic_2points = traj.getTraj_Cubic_2points(time, start_degree, end_degree, start_velocity, end_velocity, *trajpoints);
	if (Traj_Cubic_2points == false)
		printf("Error:trajectory points need to be less than 500!\n");
	else if (Traj_Cubic_2points == true)
	{
	    printf("The trajectory from %f°to %f° is:\n",start_degree,end_degree);

		for (int t = 0; t <= time * 10; t++)
		{
			printf("Time:%f		degree:%f	velocity:%f		accel:%f\n", trajpoints[t][0], trajpoints[t][1], trajpoints[t][2], trajpoints[t][3]);
		}
	}
/****************三次多项式多个点之间规划轨迹*********************/
	Traj_Cubic_manypoints = traj.getTraj_Cubic_manypoints(time, degree_array, velocity_array, *trajpoints, array_num);
	if (Traj_Cubic_manypoints == false)
		printf("Error:trajectory points need to be less than 500!\n");
	else if (Traj_Cubic_manypoints == true)
	{
		printf("The trajectory between %d points is:\n",array_num);

		for (int t = 0; t < time * 10; t++)
		{
			printf("Time:%f		degree:%f	velocity:%f		accel:%f\n", trajpoints[t][0], trajpoints[t][1], trajpoints[t][2], trajpoints[t][3]);
		}
	}
}