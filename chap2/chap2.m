%Expert PID Controller
clear all;
close all;

ts=0.001;   %设定采样时间为1ms
sys=tf(133,[1,25,0]);  %建立被控对象传递函数
dsys=c2d(sys,ts,'z');   %对传递函数进行离散化处理
[num,den]=tfdata(dsys,'v'); %对离散化处理结果提取分子和分母

u_1=0;u_2=0;    %u_1为被控对象初始输入值，u_2为u_1在下一个ts内的值
y_1=0;y_2=0;    %y_1输出的初始状态,y_2为下一个ts的输出状态
x=[0,0,0]'; %x(1)表示k时刻误差，x(2)表示k时刻对应微分，x(3）表示k时刻对应积分
x2_1=0;
%对kp，ki，kd进行初始化
kp=6; 
ki=3;     
kd=0.01;

error_1=0;  %初始误差为0
%迭代10000次
for k=1:1:10000
    time(k)=k*ts;
    r(k)=1;                       %Tracing Step Signal
    u(k)=kp*x(1)+kd*x(2)+ki*x(3); %PID控制器
    
    %专家控制规则
    %Rule1:Unclosed control rule
    if abs(x(1))>0.8      
       u(k)=0.45;
    elseif abs(x(1))>0.40        
       u(k)=0.40;
    elseif abs(x(1))>0.20    
       u(k)=0.12; 
    elseif abs(x(1))>0.01 
       u(k)=0.10;   
    end
    
    %Rule2
    if x(1)*x(2)>0|(x(2)==0)       
       if abs(x(1))>=0.05
          u(k)=u_1+2*kp*x(1);
       else
          u(k)=u_1+0.4*kp*x(1);
       end
    end
       
    %Rule3
    if (x(1)*x(2)<0&x(2)*x2_1>0)|(x(1)==0)   
        u(k)=u(k);
    end

    %Rule4
    if x(1)*x(2)<0&x(2)*x2_1<0   
       if abs(x(1))>=0.05
          u(k)=u_1+2*kp*error_1;
       else
          u(k)=u_1+0.6*kp*error_1;
       end
    end

    %Rule5:Integration separation PI control
    if abs(x(1))<=0.001   
       u(k)=0.5*x(1)+0.010*x(3);
    end

    %Restricting the output of controller
    if u(k)>=10
       u(k)=10;
    end
    if u(k)<=-10
       u(k)=-10;
    end

    %Linear model
    y(k)=-den(2)*y_1-den(3)*y_2+num(1)*u(k)+num(2)*u_1+num(3)*u_2;
    error(k)=r(k)-y(k);

    %----------Return of parameters------------%
    u_3=u_2;u_2=u_1;u_1=u(k);
    y_3=y_2;y_2=y_1;y_1=y(k);

    x(1)=error(k);                % Calculating P
    x2_1=x(2);
    x(2)=(error(k)-error_1)/ts;   % Calculating D
    x(3)=x(3)+error(k)*ts;        % Calculating I

    error_1=error(k);
end

figure(1);
plot(time,r,'b',time,y,'r');
xlabel('time(s)');ylabel('r,y');
figure(2);
plot(time,r-y,'r');
xlabel('time(s)');ylabel('error');