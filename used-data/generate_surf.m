%�������������ź�
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

%% ************************************
% %�������������������ر��ź�
% clear all
% folder = '10s0-100Hz˫�崫�ݺ���\';
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

%% ************************************
% %�˹��ϳ����ݣ����Գ���
% clear all
% 
% % surf_folder = '10sֱ�ߴ��ݺ���\';
% % surf_folder = '15s���δ��ݺ���\';
% % surf_folder = '10s0-100Hz���崫�ݺ���\';
% surf_folder = '10s0-15Hz˫�崫�ݺ���\';
% 
% sf=200;
% lu=20;
% ls=20;
% lag=000;%ʱ���ӳ�
% day = 4;
% t1 = 6*7+1+144*(4-1);
% t2 = 6*19+0+144*(4-1);
% 
% alpha=cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,'ch1');
% Alpha=ifft(alpha);
% 
% 
% %�������������alpha����ͼ
% l = (lu+ls)*sf-1;
% n=0:l-1;
% n=n';
% t=n/sf;
% f=n*sf/l;
% 
% 
% load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
% alpha_test = fft(Alpha_test);
% lA = length(Alpha_test);
% nA = 0:lA-1;
% nA = nA';
% tA = nA / sf;
% fA = nA * sf / lA;
% 
% 
% % Alpha_revise = zeros(lA,1);
% % if(lag == 0)
% %     Alpha_revise(1:lA) = Alpha(1:lA);
% % elseif(lag >= lA)
% %     Alpha_revise(1:lA) = Alpha(l-lag+1:l-lag+lA);
% % else
% %     Alpha_revise(1:lag) = Alpha(l-lag+1:l);
% %     Alpha_revise(lag+1:lA) = Alpha(1:lA-lag);
% % end
% % alpha_revise = fft(Alpha_revise);
% % 
% % 
% % figure(21)
% % plot(fA,abs(alpha_test),fA,abs(alpha_revise),'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('���ش��ݺ�����ֵ','fontsize',22)...
% %     ,set(gca,'fontsize',22),legend('��ʵֵ','����ֵ')%,title('���ش��ݺ�����ʵֵ�����ֵ�Ա�')
% % span = 30;
% % alpha_revise_smoothed = smooth(abs(alpha_revise),span);
% % figure(22)
% % plot(fA,abs(alpha_test),fA,alpha_revise_smoothed,'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('���ش��ݺ�����ֵ','fontsize',22)...
% %     ,set(gca,'fontsize',22),legend('��ʵֵ','����ֵ')%,title('���ش��ݺ�����ʵֵ�����ֵ�Ա�')
% span = 30;
% alpha_smoothed = smooth(abs(alpha),span);
% figure(23)
% plot(fA,abs(alpha_test),f,alpha_smoothed,'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('���ش��ݺ�����ֵ','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('��ʵֵ','����ֵ')%,title('���ش��ݺ�����ʵֵ�����ֵ�Ա�')
% % figure(25)
% % plot(tA,Alpha_test,tA,Alpha_revise)
% 
% cut = 4000;
% aaa = fftshift(Alpha);
% Alpha_cut = aaa((l-1)/2-lag+1:(l-1)/2-lag+cut);
% alpha_cut = fft(Alpha_cut);
% fcut = [0:cut-1]'/cut*200;
% figure(30)
% plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('���ش��ݺ�����ֵ','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('��ʵֵ','�ض�ֵ')%,title('���ش��ݺ�����ʵֵ�����ֵ�Ա�')
% span = 30;
% alpha_cut_smoothed = smooth(abs(alpha_cut),span);
% figure(31)
% plot(fA,abs(alpha_test),fcut,alpha_cut_smoothed,'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('���ش��ݺ�����ֵ','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('��ʵֵ','�ض�ƽ��ֵ')%,title('���ش��ݺ�����ʵֵ�����ֵ�Ա�')
% temp = alpha_cut_smoothed .* (alpha_cut ./ abs(alpha_cut));
% Alpha_final = real(ifft(temp));
% alpha_final = fft(Alpha_final);
% figure(32)
% plot(fA,abs(alpha_test),fcut,alpha_cut_smoothed,'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('���ش��ݺ�����ֵ','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('��ʵֵ','���չ���ֵ')%,title('���ش��ݺ�����ʵֵ�����ֵ�Ա�')
% 
% % figure(1)
% % plot(fA,abs(alpha_revise))
% % figure(2)
% % plot(tA,Alpha_revise)
% % figure(3)
% % plot(fA(1:NA),abs(alpha_revise(1:NA)))
% % figure(4)
% % plot(t,Alpha)
% 
% % figure(1)
% % plot(f,abs(alpha))
% % figure(2)
% % plot(t,Alpha)
% % figure(3)
% % plot(f(1:N),abs(alpha(1:N)))
% 
% % figure(11)
% % plot(fA(1:NA),abs(alpha_test(1:NA)),f(1:N),abs(alpha(1:N)),fA(1:NA),abs(alpha_revise(1:NA)))
% figure(12)
% % plot(fA,abs(alpha_test),f,abs(alpha),fA,abs(alpha_revise))
% plot(fA,abs(alpha_test),f,abs(alpha))
% 
% 
% 
% 
% % %�����ͼ
% % error_ab = abs(abs(alpha_test)-alpha_smoothed);
% % error_re = error_ab ./ abs(alpha_test);
% % % figure(200)
% % % plot(fA,error_ab)
% % figure(201)
% % plot(fA,error_re),axis([0 100 0 0.2])


%% ************************************
% %��������������������
% clear all
% surf_folder = '10sֱ�ߴ��ݺ���\';
% % surf_folder = '15s���δ��ݺ���\';
% 
% sf=200;
% lu=20;
% ls=20;
% lag=100;%ʱ���ӳ�
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
% % figure(100)
% % plot(f,abs(alpha_ch1))
% 
% %���ݺ����ر���λ����
% load(['D:\szh\test\used-data\200#constantly\200#10-0',num2str(day),'\uch1.mat'],'uch1');
% load(['D:\szh\test\used-data\test\',surf_folder,'sch1.mat'],'sch1');
% istart =  120000*(2+6*0)+1+00000;
% iend = istart + 120000-1;
% 
% len = length(sch1) + l - 1;
% fsch1 = fft(sch1,len);
% phase = fsch1 ./ abs(fsch1);
% 
% sch_left = myfreq(uch1,sch1,fftshift(Alpha_ch1),phase);
% s_left{1} = sch_left(istart:iend);
% alpha_left_ch1{1} = iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
% 
% for i = 2:5
%     Alpha_left_ch1{i-1} = ifft(alpha_left_ch1{i-1});
%     sch_left = myfreq(uch1,sch_left,fftshift(Alpha_left_ch1{i-1}),phase);
%     s_left{i} = sch_left(istart:iend);
%     alpha_left_ch1{i} = iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
%     i
% end
% load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
% temp = conv(Alpha_test,uch1);
% s_noise = sch1 - temp(1:length(uch1));
% 
% s = sch1(istart:iend);
% cor = zeros(5,1);
% for i = 1:5
%     cor(i) = corr(filter(Hd,s_left{i}),filter(Hd,s-s_left{i}));
% end
% figure(4000)
% plot(abs(cor))
% 
% [~,aaa] = min(abs(cor));

% %ֱ�Ӽ��㴫�ݺ������������
% load(['D:\szh\test\used-data\200#constantly\200#10-0',num2str(day),'\uch1.mat'],'uch1');
% load(['D:\szh\test\used-data\test\',surf_folder,'sch1.mat'],'sch1');
% istart =  120000*(2+6*0)+1+00000;
% iend = istart + 120000-1;
% 
% % %һ���Է�����
% % z = fftshift(Alpha_ch1);
% % 
% % % cut = 2000;
% % % Alpha_cut = z((l-1)/2-lag+1:(l-1)/2-lag+cut);
% % % temp = myconv(Alpha_cut,uch1);
% % % s_u = temp(1:length(uch1));
% % temp = myconv(z,uch1);
% % s_u = temp(1+(l-1)/2-lag:length(uch1)+(l-1)/2-lag);
% % 
% % load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
% % temp = conv(Alpha_test,uch1);
% % temp = temp(1:length(uch1));
% % res = s_u(istart:iend) - temp(istart:iend);
% % figure(1)
% % plot(res)
% 
% temp = myconv(fftshift(Alpha_ch1),uch1);
% sch_left = sch1 - temp(1+(l-1)/2-lag:length(uch1)+(l-1)/2-lag);
% s_left{1} = sch_left(istart:iend);
% alpha_left_ch1{1} = iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
% 
% for i = 2:5
%     Alpha_left_ch1{i-1} = ifft(alpha_left_ch1{i-1});
%     temp = myconv(fftshift(Alpha_left_ch1{i-1}),uch1);
%     sch_left = sch_left - temp(1+(l-1)/2-lag:length(uch1)+(l-1)/2-lag);
%     s_left{i} = sch_left(istart:iend);
%     alpha_left_ch1{i} = iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
%     i
% end
% load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
% temp = conv(Alpha_test,uch1);
% s_noise = sch1 - temp(1:length(uch1));

% %���ݺ����ض�ƽ�����������
% load(['D:\szh\test\used-data\200#constantly\200#10-0',num2str(day),'\uch1.mat'],'uch1');
% load(['D:\szh\test\used-data\test\',surf_folder,'sch1.mat'],'sch1');
% cut = 2000;
% span = 30;
% Alpha_final = cut_smooth_alpha(Alpha_ch1,cut,span);
% temp = myconv(Alpha_final,uch1);
% sch_left = sch1 - temp(1:length(uch1));
% s_left{1} = sch_left(120000*6*7+1:120000*6*7+120000);
% z = iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
% Alpha_left_ch1{1} = cut_smooth_alpha(ifft(z),cut,span);
% alpha_left_ch1{1} = fft(Alpha_left_ch1{1});
% 
% f_final = [0:length(Alpha_final)-1]' / length(Alpha_final) * 200;
% figure(101)
% plot(f_final,abs(alpha_left_ch1{1}))
% 
% for i = 2:5
%     temp = myconv(Alpha_left_ch1{i-1},uch1);
%     sch_left = sch_left - temp(1:length(uch1));
%     s_left{i} = sch_left(120000*6*7+1:120000*6*7+120000);
%     z = iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
%     Alpha_left_ch1{i} = cut_smooth_alpha(ifft(z),cut,span);
%     alpha_left_ch1{i} = fft(Alpha_left_ch1{i});
% end



%% ************************************
% %������������ʵ������
% clear all
% surf_folder = '3#10-04\';
% 
% sf=200;
% lu=100;
% ls=100;
% lag=000;%ʱ���ӳ�
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
% % %û��ʱ���׼��ֱ��ʱ��������
% % load(['D:\szh\test\used-data\200#constantly\200#10-0',num2str(day),'\uch1.mat'],'uch1');
% % load(['D:\szh\test\used-data\test\',surf_folder,'sch1.mat'],'sch1');
% % temp = myconv(Alpha_ch1,uch1);
% % sch_left = sch1 - temp(1:length(uch1));
% % s_left{1} = sch_left(120000*6*7+1:120000*6*7+120000);
% % alpha_left_ch1{1}=iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
% % 
% % figure(101)
% % plot(f,abs(alpha_left_ch1{1})),xlim([0 15])
% % 
% % for i = 2:5
% %     Alpha_left_ch1{i-1} = ifft(alpha_left_ch1{i-1});
% %     temp = myconv(Alpha_left_ch1{i-1},uch1);
% %     sch_left = sch_left - temp(1:length(uch1));
% %     s_left{i} = sch_left(120000*6*7+1:120000*6*7+120000);
% %     alpha_left_ch1{i}=iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
% % end
% 
% %û��ʱ���׼�����ݺ����ض�ƽ��������ֱ�Ӿ������
% load(['D:\szh\test\used-data\200#constantly\200#10-0',num2str(day),'\uch1.mat'],'uch1');
% load(['D:\szh\test\used-data\test\',surf_folder,'sch1.mat'],'sch1');
% cut = 4000;
% span = 1;
% Alpha_final = cut_smooth_alpha(Alpha_ch1,cut,span);
% temp = myconv(Alpha_final,uch1);
% sch_left = sch1 - temp(1:length(uch1));
% s_left{1} = sch_left(120000*6*7+1:120000*6*7+120000);
% z = iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
% Alpha_left_ch1{1} = ifft(z);%cut_smooth_alpha(ifft(z),cut,span);
% alpha_left_ch1{1} = fft(Alpha_left_ch1{1});
% 
% f_final = [0:length(Alpha_final)-1]' / length(Alpha_final) * 200;
% % figure(101)
% % plot(f_final,abs(alpha_left_ch1{1}))
% 
% for i = 2:5
%     temp = myconv(Alpha_left_ch1{i-1},uch1);
%     sch_left = sch_left - temp(1:length(uch1));
%     s_left{i} = sch_left(120000*6*7+1:120000*6*7+120000);
%     z = iter_alpha(lag,sch_left,day,t1,t2,lu,ls,'ch1');
%     Alpha_left_ch1{i} = ifft(z);%cut_smooth_alpha(ifft(z),cut,span);
%     alpha_left_ch1{i} = fft(Alpha_left_ch1{i});
%     i
% end
% 
% alpha_final = fft(Alpha_final);
% figure(100)
% plot(f_final,abs(alpha_final)),xlim([0 15])
% for i = 1:5
% figure(100+i)
% plot(f_final,abs(alpha_left_ch1{i})),xlim([0 15])
% end
% Hd = bandpass2_6;
% for i = 1:5
% figure(200+i)
% plot(filter(Hd,s_left{i}))
% end

%% ************************************
% 3#10-04 07-19���ݲ���
clear all
folder = '3#10-04-07-19\';

sf=200;
lu=20;
ls=20;
lag=000;%ʱ���ӳ�
day = 4;
t1 = 6*7+1+144*(4-1);
t2 = 6*19+0+144*(4-1);

load(['D:\szh\test\used-data\test\',folder,'sch1.mat'],'sch1');
load(['D:\szh\test\used-data\test\',folder,'uch1.mat'],'uch1');

alpha_ch1=test_iter_alpha(uch1,sch1,day,t1,t2,lu,ls,'ch1');
Alpha_ch1=ifft(alpha_ch1);

l = (lu+ls)*sf-1;
n=0:l-1;
n=n';
t=n/sf;
f=n*sf/l;
figure(1)
plot(f,abs(alpha_ch1)),xlim([0 15])


%ֱ��ʱ��������
istart =  120000*(2+6*0)+1+00000;
iend = istart + 120000-1;

temp = conv(fftshift(Alpha_ch1),uch1);
sch_left = sch1 - temp(1+(l-1)/2:length(uch1)+(l-1)/2);
s_u{1} = temp(istart+(l-1)/2:iend+(l-1)/2);
u = uch1(istart:iend);
s = sch1(istart:iend);
s_left{1} = sch_left(istart:iend);%0700-0710
alpha_left_ch1{1}=test_iter_alpha(uch1,sch_left,day,t1,t2,lu,ls,'ch1');

for i = 2:5
    Alpha_left_ch1{i-1} = ifft(alpha_left_ch1{i-1});
    temp = conv(fftshift(Alpha_left_ch1{i-1}),uch1);
    sch_left = sch_left - temp(1+(l-1)/2:length(uch1)+(l-1)/2);
    s_u{i} = temp(istart+(l-1)/2:iend+(l-1)/2);
    s_left{i} = sch_left(istart:iend);
    alpha_left_ch1{i}=test_iter_alpha(uch1,sch_left,day,t1,t2,lu,ls,'ch1');
    i
end
for i = 1:5
figure(100+i)
plot(f,abs(alpha_left_ch1{i})),xlim([0 15])
end
Hd = bandpass2_6;
% Hd = lowpass1015;

time = [0:120000-1]'/200;
for i = 1:5
figure(300+i)
subplot(4,1,1),plot(time,filter(Hd,u)),ylim([-0.03 0.03]);
subplot(4,1,2),plot(time,filter(Hd,s_u{i})),ylim([-0.03 0.03]);
subplot(4,1,3),plot(time,filter(Hd,s)),ylim([-0.03 0.03]);
subplot(4,1,4),plot(time,filter(Hd,s_left{i})),ylim([-0.03 0.03]);
handle{i} = get(gcf,'children');
axes(handle{i}(4));title('����ԭʼ��¼');
axes(handle{i}(3));title('��������ɷ�');
axes(handle{i}(2));title('����ԭʼ��¼');
axes(handle{i}(1));title('����ʣ�µĵ��������ɷ�');
end



% %�ض�ƽ��������ʱ��������
% cut = 3999;
% Alpha_cut(1:(cut+1)/2,1) = Alpha_ch1(1:(cut+1)/2);
% Alpha_cut((cut+1)/2+1:cut,1) = Alpha_ch1(end-(cut-1)/2+1:end);
% temp = myconv(ifftshift(Alpha_cut),uch1);
% sch_left = sch1 - temp(1+(cut-1)/2:length(uch1)+(cut-1)/2);
% s_left{1} = sch_left(1:120000);%0700-0710
% alpha_left_ch1{1}=test_iter_alpha(uch1,sch_left,day,t1,t2,lu,ls,'ch1');
% 
% f_cut = [0:cut-1]'/cut*200;
% for i = 2:5
%     Alpha_left_ch1{i-1} = ifft(alpha_left_ch1{i-1});
%     temp = myconv(ifftshift(Alpha_left_ch1{i-1}),uch1);
%     sch_left = sch_left - temp(1+(l-1)/2:length(uch1)+(l-1)/2);
%     s_left{i} = sch_left(1:120000);
%     alpha_left_ch1{i}=test_iter_alpha(uch1,sch_left,day,t1,t2,lu,ls,'ch1');
%     i
% end
% for i = 1:5
% figure(100+i)
% plot(f,abs(alpha_left_ch1{i})),xlim([0 15])
% end
% Hd = bandpass2_6;
% for i = 1:5
% figure(200+i)
% plot(filter(Hd,s_left{i})),ylim([-.04 .04])
% end



% %Ƶ���������
% count = 5;
% istart = 120000*(5+6*0)+1+20000;%0700-0710
% iend = istart + 120000-1;
% 
% sch_left = myfreq(uch1,sch1,ifftshift(Alpha_ch1));
% u = uch1(istart:iend);
% s = sch1(istart:iend);
% s_left{1} = sch_left(istart:iend);
% alpha_left_ch1{1}=test_iter_alpha(uch1,sch_left,day,t1,t2,lu,ls,'ch1');
% 
% for i = 2:count
%     Alpha_left_ch1{i-1} = ifft(alpha_left_ch1{i-1});
%     sch_left = myfreq(uch1,sch_left,ifftshift(Alpha_left_ch1{i-1}));
%     s_left{i} = sch_left(istart:iend);
%     alpha_left_ch1{i}=test_iter_alpha(uch1,sch_left,day,t1,t2,lu,ls,'ch1');
%     i
% end
% % for i = 1:count
% % figure(100+i)
% % plot(f,abs(alpha_left_ch1{i})),xlim([0 15]),ylim([0 .7])
% % end
% Hd = bandpass2_6;
% % Hd = bandpass2_10;
% % for i = 1:count
% % figure(200+i)
% % plot(filter(Hd,s_left{i})),ylim([-.04 .04])
% % end
% 
% time = [0:120000-1]'/200;
% % for i = 1:count
% % figure(300+i)
% % subplot(3,1,1),plot(time,filter(Hd,u)),ylim([-0.03 0.03]);
% % % subplot(4,1,2),plot(time,filter(Hd,s_u{i})),ylim([-0.03 0.03]);
% % subplot(3,1,2),plot(time,filter(Hd,s)),ylim([-0.03 0.03]);
% % subplot(3,1,3),plot(time,filter(Hd,s_left{i})),ylim([-0.03 0.03]);
% % handle_2 = get(gcf,'children');
% % axes(handle_2(3));title('����ԭʼ��¼');
% % % axes(handle_2(3));title('��������ɷ�');
% % axes(handle_2(2));title('����ԭʼ��¼');
% % axes(handle_2(1));title('����ʣ�µĵ��������ɷ�');
% % end
% 
% % %%���ݺ���ֱ�����
% % test{1} = alpha_ch1;
% % for i = 1:count
% % test{i+1} = test{i} + alpha_left_ch1{i};
% % Atest{i} = ifft(test{i});
% % sch_other{i} = myfreq(uch1,sch1,ifftshift(Atest{i}));
% % res{i} = sch_other{i}(istart:iend);
% % end
% 
% %%���ݺ�������ֵ���
% phase_alpha = alpha_ch1 ./ abs(alpha_ch1);
% test{1} = abs(alpha_ch1);
% for i = 1:count
% test{i+1} = test{i} + abs(alpha_left_ch1{i});
% Atest{i} = ifft(test{i} .* phase_alpha);
% sch_other{i} = myfreq(uch1,sch1,ifftshift(Atest{i}));
% res{i} = sch_other{i}(istart:iend);
% end
% 
% 
% % figure(400)
% % subplot(3,1,1),plot(time,filter(Hd,u)),ylim([-0.03 0.03]);
% % % subplot(4,1,2),plot(time,filter(Hd,s_u{i})),ylim([-0.03 0.03]);
% % subplot(3,1,2),plot(time,filter(Hd,s)),ylim([-0.03 0.03]);
% % subplot(3,1,3),plot(time,filter(Hd,res{2})),ylim([-0.03 0.03]);
% % handle_2 = get(gcf,'children');
% % axes(handle_2(3));title('����ԭʼ��¼');
% % % axes(handle_2(3));title('��������ɷ�');
% % axes(handle_2(2));title('����ԭʼ��¼');
% % axes(handle_2(1));title('����ʣ�µĵ��������ɷ�');
% 
% figure(2000)
% for i=1:count
%     subplot(count,1,i),plot(time,filter(Hd,s_left{i})),ylim([-0.03 0.03]);
% end
% figure(3000)
% for i=1:count
%     subplot(count,1,i),plot(time,filter(Hd,res{i})),ylim([-0.03 0.03]);
% end
% 
% cor = zeros(count,1);
% for i = 1:count
%     cor(i) = corr(filter(Hd,s_left{i}),filter(Hd,s-s_left{i}));
% end
% figure(4000)
% plot(abs(cor))
% 
% [~,aaa] = min(abs(cor));
% figure(1000)
% subplot(4,1,1),plot(time,filter(Hd,u)),ylim([-0.03 0.03]);
% subplot(4,1,2),plot(time,filter(Hd,s)),ylim([-0.03 0.03]);
% subplot(4,1,3),plot(time,filter(Hd,s-res{aaa})),ylim([-0.03 0.03]);
% subplot(4,1,4),plot(time,filter(Hd,res{aaa})),ylim([-0.03 0.03]);
% handle_2 = get(gcf,'children');
% axes(handle_2(4));title('����ԭʼ��¼');
% axes(handle_2(3));title('����ԭʼ��¼');
% axes(handle_2(2));title('���շ�����ĵ�������ɷ�');
% axes(handle_2(1));title('����ʣ�µĵ��������ɷ�');
% figure(1001)
% plot(f,abs(alpha_ch1),f,abs(test{aaa})),xlim([0 15])
% figure(1002)
% subplot(3,1,1),plot(time,filter(Hd,s_left{aaa})),ylim([-0.03 0.03]);
% subplot(3,1,2),plot(time,filter(Hd,res{aaa})),ylim([-0.03 0.03]);
% subplot(3,1,3),plot(time,s_left{aaa}-res{aaa}),ylim([-0.03 0.03]);
% handle_3 = get(gcf,'children');
% axes(handle_3(3));title('��ε����������ĵر������ɷ�');
% axes(handle_3(2));title('�����еõ��Ĵ��ݺ�����ӣ�һ���Է�����ĵر������ɷ�');
% axes(handle_3(1));title('����֮��');



% %�Դ��ݺ�������������Ƶ���������
% count = 5;
% istart = 120000*(2+6*0)+1+20000;%0700-0710
% iend = istart + 120000-1;
% 
% sch_left = myfreq(uch1,sch1,ifftshift(Alpha_ch1));
% u = uch1(istart:iend);
% s = sch1(istart:iend);
% s_left{1} = sch_left(istart:iend);
% alpha_left_ch1{1}=test_iter_alpha(uch1,sch_left,day,t1,t2,lu,ls,'ch1');
% 
% for i = 2:count
%     Alpha_left_ch1{i-1} = ifft(alpha_left_ch1{i-1});
%     sch_left = myfreq(uch1,sch_left,ifftshift(Alpha_left_ch1{i-1}));
%     s_left{i} = sch_left(istart:iend);
%     alpha_left_ch1{i}=test_iter_alpha(uch1,sch_left,day,t1,t2,lu,ls,'ch1');
%     i
% end
% % for i = 1:count
% % figure(100+i)
% % plot(f,abs(alpha_left_ch1{i})),xlim([0 15]),ylim([0 .7])
% % end
% Hd = bandpass2_6;
% % Hd = lowpass1015;
% % for i = 1:count
% % figure(200+i)
% % plot(filter(Hd,s_left{i})),ylim([-.04 .04])
% % end
% 
% time = [0:120000-1]'/200;
% for i = 1:count
% figure(300+i)
% subplot(3,1,1),plot(time,filter(Hd,u)),ylim([-0.03 0.03]);
% % subplot(4,1,2),plot(time,filter(Hd,s_u{i})),ylim([-0.03 0.03]);
% subplot(3,1,2),plot(time,filter(Hd,s)),ylim([-0.03 0.03]);
% subplot(3,1,3),plot(time,filter(Hd,s_left{i})),ylim([-0.03 0.03]);
% handle_2 = get(gcf,'children');
% axes(handle_2(3));title('����ԭʼ��¼');
% % axes(handle_2(3));title('��������ɷ�');
% axes(handle_2(2));title('����ԭʼ��¼');
% axes(handle_2(1));title('����ʣ�µĵ��������ɷ�');
% end
% 
% %���ݺ���ֱ�����
% test{1} = alpha_ch1;
% for i = 1:count
% test{i+1} = test{i} + alpha_left_ch1{i};
% Atest{i} = ifft(test{i});
% sch_other{i} = myfreq(uch1,sch1,ifftshift(Atest{i}));
% res{i} = sch_other{i}(istart:iend);
% end
% 
% % %%���ݺ�������ֵ���
% % phase_alpha = alpha_ch1 ./ abs(alpha_ch1);
% % test{1} = abs(alpha_ch1);
% % for i = 1:count
% % test{i+1} = test{i} + abs(alpha_left_ch1{i});
% % Atest{i} = ifft(test{i} .* phase_alpha);
% % sch_other{i} = myfreq(uch1,sch1,ifftshift(Atest{i}));
% % res{i} = sch_other{i}(istart:iend);
% % end
% figure(2)
% plot(f,abs(test{2})),xlim([0 15])
% 
% figure(400)
% subplot(3,1,1),plot(time,filter(Hd,u)),ylim([-0.03 0.03]);
% % subplot(4,1,2),plot(time,filter(Hd,s_u{i})),ylim([-0.03 0.03]);
% subplot(3,1,2),plot(time,filter(Hd,s)),ylim([-0.03 0.03]);
% subplot(3,1,3),plot(time,filter(Hd,res{2})),ylim([-0.03 0.03]);
% handle_2 = get(gcf,'children');
% axes(handle_2(3));title('����ԭʼ��¼');
% % axes(handle_2(3));title('��������ɷ�');
% axes(handle_2(2));title('����ԭʼ��¼');
% axes(handle_2(1));title('����ʣ�µĵ��������ɷ�');
% 
% figure(1000)
% subplot(4,1,1),plot(time,filter(Hd,u)),ylim([-0.03 0.03]);
% subplot(4,1,2),plot(time,filter(Hd,s)),ylim([-0.03 0.03]);
% subplot(4,1,3),plot(time,filter(Hd,s-res{2})),ylim([-0.03 0.03]);
% subplot(4,1,4),plot(time,filter(Hd,res{2})),ylim([-0.03 0.03]);
% handle_2 = get(gcf,'children');
% axes(handle_2(4));title('����ԭʼ��¼');
% axes(handle_2(3));title('����ԭʼ��¼');
% axes(handle_2(2));title('���շ�����ĵ�������ɷ�');
% axes(handle_2(1));title('����ʣ�µĵ��������ɷ�');
% 
% figure(2000)
% for i=1:count
%     subplot(count,1,i),plot(time,filter(Hd,s_left{i})),ylim([-0.03 0.03]);
% end
% figure(3000)
% for i=1:count
%     subplot(count,1,i),plot(time,filter(Hd,res{i})),ylim([-0.03 0.03]);
% end
