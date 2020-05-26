%两点均匀插补，匀速运动。
clear;
clc;
p0=[1,2,3];
pf=[2,4,5];         %指定起止位置
v=0.1;              %指定速度
x=[p0(1)];y=[p0(2)];z=[p0(3)];
L=((pf(1)-p0(1))^2+(pf(2)-p0(2))^2+(pf(3)-p0(3))^2)^0.5;%直线长度
N=L/v;              %插补次数
dx=(pf(1)-p0(1))/N; %每个周期各轴增量
dy=(pf(2)-p0(2))/N;
dz=(pf(3)-p0(3))/N;
for t=1:1:N         %插补
x(t+1)=x(t)+dx;
y(t+1)=y(t)+dy;
z(t+1)=z(t)+dz;
end
plot3(x,y,z,'r'),xlabel('x'),ylabel('y'),zlabel('z'),hold on,plot3(x,y,z,'o','color','g'),grid on;
