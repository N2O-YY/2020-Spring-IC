clc, clear;
%3-1进行四个隶属函数的仿真
a = 0:200/1e5:200; %自变量
o = zeros(size(a)); %隶属函数o
y = zeros(size(a)); %隶属函数y
w = zeros(size(a)); %隶属函数w
v = zeros(size(a)); %隶属函数v

%定义隶属函数o
for i = 1:1e5
    if a(i)>=0 && a(i)<=50
        o(i) = 0;
    elseif a(i)>=50 && a(i)<=70
        o(i) = (a(i)-50)/20;
    elseif a(i)>=70
        o(i) = 1;
    end
end

%定义隶属函数y
for i = 1:1e5
    if a(i)>=0 && a(i)<=25
        y(i) = 1;
    elseif a(i)>=25 && a(i)<=70
        y(i) = (70-a(i))/45;
    elseif a(i)>=70
        y(i) = 0;
    end
end

%定义隶属函数w
for i = 1:1e5
    if a(i)>=0 && a(i)<=25
        w(i) = 1;
    elseif a(i)>=25 && a(i)<=70
        w(i) = ((70-a(i))/45)^2;
    elseif a(i)>=70
        w(i) = 0;
    end
end

%定义隶属函数v
for i = 1:1e5
    if a(i)>=0 && a(i)<=25
        v(i) = 0;
    elseif a(i)>=25 && a(i)<=730/13
        v(i) = (a(i)-25)/45;
    elseif a(i)>=730/13 && a(i)<=70
        v(i) = (70-a(i))/20;        
    elseif a(i)>=70
        v(i) = 0;
    end
end

%绘制函数图像
subplot(2,2,1);
plot(a,o);
title('O');xlabel('a Years');ylabel('Degree of membership');
subplot(2,2,2);
plot(a,y);
title('Y');xlabel('a Years');ylabel('Degree of membership');
subplot(2,2,3);
plot(a,w);
title('W');xlabel('a Years');ylabel('Degree of membership');
subplot(2,2,4);
plot(a,v);
title('V');xlabel('a Years');ylabel('Degree of membership');