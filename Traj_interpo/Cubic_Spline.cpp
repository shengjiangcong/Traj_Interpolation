#include "Cubic_Spline.h"
#include <stdio.h>
#include <math.h>
#include <iostream>

bool CubicSpline::getTraj_Cubic_2points(int time, float start_degree, float end_degree, float start_velocity, float end_velocity, float *trajpoints)
{
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

bool CubicSpline::getTraj_Cubic_manypoints(int time, float *degree_array, float *velocity_array, float *trajpoints, unsigned long long array_num)
{

	float dk1 = 0;
	float dk2 = 0;
	float **a = new float*[array_num];

	if (time > 50)
		return false;

	for (int i = 0; i < array_num; ++i)
	{
		a[i] = new float[4];
	}

	for (int i = 0; i < array_num - 1; i++)
	{
		if (i > 0)
		{
			dk1 = (degree_array[i] - degree_array[i - 1]) / (float(time) / (array_num - 1));
			dk2 = (degree_array[i + 1] - degree_array[i]) / (float(time) / (array_num - 1));
		}
		if ((dk2 >= 0 && dk1 >= 0) || (dk2 <= 0 && dk1 <= 0))
			velocity_array[i] = 1.0 / 2.0 * (dk1 + dk2);
		else
			velocity_array[i] = 0;
		//printf("%f\n", velocity_array[i]);
	}

	for (int i = 0; i < array_num - 1; i++)
	{
		float t = float(time) / (array_num - 1);
		int k = 0;

		a[i][0] = degree_array[i];
		a[i][1] = velocity_array[i];
		a[i][2] = (3 * (degree_array[i + 1] - degree_array[i]) - (2 * velocity_array[i] + velocity_array[i + 1]) * t) / (t * t);
		a[i][3] = (-2 * (degree_array[i + 1] - degree_array[i]) + (velocity_array[i] + velocity_array[i + 1]) * t) / (t * t * t);
		//printf("%f  %f  %f  %f\n", a[i][0], a[i][1], a[i][2], a[i][3]);
		for (k = i * 10 * t; k < (i + 1) * 10 * t; k++)
		{
			trajpoints[k * 4 + 0] = float(k) / 10;
			trajpoints[k * 4 + 1] = a[i][0] + a[i][1] * pow((float(k - 10 * i * t ) / 10), 1) + a[i][2] * pow((float(k - 10 * i * t ) / 10), 2) + a[i][3] * pow((float(k - 10 * i * t ) / 10), 3);
			trajpoints[k * 4 + 2] = a[i][1] + 2 * a[i][2] * pow((float(k - 10 * i * t) / 10), 1) + 3 * a[i][3] * pow((float(k - 10 * i * t) / 10), 2);
			trajpoints[k * 4 + 3] = 2 * a[i][2] + 6 * a[i][3]  * pow((float(k - 10 * i * t) / 10), 1);
			//printf("Time:%f		degree:%f	velocity:%f		accel:%f\n", trajpoints[k * 4 + 0], trajpoints[k * 4 + 1], trajpoints[k * 4 + 2], trajpoints[k * 4 + 3]);
		}
	}

	delete[] a;
	return true;
}