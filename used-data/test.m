%测试其他迭代方法
clear all

folder='3#\';
% [name_200,name_3]=list('D:\szh\test\used-data\200#\',['D:\szh\test\used-data\',folder]);
load('D:\szh\test\used-data\namelist\name_200.mat','name_200');

sf=200;
lu=20;
ls=20;
lag=1059;%时间延迟
sum_u=zeros(lu*sf+ls*sf-1,1);
sum_s=zeros(lu*sf+ls*sf-1,1);


window_u = tukeywin(lu*sf,0.5);
window_s = tukeywin(ls*sf,0.5);

count = 0;
for i=(6*7+1+144*(4-1)):(6*19+144*(4-1))
    if(strcmp(name_200{i},'1005103000.mat')==1 || strcmp(name_200{i},'1005104000.mat')==1 || strcmp(name_200{i},'1005105000.mat')==1)
        continue
    end
    load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
    load(['D:\szh\test\used-data\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');

    cor = xcorr(surf_ch1,under_ch1);
    [~,b] = max(cor);
    lag = b - length(under_ch1);
    
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
%         uch{k}=filter(Hd,uch{k});
%         sch{k}=filter(Hd,sch{k});
        fu{k}=fft(uch{k});
        fs{k}=fft(sch{k});
        
%         sum_s=sum_s+fs{k}.*conj(fu{k});
%         sum_u=sum_u+fu{k}.*conj(fu{k});

%         sum_s=sum_s+abs(fs{k}.*conj(fu{k}));
%         sum_u=sum_u+abs(fu{k}.*conj(fu{k}));
        sum_s = sum_s + (fs{k}.*conj(fu{k})) ./ (fu{k}.*conj(fu{k}));

        count = count +1;
    end
end
% alpha=sum_s./sum_u;
alpha = sum_s / count;
Alpha=ifft(alpha);


% Hd=highpass105;
% Alpha=filter(Hd,Alpha);
% alpha=fft(Alpha);

n=0:(lu+ls)*sf-2;
n=n';
t=n/sf;
f=n*sf/(lu*sf+ls*sf-1);

figure(1)
plot(f,abs(alpha))
figure(2)
plot(t,Alpha)
figure(3)
plot(f,abs(alpha)),xlim([0 15]),ylim([0 2.5])
% figure(4)
% plot(t,ifft(alpha*(lu*sf+ls*sf-1)))

% AlphaCut=Alpha(1:(ls*sf-lu*sf));
% alphaCut=fft(AlphaCut);
% NA=0:length(AlphaCut)-1;
% NA=NA';
% t=NA/sf;
% f=NA*sf/(length(AlphaCut)+1);
% for j=1:length(n)
%     if(f(j)>=30)
%         N=j;
%         break
%     end
% end
% figure(4)
% plot(f,abs(alphaCut))
% figure(5)
% plot(t,AlphaCut)
% figure(6)
% plot(f(1:N),abs(alphaCut(1:N)))