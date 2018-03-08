%º∆À„alpha£¨Œ¥¬À≤®
clear all

folder='3#\';
% [name_200,name_3]=list('D:\szh\test\used-data\200#\',['D:\szh\test\used-data\',folder]);
load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
l1=length(name_200);
% for i=1:l1
%     if(strcmp(name_200{i},name_3{i})==0)
%         disp('name error');
%         return
%     end
% end
% clear name_3
sf=200;
lu=20;
ls=20;
lag=1065;% ±º‰—”≥Ÿ
sum_u=zeros(lu*sf+ls*sf-1,1);
sum_s=zeros(lu*sf+ls*sf-1,1);
% Hd=lowpass2530;

window_u = tukeywin(lu*sf,0.2);
window_s = tukeywin(ls*sf,0.2);

for i=(6*7+1+144*(4-1)):(6*19+144*(4-1))
% for i=(6*7+1+0):(6*19+0)
%     if(iii<=9)
%         if(strcmp(name_200{i},file{1}{iii})==1)
%             iii=iii+1;
%             continue
%         end
%     end
    if(strcmp(name_200{i},'1005103000.mat')==1 || strcmp(name_200{i},'1005104000.mat')==1 || strcmp(name_200{i},'1005105000.mat')==1)
        continue
    end
    load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
    load(['D:\szh\test\used-data\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
    if(length(under_ch1)~=length(surf_ch1) || length(under_ch2)~=length(surf_ch2) || length(under_ch3)~=length(surf_ch3))
        disp('length error');
        break
    end
%     under_ch2=filter(Hd,under_ch2);
%     surf_ch2=filter(Hd,surf_ch2);
    time=fix(600/ls);
    for k=1:time-2
        if((k*lu*sf+lag+ls*sf)>120000)
            continue
        end
        uch{k}=under_ch2((k*lu*sf+1):(k*lu*sf+lu*sf));
        sch{k}=surf_ch2((k*lu*sf+lag+1):(k*lu*sf+lag+ls*sf));

        uch{k} = uch{k} .* window_u;
        sch{k} = sch{k} .* window_s;
        
        uch{k}=[uch{k};zeros(ls*sf-1,1)];
        sch{k}=[sch{k};zeros(lu*sf-1,1)];
%         uch{k}=filter(Hd,uch{k});
%         sch{k}=filter(Hd,sch{k});
        fu{k}=fft(uch{k});
        fs{k}=fft(sch{k});
        sum_s=sum_s+fs{k}.*conj(fu{k});
        sum_u=sum_u+fu{k}.*conj(fu{k});
    end
end
alpha=sum_s./sum_u;
Alpha=ifft(alpha);
% Alpha=filter(Hd,Alpha);

% Hd=highpass105;
% Alpha=filter(Hd,Alpha);
% alpha=fft(Alpha);

n=0:(lu+ls)*sf-2;
n=n';
t=n/sf;
f=n*sf/(lu*sf+ls*sf-1);
for j=1:length(n)
    if(f(j)>=20)
        N=j-1;
        break
    end
end
figure(1)
plot(f,abs(alpha))
figure(2)
plot(t,Alpha)
figure(3)
plot(f(1:N),abs(alpha(1:N)))
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