clear all;
close all;
load de2_file;

%�޶�λ�ú��ٶȵķ�Χ
MinX = [0 0 0 0];       %����������Χ
MaxX = [10 10 30 3];

%�������Ⱥ����
Size = 30;              %��Ⱥ��ģ
CodeL = 4;              %��������

F = 0.95;               % �������ӣ�[1,2]
cr = 0.6;               % ��������
G = 100;                % ���������� 
%��ʼ����Ⱥ�ĸ���
for i=1:1:CodeL       
    X(:,i) = MinX(i)+(MaxX(i)-MinX(i))*rand(Size,1);
end
BestS = X(1,:);         %ȫ�����Ÿ���
for i=2:Size
    if obj(X(i,:),t,N,ut,y)<obj(BestS,t,N,ut,y)
        BestS = X(i,:);
    end
end
Ji = obj(BestS,t,N,ut,y);
%������Ҫѭ����ֱ�����㾫��Ҫ��
for kg=1:1:G
     time(kg) = kg;
%����
    for i=1:Size
        r1 = 1;
        r2 = 1;
        r3 = 1;
        r4 = 1;
        while r1==r2 || r1==r3 || r2==r3 || r1==i || r2==i || r3==i || r4==i || r1==r4 || r2==r4 || r3==r4
            r1 = ceil(Size * rand(1));
            r2 = ceil(Size * rand(1));
            r3 = ceil(Size * rand(1));
            r4 = ceil(Size * rand(1));
        end
        h(i,:) = BestS+F*(X(r2,:)-X(r3,:));
        %h(i,:) = X(r1,:)+F*(X(r2,:)-X(r3,:));

       for j=1:CodeL  %���ֵ�Ƿ�Խ��
            if h(i,j)<MinX(j)
                h(i,j) = MinX(j);
            elseif h(i,j)>MaxX(j)
                h(i,j) = MaxX(j);
            end
        end            
%����
        for j = 1:1:CodeL
              tempr = rand(1);
              if tempr<cr
                  v(i,j) = h(i,j);
               else
                  v(i,j) = X(i,j);
               end
        end
%ѡ��        
        if obj(v(i,:),t,N,ut,y)<obj(X(i,:),t,N,ut,y)
            X(i,:) = v(i,:);
        end 
%�жϺ͸���
       if obj(X(i,:),t,N,ut,y)<Ji %�жϵ���ʱ��ָ���Ƿ�Ϊ���ŵ����
          Ji = obj(X(i,:),t,N,ut,y);
          BestS = X(i,:);
        end
    end
    Best_J(kg) = obj(BestS,t,N,ut,y);
end
display('true value: K=2;T1=1;T2=20;T=0.8');

BestS    %��Ѹ���
Best_J(kg)%���Ŀ�꺯��ֵ
figure(1);%ָ�꺯��ֵ�仯����
plot(time,Best_J(time),'r','linewidth',2);
xlabel('Time');ylabel('Best J');