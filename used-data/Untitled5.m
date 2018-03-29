% %生成测试用地表信号,10分钟信号卷积后相连
% clear all
% % folder = '3#10-04-07-19-ch3-change\';
% % folder = 'new200\';
% folder = 'doublepeak\';
% load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% load(['D:\szh\test\used-data\test_alpha\',folder,'Alpha_test.mat'],'Alpha_test');
% 
% l = 120000;
% sf = 200;
% n = 0 : l - 1;
% n = n';
% t = n / sf;
% 
% % noise_folder = 'wgn-db_-27\';
% noise_folder = 'noise-similar\';
% for i = 1 : 1008
%     load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
%     load(['D:\szh\test\used-data\test_noise\',noise_folder,name_200{i}],'noise_ch1','noise_ch2','noise_ch3');
%     if(length(under_ch1)~=length(noise_ch1) || length(under_ch2)~=length(noise_ch2) || length(under_ch3)~=length(noise_ch3))
%         disp('length error');
%         break
%     end
%     ch1 = conv(Alpha_test,under_ch1);
%     ch2 = conv(Alpha_test,under_ch2);
%     ch3 = conv(Alpha_test,under_ch3);
%     surf_ch1 = ch1(1:l) + noise_ch1;
%     surf_ch2 = ch2(1:l) + noise_ch2;
%     surf_ch3 = ch3(1:l) + noise_ch3;
%     save(['D:\szh\test\used-data\test_surf\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
% end


% %生成测试用地表信号,全部信号连接后卷积
% clear all
% % folder = '3#10-04-07-19-ch3-change\';
% folder = 'new100-similar\';
% % folder = 'doublepeak-5s+5s_0\';
% load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% load(['D:\szh\test\used-data\test_alpha\',folder,'Alpha_test.mat'],'Alpha_test');
% 
% l = 120000;
% sf = 200;
% n = 0 : l - 1;
% n = n';
% t = n / sf;
% 
% % noise_folder = 'wgn-db_-27\';
% noise_folder = 'noise-similar-2\';
% load(['D:\szh\test\used-data\200#\',name_200{1}],'under_ch1','under_ch2','under_ch3');
% load(['D:\szh\test\used-data\test_noise\',noise_folder,name_200{1}],'noise_ch1','noise_ch2','noise_ch3');

% uch1 = under_ch1;uch2 = under_ch2;uch3 = under_ch3;
% noise_1 = noise_ch1;noise_2 = noise_ch2;noise_3 = noise_ch3;
% for i = 2 : 1008
%     load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
%     load(['D:\szh\test\used-data\test_noise\',noise_folder,name_200{i}],'noise_ch1','noise_ch2','noise_ch3');
%     uch1 = [uch1;under_ch1];
%     uch2 = [uch2;under_ch2];
%     uch3 = [uch3;under_ch3];
%     noise_1 = [noise_1;noise_ch1];
%     noise_2 = [noise_2;noise_ch2];
%     noise_3 = [noise_3;noise_ch3];
% end
% 
% save('D:\szh\test\used-data\3#constantly\under.mat','uch1','uch2','uch3');
% ch1 = conv(Alpha_test,uch1);
% ch2 = conv(Alpha_test,uch2);
% ch3 = conv(Alpha_test,uch3);
% sch1 = ch1(1:l*1008) + noise_ch1;
% sch2 = ch2(1:l*1008) + noise_ch2;
% sch3 = ch3(1:l*1008) + noise_ch3;
% 
% load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% folder = '0-15Hz-noise_similar-2\';
% for i = 1 : 1008
%     surf_ch1 = sch1(:,i);
%     surf_ch2 = sch2(:,i);
%     surf_ch3 = sch3(:,i);
% 	save(['D:\szh\test\used-data\test_surf\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
%     i
% end


% %生成测试用Alpha
% load('D:\szh\test\used-data\test_alpha\3#10-04-07-19-ch1\Alpha_test.mat','Alpha_test');
% alpha_test = fft(Alpha_test);
% l = length(Alpha_test);
% sf = 200;
% n = 0 : l - 1;
% n = n';
% t = n / sf;
% f = n * sf / l;
% N = 1;
% while(f(N)<=20)
%     N = N + 1;
% end
% N = N -1;
% figure(4)
% plot(f(1:N),abs(alpha_test(1:N)))
% figure(5)
% plot(f,abs(alpha_test))
% figure(6)
% plot(t,Alpha_test)



% %改变Alpha谱值
% load('D:\szh\test\used-data\test_alpha\3#10-04-07-19-ch3\Alpha_test.mat','Alpha_test');
% alpha_test = fft(Alpha_test);
% z = alpha_test;
% x = zeros(length(alpha_test),1);
% for i = 251:900
%     if(i == 501 || i ==251)
%         continue;
%     end
%     x(i) = 30 * exp(-abs(i - 550) / 150);
% %     x(i) = exp(-abs(i - 550) / 350);
%     z(i) = z(i) * x(i);
%     z(2002 - i) = z(2002 - i) * x(i);
% end
% % y = z;
% % for i = 251:900
% %     y(i) = (z(i-1) + z(i+1) + z(i))/3;
% % end
% 
% figure(10)
% plot(abs(z))


% %生成噪声，分段保存
% clear all
% load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% 
% l = 120000;
% sf = 200;
% n = 0 : l - 1;
% n = n';
% t = n / sf;
% 
% for i = 1 : 1008
%     noise_ch1 = getnoise();
%     noise_ch2 = getnoise();
%     noise_ch3 = getnoise();
%     
%     p = polyfit(t,noise_ch1,1);
%     noise_ch1 = noise_ch1 - (p(1) * t + p(2));
%     p = polyfit(t,noise_ch2,1);
%     noise_ch2 = noise_ch2 - (p(1) * t + p(2));
%     p = polyfit(t,noise_ch3,1);
%     noise_ch3 = noise_ch3 - (p(1) * t + p(2));
%     
%     noise_ch1 = noise_ch1 - sum(noise_ch1) / 120000;
%     noise_ch2 = noise_ch2 - sum(noise_ch2) / 120000;
%     noise_ch3 = noise_ch3 - sum(noise_ch3) / 120000;
%     
%     save(['D:\szh\test\used-data\test_noise\noise-similar-2\',name_200{i}],'noise_ch1','noise_ch2','noise_ch3');
% end


% %生成噪声，连续
% noise_folder = 'noise-similar-2\';
% load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% load(['D:\szh\test\used-data\test_noise\',noise_folder,name_200{1}],'noise_ch1','noise_ch2','noise_ch3');
% noise_1 = noise_ch1;noise_2 = noise_ch2;noise_3 = noise_ch3;
% for i = 2:1008
%     load(['D:\szh\test\used-data\test_noise\',noise_folder,name_200{i}],'noise_ch1','noise_ch2','noise_ch3');
%     noise_1 = [noise_1;noise_ch1];
%     noise_2 = [noise_2;noise_ch2];
%     noise_3 = [noise_3;noise_ch3];
% end
% clear noise_ch1 noise_ch2 noise_ch3
% save(['D:\szh\test\used-data\test_noise\',noise_folder,'_ch1.mat'],'noise_1');
% save(['D:\szh\test\used-data\test_noise\',noise_folder,'_ch2.mat'],'noise_2');
% save(['D:\szh\test\used-data\test_noise\',noise_folder,'_ch3.mat'],'noise_3');

% folder = 'doublepeak-noise-similar-2\';
% load(['D:\szh\test\used-data\test_alpha\',folder,'Alpha_test.mat'],'Alpha_test');
% load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% load('D:\szh\test\used-data\3#constantly\uch1.mat','uch1');
% load('D:\szh\test\used-data\3#constantly\uch2.mat','uch2');
% load('D:\szh\test\used-data\3#constantly\uch3.mat','uch3');
% 
% lA = length(Alpha_test)-1;
% 
% ch1 = conv(Alpha_test,uch1);
% ch2 = conv(Alpha_test,uch2);
% ch3 = conv(Alpha_test,uch3);
% clear uch1 uch2 uch3
% 
% ch1 = [ch1;zeros(120000-lA,1)];
% ch2 = [ch2;zeros(120000-lA,1)];
% ch3 = [ch3;zeros(120000-lA,1)];
% 
% load(['D:\szh\test\used-data\test_noise\',folder,'_ch1.mat'],'noise_1');
% load(['D:\szh\test\used-data\test_noise\',folder,'_ch2.mat'],'noise_2');
% load(['D:\szh\test\used-data\test_noise\',folder,'_ch3.mat'],'noise_3');
% 
% noise_1 = [noise_1;zeros(120000,1)];
% noise_2 = [noise_2;zeros(120000,1)];
% noise_3 = [noise_3;zeros(120000,1)];
% 
% surf_1 = ch1 + noise_1;clear ch1 noise_1
% surf_2 = ch2 + noise_2;clear ch2 noise_2
% surf_3 = ch3 + noise_3;clear ch3 noise_3
% 
% save('D:\szh\test\used-data\surf_1.mat','surf_1');
% save('D:\szh\test\used-data\surf_2.mat','surf_2');
% save('D:\szh\test\used-data\surf_3.mat','surf_3');
% 
% for i = 1 : 1008
%     surf_ch1 = surf_1(:,i);
%     surf_ch2 = surf_2(:,i);
%     surf_ch3 = surf_3(:,i);
% 	save(['D:\szh\test\used-data\test_surf\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
% end

% %生成地下测试信号，用地铁信号+白噪声作为实际地下记录
% clear all
% load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% folder = 'test_under\wgn(p=-43)\';
% for i = 1:1008
%     load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
%     under_ch1 = under_ch1 + wgn(120000,1,-43);
%     under_ch2 = under_ch2 + wgn(120000,1,-43);
%     under_ch3 = under_ch3 + wgn(120000,1,-43);
%     save(['D:\szh\test\used-data\',folder,name_200{i}],'under_ch1','under_ch2','under_ch3');
% end

% %10-04单日地铁、噪声信号连接并存储
% clear all
% load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% l = 120000;
% uch1 = zeros(l*6*24,1);
% uch2 = zeros(l*6*24,1);
% uch3 = zeros(l*6*24,1);
% noise_1 = zeros(l*6*24,1);
% noise_2 = zeros(l*6*24,1);
% noise_3 = zeros(l*6*24,1);
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
%     j = j+1
% end
% save(['D:\szh\test\used-data\200#10-04\','uch1.mat'],'uch1');
% save(['D:\szh\test\used-data\200#10-04\','uch2.mat'],'uch2');
% save(['D:\szh\test\used-data\200#10-04\','uch3.mat'],'uch3');
% save(['D:\szh\test\used-data\test_noise\10-04\','noise_1.mat'],'noise_1');
% save(['D:\szh\test\used-data\test_noise\10-04\','noise_2.mat'],'noise_2');
% save(['D:\szh\test\used-data\test_noise\10-04\','noise_3.mat'],'noise_3');


% clear all
% l = 120000;
% x = zeros(2000,1);
% x(101) = 2;
% Alpha_test = x;
% load('D:\szh\test\used-data\200#10-04\uch1.mat');
% load('D:\szh\test\used-data\test_noise\10-04\noise_1.mat');
% sch1 = conv(Alpha_test,uch1);
% clear uch1
% sch1 = sch1(1:end-1999);
% sch1 = sch1+noise_1;
% clear noise_1
% sch1 = reshape(sch1,l,[]);
% 
% load('D:\szh\test\used-data\200#10-04\uch2.mat');
% load('D:\szh\test\used-data\test_noise\10-04\noise_2.mat');
% sch2 = conv(Alpha_test,uch2);
% clear uch2
% sch2 = sch2(1:end-1999);
% sch2 = sch2+noise_2;
% clear noise_2
% sch2 = reshape(sch2,l,[]);
% 
% load('D:\szh\test\used-data\200#10-04\uch3.mat');
% load('D:\szh\test\used-data\test_noise\10-04\noise_3.mat');
% sch3 = conv(Alpha_test,uch3);
% clear uch3
% sch3 = sch3(1:end-1999);
% sch3 = sch3+noise_3;
% clear noise_3
% sch3 = reshape(sch3,l,[]);
% 
% load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% folder = '0-100Hz-noise_similar-2\';
% for i = 1 : 144
%     surf_ch1 = sch1(:,i);
%     surf_ch2 = sch2(:,i);
%     surf_ch3 = sch3(:,i);
% 	save(['D:\szh\test\used-data\test_surf\',folder,name_200{i+432}],'surf_ch1','surf_ch2','surf_ch3');
%     i
% end

% %测试对传递函数截断后的影响
% figure(10)
% plot(f,abs(alpha_ch1)),xlim([0 15])
% 
% k = 3000;
% sss = Alpha_ch1(1:k);
% fk = [0:k-1]' /k * 200;
% figure(11)
% plot(fk,abs(fft(sss))),xlim([0 15])
% 
% figure(12)
% plot(f,abs(alpha_ch1),fk,abs(fft(sss)))
% figure(13)
% plot(f,abs(alpha_ch1),fk,abs(fft(sss))),xlim([0 15])

% %生成07:00-19:00信号
% % folder = '3#10-04-07-19\';
% % lag = 1062;
% folder = '2#10-04-07-19\';
% lag = 200*-3.605;
% uch1 = uch1(120000*6*7+1:120000*6*19);
% sch1 = sch1(lag+120000*6*7+1:120000*6*19+lag);
% save(['D:\szh\test\used-data\test\',folder,'sch1.mat'],'sch1');
% save(['D:\szh\test\used-data\test\',folder,'uch1.mat'],'uch1');

%%
% %test wangbo
% clear all
% folder = '15s梯形传递函数2\';
% 
% load(['D:\szh\test\used-data\test\',folder,'Alpha_test.mat'],'Alpha_test');
% l = 120000;
% 
% load('D:\szh\test\used-data\200#constantly\200#10-04\uch1.mat');
% sch1 = conv(Alpha_test,uch1);
% clear uch1
% sch1 = sch1(1:end-length(Alpha_test)+1);
% noise_1 = zeros(l*6*24,1);
% for i = 1:6*24
%     noise_1((i-1)*l+1:i*l) = wgn(120000,1,-32);
% end
% sch1 = sch1+noise_1;
% % save(['D:\szh\test\used-data\test\',folder,'noise_1.mat'],'noise_1');
% clear noise_1
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
%     noise_2((i-1)*l+1:i*l) = wgn(120000,1,-32);
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
%     noise_3((i-1)*l+1:i*l) = wgn(120000,1,-32);
% end
% sch3 = sch3+noise_3;
% clear noise_3
% save(['D:\szh\test\used-data\test\',folder,'sch3.mat'],'sch3');
% clear sch3

%%
t1 = 6*7 + 5 + 144*(4-1);
% load('D:\szh\test\used-data\namelist\name_200.mat');
% load(['D:\szh\test\used-data\200#\',name_200{t1}]);
% A_200=zeros(120000,3);
% A_200(:,1)=under_ch1;
% A_200(:,2)=under_ch2;
% A_200(:,3)=under_ch3;
% save(['F:\A_200\A200_1240.mat'],'A_200');

% folder = '10s梯形传递函数 简单相位1\';
folder = '10s双峰传递函数 简单相位3\';
load(['D:\szh\test\used-data\test\',folder,'sch1.mat'],'sch1');
% load(['D:\szh\test\used-data\test\',folder,'sch2.mat'],'sch2');
% load(['D:\szh\test\used-data\test\',folder,'sch3.mat'],'sch3');
XAD=zeros(360000,3);
tt1 = t1 - 144*(4-1);
l = 120000;
x1 = (tt1-1)*l;
XAD(:,1)=sch1(x1+1:x1+l*3);
% XAD(:,2)=sch2(x1+1:x1+l*3);
% XAD(:,3)=sch3(x1+1:x1+l*3);
save(['F:\A04\A04_1200.mat'],'XAD');

A_200=zeros(120000,3);
load('D:\szh\test\used-data\test_11.mat');
A_200(:,1)=uch1(x1+1:x1+l);
save(['F:\A_200\A200_1220.mat'],'A_200');