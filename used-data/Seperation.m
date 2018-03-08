%频域相减迭代分离
%10-04 07-19数据测试
clear all
folder = '2#10-04-07-19\';
% folder = '2#10-04-07-19\';

sf=200;
lu=20;
ls=20;
lag=000;%时间延迟
day = 4;
t1 = 6*7+1+144*(4-1);
t2 = 6*19+0+144*(4-1);

channel = 'ch3';

load(['D:\szh\test\used-data\test\',folder,'s',channel,'.mat']);
load(['D:\szh\test\used-data\test\',folder,'u',channel,'.mat']);
if(strcmp(channel,'ch1') == 1)
    uch = uch1;clear uch1;
    sch = sch1;clear sch1;
elseif(strcmp(channel,'ch2') == 1)
    uch = uch2;clear uch2;
    sch = sch2;clear sch2;
elseif(strcmp(channel,'ch3') == 1)
    uch = uch3;clear uch3;
    sch = sch3;clear sch3;
end


alpha_initial=test_iter_alpha(uch,sch,day,t1,t2,lu,ls,channel);
Alpha_initial=ifft(alpha_initial);

l = (lu+ls)*sf-1;
n=0:l-1;
n=n';
t=n/sf;
f=n*sf/l;
figure(1)
plot(f,abs(alpha_initial)),xlim([0.1 25])


count = 5;
istart = 120000*(5+6*0)+1+20000;%0700-0710
iend = istart + 120000-1;

lll = length(sch) + length(Alpha_initial) - 1;
%地表相位
fsch = fft(sch,lll);
phase = fsch ./ abs(fsch);
% %地铁相位
% fuch = fft(uch,lll);
% phase = fuch ./ abs(fuch);

sch_left = myfreq(uch,sch,fftshift(Alpha_initial),phase);
u = uch(istart:iend);
s = sch(istart:iend);
s_left{1} = sch_left(istart:iend);
alpha_left{1}=test_iter_alpha(uch,sch_left,day,t1,t2,lu,ls,channel);

for i = 2:count
    Alpha_left{i-1} = ifft(alpha_left{i-1});
    sch_left = myfreq(uch,sch_left,fftshift(Alpha_left{i-1}),phase);
    s_left{i} = sch_left(istart:iend);
    alpha_left{i}=test_iter_alpha(uch,sch_left,day,t1,t2,lu,ls,channel);
    i
end

% for i = 1:count
% figure(100+i)
% plot(f,abs(alpha_left{i})),xlim([0 15]),ylim([0 .7])
% end


Hd = bandpass2_6;
% Hd = bandpass2_10;
% for i = 1:count
% figure(200+i)
% plot(filter(Hd,s_left{i})),ylim([-.04 .04])
% end

time = [0:120000-1]'/200;
% for i = 1:count
% figure(300+i)
% subplot(3,1,1),plot(time,filter(Hd,u)),ylim([-0.03 0.03]);
% % subplot(4,1,2),plot(time,filter(Hd,s_u{i})),ylim([-0.03 0.03]);
% subplot(3,1,2),plot(time,filter(Hd,s)),ylim([-0.03 0.03]);
% subplot(3,1,3),plot(time,filter(Hd,s_left{i})),ylim([-0.03 0.03]);
% handle_2 = get(gcf,'children');
% axes(handle_2(3));title('地铁原始记录');
% % axes(handle_2(3));title('地面地铁成份');
% axes(handle_2(2));title('地面原始记录');
% axes(handle_2(1));title('分离剩下的地面其他成份');
% end

% %%传递函数直接相加
% test{1} = alpha_initial;
% for i = 1:count
% test{i+1} = test{i} + alpha_left{i};
% Atest{i} = ifft(test{i});
% sch_other{i} = myfreq(uch,sch,ifftshift(Atest{i}));
% res{i} = sch_other{i}(istart:iend);
% end

%%传递函数绝对值相加
phase_alpha = alpha_initial ./ abs(alpha_initial);
test{1} = abs(alpha_initial);
for i = 1:count
test{i+1} = test{i} + abs(alpha_left{i});
Atest{i} = ifft(test{i} .* phase_alpha);
sch_other{i} = myfreq(uch,sch,fftshift(Atest{i}),phase);
res{i} = sch_other{i}(istart:iend);
end


% figure(400)
% subplot(3,1,1),plot(time,filter(Hd,u)),ylim([-0.03 0.03]);
% % subplot(4,1,2),plot(time,filter(Hd,s_u{i})),ylim([-0.03 0.03]);
% subplot(3,1,2),plot(time,filter(Hd,s)),ylim([-0.03 0.03]);
% subplot(3,1,3),plot(time,filter(Hd,res{2})),ylim([-0.03 0.03]);
% handle_2 = get(gcf,'children');
% axes(handle_2(3));title('地铁原始记录');
% % axes(handle_2(3));title('地面地铁成份');
% axes(handle_2(2));title('地面原始记录');
% axes(handle_2(1));title('分离剩下的地面其他成份');

figure(2000)%每次迭代分离，地面其他成分
for i=1:count
    subplot(count,1,i),plot(time,filter(Hd,s_left{i})),ylim([-0.03 0.03]),ylabel('加速度/gal','fontsize',12);
end
xlabel('时间/s','fontsize',12)
handle_4 = get(gcf,'children');
axes(handle_4(5));title('最初传递函数直接分离，地面其他成分');
axes(handle_4(4));title('第一次迭代后，地面其他成分');
axes(handle_4(3));title('第二次迭代后，地面其他成分');
axes(handle_4(2));title('第三次迭代后，地面其他成分');
axes(handle_4(1));title('第四次迭代后，地面其他成分');

% figure(3000)%前n次迭代分离，地面其他成分
% for i=1:count
%     subplot(count,1,i),plot(time,filter(Hd,res{i})),ylim([-0.03 0.03]);
% end

cor = zeros(count,1);
for i = 1:count
    cor(i) = corr(filter(Hd,s_left{i}),filter(Hd,s-s_left{i}));
end
% figure(4000)
% plot([0:count-1]',abs(cor),'-p'),xlabel('迭代次数','fontsize',22),ylabel('相关系数绝对值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('地面地铁成分与地面其他成分相关系数')

figure(4001)
plot([0:count-1]',cor,'-p',[0:count-1]',abs(cor),'-p'),xlabel('迭代次数','fontsize',22)...
    ,set(gca,'fontsize',22),set(gca,'xtick',[0:4]),legend('相关系数','相关系数绝对值'),title('地面地铁成分与地面其他成分相关系数')

[~,aaa] = min(abs(cor));
figure(1000)
subplot(4,1,1),plot(time,filter(Hd,u)),ylim([-0.03 0.03]),ylabel('加速度/gal','fontsize',12);
subplot(4,1,2),plot(time,filter(Hd,s)),ylim([-0.03 0.03]),ylabel('加速度/gal','fontsize',12);
subplot(4,1,3),plot(time,filter(Hd,s-res{aaa})),ylim([-0.03 0.03]),ylabel('加速度/gal','fontsize',12);
subplot(4,1,4),plot(time,filter(Hd,res{aaa})),ylim([-0.03 0.03]),ylabel('加速度/gal','fontsize',12),xlabel('时间/s','fontsize',12);
handle_2 = get(gcf,'children');
axes(handle_2(4));title('地铁振动信号');
axes(handle_2(3));title('地面振动信号');
axes(handle_2(2));title('地面振动的地铁成份');
axes(handle_2(1));title('分离剩下的地面振动的其他成份');

figure(1001)
plot(f,abs(alpha_initial),f,abs(test{aaa})),xlim([.1 25]),xlabel('f/Hz','fontsize',22),ylabel('幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('最初得到的传递函数幅值','最终迭代后的传递函数幅值'),set(gca,'xtick',[0.1 5 10 15 20 25])

% figure(1002)
% subplot(3,1,1),plot(time,filter(Hd,s_left{aaa})),ylim([-0.03 0.03]);
% subplot(3,1,2),plot(time,filter(Hd,res{aaa})),ylim([-0.03 0.03]);
% subplot(3,1,3),plot(time,s_left{aaa}-res{aaa}),ylim([-0.03 0.03]);
% handle_3 = get(gcf,'children');
% axes(handle_3(3));title('多次迭代后分离出的地表其他成份');
% axes(handle_3(2));title('迭代中得到的传递函数相加，一次性分离出的地表其他成份');
% axes(handle_3(1));title('两者之差');
% 
% figure(100)
% plot(f,abs(alpha_initial),f,abs(alpha_left{1}),f,abs(alpha_left{2}),f,abs(alpha_left{3}),f,abs(alpha_left{4})),xlim([0.1 25])...
%     ,xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22),set(gca,'fontsize',22)...
%     ,legend('最初传递函数','第1次迭代','第2次迭代','第3次迭代','第4次迭代'),title('每次得到的传递函数')



% alpha_final = test{aaa};
% save(['D:\szh\test\used-data\test\result\',folder,channel,'.mat'],'alpha_initial','alpha_final');
