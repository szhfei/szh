%人工合成数据，测试程序
clear all

under_folder = '200#\';
% under_folder = 'test_under\wgn(p=-43)\';

% noise_folder = 'noise_similar\';
noise_folder = 'noise_similar-2\';

% surf_folder = ['new100-',noise_folder];
% surf_folder = ['new100-similar--',noise_folder];
% surf_folder = ['doublepeak-',noise_folder];
surf_folder = ['0-15Hz-',noise_folder];




load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
l1=length(name_200);

count = 0;number = 1000;
sf=200;
lu=100;
ls=100;
lag=100;%时间延迟
sum_u=zeros(lu*sf+ls*sf-1,1);
sum_s=zeros(lu*sf+ls*sf-1,1);

window_u = tukeywin(lu*sf,0.5);
window_s = tukeywin(ls*sf,0.5);

for i=(6*7+1+144*(4-1)+0):(6*19+144*(4-1)+0)
    if(count > number)
        break;
    end
    load(['D:\szh\test\used-data\',under_folder,name_200{i}],'under_ch1','under_ch2','under_ch3');
    load(['D:\szh\test\used-data\test_surf\',surf_folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
    if(length(under_ch1)~=length(surf_ch1) || length(under_ch2)~=length(surf_ch2) || length(under_ch3)~=length(surf_ch3))
        disp('length error');
        break
    end
    %完全不重复叠加
    time=fix(600/ls);
    for k=1:time-2
        if((k*lu*sf+lag+ls*sf)>120000)
            continue
        end
        uch{k}=under_ch1((k*lu*sf+1):(k*lu*sf+lu*sf));
        sch{k}=surf_ch1((k*lu*sf+lag+1):(k*lu*sf+lag+ls*sf));
        
        uch{k} = uch{k} .* window_u;
        sch{k} = sch{k} .* window_s;
        
        uch{k}=[uch{k};zeros(ls*sf-1,1)];
        sch{k}=[sch{k};zeros(lu*sf-1,1)];
        fu{k}=fft(uch{k});
        fs{k}=fft(sch{k});
        sum_s=sum_s+fs{k}.*conj(fu{k});
        sum_u=sum_u+fu{k}.*conj(fu{k});
        count = count +1;
    end
end
alpha=sum_s./sum_u;
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

load(['D:\szh\test\used-data\test_alpha\',surf_folder,'Alpha_test.mat'],'Alpha_test');
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

Alpha_revise = zeros(lA,1);
if(lag == 0)
    Alpha_revise(1:lA) = Alpha(1:lA);
elseif(lag >= lA)
    Alpha_revise(1:lA) = Alpha(l-lag+1:l-lag+lA);
elseif(lag > 0)
    Alpha_revise(1:lag) = Alpha(l-lag+1:l);
    Alpha_revise(lag+1:lA) = Alpha(1:lA-lag);
elseif(lag < 0)
    Alpha_revise(1:lA) = Alpha(1+(-lag):lA+(-lag));
end
alpha_revise = fft(Alpha_revise);

% figure(20)
% plot(fA(1:NA),abs(alpha_test(1:NA)),fA(1:NA),abs(alpha_revise(1:NA)))
figure(21)
plot(fA,abs(alpha_test),fA,abs(alpha_revise),'linewidth',1.3),xlim([0 15]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('真实值','估计值')%,title('场地传递函数真实值与估计值对比')
span = 30;
alpha_revise_smoothed = smooth(abs(alpha_revise),span);
figure(22)
plot(fA,abs(alpha_test),fA,alpha_revise_smoothed,'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('真实值','估计值')%,title('场地传递函数真实值与估计值对比')
figure(23)
plot(tA,Alpha_test,tA,Alpha_revise)

figure(1)
plot(fA,abs(alpha_revise))
figure(2)
plot(tA,Alpha_revise)
% figure(3)
% plot(fA(1:NA),abs(alpha_revise(1:NA)))
figure(4)
plot(t,Alpha)

% figure(1)
% plot(f,abs(alpha))
% figure(2)
% plot(t,Alpha)
% figure(3)
% plot(f(1:N),abs(alpha(1:N)))

% figure(11)
% plot(fA(1:NA),abs(alpha_test(1:NA)),f(1:N),abs(alpha(1:N)),fA(1:NA),abs(alpha_revise(1:NA)))
figure(12)
plot(fA,abs(alpha_test),f,abs(alpha),fA,abs(alpha_revise))

%分离信号
date = 6*19+1+144*(4-1);
load(['D:\szh\test\used-data\200#\',name_200{date}],'under_ch1','under_ch2','under_ch3');
load(['D:\szh\test\used-data\test_surf\',surf_folder,name_200{date}],'surf_ch1','surf_ch2','surf_ch3');
load(['D:\szh\test\used-data\test_noise\',noise_folder,name_200{date}],'noise_ch1','noise_ch2','noise_ch3');

len = 120000;
n=0:len-1;
n=n';
time=n/200;

surf_subway_ch1 = conv(Alpha_revise,under_ch1);
surf_subway_ch2 = conv(Alpha_revise,under_ch2);
surf_subway_ch3 = conv(Alpha_revise,under_ch3);
surf_other_ch1 = surf_ch1 - surf_subway_ch1(1:len);
surf_other_ch2 = surf_ch2 - surf_subway_ch2(1:len);
surf_other_ch3 = surf_ch3 - surf_subway_ch3(1:len);
surf_left_ch1 = surf_other_ch1 - noise_ch1;
surf_left_ch2 = surf_other_ch2 - noise_ch2;
surf_left_ch3 = surf_other_ch3 - noise_ch3;
figure(200)
plot(surf_left_ch1)

% Alpha_z(1:lag) = Alpha(l-lag+1:l);
% Alpha_z(lag+1:l) = Alpha(1:l-lag);
% surf_subway_ch1 = conv(Alpha_z,under_ch1);
% surf_subway_ch2 = conv(Alpha_z,under_ch2);
% surf_subway_ch3 = conv(Alpha_z,under_ch3);
% surf_other_ch1 = surf_ch1 - surf_subway_ch1(1:len);
% surf_other_ch2 = surf_ch2 - surf_subway_ch2(1:len);
% surf_other_ch3 = surf_ch3 - surf_subway_ch3(1:len);
% surf_left_ch1 = surf_other_ch1 - noise_ch1;
% surf_left_ch2 = surf_other_ch2 - noise_ch2;
% surf_left_ch3 = surf_other_ch3 - noise_ch3;
% figure(201)
% plot(surf_left_ch1)

%用Alpha_revise分离的结果
% figure(1000)
% subplot(4,1,1),plot(time,under_ch1),axis([0 600 -0.2 0.2]);
% subplot(4,1,2),plot(time,surf_ch1),axis([0 600 -0.2 0.2]);
% subplot(4,1,3),plot(time,surf_subway_ch1(1:len)),axis([0 600 -0.1 0.1]);
% subplot(4,1,4),plot(time,surf_other_ch1(1:len)),axis([0 600 -0.2 0.2]);
% handle = get(gcf,'children');
% axes(handle(4));title('地铁原始记录');
% axes(handle(3));title('人造地面原始记录');
% axes(handle(2));title('地面地铁成分');
% axes(handle(1));title('地面其他成分');

sss = conv(Alpha,under_ch1);
cor = xcorr(surf_ch1,sss);
[a,b] = max(cor);
test_lag = b - length(sss);
if test_lag == lag
    disp('True lag')
end
r_lag = mod(test_lag,length(Alpha));
Alpha_sss = zeros(l,1);
Alpha_sss(1:r_lag) = Alpha(l-r_lag+1:l);
Alpha_sss(r_lag+1:l) = Alpha(1:l-r_lag);
s_u_ch1 = conv(Alpha_sss,under_ch1);
s_u_ch2 = conv(Alpha_sss,under_ch2);
s_u_ch3 = conv(Alpha_sss,under_ch3);
surf_subway_ch1 = s_u_ch1(1:len);
surf_subway_ch2 = s_u_ch2(1:len);
surf_subway_ch3 = s_u_ch3(1:len);
surf_other_ch1 = surf_ch1 - surf_subway_ch1;
surf_other_ch2 = surf_ch2 - surf_subway_ch2;
surf_other_ch3 = surf_ch3 - surf_subway_ch3;
surf_left_ch1 = surf_other_ch1 - noise_ch1;
surf_left_ch2 = surf_other_ch2 - noise_ch2;
surf_left_ch3 = surf_other_ch3 - noise_ch3;
figure(100)
plot(surf_left_ch1)

%用未截断的Alpha分离的结果
%ch1
figure(1001)
subplot(5,1,1),plot(time,under_ch1),axis([0 600 -0.2 0.2]);
subplot(5,1,2),plot(time,surf_ch1),axis([0 600 -0.2 0.2]);
subplot(5,1,3),plot(time,surf_subway_ch1),axis([0 600 -0.1 0.1]);
subplot(5,1,4),plot(time,surf_other_ch1),axis([0 600 -0.2 0.2]);
subplot(5,1,5),plot(time,surf_left_ch1),ylim([-0.008 0.008]);
handle_2 = get(gcf,'children');
axes(handle_2(5));title('人造地铁原始记录');
axes(handle_2(4));title('人造地面原始记录');
axes(handle_2(3));title('H*得到的地面地铁成分');
axes(handle_2(2));title('H*分离出的地面其他成分');
axes(handle_2(1));title('分离误差');

figure(1002)
subplot(3,1,1),plot(time,noise_ch1),axis([0 600 -0.2 0.2]);
subplot(3,1,2),plot(time,surf_other_ch1),axis([0 600 -0.2 0.2]);
subplot(3,1,3),plot(time,surf_left_ch1),ylim([-0.008 0.008]);
handle_2 = get(gcf,'children');
axes(handle_2(3));title('人造地面其他成分');
axes(handle_2(2));title('H*分离出的地面其他成分');
axes(handle_2(1));title('分离误差');

% %ch2
% figure(1001)
% subplot(5,1,1),plot(time,under_ch2),axis([0 600 -0.5 0.5]);
% subplot(5,1,2),plot(time,surf_ch2),axis([0 600 -0.5 0.5]);
% subplot(5,1,3),plot(time,surf_subway_ch2(1:len)),axis([0 600 -0.5 0.5]);
% subplot(5,1,4),plot(time,surf_other_ch2(1:len)),axis([0 600 -0.2 0.2]);
% subplot(5,1,5),plot(time,surf_left_ch2),ylim([-0.008 0.008]);
% handle = get(gcf,'children');
% axes(handle(5));title('人造地铁原始记录');
% axes(handle(4));title('人造地面原始记录');
% axes(handle(3));title('H*得到的地面地铁成分');
% axes(handle(2));title('H*分离出的地面其他成分');
% axes(handle(1));title('分离误差');
% figure(1002)
% subplot(3,1,1),plot(time,noise_ch2),axis([0 600 -0.2 0.2]);
% subplot(3,1,2),plot(time,surf_other_ch2(1:len)),axis([0 600 -0.2 0.2]);
% subplot(3,1,3),plot(time,surf_left_ch2),ylim([-0.008 0.008]);
% handle = get(gcf,'children');
% axes(handle(3));title('人造地面其他成分');
% axes(handle(2));title('H*分离出的地面其他成分');
% axes(handle(1));title('分离误差');

% %ch3
% figure(1001)
% subplot(5,1,1),plot(time,under_ch3),axis([0 600 -0.5 0.5]);
% subplot(5,1,2),plot(time,surf_ch3),axis([0 600 -0.5 0.5]);
% subplot(5,1,3),plot(time,surf_subway_ch3(1:len)),axis([0 600 -0.5 0.5]);
% subplot(5,1,4),plot(time,surf_other_ch3(1:len)),axis([0 600 -0.2 0.2]);
% subplot(5,1,5),plot(time,surf_left_ch3),ylim([-0.008 0.008]);
% handle = get(gcf,'children');
% axes(handle(5));title('人造地铁原始记录');
% axes(handle(4));title('人造地面原始记录');
% axes(handle(3));title('H*得到的地面地铁成分');
% axes(handle(2));title('H*分离出的地面其他成分');
% axes(handle(1));title('分离误差');
% figure(1002)
% subplot(3,1,1),plot(time,noise_ch3),axis([0 600 -0.2 0.2]);
% subplot(3,1,2),plot(time,surf_other_ch3(1:len)),axis([0 600 -0.2 0.2]);
% subplot(3,1,3),plot(time,surf_left_ch3),ylim([-0.008 0.008]);
% handle = get(gcf,'children');
% axes(handle(3));title('人造地面其他成分');
% axes(handle(2));title('H*分离出的地面其他成分');
% axes(handle(1));title('分离误差');


%滤波
Hd = lowpass1015;
uch1 = filter(Hd,under_ch1);
sch1 = filter(Hd,surf_ch1);
s_u_ch1_filtered = filter(Hd,surf_subway_ch1);
s_other_ch1_filtered = filter(Hd,surf_other_ch1);
s_left_ch1_filtered = filter(Hd,surf_left_ch1);
noise_ch1_filterd = filter(Hd,noise_ch1);

%用未截断的Alpha分离的结果
%ch1
s_origin = conv(Alpha_test,under_ch1);
s_origin_filtered = filter(Hd,s_origin(1:120000));
figure(2000)
subplot(4,1,1),plot(time,uch1),axis([0 600 -0.05 0.05]);
subplot(4,1,2),plot(time,s_origin_filtered),axis([0 600 -0.05 0.05]);
subplot(4,1,3),plot(time,noise_ch1_filterd),axis([0 600 -0.05 0.05]);
subplot(4,1,4),plot(time,sch1),axis([0 600 -0.05 0.05]);
handle_1 = get(gcf,'children');
axes(handle_1(4));title('人造地铁原始记录');
axes(handle_1(3));title('人造地面地铁成分');
axes(handle_1(2));title('人造地面其他成分');
axes(handle_1(1));title('人造地面原始记录');

figure(2001)
subplot(5,1,1),plot(time,uch1),axis([0 600 -0.05 0.05]);
subplot(5,1,2),plot(time,s_u_ch1_filtered),axis([0 600 -0.05 0.05]);
subplot(5,1,3),plot(time,sch1),axis([0 600 -0.05 0.05]);
subplot(5,1,4),plot(time,s_other_ch1_filtered),axis([0 600 -0.05 0.05]);
subplot(5,1,5),plot(time,noise_ch1_filterd),axis([0 600 -0.05 0.05]);
handle_1 = get(gcf,'children');
axes(handle_1(5));title('人造地铁原始记录');
axes(handle_1(4));title('H*得到的地面地铁成分');
axes(handle_1(3));title('人造地面原始记录');
axes(handle_1(2));title('H*分离出的地面其他成分');
axes(handle_1(1));title('人造地面其他成分');


%幅值谱直接减尝试分离
test_u_ch1 = fft(under_ch1,159998);
test_s_ch1 = fft(surf_ch1,159998);
test_s_u_ch1 = abs(test_u_ch1) .* abs(fft(Alpha,159998));
test_phase_ch1 = test_s_ch1 ./ abs(test_s_ch1);
test_other_ch1 = ifft(abs(abs(test_s_ch1) - test_s_u_ch1) .* test_phase_ch1);
xxx_ch1 = ifft(test_s_ch1) - test_other_ch1;

figure(2002)
subplot(5,1,1),plot(time,filter(Hd,under_ch1)),axis([0 600 -0.05 0.05]);
subplot(5,1,2),plot(time,filter(Hd,xxx_ch1(1:len))),axis([0 600 -0.05 0.05]);
subplot(5,1,3),plot(time,filter(Hd,surf_ch1)),axis([0 600 -0.05 0.05]);
subplot(5,1,4),plot(time,filter(Hd,test_other_ch1(1:len))),axis([0 600 -0.05 0.05]);
subplot(5,1,5),plot(time,noise_ch1_filterd),axis([0 600 -0.05 0.05]);
handle_2 = get(gcf,'children');
axes(handle_2(5));title('人造地铁原始记录');
axes(handle_2(4));title('H*得到的地面地铁成分');
axes(handle_2(3));title('人造地面原始记录');
axes(handle_2(2));title('H*分离剩下的地面其他成分');
axes(handle_1(1));title('人造地面其他成分');
