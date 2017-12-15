%%
% %���������ݽ��ͼ
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
% lag=100;%ʱ���ӳ�
% surf_folder = '10sֱ�ߴ��ݺ���\';
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
% subplot(2,2,1),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 100]),xlabel('f/Hz','fontsize',22),ylabel('���ش��ݺ�����ֵ','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('��ʵֵ','����ֵ'),set(gca,'ytick',[1:0.5:2.5]),ylim([1 2.5])
% 
% 
% lag=200;%ʱ���ӳ�
% surf_folder = '15s���δ��ݺ���\';
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
% subplot(2,2,2),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 100]),xlabel('f/Hz','fontsize',22),ylabel('���ش��ݺ�����ֵ','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('��ʵֵ','����ֵ')%,title('���ش��ݺ�����ʵֵ�����ֵ�Ա�')
% 
% 
% lag=400;%ʱ���ӳ�
% surf_folder = '10s0-100Hz���崫�ݺ���\';
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
% subplot(2,2,3),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 100]),xlabel('f/Hz','fontsize',22),ylabel('���ش��ݺ�����ֵ','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('��ʵֵ','����ֵ')%,title('���ش��ݺ�����ʵֵ�����ֵ�Ա�')
% 
% 
% lag=700;%ʱ���ӳ�
% surf_folder = '10s0-15Hz˫�崫�ݺ���\';
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
% subplot(2,2,4),plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0.1 100]),xlabel('f/Hz','fontsize',22),ylabel('���ش��ݺ�����ֵ','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('��ʵֵ','����ֵ'),set(gca,'ytick',[0:0.5:2]),ylim([0 2])



%%
%�����ͼ
clear all

surf_folder = '10sֱ�ߴ��ݺ���\';
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
subplot(1,2,1),plot(fA,error_20,fA,error_50,fA,error_100,'linewidth',1.3),xlim([0 100]),xlabel('Ƶ�� f/Hz','fontsize',22),ylabel('��ֵ���','fontsize',22)...
    ,set(gca,'fontsize',22),legend('20s','50s','100s')%,title('��ͬ���Ӵ�����ʱ�����ȶ�����Ӱ��')


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
subplot(1,2,2),plot(fA,error_a,fA,error_b,fA,error_c,'linewidth',1.3),xlim([0 100]),xlabel('Ƶ�� f/Hz','fontsize',22),ylabel('��ֵ���','fontsize',22)...
    ,set(gca,'fontsize',22),legend('50��','100��','400��'),ylim([0 0.5])%,title('��ͬ���Ӵ�����ʱ�����ȶ�����Ӱ��')