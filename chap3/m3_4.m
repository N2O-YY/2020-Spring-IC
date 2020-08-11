clc, clear;
%����������
A = [1,0.5];
B = [0.1,0.5,1];
C = [0.2,1];
%�ϳ�A��B
AB = zeros(size(A,2),size(B,2));
for i = 1:size(AB,1)
    for j = 1:size(AB,2)
        AB(i,j) = min(A(i),B(j));
    end
end
%��ABת��������
ABT1 = AB';
AB_T1 = ABT1(:);
%ȷ��ģ����ϵ����R
R = zeros(size(AB_T1,1),size(C,2));
for i = 1:size(R,1)
    for j = 1:size(R,2)
        R(i,j) = min(AB_T1(i),C(j));
    end
end

%����������
A1 = [0.8,0.1];
B1 = [0.5,0.2,0];
%�ϳ�A1��B1
A1B1 = zeros(size(A1,2),size(B1,2));
for i = 1:size(A1B1,1)
    for j = 1:size(A1B1,2)
        A1B1(i,j) = min(A1(i),B1(j));
    end
end
%��A1B1ת��������
A1B1_T2 = reshape(A1B1,1,size(A1B1,1)*size(A1B1,2));
%ȷ���������C1
tmp = zeros(size(R,2),size(R,1));
for i = 1:size(tmp,1)
    for j = 1:size(tmp,2)
        tmp(i,j) = min(A1B1_T2(j),R(j,i));
    end
end
C1 = (max(tmp,[],2))';
 