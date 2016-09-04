%计算alpha，反褶积
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
lu=15;
ls=20;
lag=1090;%时间延迟
sum_u=zeros(lu*sf+lu*sf-1,1);
sum_s=zeros(lu*sf+ls*sf-1,1);
Hd=lowpass2530;
%     fid=fopen('problem.txt','r');
%     file=textscan(fid,'%s');
%     fclose(fid);
%     iii=1;
for i=6*7+1+0:6*22+0
%     if(iii<=9)
%         if(strcmp(name_200{i},file{1}{iii})==1)
%             iii=iii+1;
%             continue
%         end
%     end
    load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch2');
    load(['D:\szh\test\used-data\',folder,name_200{i}],'surf_ch2');
    if(length(under_ch2)~=length(surf_ch2))
        disp('length error');
        break
    end
    time=fix(600/ls);
    for k=1:time-2
        uch{k}=under_ch2((k*lu*sf+1):(k*lu*sf+lu*sf));
        sch{k}=surf_ch2((k*lu*sf+lag+1):(k*lu*sf+lag+ls*sf));
%         uch{k}=[uch{k};zeros(ls*sf-1,1)];
%         sch{k}=[sch{k};zeros(lu*sf-1,1)];
%         fu{k}=fft(uch{k});
%         fs{k}=fft(sch{k});
%         sum_s=sum_s+fs{k}.*conj(fu{k});
%         sum_u=sum_u+fu{k}.*conj(fu{k});
        fa{k}=xcorr(sch{k},uch{k});
        fb{k}=xcorr(uch{k},uch{k});
        sum_s=sum_s+fa{k};%(1001:7999,1);
        sum_u=sum_u+fb{k};
    end
end
% alpha=sum_s./sum_u;
% Alpha=ifft(alpha);
[alpha,e]=deconv(sum_s,sum_u);
plot(alpha)

% n=0:(lu+ls)*sf-2;
% n=n';
% t=n/sf;
% f=n*sf/(lu*sf+ls*sf);
% for j=1:length(n)
%     if(f(j)>=30)
%         N=j;
%         break
%     end
% end
% figure(1)
% plot(f,abs(alpha))
% figure(2)
% plot(t,Alpha)
% figure(3)
% plot(f(1:N),abs(alpha(1:N)))