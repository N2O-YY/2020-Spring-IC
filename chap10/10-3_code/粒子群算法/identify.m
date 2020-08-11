clear all;
close all;
load pso2_file;

%�޶�λ�ú��ٶȵķ�Χ
MinX = [0 0 0 0];           %����������Χ
MaxX = [30 30 30 1];
Vmax = 1;
Vmin = -1;                  % �޶��ٶȵķ�Χ 

%�������Ⱥ����
Size = 80;   %��Ⱥ��ģ
CodeL = 4;   %��������

c1 = 1.3;
c2 = 1.7;                   % ѧϰ���ӣ�[1,2]
wmax = 0.90;
wmin = 0.10;                % ����Ȩ����Сֵ:(0,1)
G = 200;                    % ����������
%(1)��ʼ����Ⱥ�ĸ���
for i = 1:G                 %����ʱ��Ȩ��
    w(i) = wmax-((wmax-wmin)/G)*i;  
end  
for i = 1:1:CodeL           %ʮ���Ƹ����Ʊ���
    X(:,i) = MinX(i)+(MaxX(i)-MinX(i))*rand(Size,1); 
    v(:,i) = Vmin+(Vmax-Vmin)*rand(Size,1);%�����ʼ���ٶ�
end
%��2����ʼ���������ź�ȫ�����ţ��ȼ���������ӵ�Ŀ�꺯��������ʼJi��BestS
for i = 1:Size
    Ji(i) = obj(X(i,:),t,N,ut,y);
    Xl(i,:) = X(i,:);       %Xl���ھֲ��Ż�
end

BestS = X(1,:);             %ȫ�����Ÿ����ʼ��
for i = 2:Size
    if obj(X(i,:),t,N,ut,y)<obj(BestS,t,N,ut,y)
        BestS = X(i,:);
    end
end
%��3��������Ҫѭ����ֱ�����㾫��Ҫ��
 for kg = 1:1:G
     times(kg) = kg;
    for i = 1:Size
       v(i,:) = w(kg)*v(i,:)+c1*rand*(Xl(i,:)-X(i,:))+c2*rand*(BestS-X(i,:));%��Ȩ��ʵ���ٶȵĸ���
          for j = 1:CodeL       %����ٶ��Ƿ�Խ��
            if v(i,j)<Vmin
                v(i,j) = Vmin;
            elseif  v(i,j)>Vmax
                v(i,j) = Vmax;
            end
          end
        X(i,:) = X(i,:)+v(i,:); %ʵ��λ�õĸ���
        for j = 1:CodeL         %���λ���Ƿ�Խ��
            if X(i,j)<MinX(j)
                X(i,j) = MinX(j);
            elseif X(i,j)>MaxX(j)
                X(i,j) = MaxX(j);
            end
        end         
%����Ӧ����,��������ֲ�����
       if rand>0.8
            k = ceil(4*rand);   %ceilΪ����ȡ��
            X(i,k) = 30*rand; 
            if k ==4
                X(i,k) = rand; 
            end            
       end
%��4���жϺ͸���       
       if obj(X(i,:),t,N,ut,y)<Ji(i) %�ֲ��Ż����жϵ���ʱ��λ���Ƿ�Ϊ���ŵ����
          Ji(i) = obj(X(i,:),t,N,ut,y);
          Xl(i,:) = X(i,:);
       end
        
        if Ji(i)<obj(BestS,t,N,ut,y)  %ȫ���Ż�
          BestS = Xl(i,:);
        end
    end
Best_J(kg) = obj(BestS,t,N,ut,y);
end
display('true value: K = 2;T1 = 1;T2 = 20;T = 0.8');

BestS           %��Ѹ���
Best_J(kg)      %���Ŀ�꺯��ֵ
figure(1);      %Ŀ�꺯��ֵ�仯����
plot(times,Best_J(times),'r','linewidth',2);
xlabel('Times');ylabel('Best J');