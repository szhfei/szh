%%
% %wangbo's results
% clear all
% 
% folder = '10s˫�崫�ݺ��� ����λ2\';
% load(['D:\szh\test\used-data\test\',folder,'Alpha_test.mat']);
% load(['D:\szh\test\used-data\test\',folder,'alpha_wangbo.mat']);
% load(['D:\szh\test\used-data\test\',folder,'alpha_co4_min.mat']);
% 
% f_test = [0:length(Alpha_test)-1]'/length(Alpha_test)*200;
% f_wangbo = [0.2:0.2:80]';
% f_co4 = [1:.2:80];
% 
% figure(100)
% subplot(1,2,1),plot(f_test,abs(fft(Alpha_test)),f_wangbo,abs(alpha_wangbo),f_co4,abs(alpha_co4_min),'linewidth',1.3),xlim([0.1 50])...
%     ,set(gca,'xtick',[.1 10 20 30 40 50]),xlabel('f/Hz','fontsize',22),ylabel('���ش��ݺ�����ֵ','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('H(f)���趨ֵ','��ʱ�̱Ƚ��','����ԭʼ������')
% 
% folder = '10s���δ��ݺ��� ����λ1\';
% load(['D:\szh\test\used-data\test\',folder,'Alpha_test.mat']);
% load(['D:\szh\test\used-data\test\',folder,'alpha_wangbo.mat']);
% load(['D:\szh\test\used-data\test\',folder,'alpha_co4_min.mat']);
% 
% figure(100)
% subplot(1,2,2),plot(f_test,abs(fft(Alpha_test)),f_wangbo,abs(alpha_wangbo),f_co4,abs(alpha_co4_min),'linewidth',1.3),xlim([0.1 50])...
%     ,set(gca,'xtick',[.1 10 20 30 40 50]),xlabel('f/Hz','fontsize',22),ylabel('���ش��ݺ�����ֵ','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('H(f)���趨ֵ','��ʱ�̱Ƚ��','����ԭʼ������'),ylim([0 3])


%%
%���������ݽ��ͼ
clear all

sf=200;
lu=20;
ls=20;
day = 4;
t1 = 6*7+1+144*(4-1);
t2 = 6*19+0+144*(4-1);

l = (lu+ls)*sf-1;
n=0:l-1;
n=n';
t=n/sf;
f=n*sf/l;

% %˫�崫�ݺ���
% lag=200;%ʱ���ӳ�
% surf_folder = '10s˫�崫�ݺ��� ����λ1\';
% alpha=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
% Alpha=ifft(alpha);
% 
% load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
% alpha_test = fft(Alpha_test);
% lA = length(Alpha_test);
% nA = 0:lA-1;
% nA = nA';
% tA = nA / sf;
% fA = nA * sf / lA;
% 
% cut = lA;
% aaa = fftshift(Alpha);
% Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
% alpha_cut = fft(Alpha_cut);
% fcut = [0:cut-1]'/cut*200;
% 
% t = [1:lA]'/sf;
% 
% figure(101)
% subplot(2,3,1),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 50]),set(gca,'xtick',[.1 10 20 30 40 50])...
%     ,ylabel('��ֵ','fontsize',15),set(gca,'fontsize',15),legend('H(f)�趨ֵ','���ķ�������ֵ'),title('���ݺ��������')
% subplot(2,3,2),plot(fA,angle(alpha_test),fcut,angle(alpha_cut),'linewidth',1.3),xlim([0.1 50]),set(gca,'xtick',[.1 10 20 30 40 50])...
%     ,ylabel('��λ/rad','fontsize',15),set(gca,'fontsize',15),legend('H(f)�趨ֵ','���ķ�������ֵ'),ylim([-5 5]),title('���ݺ�����λ��')
% subplot(2,3,3),plot(t,Alpha_test,t,Alpha_cut,'linewidth',1.3),xlim([0 2]),ylabel('���ٶ�/(m/s^2)','fontsize',15)...
%     ,set(gca,'fontsize',15),legend('H(f)�趨ֵ','���ķ�������ֵ'),ylim([-.3 .3]),title('��Ӧ��ʱ��������Ӧ����')
% 
% 
% lag=200;%ʱ���ӳ�
% surf_folder = '10s˫�崫�ݺ��� ����λ2\';
% alpha=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
% Alpha=ifft(alpha);
% 
% load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
% alpha_test = fft(Alpha_test);
% lA = length(Alpha_test);
% nA = 0:lA-1;
% nA = nA';
% tA = nA / sf;
% fA = nA * sf / lA;
% 
% cut = lA;
% aaa = fftshift(Alpha);
% Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
% alpha_cut = fft(Alpha_cut);
% fcut = [0:cut-1]'/cut*200;
% 
% t = [1:lA]'/sf;
% 
% figure(101)
% subplot(2,3,4),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 50]),set(gca,'xtick',[.1 10 20 30 40 50])...
%     ,xlabel('f/Hz','fontsize',15),ylabel('��ֵ','fontsize',15),set(gca,'fontsize',15),legend('H(f)�趨ֵ','���ķ�������ֵ')
% subplot(2,3,5),plot(fA,angle(alpha_test),fcut,angle(alpha_cut),'linewidth',1.3),xlim([0.1 50]),set(gca,'xtick',[.1 10 20 30 40 50])...
%     ,xlabel('f/Hz','fontsize',15),ylabel('��λ/rad','fontsize',15),set(gca,'fontsize',15),legend('H(f)�趨ֵ','���ķ�������ֵ'),ylim([-5 5])
% subplot(2,3,6),plot(t,Alpha_test,t,Alpha_cut,'linewidth',1.3),xlim([0 2]),xlabel('t/s','fontsize',15),ylabel('���ٶ�/(m/s^2)','fontsize',15)...
%     ,set(gca,'fontsize',15),legend('H(f)�趨ֵ','���ķ�������ֵ'),ylim([-.3 .3])

%���δ��ݺ���
lag=100;%ʱ���ӳ�
surf_folder = '10s���δ��ݺ��� ����λ1\';
alpha=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
Alpha=ifft(alpha);

load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
alpha_test = fft(Alpha_test);
lA = length(Alpha_test);
nA = 0:lA-1;
nA = nA';
tA = nA / sf;
fA = nA * sf / lA;

cut = lA;
Alpha_cut = zeros(lA,1);
Alpha_cut(1:lag)=Alpha(end-lag+1:end);
Alpha_cut(lag+1:end)=Alpha(1:lA-lag);
alpha_cut = fft(Alpha_cut);
fcut = [0:cut-1]'/cut*200;

t = [1:lA]'/sf;

figure(102)
subplot(2,3,1),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 50]),set(gca,'xtick',[.1 10 20 30 40 50])...
    ,ylabel('��ֵ','fontsize',15),set(gca,'fontsize',15),legend('H(f)�趨ֵ','���ķ�������ֵ'),title('���ݺ��������')
subplot(2,3,2),plot(fA,angle(alpha_test),fcut,angle(alpha_cut),'linewidth',1.3),xlim([0.1 50]),set(gca,'xtick',[.1 10 20 30 40 50])...
    ,ylabel('��λ/rad','fontsize',15),set(gca,'fontsize',15),legend('H(f)�趨ֵ','���ķ�������ֵ'),ylim([-5 5]),title('���ݺ�����λ��')
subplot(2,3,3),plot(t,Alpha_test,t,Alpha_cut,'linewidth',1.3),xlim([0 1]),ylabel('���ٶ�/(m/s^2)','fontsize',15)...
    ,set(gca,'fontsize',15),legend('H(f)�趨ֵ','���ķ�������ֵ'),ylim([-.7 .5]),title('��Ӧ��ʱ��������Ӧ����')


lag=100;%ʱ���ӳ�
surf_folder = '10s���δ��ݺ��� ����λ2\';
alpha=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
Alpha=ifft(alpha);

load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
alpha_test = fft(Alpha_test);
lA = length(Alpha_test);
nA = 0:lA-1;
nA = nA';
tA = nA / sf;
fA = nA * sf / lA;

cut = lA;
aaa = fftshift(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
fcut = [0:cut-1]'/cut*200;

t = [1:lA]'/sf;

figure(102)
subplot(2,3,4),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 50]),set(gca,'xtick',[.1 10 20 30 40 50])...
    ,xlabel('f/Hz','fontsize',15),ylabel('��ֵ','fontsize',15),set(gca,'fontsize',15),legend('H(f)�趨ֵ','���ķ�������ֵ')
subplot(2,3,5),plot(fA,angle(alpha_test),fcut,angle(alpha_cut),'linewidth',1.3),xlim([0.1 50]),set(gca,'xtick',[.1 10 20 30 40 50])...
    ,xlabel('f/Hz','fontsize',15),ylabel('��λ/rad','fontsize',15),set(gca,'fontsize',15),legend('H(f)�趨ֵ','���ķ�������ֵ'),ylim([-5 5])
subplot(2,3,6),plot(t,Alpha_test,t,Alpha_cut,'linewidth',1.3),xlim([0 1]),xlabel('t/s','fontsize',15),ylabel('���ٶ�/(m/s^2)','fontsize',15)...
    ,set(gca,'fontsize',15),legend('H(f)�趨ֵ','���ķ�������ֵ'),ylim([-.3 .8])



%%
%�����ͼ
clear all

surf_folder = '10sֱ�ߴ��ݺ���\';
% surf_folder = '10s0-50Hz˫�崫�ݺ���\';
lag=100;%ʱ���ӳ�
sf=200;
day = 4;
t1 = 6*7+1+144*(4-1);
t2 = 6*19+0+144*(4-1);

% l = (lu+ls)*sf-1;
% n=0:l-1;
% n=n';
% t=n/sf;
% f=n*sf/l;

load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
alpha_test = fft(Alpha_test);
lA = length(Alpha_test);
nA = 0:lA-1;
nA = nA';
tA = nA / sf;
fA = nA * sf / lA;


alpha=get_error(lag,surf_folder,day,t1,t2,20,20,'ch1',50);
Alpha=ifft(alpha);
cut = 2000;
aaa = fftshift(Alpha);
l = length(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
error_a = abs(abs(alpha_cut) - abs(alpha_test));

alpha=get_error(lag,surf_folder,day,t1,t2,20,20,'ch1',100);
Alpha=ifft(alpha);
cut = 2000;
aaa = fftshift(Alpha);
l = length(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
error_b = abs(abs(alpha_cut) - abs(alpha_test));

alpha=get_error(lag,surf_folder,day,t1,t2,20,20,'ch1',200);
Alpha=ifft(alpha);
cut = 2000;
aaa = fftshift(Alpha);
l = length(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
error_c = abs(abs(alpha_cut) - abs(alpha_test));

alpha=get_error(lag,surf_folder,day,t1,t2,20,20,'ch1',400);
Alpha=ifft(alpha);
cut = 2000;
aaa = fftshift(Alpha);
l = length(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
error_d = abs(abs(alpha_cut) - abs(alpha_test));

alpha=get_error(lag,surf_folder,day,t1,t2,20,20,'ch1',1000);
Alpha=ifft(alpha);
cut = 2000;
aaa = fftshift(Alpha);
l = length(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
error_e = abs(abs(alpha_cut) - abs(alpha_test));

% figure(101)
% subplot(2,2,1),plot(fA,error_a,'linewidth',1.3),xlim([0.1 50]),ylabel('������','fontsize',15)...
%     ,set(gca,'fontsize',15),legend('N=50'),set(gca,'xtick',[.1 10 20 30 40 50]),ylim([0 .6])
% subplot(2,2,2),plot(fA,error_b,'linewidth',1.3),xlim([0.1 50])...
%     ,set(gca,'fontsize',15),legend('N=100'),set(gca,'xtick',[.1 10 20 30 40 50])
% subplot(2,2,3),plot(fA,error_d,'linewidth',1.3),xlim([0.1 50]),xlabel('Ƶ�� f/Hz','fontsize',15),ylabel('������','fontsize',15)...
%     ,set(gca,'fontsize',15),legend('N=400'),set(gca,'xtick',[.1 10 20 30 40 50])
% subplot(2,2,4),plot(fA,error_e,'linewidth',1.3),xlim([0.1 50]),xlabel('Ƶ�� f/Hz','fontsize',15)...
%     ,set(gca,'fontsize',15),legend('N=1000'),set(gca,'xtick',[.1 10 20 30 40 50])
figure(101)
subplot(2,2,1),plot(fA,error_a,'linewidth',1.3),xlim([0.1 50]),ylabel('������','fontsize',15)...
    ,set(gca,'fontsize',15),set(gca,'xtick',[.1 10 20 30 40 50]),ylim([0 .6]),title('N=50')
subplot(2,2,2),plot(fA,error_b,'linewidth',1.3),xlim([0.1 50])...
    ,set(gca,'fontsize',15),set(gca,'xtick',[.1 10 20 30 40 50]),title('N=100')
subplot(2,2,3),plot(fA,error_d,'linewidth',1.3),xlim([0.1 50]),xlabel('Ƶ�� f/Hz','fontsize',15),ylabel('������','fontsize',15)...
    ,set(gca,'fontsize',15),set(gca,'xtick',[.1 10 20 30 40 50]),title('N=400')
subplot(2,2,4),plot(fA,error_e,'linewidth',1.3),xlim([0.1 50]),xlabel('Ƶ�� f/Hz','fontsize',15)...
    ,set(gca,'fontsize',15),set(gca,'xtick',[.1 10 20 30 40 50]),title('N=1000')


x = [50;100;200;400;1000];
y = [max(error_a(1:end/4));max(error_b(1:end/4));max(error_c(1:end/4));max(error_d(1:end/4));max(error_e(1:end/4))];
figure(102)
plot(x,y,'p-','linewidth',1.3,'markersize',12),xlabel('���Ӵ���','fontsize',22),ylabel('���������','fontsize',22)...
    ,set(gca,'fontsize',22),xlim([0 1000]),title('�������������Ӵ����ı仯')%,set(gca,'xtick',[50 100 200 400])