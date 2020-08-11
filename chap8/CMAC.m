clc, clear;

eta = 0.20;
alpha = 0.05;
M = 200;
N = 20;
c = 3;
w = zeros(N,1);
w_1 = w;
w_2 = w;
d_w = w;
u_1 = 0;
y_1 = 0;

ts = 0.05;
for k = 1:1:200
    time(k) = k*ts;
    u(k) = sin(8*pi*k*ts);
    xmin = -1.0; 
    xmax = 1.0;
    for i = 1:1:c
        s(k,i) = round((u(k)-xmin)*M/(xmax-xmin))+i;   %Quantity:U-->AC
        ad(i) = mod(s(k,i),N)+1;                       %Hash transfer:AC-->AP
    end
    sum = 0;
    for i = 1:1:c
        sum = sum+w(ad(i));
    end
    yn(k) = sum;
    y(k) = (u_1-0.9*y_1)/(1+y_1^2);                      %Nonlinear model
    error(k) = y(k)-yn(k);
    for i = 1:1:c
        ad(i) = mod(s(k,i),N)+1;
        j = ad(i);
        d_w(j) = eta*error(k);
        w(j) = w_1(j)+d_w(j)+alpha*(w_1(j)-w_2(j));
    end
    w_2 = w_1;
    w_1 = w;
    u_1 = u(k);
    y_1 = y(k);
end

figure(1);
plot(time,y,'b',time,yn,'r');
xlabel('time(s)');
ylabel('y,yn');
title('CMACÍøÂç±Æ½üÐ§¹û');
figure(2);
plot(time,y-yn,'k');
xlabel('time(s)');
ylabel('error');
title('CMACÍøÂç±Æ½üÎó²î');