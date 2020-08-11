clc, clear;
eta = 0.50;
alpha = 0.05;

x = [0,0]';
b = 1.5*ones(5,1);
c = [-1.5, -0.5, 0, 0.5, 1.5;
    -1.5, 0.5, 0, 0.5, 1.5];

w = rands(5,1);
w_1 = w;
w_2 = w;
u_1 = 0;
y_1 = 0;

ts = 0.001;
for k = 1:1000
    time(k) = k*ts;
    u(k) = 0.50*sin(6*pi*k*ts);
    y(k) = (u_1-0.9*y_1)/(1+y_1^2);
    x(1) = u(k);
    x(2) = y(k);
    for j = 1:5
        h(j) = exp(-norm(x-c(:,j))^2/(2*b(j)*b(j)));
    end
    ym(k) = w'*h';
    em(k) = y(k)-ym(k);
    d_w = eta*em(k)*h';
    w = w_1+d_w+alpha*(w_1-w_2);
    y_1 = y(k);
    u_1 = u(k);
    w_2 = w_1;
    w_1 = w;
end

figure(1);
plot(time,y,'r',time,ym,'b');
xlabel('time(s)');
ylabel('error');
title('RBFÍøÂç±Æ½üÐ§¹û');
figure(2);
plot(time,y-ym,'r');
xlabel('time(s)');
ylabel('error');
title('RBFÍøÂç±Æ½üÎó²î');