clc, clear;
load wfile w1 w2;

x = [1,0.1;0.5,0.5;0.1,1];
for i = 1:3
    for j = 1:6
        I(i,j) = x(i,:)*w1(:,j);
        Iout(i,j) = 1/(1+exp(-I(i,j)));
    end
end
y = w2'*Iout';
y = y';