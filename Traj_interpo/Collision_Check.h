#pragma once
#include <math.h>

class Collision_Check
{
public:
	bool colcheck();
	bool IsEqual(double d1, double d2);
    double SqureDistanceSegmentToSegment(
		double x1, double y1, double z1,
		double x2, double y2, double z2,
		double x3, double y3, double z3,
		double x4, double y4, double z4);
	float CalculatePointToLineDistance(float point[2], const float p1[2], const float p2[2]);
};