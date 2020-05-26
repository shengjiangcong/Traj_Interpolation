%example轨迹规划三次多项式：两点直线运动，加速度不受控制
% clc
% clear
% %轨迹定义条件
% %时间
% t0=0;
% t1=8;
% %位置和速度（a）
% q0=0;
% q1=10;
% v0=0;
% v1=0;
% %利用公式（1-22）求系数
% h=q1-q0;
% T=t1-t0;
% a0=q0;
% a1=v0;
% a2=(3*h-(2*v0+v1)*T)/(T*T);
% a3=(-2*h+(v0+v1)*T)/(T*T*T);
% %轨迹生成
% t=t0:0.1:t1;
% %位置
% q=a0+a1*power((t-t0),1)+a2*power((t-t0),2)+a3*power((t-t0),3);
% %速度
% v=a1+2*a2*power((t-t0),1)+3*a3*power((t-t0),2);
% %加速度
% acc=2*a2+6*a3*power((t-t0),1);
% %绘图
% subplot(3,2,1)
% plot(t,q,'r');
% ylabel('position')
% grid on
% subplot(3,2,3)
% plot(t,v,'b');
% ylabel('velocity')
% grid on
% subplot(3,2,5)
% plot(t,acc,'g');
% xlabel('(a)');
% ylabel('acceleration')
% grid on
% 
% %时间
% t0=0;
% t1=8;
% %位置和速度（b）
% q0=0;
% q1=10;
% v0=0;
% v1=2;
% %利用公式（1-22）求系数
% h=q1-q0;
% T=t1-t0;
% a0=q0;
% a1=v0;
% a2=(3*h-(2*v0+v1)*T)/(T*T);
% a3=(-2*h+(v0+v1)*T)/(T*T*T);
% %轨迹生成
% t=t0:0.1:t1;
% %位置
% q=a0+a1*power((t-t0),1)+a2*power((t-t0),2)+a3*power((t-t0),3);
% %速度
% v=a1+2*a2*power((t-t0),1)+3*a3*power((t-t0),2);
% %加速度
% acc=2*a2+6*a3*power((t-t0),1);
% %绘图
% subplot(3,2,2)
% plot(t,q,'r');
% ylabel('position')
% grid on
% subplot(3,2,4)
% plot(t,v,'b');
% ylabel('velocity')
% grid on
% subplot(3,2,6)
% plot(t,acc,'g');
% xlabel('(b)');
% ylabel('acceleration')
% grid on


%example三次多项式轨迹：多个点连接的路径,加速度不连续，中间点速度确定
clc
clear
%轨迹定义条件
t_array=[0,2,4,6,8];
q_array=[0,10,20,30,40];
v_array=[0,2,2,2,0];
%计算轨迹
%初始位置
t=t_array(1);
q=q_array(1);
v=v_array(1);
%计算各段轨迹
for k=1:length(t_array)-1
    %计算各段多项式的系数
    h(k)=q_array(k+1)-q_array(k);
    T(k)=t_array(k+1)-t_array(k);
    a0(k)=q_array(k);
    a1(k)=v_array(k);
    a2(k)=(3*h(k)-(2*v_array(k)+v_array(k+1))*T(k))/(T(k)*T(k));
    a3(k)=(-2*h(k)+(v_array(k)+v_array(k+1))*T(k))/(T(k)*T(k)*T(k));

    %生成各段轨迹密化的数据点
    %局部时间坐标
    tau=t_array(k):T(k)/100:t_array(k+1);
    %全局时间坐标，由局部时间坐标组成
    t=[t,tau(2:end)];
    %局部位置坐标
    qk=a0(k)+a1(k)*power(tau-tau(k),1)+a2(k)*power(tau-tau(k),2)+a3(k)*power(tau-tau(k),3);
    %全局位置坐标
    q=[q,qk(2:end)];
    %速度
    vk=a1(k)+2*a2(k)*power(tau-tau(k),1)+3*a3(k)*power(tau-tau(k),2);
    v=[v,vk(2:end)];
    %加速度
    acck=2*a2(k)+6*a3(k)*power(tau-tau(k),1);
    if(k==1)
        acc=2*a2(k);
    end
    acc=[acc,acck(2:end)];
end
%绘图
subplot(3,1,1);
h1=plot(t,q,'-r');
legend(h1,'第一种方式')
hold on;
plot(t_array,q_array,'or');
axis([0,10,-5,45]);
ylabel('position')
grid on;
subplot(3,1,2);
plot(t_array,v_array,'ob');
hold on;
plot(t,v,'b');
axis([0,10,-20,15]);
ylabel('velocity')
grid on;
subplot(3,1,3);
plot(t,acc,'g');
hold on
axis([0,10,-45,45]);
ylabel('acceleration')
grid on;






%example三次多项式轨迹：多个点连接的路径,加速度不连续，中间点速度不确定
%example2.8
clc
clear
%轨迹定义条件
t_array=[0,2,4,6,8];
q_array=[0,10,20,30,40];
v_array=[0,2,2,2,0];
%计算轨迹
%初始位置
t=t_array(1);
q=q_array(1);
v=v_array(1);
v_array2=v_array;

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

%计算各段轨迹
for k=1:length(t_array)-1
    %计算各段多项式的系数
    h(k)=q_array(k+1)-q_array(k);
    T(k)=t_array(k+1)-t_array(k);
    a0(k)=q_array(k);
    a1(k)=v_array2(k);
    a2(k)=(3*h(k)-(2*v_array2(k)+v_array2(k+1))*T(k))/(T(k)*T(k));
    a3(k)=(-2*h(k)+(v_array2(k)+v_array2(k+1))*T(k))/(T(k)*T(k)*T(k));

    %生成各段轨迹密化的数据点
    %局部时间坐标
    tau=t_array(k):T(k)/100:t_array(k+1);
    %全局时间坐标，由局部时间坐标组成
    t=[t,tau(2:end)];
    %局部位置坐标
    qk=a0(k)+a1(k)*power(tau-tau(k),1)+a2(k)*power(tau-tau(k),2)+a3(k)*power(tau-tau(k),3);
    %全局位置坐标
    q=[q,qk(2:end)];
    %速度
    vk=a1(k)+2*a2(k)*power(tau-tau(k),1)+3*a3(k)*power(tau-tau(k),2);
    v=[v,vk(2:end)];
    %加速度
    acck=2*a2(k)+6*a3(k)*power(tau-tau(k),1);
    if(k==1)
        acc=2*a2(k);
    end
    acc=[acc,acck(2:end)];
end
%绘图
subplot(3,1,1);
h2=plot(t,q,'--r');
legend(h2,'第二种方式')
hold on;
plot(t_array,q_array,'^r');
axis([0,10,-5,45]);
ylabel('position')
grid on;
subplot(3,1,2);
plot(t_array,v_array2,'^b');
hold on;
plot(t,v,'--b');
axis([0,10,-20,15]);
ylabel('velocity')
grid on;
subplot(3,1,3);
plot(t,acc,'--g');
axis([0,10,-45,45]);
ylabel('acceleration')
grid on;