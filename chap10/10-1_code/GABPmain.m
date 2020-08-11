clc;
clear all;
close all;
%% ���������
% �������ݾ���ǰ�������������г�������
% ��ʼ��������Ԫ����
hiddennum = 6;
% �������������ֵ����Сֵ
threshold = [0.1;0.1];
inputnum = 2;                       % �������Ԫ����
outputnum = 1;                      % �������Ԫ����
w1num = 12;                         % ����㵽�������Ȩֵ����
w2num = 6;                          % �����㵽������Ȩֵ����
N = w1num + w2num + 1;              % ���Ż��ı���������Ȩֵ��ѧϰ���ʣ�

%% �����Ŵ��㷨����
NIND = 40;                      % ��Ⱥ��С
MAXGEN = 50;                    % ����Ŵ�����
PRECI = 10;                     % ���峤��
GGAP = 0.95;                    % ����
px = 0.7;                       % �������
pm = 0.01;                      % �������
trace = zeros(N+1,MAXGEN);      % Ѱ�Ž���ĳ�ʼֵ

FieldD = [repmat(PRECI,1,N);repmat([0;1],1,N);repmat([1;0;1;1],1,N)];  % ����������
Chrom = crtbp(NIND,PRECI*N);    % ����������ɢ�����Ⱥ
%% �Ż�
gen = 0;                        % ��������
X = bs2rv(Chrom,FieldD);        % �����ʼ��Ⱥ��ʮ����ת��
ObjV = Objfun(X);               % ����Ŀ�꺯��ֵ
while gen<MAXGEN
    fprintf('%d\n',gen);
    FitnV = ranking(ObjV);                      % ������Ӧ��ֵ
    SelCh = select('sus',Chrom,FitnV,GGAP);     % ѡ��
    SelCh = recombin('xovsp',SelCh,px);         % ����
    SelCh = recombin('xovsp',SelCh,px);         % ����
    X = bs2rv(SelCh,FieldD);                    % �Ӵ�����Ķ����Ƶ�ʮ����ת��
    ObjVSel = Objfun(X);                        % �����Ӵ���Ŀ�꺯��ֵ
    [Chrom,ObjV] = reins(Chrom,SelCh,1,1,ObjV,ObjVSel); % ���Ӵ��ز��븸�����õ�����Ⱥ
    X = bs2rv(Chrom,FieldD);
    gen = gen+1;                                % ������������
    %��ȡÿ�����Ž⼰����ţ�YΪ���Ž⣬IΪ��������
    [Y,I] = min(ObjV);
    trace(1:N,gen) = X(I,:);                    % ����ÿ��������ֵ
    trace(end,gen) = Y;                         % ����ÿ��������ֵ
end
%% ������ͼ
figure(1);
plot(1:MAXGEN,trace(end,:));
grid on
xlabel('�Ŵ�����');
ylabel('���ı仯');
title('��������');
bestX = trace(1:end-1,end);
bestErr = trace(end,end);
fprintf(['���ų�ʼȨֵ��ѧϰ�ʣ�\nX = ',num2str(bestX'),'\n��С���err = ',num2str(bestErr),'\n']);