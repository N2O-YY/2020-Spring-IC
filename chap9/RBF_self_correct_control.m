%Self-Correct control based RBF Identification
clear all;
close all;

xite1 = 0.15;
xite2 = 0.50;
alfa = 0.05;
w = 0.5*ones(6,1);
v = 0.5*ones(6,1);
cij = 0.50*ones(1,6);
bj = 5*ones(6,1);
h = zeros(6,1);
 
w_1 = w;
w_2 = w_1;
v_1 = v;
v_2 = v_1;
u_1 = 0;
y_1 = 0;
ym_1 = 0;

 ts = 0.001;
 for k = 1:1:5000
    time(k) = k*ts;
    r(k) = 0.50*sin(2*pi*k*ts);
 
    %Practical Plant;
    g(k) = 0.8*sin(y_1);
    f(k) = 15;
    y(k) = g(k)+f(k)*u_1;
    for j = 1:1:6
       h(j) = exp(-norm(y(k)-cij(:,j))^2/(2*bj(j)*bj(j)));
    end
    Ng(k) = w'*h;
    Nf(k) = v'*h;
    ym(k) = 0.6*ym_1+r(k);
    e(k) = y(k)-ym(k);
    d_w = 0*w;
    for j = 1:1:6
       d_w(j) = xite1*e(k)*h(j);
    end
    w = w_1+d_w+alfa*(w_1-w_2);
    d_v = 0*v;
    for j = 1:1:6
       d_v(j) = xite2*e(k)*h(j)*u_1;
    end
    v = v_1+d_v+alfa*(v_1-v_2);
    u(k) = -Ng(k)/Nf(k)+r(k)/Nf(k);
    u_1 = u(k);
    y_1 = y(k);
    ym_1 = ym(k);
    w_2 = w_1;
    w_1 = w;
    v_2 = v_1;
    v_1 = v;
end

figure(1);
plot(time,r,'r',time,y,'b');
title('正弦位置跟踪');
xlabel('Time(second)');ylabel('Position tracking');
figure(2);
plot(time,g,'r',time,Ng,'b');
title('g(x,t)及其逼近结果');
xlabel('Time(second)');ylabel('g and Ng');
figure(3);
plot(time,f,'r',time,Nf,'b');
title('f(x,t)及其逼近结果');
xlabel('Time(second)');ylabel('f and Nf');