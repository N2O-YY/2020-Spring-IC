clc, clear;
%3-1�����ĸ����������ķ���
a = 0:200/1e5:200; %�Ա���
o = zeros(size(a)); %��������o
y = zeros(size(a)); %��������y
w = zeros(size(a)); %��������w
v = zeros(size(a)); %��������v

%������������o
for i = 1:1e5
    if a(i)>=0 && a(i)<=50
        o(i) = 0;
    elseif a(i)>=50 && a(i)<=70
        o(i) = (a(i)-50)/20;
    elseif a(i)>=70
        o(i) = 1;
    end
end

%������������y
for i = 1:1e5
    if a(i)>=0 && a(i)<=25
        y(i) = 1;
    elseif a(i)>=25 && a(i)<=70
        y(i) = (70-a(i))/45;
    elseif a(i)>=70
        y(i) = 0;
    end
end

%������������w
for i = 1:1e5
    if a(i)>=0 && a(i)<=25
        w(i) = 1;
    elseif a(i)>=25 && a(i)<=70
        w(i) = ((70-a(i))/45)^2;
    elseif a(i)>=70
        w(i) = 0;
    end
end

%������������v
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

%���ƺ���ͼ��
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