#include "Cubic_Spline.h"
#include <stdio.h>
#include <math.h>

bool CubicSpline::getTraj_Cubic_2points(int time, float start_degree, float end_degree, float start_velocity, float end_velocity, float *trajpoints)
{
	printf("getTraj_Cubic_2points:\n");

	//float trajpoints[500][4] = { 0 };//轨迹点，最大支持500个点
	float degree = 0;
	float a[4] = { 0 };

	if (time > 50)
		return false;

	degree = end_degree - start_degree;
	a[0] = start_degree;
	a[1] = start_velocity;
	a[2] = (3 * degree - (2 * start_velocity + end_velocity)*time) / (time*time);
	a[3] = (-2 * degree + (start_velocity + end_velocity)*time) / (time*time*time);
	
	for (int t = 0; t <= time * 10; t++)
	{
		trajpoints[t*4 + 0] = float(t) / 10;
		trajpoints[t*4 + 1] = a[0] + a[1]*pow((float(t) / 10), 1) + a[2]*pow((float(t) / 10), 2) + a[3]*pow((float(t) / 10), 3);
		trajpoints[t*4 + 2] = a[1] + 2 * a[2]*pow((float(t) / 10), 1) + 3 * a[3]*pow((float(t) / 10), 2);
		trajpoints[t*4 + 3] = 2 * a[2] + 6 * a[3]*pow((float(t) / 10), 1);
	}
	return true;
}