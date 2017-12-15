%人工合成数据，测试程序
clear all

% under_folder = '200#\';
under_folder = 'test_under\wgn(p=-43)\';

% surf_folder = '0-100Hz-noise_similar-2\';
surf_folder = '0-15Hz-noise_similar-2\';
% surf_folder = 'doublepeak-noise-similar-2\';
% surf_folder = 'new100-similar--noise_similar-2\';
% folder = 'doublepeak-5s+5s_0\';
% surf_folder = 'doublepeak-5s\';
% folder='new100\';
% folder='3#10-04-07-19-ch2-change\';
% [name_200,name_3]=list('D:\szh\test\used-data\200#\',['D:\szh\test\used-data\',folder]);
load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
l1=length(name_200);

count = 0;number = 10000;
sf=200;
lu=20;
ls=20;
lag=700;%时间延迟
sum_u=zeros(lu*sf+ls*sf-1,1);
sum_s=zeros(lu*sf+ls*sf-1,1);

window_u = tukeywin(lu*sf,0.5);
window_s = tukeywin(ls*sf,0.5);

for i=(6*7+1+144*(4-1)+0):(6*19+144*(7-1)+0)
    if(count > number)
        break;
    end
    load(['D:\szh\test\used-data\',under_folder,name_200{i}],'under_ch1','under_ch2','under_ch3');
    load(['D:\szh\test\used-data\test_surf\',surf_folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');

%     cor = xcorr(surf_ch1,under_ch1);
%     [~,b] = max(cor);
%     lag = b - length(under_ch1);
    
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

%         sum_s=sum_s+abs(fs{k}.*conj(fu{k}));
%         sum_u=sum_u+abs(fu{k}.*conj(fu{k}));
%         sum_s = sum_s + (fs{k}.*conj(fu{k})) ./ (fu{k}.*conj(fu{k}));

        count = count +1;
    end
    %部分重复叠加，没有用
%     shift = 5;
%     k = ls;
%     while(k < 600 - ls)
%         uch{k}=under_ch1((k*sf+1):(k*sf+lu*sf));
%         sch{k}=surf_ch1((k*sf+lag+1):(k*sf+lag+ls*sf));
%         uch{k}=[uch{k};zeros(ls*sf-1,1)];
%         sch{k}=[sch{k};zeros(lu*sf-1,1)];
%         fu{k}=fft(uch{k});
%         fs{k}=fft(sch{k});
%         sum_s=sum_s+fs{k}.*conj(fu{k});
%         sum_u=sum_u+fu{k}.*conj(fu{k});
%         k = k + shift;
%         count = count + 1;
%     end
end
alpha=sum_s./sum_u;
% alpha = sum_s / count;
Alpha=ifft(alpha);
% Alpha=filter(Hd,Alpha);

% Hd=highpass105;
% Alpha=filter(Hd,Alpha);
% alpha=fft(Alpha);

%以下修正计算的alpha并画图
l = (lu+ls)*sf-1;
n=0:l-1;
n=n';
t=n/sf;
f=n*sf/l;


load(['D:\szh\test\used-data\test_alpha\',surf_folder,'Alpha_test.mat'],'Alpha_test');
alpha_test = fft(Alpha_test);
lA = length(Alpha_test);
nA = 0:lA-1;
nA = nA';
tA = nA / sf;
fA = nA * sf / lA;


Alpha_revise = zeros(lA,1);
if(lag == 0)
    Alpha_revise(1:lA) = Alpha(1:lA);
elseif(lag >= lA)
    Alpha_revise(1:lA) = Alpha(l-lag+1:l-lag+lA);
else
    Alpha_revise(1:lag) = Alpha(l-lag+1:l);
    Alpha_revise(lag+1:lA) = Alpha(1:lA-lag);
end
alpha_revise = fft(Alpha_revise);

% figure(20)
% plot(fA(1:NA),abs(alpha_test(1:NA)),fA(1:NA),abs(alpha_revise(1:NA)))
figure(21)
plot(fA,abs(alpha_test),fA,abs(alpha_revise),'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('真实值','估计值')%,title('场地传递函数真实值与估计值对比')
% span = 30;
% alpha_revise_smoothed = smooth(abs(alpha_revise),span);
% figure(22)
% plot(fA,abs(alpha_test),fA,alpha_revise_smoothed,'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('真实值','估计值')%,title('场地传递函数真实值与估计值对比')
% alpha_smoothed = smooth(abs(alpha),span);
% figure(23)
% plot(fA,abs(alpha_test),f,alpha_smoothed,'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('真实值','估计值')%,title('场地传递函数真实值与估计值对比')
figure(24)
plot(tA,Alpha_test,tA,Alpha_revise)

% figure(1)
% plot(fA,abs(alpha_revise))
% figure(2)
% plot(tA,Alpha_revise)
figure(3)
plot(t,Alpha)




figure(12)
plot(fA,abs(alpha_test),f,abs(alpha),fA,abs(alpha_revise))


% %尝试传递函数时窗不同长度
% len = 2000;
% Alpha_zzz = zeros(len,1);
% if(len >= lA)
%     if(lag == 0)
%         Alpha_zzz(1:len) = Alpha(1:len);
%     elseif(lag >= lA && lag < len)
%         Alpha_zzz(1:lA) = Alpha(l-lag+1:l-lag+lA);
%         % not finished
%     elseif(lag >= len)
%         Alpha_zzz(1:len) = Alpha(l-lag+1:l-lag+len);
%     else
%         Alpha_zzz(1:lag) = Alpha(l-lag+1:l);
%         Alpha_zzz(lag+1:lA) = Alpha(1:lA-lag);
%         Alpha_zzz(lA+1:len) = Alpha(lA-lag+1:len-lag);
%     end
% else
%     if(lag == 0)
%         Alpha_zzz(1:len) = Alpha(1:len);
%     elseif(lag >= len)
%         Alpha_zzz(1:len) = Alpha(l-lag+1:l-lag+len);
%     else
%         Alpha_zzz(1:lag) = Alpha(l-lag+1:l);
%         Alpha_zzz(lag+1:len) = Alpha(1:len-lag);
%     end
% end
% alpha_zzz = fft(Alpha_zzz);
% nlen = 0:len-1;
% nlen = nlen';
% tlen = nlen / sf;
% flen = nlen * sf / len;
% for j=1:length(n)
%     if(flen(j)>=20)
%         Nlen=j-1;
%         break
%     end
% end
% figure(100)
% plot(f,abs(alpha),fA,abs(alpha_revise),flen,abs(alpha_zzz))
% figure(101)
% plot(fA,abs(alpha_revise),flen,abs(alpha_zzz),fA,abs(alpha_test))

%画误差图
% error_ab = abs(abs(alpha_test)-alpha_revise_smoothed);
% error_re = error_ab ./ abs(alpha_test);
% % figure(200)
% % plot(fA,error_ab)
% figure(201)
% plot(fA,error_re),axis([0 100 0 0.2])


zzz = fftshift(Alpha);
cut = 3000;
fcut = [0:cut-1]'/cut*200;
Alpha_cut = zzz((l-1)/2-lag+1:(l-1)/2-lag+cut);
alpha_cut = fft(Alpha_cut);
figure(100)
plot(fA,abs(alpha_test),fcut,abs(alpha_cut),'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('真实值','截断值')%,title('场地传递函数真实值与估计值对比')
%相位误差
p1 = angle(fft(Alpha_test,cut));
p2 = angle(alpha_cut);
p = p1 - p2;
for i = 1:length(Alpha_cut)
    while(p(i)>pi)
        p(i) = p(i)- 2*pi;
    end
    while(p(i)<-pi)
        p(i) = p(i)+ 2*pi;
    end
end
figure(300)
plot(fcut,p1,fcut,p2)

p1_revise = angle(alpha_test);
p2_revise = angle(alpha_revise);
pp = p1_revise - p2_revise;
for i = 1:length(Alpha_test)
    while(pp(i)>pi)
        pp(i) = pp(i)- 2*pi;
    end
    while(pp(i)<-pi)
        pp(i) = pp(i)+ 2*pi;
    end
end
figure(301)
plot(fA,angle(alpha_test),fA,angle(alpha_revise))