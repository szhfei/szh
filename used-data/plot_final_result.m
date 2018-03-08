%%
%画测试数据结果图
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


lag=100;%时间延迟
surf_folder = '10s直线传递函数\';
alpha=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
Alpha=ifft(alpha);

load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
alpha_test = fft(Alpha_test);
lA = length(Alpha_test);
nA = 0:lA-1;
nA = nA';
tA = nA / sf;
fA = nA * sf / lA;

cut = 2000;
aaa = fftshift(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
fcut = [0:cut-1]'/cut*200;

figure(100)
subplot(2,2,1),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('假定值','估计值'),set(gca,'ytick',[1:0.5:2.5]),ylim([1 2.5])


lag=200;%时间延迟
surf_folder = '15s梯形传递函数\';
alpha=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
Alpha=ifft(alpha);

load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
alpha_test = fft(Alpha_test);
lA = length(Alpha_test);
nA = 0:lA-1;
nA = nA';
tA = nA / sf;
fA = nA * sf / lA;

cut = 2000;
aaa = fftshift(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
fcut = [0:cut-1]'/cut*200;

figure(100)
subplot(2,2,2),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('假定值','估计值')%,title('场地传递函数假定值与估计值对比')


lag=400;%时间延迟
surf_folder = '10s0-100Hz单峰传递函数\';
alpha=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
Alpha=ifft(alpha);

load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
alpha_test = fft(Alpha_test);
lA = length(Alpha_test);
nA = 0:lA-1;
nA = nA';
tA = nA / sf;
fA = nA * sf / lA;

cut = 2000;
aaa = fftshift(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
fcut = [0:cut-1]'/cut*200;

figure(100)
subplot(2,2,3),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('假定值','估计值')%,title('场地传递函数假定值与估计值对比')


lag=700;%时间延迟
surf_folder = '10s0-15Hz双峰传递函数\';
alpha=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
Alpha=ifft(alpha);

load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
alpha_test = fft(Alpha_test);
lA = length(Alpha_test);
nA = 0:lA-1;
nA = nA';
tA = nA / sf;
fA = nA * sf / lA;

cut = 2000;
aaa = fftshift(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
fcut = [0:cut-1]'/cut*200;

figure(100)
subplot(2,2,4),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('假定值','估计值'),set(gca,'ytick',[0:0.5:2]),ylim([0 2])


load('F:\A07\alpha_co4_min.mat');
fl = [0:length(alpha_co4_min)-1]'/length(alpha_co4_min) *80;
figure(200)
subplot(1,2,1),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 20]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('假定值','本文方法结果'),set(gca,'ytick',[0:0.5:2]),ylim([0 2])
subplot(1,2,2),plot(fA,abs(alpha_test),fl,abs(alpha_co4_min),'linewidth',1.3),xlim([0.1 20]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('假定值','王博程序结果'),set(gca,'ytick',[0:0.5:2]),ylim([0 2])



%%
%画误差图
clear all

surf_folder = '10s直线传递函数\';
% surf_folder = '10s0-50Hz双峰传递函数\';
lag=100;%时间延迟
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



% alpha=get_error(lag,surf_folder,day,t1,t2,20,20,'ch1',400);
% Alpha=ifft(alpha);
% cut = 2000;
% aaa = fftshift(Alpha);
% l = length(Alpha);
% Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
% alpha_cut = fft(Alpha_cut);
% error_20 = abs(abs(alpha_cut) - 2);
% 
% alpha=get_error(lag,surf_folder,day,t1,t2,50,50,'ch1',400);
% Alpha=ifft(alpha);
% cut = 2000;
% aaa = fftshift(Alpha);
% l = length(Alpha);
% Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
% alpha_cut = fft(Alpha_cut);
% error_50 = abs(abs(alpha_cut) - 2);
% 
% alpha=get_error(lag,surf_folder,day,t1,t2,100,100,'ch1',400);
% Alpha=ifft(alpha);
% cut = 2000;
% aaa = fftshift(Alpha);
% l = length(Alpha);
% Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
% alpha_cut = fft(Alpha_cut);
% error_100 = abs(abs(alpha_cut) - 2);
% 
% figure(101)
% subplot(1,2,1),plot(fA,error_20,fA,error_50,fA,error_100,'linewidth',1.3),xlim([0 100]),xlabel('频率 f/Hz','fontsize',22),ylabel('幅值误差','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('20s','50s','100s')%,title('相同叠加次数下时窗长度对误差的影响')


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

alpha=get_error(lag,surf_folder,day,t1,t2,20,20,'ch1',400);
Alpha=ifft(alpha);
cut = 2000;
aaa = fftshift(Alpha);
l = length(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
error_c = abs(abs(alpha_cut) - abs(alpha_test));

alpha=get_error(lag,surf_folder,day,t1,t2,20,20,'ch1',200);
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

figure(101)
subplot(2,2,1),plot(fA,error_a,'linewidth',1.3),xlim([0.1 50]),xlabel('频率 f/Hz','fontsize',22),ylabel('振幅误差','fontsize',22)...
    ,set(gca,'fontsize',22),legend('50次'),set(gca,'xtick',[.1 10 20 30 40 50]),ylim([0 .6])
subplot(2,2,2),plot(fA,error_b,'linewidth',1.3),xlim([0.1 50]),xlabel('频率 f/Hz','fontsize',22),ylabel('振幅误差','fontsize',22)...
    ,set(gca,'fontsize',22),legend('100次'),set(gca,'xtick',[.1 10 20 30 40 50])
subplot(2,2,3),plot(fA,error_c,'linewidth',1.3),xlim([0.1 50]),xlabel('频率 f/Hz','fontsize',22),ylabel('振幅误差','fontsize',22)...
    ,set(gca,'fontsize',22),legend('400次'),set(gca,'xtick',[.1 10 20 30 40 50])
subplot(2,2,4),plot(fA,error_e,'linewidth',1.3),xlim([0.1 50]),xlabel('频率 f/Hz','fontsize',22),ylabel('振幅误差','fontsize',22)...
    ,set(gca,'fontsize',22),legend('1000次'),set(gca,'xtick',[.1 10 20 30 40 50])


x = [50;100;200;400;1000];
y = [max(error_a(1:end/4));max(error_b(1:end/4));max(error_d(1:end/4));max(error_c(1:end/4));max(error_e(1:end/4))];
figure(102)
plot(x,y,'p-','linewidth',1.3),xlabel('叠加次数','fontsize',22),ylabel('最大振幅误差','fontsize',22)...
    ,set(gca,'fontsize',22),xlim([0 1000]),title('最大振幅误差随叠加次数的变化')%,set(gca,'xtick',[50 100 200 400])



%%
%画测试数据结果图
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


lag=200;%时间延迟
surf_folder = '15s梯形传递函数0-50Hz\';
alpha=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
Alpha=ifft(alpha);

load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
alpha_test = fft(Alpha_test);
lA = length(Alpha_test);
nA = 0:lA-1;
nA = nA';
tA = nA / sf;
fA = nA * sf / lA;

cut = 2000;
aaa = fftshift(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
fcut = [0:cut-1]'/cut*200;

figure(100)
subplot(1,2,1),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 50]),set(gca,'xtick',[.1 10 20 30 40 50]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('设定值','估计值')%,title('场地传递函数假定值与估计值对比')

% load('F:\A02\alpha_co4_min.mat');
% df=0.2;f3=[1:df:80];
% figure(200)
% subplot(1,2,1),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),f3,abs(alpha_co4_min),'linewidth',1.3),xlim([0.1 50]),set(gca,'xtick',[.1 10 20 30 40 50]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('设定值','估计值','王博程序结果')



lag=400;%时间延迟
surf_folder = '10s0-50Hz双峰传递函数\';
alpha=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
Alpha=ifft(alpha);

load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
alpha_test = fft(Alpha_test);
lA = length(Alpha_test);
nA = 0:lA-1;
nA = nA';
tA = nA / sf;
fA = nA * sf / lA;

cut = 2000;
aaa = fftshift(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
fcut = [0:cut-1]'/cut*200;

figure(100)
subplot(1,2,2),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 50]),set(gca,'xtick',[.1 10 20 30 40 50]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('设定值','估计值')%,title('场地传递函数假定值与估计值对比')


% load('F:\A01\alpha_co4_min.mat');
% df=0.2;f3=[1:df:80];
% figure(200)
% subplot(1,2,2),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),f3,abs(alpha_co4_min),'linewidth',1.3),xlim([0.1 50]),set(gca,'xtick',[.1 10 20 30 40 50]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('设定值','估计值','王博程序结果')


%%
%迭代后传递函数画图
clear all

f = [0:7998]'/7999*200;

figure(20)

load(['D:\szh\test\used-data\test\result\2#10-04-07-19\ch1.mat'],'alpha_initial','alpha_final');
subplot(2,3,1),plot(f,abs(alpha_final),'linewidth',1.4),xlim([0.1 25]),set(gca,'fontsize',18),set(gca,'xtick',[0.1 5 10 15 20 25])...
        ,legend('最终传递函数'),set(legend,'fontsize',8),ylabel('幅值','fontsize',18),xlabel('频率 f/Hz','fontsize',18),title('2# NS')
load(['D:\szh\test\used-data\test\result\2#10-04-07-19\ch2.mat'],'alpha_initial','alpha_final');
subplot(2,3,2),plot(f,abs(alpha_final),'linewidth',1.4),xlim([0.1 25]),set(gca,'fontsize',18),set(gca,'xtick',[0.1 5 10 15 20 25])...
        ,legend('最终传递函数'),set(legend,'fontsize',8),ylabel('幅值','fontsize',18),xlabel('频率 f/Hz','fontsize',18),title('2# EW')
load(['D:\szh\test\used-data\test\result\2#10-04-07-19\ch3.mat'],'alpha_initial','alpha_final');
subplot(2,3,3),plot(f,abs(alpha_final),'linewidth',1.4),xlim([0.1 25]),set(gca,'fontsize',18),set(gca,'xtick',[0.1 5 10 15 20 25])...
        ,legend('最终传递函数'),set(legend,'fontsize',8),ylabel('幅值','fontsize',18),xlabel('频率 f/Hz','fontsize',18),title('2# UD')
load(['D:\szh\test\used-data\test\result\3#10-04-07-19\ch1.mat'],'alpha_initial','alpha_final');
subplot(2,3,4),plot(f,abs(alpha_final),'linewidth',1.4),xlim([0.1 25]),set(gca,'fontsize',18),set(gca,'xtick',[0.1 5 10 15 20 25])...
        ,legend('最终传递函数'),set(legend,'fontsize',8),ylabel('幅值','fontsize',18),xlabel('频率 f/Hz','fontsize',18),title('3# NS')
load(['D:\szh\test\used-data\test\result\3#10-04-07-19\ch2.mat'],'alpha_initial','alpha_final');
subplot(2,3,5),plot(f,abs(alpha_final),'linewidth',1.4),xlim([0.1 25]),set(gca,'fontsize',18),set(gca,'xtick',[0.1 5 10 15 20 25])...
        ,legend('最终传递函数'),set(legend,'fontsize',8),ylabel('幅值','fontsize',18),xlabel('频率 f/Hz','fontsize',18),title('3# EW')
load(['D:\szh\test\used-data\test\result\3#10-04-07-19\ch3.mat'],'alpha_initial','alpha_final');
subplot(2,3,6),plot(f,abs(alpha_final),'linewidth',1.4),xlim([0.1 25]),set(gca,'fontsize',18),set(gca,'xtick',[0.1 5 10 15 20 25])...
        ,legend('最终传递函数'),set(legend,'fontsize',8),ylabel('幅值','fontsize',18),xlabel('频率 f/Hz','fontsize',18),title('3# UD')        