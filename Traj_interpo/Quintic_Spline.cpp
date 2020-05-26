#include "Quintic_Spline.h"
#include <stdio.h>
#include <math.h>

bool QuinticSpline::getTraj_Quintic_manypoints(int time, float *degree_array, float *velocity_array, float *acceleration_array, float *trajpoints, unsigned long long array_num)
{

	float dk1 = 0;
	float dk2 = 0;
	float **a = new float*[array_num];

	if (time > 50)
		return false;

	for (int i = 0; i < array_num; ++i)
	{
		a[i] = new float[6];
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
		a[i][2] = 0.5 * acceleration_array[i];
		a[i][3] = 1.0 / (2 * t * t * t)*(20 * (degree_array[i + 1] - degree_array[i]) - (8 * velocity_array[i + 1] + 12 * velocity_array[i]) * t + (acceleration_array[i + 1] - 3 * acceleration_array[i]) * (t * t));
		a[i][4] = 1.0 / (2 * t * t * t * t)*(-30 * (degree_array[i + 1] - degree_array[i]) + (14 * velocity_array[i + 1] + 16 * velocity_array[i]) * t + (3 * acceleration_array[i] - 2 * acceleration_array[i + 1]) * (t * t));
		a[i][5] = 1.0 / (2 * t * t * t * t * t) * (12 * (degree_array[i + 1] - degree_array[i]) - 6 * (velocity_array[i + 1] + velocity_array[i]) * t + (acceleration_array[i + 1] - acceleration_array[i]) * (t * t));
		//printf("%f  %f  %f  %f	%f	%f\n", a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5]);

		for (k = i * 10 * t; k < (i + 1) * 10 * t; k++)
		{
			trajpoints[k * 4 + 0] = float(k) / 10;
			trajpoints[k * 4 + 1] = a[i][0] + a[i][1] * pow((float(k - 10 * i * t) / 10), 1) + a[i][2]  * pow((float(k - 10 * i * t) / 10), 2) + a[i][3] * pow((float(k - 10 * i * t) / 10), 3) + a[i][4] * pow((float(k - 10 * i * t) / 10), 4) + a[i][5] * pow((float(k - 10 * i * t) / 10), 5);
			trajpoints[k * 4 + 2] = a[i][1] + 2 * a[i][2] * pow((float(k - 10 * i * t) / 10), 1) + 3 * a[i][3] * pow((float(k - 10 * i * t) / 10), 2) + 4 * a[i][4] * pow((float(k - 10 * i * t) / 10), 3) + 5 * a[i][5] * pow((float(k - 10 * i * t) / 10), 4);
			trajpoints[k * 4 + 3] = 2 * a[i][2] + 6 * a[i][3] * pow((float(k - 10 * i * t) / 10), 1) + 12 * a[i][4] * pow((float(k - 10 * i * t) / 10), 2) + 20 * a[i][5] * pow((float(k - 10 * i * t) / 10), 3);
			//printf("Time:%f		degree:%f	velocity:%f		accel:%f\n", trajpoints[k * 4 + 0], trajpoints[k * 4 + 1], trajpoints[k * 4 + 2], trajpoints[k * 4 + 3]);
		}
	}

	delete[] a;
	return true;
}