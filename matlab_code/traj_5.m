%example五次多项式轨迹生成：（直线规划，两点规划没有中间点）
clc
clear
%轨迹定义条件
%时间
t0=0;
t1=8;
%位置和速度（a）
q0=0;
q1=10;
v0=0;
v1=0;
acc0=0;
acc1=0;
%利用公式（1-25）求系数
h=q1-q0;
T=t1-t0;
a0=q0;
a1=v0;
a2=1.0/2*acc0;
a3=1.0/(2*T*T*T)*(20*h-(8*v1+12*v0)*T+(acc1-3*acc0)*(T*T));
a4=1.0/(2*T*T*T*T)*(-30*h+(14*v1+16*v0)*T+(3*acc0-2*acc1)*(T*T));
a5=1.0/(2*T*T*T*T*T)*(12*h-6*(v1+v0)*T+(acc1-acc0)*(T*T));
%轨迹生成
t=t0:0.1:t1;%0.1s间隔画一个点，共八十个点
%位置
q=a0+a1*power((t-t0),1)+a2*power((t-t0),2)+a3*power((t-t0),3)+...
    a4*power(t-t0,4)+a5*power(t-t0,5);
%速度
v=a1+2*a2*power((t-t0),1)+3*a3*power((t-t0),2)+4*a4*power(t-t0,3)+...
    5*a5*power(t-t0,4);
%加速度
acc=2*a2+6*a3*power((t-t0),1)+12*a4*power(t-t0,2)+20*a5*power(t-t0,3);
%绘图
subplot(3,2,1)
plot(t,q,'r');
axis([0,8,0,11])
ylabel('position')
grid on
subplot(3,2,3)
plot(t,v,'b');
axis([0,8,-1,2.5])
ylabel('velocity')
grid on
subplot(3,2,5)
plot(t,acc,'g');
xlabel('(a)');
ylabel('acceleration')
grid on

%时间
t0=0;
t1=8;
%位置和速度（a）
q0=0;
q1=10;
v0=0;
v1=2;
acc0=0;
acc1=0;
%利用公式（1-25）求系数
h=q1-q0;
T=t1-t0;
a0=q0;
a1=v0;
a2=1.0/2*acc0;
a3=1.0/(2*T*T*T)*(20*h-(8*v1+12*v0)*T+(acc1-3*acc0)*(T*T));
a4=1.0/(2*T*T*T*T)*((-30*h+(14*v1+16*v0)*T)+(3*acc0-2*acc1)*(T*T));
a5=1.0/(2*T*T*T*T*T)*(12*h-6*(v1+v0)*T+(acc1-acc0)*(T*T));
%轨迹生成
t=t0:0.1:t1;
%位置
q=a0+a1*power((t-t0),1)+a2*power((t-t0),2)+a3*power((t-t0),3)+...
    a4*power(t-t0,4)+a5*power(t-t0,5);
%速度
v=a1+2*a2*power((t-t0),1)+3*a3*power((t-t0),2)+4*a4*power(t-t0,3)+...
    5*a5*power(t-t0,4);
%加速度
acc=2*a2+6*a3*power((t-t0),1)+12*a4*power(t-t0,2)+20*a5*power(t-t0,3);
%绘图
subplot(3,2,2)
plot(t,q,'r');
axis([0,8,-5,30])
ylabel('position')
grid on
subplot(3,2,4)
plot(t,v,'b');
ylabel('velocity')
grid on
subplot(3,2,6)
plot(t,acc,'g');
xlabel('(b)');
ylabel('acceleration')
grid on


%example五次多项式轨迹生成：（直线规划，两点规划包含有中间点）
clc
clear
close('all')
%轨迹定义条件
%时间、位置和速度（a）
t_array=[0,2,4,6,8];
q_array=[0,10,20,30,40];
v_array=[3,3,3,3,3];
%起点和终点加速度假设为0，中间点加速度都初始化为0，
acc_array=[0,0,0,0,0];
%计算轨迹
%初始位置
t=t_array(1);
q=q_array(1);
v=v_array(1);
v_array2=v_array;
acc=acc_array(1);

for k=1:length(t_array)-1
    %按照式（1-23）式确定中间点的速度值
    if(k>1)
        dk1=(q_array(k)-q_array(k-1))/(t_array(k)-t_array(k-1));
        dk2=(q_array(k+1)-q_array(k))/(t_array(k+1)-t_array(k));
        if((dk2>=0 && dk1>=0) || (dk2<=0 && dk1<=0))
            v_array2(k)=1.0/2.0*(dk1+dk2);
        else
            v_array2(k)=0;
        end  
    end
end

for k=1:length(t_array)-1
   
    %利用公式（1-25）求系数
    %计算各段多项式的系数
    h(k)=q_array(k+1)-q_array(k);
    T(k)=t_array(k+1)-t_array(k);
    a0(k)=q_array(k);
    a1(k)=v_array2(k);
    a2(k)=1.0/2*acc_array(k);
    a3(k)=1.0/(2*T(k)*T(k)*T(k))*(20*h(k)-(8*v_array2(k+1)+12*v_array2(k))*T(k)+(acc_array(k+1)-3*acc_array(k))*(T(k)*T(k)));
    a4(k)=1.0/(2*T(k)*T(k)*T(k)*T(k))*(-30*h(k)+(14*v_array2(k+1)+16*v_array2(k))*T(k)+(3*acc_array(k)-2*acc_array(k+1))*(T(k)*T(k)));
    a5(k)=1.0/(2*T(k)*T(k)*T(k)*T(k)*T(k))*(12*h(k)-6*(v_array2(k+1)+v_array2(k))*T(k)+(acc_array(k+1)-acc_array(k))*(T(k)*T(k)));
    
    %生成各段轨迹密化的数据点
    %局部时间坐标
    tau=t_array(k):T(k)/100:t_array(k+1);
    %全局时间坐标，由局部时间坐标组成
    t=[t,tau(2:end)];
    %位置
    qk=a0(k)+a1(k)*power(tau-tau(k),1)+a2(k)*power(tau-tau(k),2)+a3(k)*power(tau-tau(k),3)+...
        a4(k)*power(tau-tau(k),4)+a5(k)*power(tau-tau(k),5);
     %全局位置坐标
    q=[q,qk(2:end)];
    %速度
    vk=a1(k)+2*a2(k)*power(tau-tau(k),1)+3*a3(k)*power(tau-tau(k),2)+4*a4(k)*power(tau-tau(k),3)+...
        5*a5(k)*power(tau-tau(k),4);
     v=[v,vk(2:end)];
    %加速度
    acck=2*a2(k)+6*a3(k)*power(tau-tau(k),1)+12*a4(k)*power(tau-tau(k),2)+20*a5(k)*power(tau-tau(k),3);
    acc=[acc,acck(2:end)];

end
%绘图
subplot(3,1,1)
plot(t,q,'r');
hold on
plot(t_array,q_array,'o');
 axis([0,10,-5,45])
ylabel('position')
grid on
subplot(3,1,2)
plot(t,v,'b');
hold on
plot(t_array,v_array2,'o');
axis([0,10,-20,15])
ylabel('velocity')
grid on
subplot(3,1,3)
plot(t,acc,'g');
axis([0,10,-35,35])
ylabel('acceleration')
grid on
