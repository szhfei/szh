%%
% %画测试数据结果图
% clear all
% 
% sf=200;
% lu=20;
% ls=20;
% day = 4;
% t1 = 6*7+1+144*(4-1);
% t2 = 6*19+0+144*(4-1);
% 
% l = (lu+ls)*sf-1;
% n=0:l-1;
% n=n';
% t=n/sf;
% f=n*sf/l;
% 
% 
% lag=100;%时间延迟
% surf_folder = '10s直线传递函数\';
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
% cut = 2000;
% aaa = fftshift(Alpha);
% Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
% alpha_cut = fft(Alpha_cut);
% fcut = [0:cut-1]'/cut*200;
% 
% figure(100)
% subplot(2,2,1),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('真实值','估计值'),set(gca,'ytick',[1:0.5:2.5]),ylim([1 2.5])
% 
% 
% lag=200;%时间延迟
% surf_folder = '15s梯形传递函数\';
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
% cut = 2000;
% aaa = fftshift(Alpha);
% Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
% alpha_cut = fft(Alpha_cut);
% fcut = [0:cut-1]'/cut*200;
% 
% figure(100)
% subplot(2,2,2),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('真实值','估计值')%,title('场地传递函数真实值与估计值对比')
% 
% 
% lag=400;%时间延迟
% surf_folder = '10s0-100Hz单峰传递函数\';
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
% cut = 2000;
% aaa = fftshift(Alpha);
% Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
% alpha_cut = fft(Alpha_cut);
% fcut = [0:cut-1]'/cut*200;
% 
% figure(100)
% subplot(2,2,3),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('真实值','估计值')%,title('场地传递函数真实值与估计值对比')
% 
% 
% lag=700;%时间延迟
% surf_folder = '10s0-15Hz双峰传递函数\';
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
% cut = 2000;
% aaa = fftshift(Alpha);
% Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
% alpha_cut = fft(Alpha_cut);
% fcut = [0:cut-1]'/cut*200;
% 
% figure(100)
% subplot(2,2,4),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('真实值','估计值'),set(gca,'ytick',[0:0.5:2]),ylim([0 2])



%%
%画误差图
clear all

surf_folder = '10s直线传递函数\';
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



alpha=get_error(lag,surf_folder,day,t1,t2,20,20,'ch1',400);
Alpha=ifft(alpha);
cut = 2000;
aaa = fftshift(Alpha);
l = length(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
error_20 = abs(abs(alpha_cut) - 2);

alpha=get_error(lag,surf_folder,day,t1,t2,50,50,'ch1',400);
Alpha=ifft(alpha);
cut = 2000;
aaa = fftshift(Alpha);
l = length(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
error_50 = abs(abs(alpha_cut) - 2);

alpha=get_error(lag,surf_folder,day,t1,t2,100,100,'ch1',400);
Alpha=ifft(alpha);
cut = 2000;
aaa = fftshift(Alpha);
l = length(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
error_100 = abs(abs(alpha_cut) - 2);

figure(101)
subplot(1,2,1),plot(fA,error_20,fA,error_50,fA,error_100,'linewidth',1.3),xlim([0 100]),xlabel('频率 f/Hz','fontsize',22),ylabel('幅值误差','fontsize',22)...
    ,set(gca,'fontsize',22),legend('20s','50s','100s')%,title('相同叠加次数下时窗长度对误差的影响')


alpha=get_error(lag,surf_folder,day,t1,t2,50,50,'ch1',50);
Alpha=ifft(alpha);
cut = 2000;
aaa = fftshift(Alpha);
l = length(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
error_a = abs(abs(alpha_cut) - 2);

alpha=get_error(lag,surf_folder,day,t1,t2,50,50,'ch1',100);
Alpha=ifft(alpha);
cut = 2000;
aaa = fftshift(Alpha);
l = length(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
error_b = abs(abs(alpha_cut) - 2);

alpha=get_error(lag,surf_folder,day,t1,t2,50,50,'ch1',400);
Alpha=ifft(alpha);
cut = 2000;
aaa = fftshift(Alpha);
l = length(Alpha);
Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
error_c = abs(abs(alpha_cut) - 2);

figure(101)
subplot(1,2,2),plot(fA,error_a,fA,error_b,fA,error_c,'linewidth',1.3),xlim([0 100]),xlabel('频率 f/Hz','fontsize',22),ylabel('幅值误差','fontsize',22)...
    ,set(gca,'fontsize',22),legend('50次','100次','400次'),ylim([0 0.5])%,title('相同叠加次数下时窗长度对误差的影响')