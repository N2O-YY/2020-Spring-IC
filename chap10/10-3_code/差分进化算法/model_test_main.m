clear all;
close all;

n = 8;           % ��λ�Ĵ����ĸ���
A = 4;           % M���е������ֵ��1->A,0->+A
ts = 0.10;       % ʱ�����ڣ�������ʱ�䣩
N = 1000;        % ����ĸ���
%Generate M-sequence
ut = genPRBS(n,A,N);
G = tf([2],[20 21 1],'inputdelay',0.8);
t = 0:ts:N*ts-ts;
y = lsim(G, ut, t);  %lsim������ģ�����

figure(1);
stairs(t,ut,'r');
figure(2);
plot(t,y,'r');
save de2_file t N ut y;