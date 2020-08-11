clc, clear;
eta = 0.50;
alpha = 0.05;

w1 = rands(2,6);
w1_1 = w1;
w1_2 = w1;
dw1 = 0*w1;

w2 = rands(6,1);
w2_1 = w2;
w2_2 = w2;

I = [0,0,0,0,0,0]';
Iout = [0,0,0,0,0,0]';
FI = [0,0,0,0,0,0]';

OUT = 2;
k = 0;
E = 1.0;
NS = 3;

while E >= 1e-20
    k = k+1;
    times(k) = k;
    for s = 1:NS
        xs = [1,0;0,0;0,1];
        ys = [1,0,-1]';
        x = xs(s,:);
        for j = 1:6
            I(j) = x*w1(:,j);
            Iout(j) = 1/(1+exp(-I(j)));
        end
        y1 = w2'*Iout;
        e1 = 0;
        y = ys(s,:);
        e1 = e1+0.5*(y(1)-y1(1))^2;
        es(s) = e1;
        E = 0;
        if s == NS
            for s = 1:NS
                E = E+es(s);
            end
        end
        ey = y-y1;
        w2 = w2_1 +eta*Iout*ey+alpha*(w2_1-w2_2);
        for j=1:6
            S = 1/(1+exp(-I(j)));
            FI(j) = S*(1-S);
        end
        for i = 1:2
            for j = 1:6
                dw1(i,j) = eta*FI(j)*x(i)*ey(1)*w2(j,1);
            end
        end
        w1 = w1_1+dw1+alpha*(w1-w1_2);
        w1_2 = w1_1;
        w1_1 = w1;
        w2_2 = w2_1;
        w2_1 = w2;
    end
    Ek(k) = E;
end

figure(1);
plot(times, Ek, 'r');
title("误差E变化情况");
xlabel('k');
ylabel('E');
save wfile w1 w2;
            