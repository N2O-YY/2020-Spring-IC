function J = obj(X,t,N,ut,y)
%********�������Ŀ�꺯��ֵ
    Kp = X(1);
    T1p = X(2);
    T2p = X(3);
    Tp = X(4);
%%%%%%%%%%%%%%%%
    Gp = tf([Kp],[T2p T1p+T2p 1],'inputdelay',Tp);
    yp = lsim(Gp,ut,t);
    E = yp-y;
    J = 0;
    for i = 1:1:N
        J = J+0.5*E(i)*E(i);
    end
end