# Traj_Interpolation

#### 项目介绍
运动学轨迹规划之三次多项式插补和五次多项式插补  
	
#### 运行环境
Visual Studio 2015  

#### 函数介绍
- 三次多项式两点插补：  
CubicSpline::getTraj_Cubic_2points(int time, float start_degree, float end_degree, float start_velocity, float end_velocity, float *trajpoints)    
- 输入： 
time：时间  
start_degree：初始角度  
end_degree：终止角度  
start_velocity：初始速度  
end_velocity：终止速度  
- 输出：
trajpoints：计算得到的时间序列轨迹点  

- 三次多项式多点插补：  
CubicSpline::getTraj_Cubic_manypoints(int time, float *degree_array, float *velocity_array, float *trajpoints, unsigned long long array_num)  
- 输入：
time: 时间   
degree_array：角度数组  
velocity_array：速度数组  
array_num：数组元素个数  
- 输出：
trajpoints：计算得到的时间序列轨迹点
#### 作者列表
盛姜聪

#### 联系方式
邮箱：136072180@qq.com
QQ:136072180
