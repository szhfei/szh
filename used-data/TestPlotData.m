% %画地面单日图
% clear all
% 
% folder='3#\';
% load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% l = 120000;
% day = 2;
% d1 = zeros(l*6*24*1,1);
% d2 = zeros(l*6*24*1,1);
% d3 = zeros(l*6*24*1,1);
% for i=(6*0+1+144*(day-1)):(6*24+144*(day-1))  
%     load(['D:\szh\test\used-data\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3')
%     j = i-(day-1)*144;
%     d1((j-1) * l + 1:j * l) = surf_ch1;
%     d2((j-1) * l + 1:j * l) = surf_ch2;
%     d3((j-1) * l + 1:j * l) = surf_ch3;
%     %i
% end
% t = [0:1:length(d1)-1];
% t = t/length(d1);
% t = t * 1 * 24;
% figure(1)
% % subplot(3,1,1),plot(t,d1),axis([0 24*1 -.5 .5]),set(gca,'fontsize',18),xlabel('时间(h)','fontsize',18),ylabel('加速度','fontsize',18)
% % subplot(3,1,2),plot(t,d2),axis([0 24*1 -.5 .5]),set(gca,'fontsize',18),xlabel('时间(h)','fontsize',18),ylabel('加速度','fontsize',18)
% % subplot(3,1,3),plot(t,d3),axis([0 24*1 -.5 .5]),set(gca,'fontsize',18),xlabel('时间(h)','fontsize',18),ylabel('加速度','fontsize',18)
% subplot(2,1,1),plot(t,d1),axis([0 24*1 -.5 .5]),xlabel('时间(h)','fontsize',13),ylabel('加速度','fontsize',13)
% subplot(2,1,2),plot(t,d3),axis([0 24*1 -.5 .5]),xlabel('时间(h)','fontsize',13),ylabel('加速度','fontsize',13)
% % subplot(3,1,3),plot(t,d3),axis([0 24*1 -.5 .5]),xlabel('时间(h)','fontsize',13),ylabel('加速度','fontsize',13)
% handle = get(gcf,'children');
% % axes(handle(3));title('3# NS');
% % axes(handle(2));title('3# EW');
% axes(handle(2));title('3# NS');
% axes(handle(1));title('3# UD');
%
% %滤波后
% Hd=lowpass2530;
% uch1=filter(Hd,under_ch1);
% uch2=filter(Hd,under_ch2);
% uch3=filter(Hd,under_ch3);
% sch1=filter(Hd,surf_ch1);
% sch2=filter(Hd,surf_ch2);
% sch3=filter(Hd,surf_ch3);
% figure(2)
% % subplot(3,1,1),plot(t,d1),axis([0 24*1 -.1 .1]),set(gca,'fontsize',18),xlabel('时间(h)','fontsize',18),ylabel('加速度','fontsize',18)
% % subplot(3,1,2),plot(t,d2),axis([0 24*1 -.15 .15]),set(gca,'fontsize',18),xlabel('时间(h)','fontsize',18),ylabel('加速度','fontsize',18)
% % subplot(3,1,3),plot(t,d3),axis([0 24*1 -.15 .15]),set(gca,'fontsize',18),xlabel('时间(h)','fontsize',18),ylabel('加速度','fontsize',18)
% subplot(2,1,1),plot(t,d1),axis([0 24*1 -.1 .1]),xlabel('时间(h)','fontsize',13),ylabel('加速度','fontsize',13)
% subplot(2,1,2),plot(t,d3),axis([0 24*1 -.15 .15]),xlabel('时间(h)','fontsize',13),ylabel('加速度','fontsize',13)
% % subplot(3,1,3),plot(t,d3),axis([0 24*1 -.15 .15]),xlabel('时间(h)','fontsize',13),ylabel('加速度','fontsize',13)
% handle = get(gcf,'children');
% % axes(handle(3));title('3# NS');
% % axes(handle(2));title('3# EW');
% axes(handle(2));title('3# NS');
% axes(handle(1));title('3# UD');

%%
%分离地铁成分画图
clear all
folder='3#\';
load('D:\szh\test\used-data\namelist\name_200.mat','name_200');

sf=200;
lu=100;
ls=100;
lag=1064;%200*-3.605; % 2# 10-04

[~,~,alpha_ch1] = get_alpha(lag,name_200,folder,6*7+1+144*(4-1),6*19+0+144*(4-1),lu,ls,'ch1');
Alpha_ch1 = ifft(alpha_ch1);
[~,~,alpha_ch2] = get_alpha(lag,name_200,folder,6*7+1+144*(4-1),6*19+0+144*(4-1),lu,ls,'ch2');
Alpha_ch2 = ifft(alpha_ch2);
[~,~,alpha_ch3] = get_alpha(lag,name_200,folder,6*7+1+144*(4-1),6*19+0+144*(4-1),lu,ls,'ch3');
Alpha_ch3 = ifft(alpha_ch3);

date = 6*12+1+144*(4-1);
load(['D:\szh\test\used-data\200#\',name_200{date}],'under_ch1','under_ch2','under_ch3');
load(['D:\szh\test\used-data\',folder,name_200{date}],'surf_ch1','surf_ch2','surf_ch3');

l=120000;
n=0:l-1;
n=n';
time=n/200;
f=n*sf/l;

l_Alpha = length(Alpha_ch1);
f_Alpha = [0:l_Alpha-1]/l_Alpha * sf;

Hd=lowpass1015;
uch1=filter(Hd,under_ch1);
uch2=filter(Hd,under_ch2);
uch3=filter(Hd,under_ch3);
sch1=filter(Hd,surf_ch1);
sch2=filter(Hd,surf_ch2);
sch3=filter(Hd,surf_ch3);

z1 = conv(Alpha_ch1,under_ch1);
z1_filtered = filter(Hd,z1);
z2 = conv(Alpha_ch2,under_ch2);
z2_filtered = filter(Hd,z2);
z3 = conv(Alpha_ch3,under_ch3);
z3_filtered = filter(Hd,z3);

% figure(100)
% subplot(2,1,1),plot(time,uch1),axis([0 600 -0.1 0.1]);
% subplot(2,1,2),plot(time,sch1),axis([0 600 -0.1 0.1]);
% handle = get(gcf,'children');
% axes(handle(2));title('地铁原始记录');
% axes(handle(1));title('地面原始记录');
% 
% figure(101)
% subplot(2,1,1),plot(time,uch1),axis([0 600 -0.1 0.1]);
% subplot(2,1,2),plot(time,z1_filtered(1:l)),axis([0 600 -0.03 0.03]);
% handle = get(gcf,'children');
% axes(handle(2));title('地铁原始记录');
% axes(handle(1));title('地面地铁成分');
% 
% figure(102)
% subplot(2,1,1),plot(time,sch1),axis([0 600 -0.1 0.1]);
% subplot(2,1,2),plot(time,z1_filtered(1:l)),axis([0 600 -0.03 0.03]);
% handle = get(gcf,'children');
% axes(handle(2));title('地面原始记录');
% axes(handle(1));title('地面地铁成分');
% 
% figure(103)
% subplot(2,1,1),plot(time,sch1),axis([0 600 -0.1 0.1]);
% subplot(2,1,2),plot(time,sch1 - z1_filtered(1+2:l+2)),axis([0 600 -0.05 0.05]);
% handle = get(gcf,'children');
% axes(handle(2));title('地面原始记录');
% axes(handle(1));title('地面其他成分');

figure(20)
subplot(4,1,1),plot(time,uch1),axis([0 600 -0.05 0.05]);
subplot(4,1,2),plot(time,z1_filtered(1+0:l+0)),axis([0 600 -0.05 0.05]);
subplot(4,1,3),plot(time,sch1),axis([0 600 -0.05 0.05]);
subplot(4,1,4),plot(time,sch1 - z1_filtered(1+0:l+0)),axis([0 600 -0.05 0.05]);
handle = get(gcf,'children');
axes(handle(4));title('地铁原始记录');
axes(handle(3));title('H*得到的地面地铁成分');
axes(handle(2));title('地面原始记录');
axes(handle(1));title('H*分离剩下的地面其他成分');
% 
% figure(21)
% subplot(4,1,1),plot(time,uch2),axis([0 600 -0.15 0.15]);
% subplot(4,1,2),plot(time,sch2),axis([0 600 -0.1 0.1]);
% subplot(4,1,3),plot(time,z2_filtered(1:l)),axis([0 600 -0.03 0.03]);
% subplot(4,1,4),plot(time,sch2 - z2_filtered(1+2:l+2)),axis([0 600 -0.1 0.1]);
% handle = get(gcf,'children');
% axes(handle(4));title('地铁原始记录');
% axes(handle(3));title('地面原始记录');
% axes(handle(2));title('地面地铁成分');
% axes(handle(1));title('地面其他成分');
% 
% figure(22)
% subplot(4,1,1),plot(time,uch3),axis([0 600 -0.15 0.15]);
% subplot(4,1,2),plot(time,sch3),axis([0 600 -0.1 0.1]);
% subplot(4,1,3),plot(time,z3_filtered(1:l)),axis([0 600 -0.03 0.03]);
% subplot(4,1,4),plot(time,sch3 - z3_filtered(1+2:l+2)),axis([0 600 -0.1 0.1]);
% handle = get(gcf,'children');
% axes(handle(4));title('地铁原始记录');
% axes(handle(3));title('地面原始记录');
% axes(handle(2));title('地面地铁成分');
% axes(handle(1));title('地面其他成分');

surf_under_ch1 = conv(Alpha_ch1,under_ch1);
cor_1 = xcorr(surf_ch1,surf_under_ch1);
[~,b] = max(cor_1);
test_lag_ch1 = b - length(surf_under_ch1);
surf_under_ch2 = conv(Alpha_ch2,under_ch2);
cor_2 = xcorr(surf_ch2,surf_under_ch2);
[~,b] = max(cor_2);
test_lag_ch2 = b - length(surf_under_ch2);
surf_under_ch3 = conv(Alpha_ch3,under_ch3);
cor_3 = xcorr(surf_ch3,surf_under_ch3);
[~,b] = max(cor_3);
test_lag_ch3 = b - length(surf_under_ch3);
if(test_lag_ch1 == test_lag_ch2 && test_lag_ch1 == test_lag_ch3)
    disp('same lag');
    test_lag = test_lag_ch1;
else
    disp('not same lag')
    test_lag = test_lag_ch1;
end




% if test_lag < 0
%     r_lag = l_Alpha + test_lag;
% end
Alpha_sss = zeros(l_Alpha,1);
r_lag = mod(test_lag,l_Alpha);
Alpha_sss(1:l_Alpha-r_lag) = Alpha_ch1(r_lag+1:l_Alpha);
Alpha_sss(l_Alpha-r_lag+1:l_Alpha) = Alpha_ch1(1:r_lag);

% if test_lag > 0
%     Alpha_sss(1:test_lag) = Alpha_ch1(l_Alpha-test_lag+1:l_Alpha);
%     Alpha_sss(test_lag+1:l_Alpha) = Alpha_ch1(1:l_Alpha-test_lag);
% elseif test_lag < 0
%     Alpha_sss(l_Alpha+test_lag+1:l_Alpha) = Alpha_ch1(1:-test_lag);
%     Alpha_sss(1:l_Alpha+test_lag) = Alpha_ch1(-test_lag+1:l_Alpha);
% end

surf_subway_ch1 = conv(Alpha_sss,under_ch1);
surf_subway_ch1_filtered = filter(Hd,surf_subway_ch1);
surf_other_ch1 = surf_ch1 - surf_subway_ch1(1:l);
surf_other_ch1_filtered = filter(Hd,surf_other_ch1);

% surf_subway_ch2 = conv(Alpha_sss,under_ch2);
% surf_subway_ch3 = conv(Alpha_sss,under_ch3);

% surf_other_ch2 = surf_ch2 - surf_subway_ch2(1:l);
% surf_other_ch3 = surf_ch3 - surf_subway_ch3(1:l);

% figure(200)
% subplot(4,1,1),plot(time,uch1),axis([0 600 -0.1 0.1]);
% subplot(4,1,2),plot(time,sch1),axis([0 600 -0.1 0.1]);
% subplot(4,1,3),plot(time,surf_subway_ch1_filtered(1:l)),axis([0 600 -0.03 0.03]);
% subplot(4,1,4),plot(time,sch1 - surf_subway_ch1_filtered(1:l)),axis([0 600 -0.1 0.1]);
% handle = get(gcf,'children');
% axes(handle(4));title('地铁原始记录');
% axes(handle(3));title('地面原始记录');
% axes(handle(2));title('地面地铁成分');
% axes(handle(1));title('地面其他成分');




%不滤波
% figure(300)
% subplot(4,1,1),plot(time,under_ch1),axis([0 600 -0.1 0.1]);
% subplot(4,1,2),plot(time,surf_ch1),axis([0 600 -0.15 0.15]);
% subplot(4,1,3),plot(time,surf_subway_ch1(1:l)),axis([0 600 -0.03 0.03]);
% subplot(4,1,4),plot(time,surf_other_ch1),axis([0 600 -0.15 0.15]);
% handle = get(gcf,'children');
% axes(handle(4));title('地铁原始记录');
% axes(handle(3));title('地面原始记录');
% axes(handle(2));title('地面地铁成分');
% axes(handle(1));title('地面其他成分');
% 
% figure(301)
% subplot(4,1,1),plot(time,under_ch2),axis([0 600 -0.15 0.15]);
% subplot(4,1,2),plot(time,surf_ch2),axis([0 600 -0.15 0.15]);
% subplot(4,1,3),plot(time,z2(1:l)),axis([0 600 -0.03 0.03]);
% subplot(4,1,4),plot(time,surf_ch2 - z2(1+2:l+2)),axis([0 600 -0.15 0.15]);
% handle = get(gcf,'children');
% axes(handle(4));title('地铁原始记录');
% axes(handle(3));title('地面原始记录');
% axes(handle(2));title('地面地铁成分');
% axes(handle(1));title('地面其他成分');
% 
% 
% figure(302)
% subplot(4,1,1),plot(time,under_ch3),axis([0 600 -0.15 0.15]);
% subplot(4,1,2),plot(time,surf_ch3),axis([0 600 -0.15 0.15]);
% subplot(4,1,3),plot(time,z3(1:l)),axis([0 600 -0.03 0.03]);
% subplot(4,1,4),plot(time,surf_ch3 - z3(1+2:l+2)),axis([0 600 -0.15 0.15]);
% handle = get(gcf,'children');
% axes(handle(4));title('地铁原始记录');
% axes(handle(3));title('地面原始记录');
% axes(handle(2));title('地面地铁成分');
% axes(handle(1));title('地面其他成分');


% for j=1:length(n)
%     if(f(j)>=20)
%         N=j-1;
%         break
%     end
% end
% figure(1)
% plot(f(1:N),abs(alpha(1:N)))

% span = 50;
% alpha_ch1_smoothed = smooth(abs(alpha_ch1),span);
% alpha_ch1_phase = alpha_ch1 ./ abs(alpha_ch1);
% alpha_ch1_smoothed = alpha_ch1_smoothed .* alpha_ch1_phase;

Hd = lowpass1015;
uuu = filter(Hd,under_ch1);
sss = filter(Hd,surf_ch1);
[~,b] = max(xcorr(sss,uuu));
my_lag = b-length(sss);

uch1 = under_ch1(1:end-my_lag);
sch1 = surf_ch1(1+my_lag:end);
xxx = uch1;
lll = length(xxx) + length(Alpha_ch1);
win = tukeywin(length(xxx),0.5);
u = fft(uch1 .* win,lll);
s = fft(sch1 .* win,lll);
phase = s ./ abs(s);
s_u = abs(u) .* abs(fft(ifftshift(Alpha_ch1),lll));
s_uuu = conv(Alpha_ch1,under_ch1);
% other = ifft(abs(abs(s) - s_u) .* phase);
other = ifft((abs(s) - s_u) .* phase);
left = ifft(s) - other;

test_time = [0:length(xxx)-1] / 200;

figure(3002)
subplot(4,1,1),plot(test_time,filter(Hd,uch1)),ylim([-0.05 0.05]);
subplot(4,1,2),plot(test_time,filter(Hd,s_uuu(1:length(xxx)))),ylim([-0.05 0.05]);
subplot(4,1,3),plot(test_time,filter(Hd,sch1)),ylim([-0.05 0.05]);
subplot(4,1,4),plot(test_time,filter(Hd,other(1:length(xxx)))),ylim([-0.05 0.05]);
handle_2 = get(gcf,'children');
axes(handle_2(4));title('地铁原始记录');
axes(handle_2(3));title('H*得到的地面地铁成分');
axes(handle_2(2));title('地面原始记录');
axes(handle_2(1));title('H*分离剩下的地面其他成分');

% span = 300;
% test = smooth(abs(fft(ifftshift(Alpha_ch1),lll)),span);
% 
% uch1 = under_ch1(1:end-my_lag);
% sch1 = surf_ch1(1+my_lag:end);
% xxx = uch1;
% lll = length(xxx) + length(Alpha_ch1);
% win = tukeywin(length(xxx),0.5);
% u = fft(uch1 .* win,lll);
% s = fft(sch1 .* win,lll);
% phase = s ./ abs(s);
% s_u = abs(u) .* abs(test);
% s_uuu = conv(Alpha_ch1,under_ch1);
% other = real(ifft(abs(abs(s) - s_u) .* phase));
% left = ifft(s) - other;
% 
% figure(3003)
% subplot(4,1,1),plot(test_time,filter(Hd,uch1)),ylim([-0.05 0.05]);
% subplot(4,1,2),plot(test_time,filter(Hd,s_uuu(1:length(xxx)))),ylim([-0.05 0.05]);
% subplot(4,1,3),plot(test_time,filter(Hd,sch1)),ylim([-0.05 0.05]);
% subplot(4,1,4),plot(test_time,filter(Hd,other(1:length(xxx)))),ylim([-0.05 0.05]);
% handle_3 = get(gcf,'children');
% axes(handle_3(4));title('地铁原始记录');
% axes(handle_3(3));title('H*得到的地面地铁成分');
% axes(handle_3(2));title('地面原始记录');
% axes(handle_3(1));title('H*分离剩下的地面其他成分');