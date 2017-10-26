%生成连续地铁信号
% clear all
% load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% l = 120000;
% uch1 = zeros(l*6*24,1);
% uch2 = zeros(l*6*24,1);
% uch3 = zeros(l*6*24,1);
% noise_1 = zeros(l*6*24,1);
% noise_2 = zeros(l*6*24,1);
% noise_3 = zeros(l*6*24,1);
% surf_folder = '3#10-04\';
% sch1 = zeros(l*6*24,1);
% sch2 = zeros(l*6*24,1);
% sch3 = zeros(l*6*24,1);
% j=1;
% for i = 6*0+1+144*(4-1):6*23+6+144*(4-1)
%     load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
%     uch1((j-1)*l+1:j*l) = under_ch1;
%     uch2((j-1)*l+1:j*l) = under_ch2;
%     uch3((j-1)*l+1:j*l) = under_ch3;
%     load(['D:\szh\test\used-data\test_noise\noise_similar-2\',name_200{i}],'noise_ch1','noise_ch2','noise_ch3');
%     noise_1((j-1)*l+1:j*l) = noise_ch1;
%     noise_2((j-1)*l+1:j*l) = noise_ch2;
%     noise_3((j-1)*l+1:j*l) = noise_ch3;
%     load(['D:\szh\test\used-data\3#\',name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
%     sch1((j-1)*l+1:j*l) = surf_ch1;
%     sch2((j-1)*l+1:j*l) = surf_ch2;
%     sch3((j-1)*l+1:j*l) = surf_ch3;
%     j = j+1
% end
% save(['D:\szh\test\used-data\200#constantly\200#10-04\','uch1.mat'],'uch1');
% save(['D:\szh\test\used-data\200#constantly\200#10-04\','uch2.mat'],'uch2');
% save(['D:\szh\test\used-data\200#constantly\200#10-04\','uch3.mat'],'uch3');
% save(['D:\szh\test\used-data\test_noise\10-04\','noise_1.mat'],'noise_1');
% save(['D:\szh\test\used-data\test_noise\10-04\','noise_2.mat'],'noise_2');
% save(['D:\szh\test\used-data\test_noise\10-04\','noise_3.mat'],'noise_3');
% save(['D:\szh\test\used-data\test\',surf_folder,'sch1.mat'],'sch1');
% save(['D:\szh\test\used-data\test\',surf_folder,'sch2.mat'],'sch2');
% save(['D:\szh\test\used-data\test\',surf_folder,'sch3.mat'],'sch3');

%%
% %利用噪声，生成连续地表信号
% clear all
% folder = '15s梯形传递函数\';
% % x = zeros(3000,1);
% % x(101) = 1;
% % Alpha_test = x;
% load(['D:\szh\test\used-data\test\',folder,'Alpha_test.mat'],'Alpha_test');
% l = 120000;
% 
% load('D:\szh\test\used-data\200#constantly\200#10-04\uch1.mat');
% sch1 = conv(Alpha_test,uch1);
% clear uch1
% sch1 = sch1(1:end-length(Alpha_test)+1);
% noise_1 = zeros(l*6*24,1);
% for i = 1:6*24
%     noise_1((i-1)*l+1:i*l) = getnoise();
% end
% sch1 = sch1+noise_1;
% % save(['D:\szh\test\used-data\test\',folder,'noise_1.mat'],'noise_1');
% % clear noise_1
% save(['D:\szh\test\used-data\test\',folder,'sch1.mat'],'sch1');
% clear sch1
% 
% 
% load('D:\szh\test\used-data\200#constantly\200#10-04\uch2.mat');
% sch2 = conv(Alpha_test,uch2);
% clear uch2
% sch2 = sch2(1:end-length(Alpha_test)+1);
% noise_2 = zeros(l*6*24,1);
% for i = 1:6*24
%     noise_2((i-1)*l+1:i*l) = getnoise();
% end
% sch2 = sch2+noise_2;
% clear noise_2
% save(['D:\szh\test\used-data\test\',folder,'sch2.mat'],'sch2');
% clear sch2
% 
% 
% load('D:\szh\test\used-data\200#constantly\200#10-04\uch3.mat');
% sch3 = conv(Alpha_test,uch3);
% clear uch3
% sch3 = sch3(1:end-length(Alpha_test)+1);
% noise_3 = zeros(l*6*24,1);
% for i = 1:6*24
%     noise_3((i-1)*l+1:i*l) = getnoise();
% end
% sch3 = sch3+noise_3;
% clear noise_3
% save(['D:\szh\test\used-data\test\',folder,'sch3.mat'],'sch3');
% clear sch3

%%
%人工合成数据，测试程序
clear all

surf_folder = '10s直线传递函数\';
% surf_folder = '15s梯形传递函数\';

sf=200;
lu=100;
ls=100;
lag=000;%时间延迟
day = 4;
t1 = 6*7+1+144*(4-1);
t2 = 6*19+0+144*(4-1);

alpha=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
Alpha=ifft(alpha);


%以下修正计算的alpha并画图
l = (lu+ls)*sf-1;
n=0:l-1;
n=n';
t=n/sf;
f=n*sf/l;
for j=1:length(n)
    if(f(j)>=20)
        N=j-1;
        break
    end
end

load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
alpha_test = fft(Alpha_test);
lA = length(Alpha_test);
nA = 0:lA-1;
nA = nA';
tA = nA / sf;
fA = nA * sf / lA;
for j=1:length(n)
    if(fA(j)>=20)
        NA=j-1;
        break
    end
end

% Alpha_revise = zeros(lA,1);
% if(lag == 0)
%     Alpha_revise(1:lA) = Alpha(1:lA);
% elseif(lag >= lA)
%     Alpha_revise(1:lA) = Alpha(l-lag+1:l-lag+lA);
% else
%     Alpha_revise(1:lag) = Alpha(l-lag+1:l);
%     Alpha_revise(lag+1:lA) = Alpha(1:lA-lag);
% end
% alpha_revise = fft(Alpha_revise);
% 
% 
% figure(21)
% plot(fA,abs(alpha_test),fA,abs(alpha_revise),'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('真实值','估计值')%,title('场地传递函数真实值与估计值对比')
% span = 30;
% alpha_revise_smoothed = smooth(abs(alpha_revise),span);
% figure(22)
% plot(fA,abs(alpha_test),fA,alpha_revise_smoothed,'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('真实值','估计值')%,title('场地传递函数真实值与估计值对比')
span = 30;
alpha_smoothed = smooth(abs(alpha),span);
figure(23)
plot(fA,abs(alpha_test),f,alpha_smoothed,'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('真实值','估计值')%,title('场地传递函数真实值与估计值对比')
% figure(25)
% plot(tA,Alpha_test,tA,Alpha_revise)

cut = 4000;
Alpha_cut = Alpha(1:cut);
alpha_cut = fft(Alpha_cut);
fcut = [0:cut-1]'/cut*200;
figure(30)
plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('真实值','截断值')%,title('场地传递函数真实值与估计值对比')
span = 30;
alpha_cut_smoothed = smooth(abs(alpha_cut),span);
figure(31)
plot(fA,abs(alpha_test),fcut,alpha_cut_smoothed,'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('真实值','截断平滑值')%,title('场地传递函数真实值与估计值对比')
temp = alpha_cut_smoothed .* (alpha_cut ./ abs(alpha_cut));
Alpha_final = real(ifft(temp));
alpha_final = fft(Alpha_final);
figure(32)
plot(fA,abs(alpha_test),fcut,alpha_cut_smoothed,'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('真实值','最终估计值')%,title('场地传递函数真实值与估计值对比')

% figure(1)
% plot(fA,abs(alpha_revise))
% figure(2)
% plot(tA,Alpha_revise)
% figure(3)
% plot(fA(1:NA),abs(alpha_revise(1:NA)))
% figure(4)
% plot(t,Alpha)

% figure(1)
% plot(f,abs(alpha))
% figure(2)
% plot(t,Alpha)
% figure(3)
% plot(f(1:N),abs(alpha(1:N)))

% figure(11)
% plot(fA(1:NA),abs(alpha_test(1:NA)),f(1:N),abs(alpha(1:N)),fA(1:NA),abs(alpha_revise(1:NA)))
figure(12)
% plot(fA,abs(alpha_test),f,abs(alpha),fA,abs(alpha_revise))
plot(fA,abs(alpha_test),f,abs(alpha))




% %画误差图
% error_ab = abs(abs(alpha_test)-alpha_smoothed);
% error_re = error_ab ./ abs(alpha_test);
% % figure(200)
% % plot(fA,error_ab)
% figure(201)
% plot(fA,error_re),axis([0 100 0 0.2])


%%
% %反复迭代测试人造数据
% clear all
% surf_folder = '200s直线传递函数\';
% 
% sf=200;
% lu=100;
% ls=100;
% lag=000;%时间延迟
% day = 4;
% t1 = 6*7+1+144*(4-1);
% t2 = 6*19+0+144*(4-1);
% 
% alpha_ch1=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
% Alpha_ch1=ifft(alpha_ch1);
% 
% l = (lu+ls)*sf-1;
% n=0:l-1;
% n=n';
% t=n/sf;
% f=n*sf/l;
% figure(100)
% plot(f,abs(alpha_ch1))
% 
% 
% load(['D:\szh\test\used-data\200#constantly\200#10-0',num2str(day),'\uch1.mat'],'uch1');
% load(['D:\szh\test\used-data\test\',surf_folder,'sch1.mat'],'sch1');
% temp = conv(Alpha_ch1,uch1);
% sch_left = sch1 - temp(1:144*120000);
% alpha_left_ch1{1}=iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
% 
% figure(101)
% plot(f,abs(alpha_left_ch1{1}))
% 
% for i = 2:5
%     Alpha_left_ch1{i-1} = ifft(alpha_left_ch1{i-1});
%     temp = conv(Alpha_left_ch1{i-1},uch1);
%     sch_left = sch_left - temp(1:144*120000);
%     alpha_left_ch1{i}=iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
% end

%%
% %反复迭代测试实际数据
% clear all
% surf_folder = '3#10-04\';
% 
% sf=200;
% lu=100;
% ls=100;
% lag=000;%时间延迟
% day = 4;
% t1 = 6*7+1+144*(4-1);
% t2 = 6*19+0+144*(4-1);
% 
% alpha_ch1=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
% Alpha_ch1=ifft(alpha_ch1);
% 
% l = (lu+ls)*sf-1;
% n=0:l-1;
% n=n';
% t=n/sf;
% f=n*sf/l;
% figure(1)
% plot(f,abs(alpha_ch1)),xlim([0 15])
% 
% 
% load(['D:\szh\test\used-data\200#constantly\200#10-0',num2str(day),'\uch1.mat'],'uch1');
% load(['D:\szh\test\used-data\test\',surf_folder,'sch1.mat'],'sch1');
% temp = myconv(Alpha_ch1,uch1);
% sch_left = sch1 - temp(1:length(sch1));
% alpha_left_ch1{1}=iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
% 
% figure(101)
% plot(f,abs(alpha_left_ch1{1})),xlim([0 15])
% 
% for i = 2:5
%     Alpha_left_ch1{i-1} = ifft(alpha_left_ch1{i-1});
%     temp = myconv(Alpha_left_ch1{i-1},uch1);
%     sch_left = sch_left - temp(1:144*120000);
%     alpha_left_ch1{i}=iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
% end