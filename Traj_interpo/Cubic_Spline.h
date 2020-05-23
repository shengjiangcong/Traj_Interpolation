
class CubicSpline
{
public:
	bool getTraj_Cubic_2points(int time, float start_degree, float end_degree, float start_velocity, float end_velocity, float *trajpoints);
	bool getTraj_Cubic_manypoints(int time, float *degree_array, float *velocity_array, float *trajpoints,  unsigned long long array_num);
};