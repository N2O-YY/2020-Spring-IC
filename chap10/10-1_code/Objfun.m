function Obj = Objfun(X)
%% �����ֱ������Ⱥ�и��������Ŀ��ֵ
%% ����
% X:���и���ĳ�ʼȨֵ����ֵ
%% ���
% Obj:���и���ÿ��ʱ�����ľ���ֵ��ƽ����
    [M,N] = size(X);
    Obj = zeros(M,1);
    for i=1:M
        Obj(i) = Bpfun(X(i,:));
    end
end