function Obj = Objfun(X)
%% 用来分别求解种群中各个个体的目标值
%% 输入
% X:所有个体的初始权值和阈值
%% 输出
% Obj:所有个体每个时刻误差的绝对值的平均数
    [M,N] = size(X);
    Obj = zeros(M,1);
    for i=1:M
        Obj(i) = PIDfun(X(i,:));
    end
end