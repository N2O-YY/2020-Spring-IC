function err = PIDfun(xi)
%% 训练和测试PID控制系统
%% 输入
    % xi:一个个体的初始权值和阈值
%% 输出
    % err:该个体每个时刻误差的绝对值的平均数
%% err计算
    ts = 0.001;
    sys = tf(5.235e005,[1,87.35,1.047e004,0]);  %Plant
    dsys = c2d(sys,ts,'z');
    [num,den] = tfdata(dsys,'v');

    u_1 = 0;
    u_2 = 0;
    u_3 = 0;
    y_1 = 0;
    y_2 = 0;
    y_3 = 0;
    x = [0,0,0]';
    x2_1 = 0;

    kp = xi(1);
    ki = xi(2);     
    kd = xi(3);

    error_1 = 0;
    for k = 1:1:500
        time(k) = k*ts;
        r(k) = 1.0;                    %Tracing Step Signal
        u(k) = kp*x(1)+kd*x(2)+ki*x(3); %PID Controller

        %Expert control rule
        if abs(x(1))>0.8      %Rule1:Unclosed control rule
           u(k) = 0.45;
        elseif abs(x(1))>0.40        
           u(k) = 0.40;
        elseif abs(x(1))>0.20    
           u(k) = 0.12; 
        elseif abs(x(1))>0.01 
           u(k) = 0.10;   
        end   

        if x(1)*x(2)>0|(x(2)==0)       %Rule2
           if abs(x(1))>=0.05
              u(k) = u_1+2*kp*x(1);
           else
              u(k) = u_1+0.4*kp*x(1);
           end
        end

        if (x(1)*x(2)<0&x(2)*x2_1>0)|(x(1)==0)   %Rule3
            u(k) = u(k);
        end

        if x(1)*x(2)<0&x(2)*x2_1<0   %Rule4
           if abs(x(1))>=0.05
              u(k) = u_1+2*kp*error_1;
           else
              u(k) = u_1+0.6*kp*error_1;
           end
        end

        if abs(x(1))<=0.001   %Rule5:Integration separation PI control
           u(k) = 0.5*x(1)+0.010*x(3);
        end

        %Restricting the output of controller
        if u(k)>=10
           u(k) = 10;
        end
        if u(k)<=-10
           u(k) = -10;
        end

        %Linear model
        y(k) = -den(2)*y_1-den(3)*y_2-den(4)*y_3+num(1)*u(k)+num(2)*u_1+num(3)*u_2+num(4)*u_3;
        error(k) = r(k)-y(k);
        %----------Return of parameters------------%
        u_3 = u_2;
        u_2 = u_1;
        u_1 = u(k);
        y_3 = y_2;
        y_2 = y_1;
        y_1 = y(k);
        x(1) = error(k);                % Calculating P
        x2_1 = x(2);
        x(2) = (error(k)-error_1)/ts;   % Calculating D
        x(3) = x(3)+error(k)*ts;        % Calculating I
        error_1 = error(k);
    end
    err = mean(abs(error));
end