%计算alpha，多天叠加,弃用
clear all

folder='3#\';
load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
l1=length(name_200);

sf=200;
lu=50;
ls=50;
lag=0;%时间延迟
sum_u=zeros(lu*sf+ls*sf-1,1);
sum_s=zeros(lu*sf+ls*sf-1,1);
% Hd=lowpass2530;
%     fid=fopen('problem.txt','r');
%     file=textscan(fid,'%s');
%     fclose(fid);
%     iii=1;
% for i=(6*7+1+144*(2-1)):(6*11+144*(2-1))
%     load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
%     load(['D:\szh\test\used-data\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
%     if(length(under_ch1)~=length(surf_ch1) || length(under_ch2)~=length(surf_ch2) || length(under_ch3)~=length(surf_ch3))
%         disp('length error');
%         break
%     end
% 
%     time=fix(600/ls);
%     for k=1:time-2
%         if((k*lu*sf+lag+ls*sf)>120000)
%             continue
%         end
%         uch{k}=under_ch2((k*lu*sf+1):(k*lu*sf+lu*sf));
%         sch{k}=surf_ch2((k*lu*sf+lag+1):(k*lu*sf+lag+ls*sf));
%         uch{k}=[uch{k};zeros(ls*sf-1,1)];
%         sch{k}=[sch{k};zeros(lu*sf-1,1)];
% 
%         fu{k}=fft(uch{k});
%         fs{k}=fft(sch{k});
%         sum_s=sum_s+fs{k}.*conj(fu{k});
%         sum_u=sum_u+fu{k}.*conj(fu{k});
%     end
% end
% for i=(6*7+1+144*(4-1)):(6*19+144*(4-1))
%     load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
%     load(['D:\szh\test\used-data\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
%     if(length(under_ch1)~=length(surf_ch1) || length(under_ch2)~=length(surf_ch2) || length(under_ch3)~=length(surf_ch3))
%         disp('length error');
%         break
%     end
% 
%     time=fix(600/ls);
%     for k=1:time-2
%         if((k*lu*sf+lag+ls*sf)>120000)
%             continue
%         end
%         uch{k}=under_ch2((k*lu*sf+1):(k*lu*sf+lu*sf));
%         sch{k}=surf_ch2((k*lu*sf+lag+1):(k*lu*sf+lag+ls*sf));
%         uch{k}=[uch{k};zeros(ls*sf-1,1)];
%         sch{k}=[sch{k};zeros(lu*sf-1,1)];
% 
%         fu{k}=fft(uch{k});
%         fs{k}=fft(sch{k});
%         sum_s=sum_s+fs{k}.*conj(fu{k});
%         sum_u=sum_u+fu{k}.*conj(fu{k});
%     end
% end
s6=zeros(lu*sf+ls*sf-1,1);
u6=zeros(lu*sf+ls*sf-1,1);
for i=(6*7+1+144*(6-1)):(6*19+144*(6-1))
    load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
    load(['D:\szh\test\used-data\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
    if(length(under_ch1)~=length(surf_ch1) || length(under_ch2)~=length(surf_ch2) || length(under_ch3)~=length(surf_ch3))
        disp('length error');
        break
    end

    time=fix(600/ls);
    for k=1:time-2
        if((k*lu*sf+lag+ls*sf)>120000)
            continue
        end
        uch{k}=under_ch1((k*lu*sf+1):(k*lu*sf+lu*sf));
        sch{k}=surf_ch1((k*lu*sf+lag+1):(k*lu*sf+lag+ls*sf));
        uch{k}=[uch{k};zeros(ls*sf-1,1)];
        sch{k}=[sch{k};zeros(lu*sf-1,1)];

        fu{k}=fft(uch{k});
        fs{k}=fft(sch{k});
%         s6=s6+fs{k}.*conj(fu{k});
%         u6=u6+fu{k}.*conj(fu{k});
        sum_s=sum_s+fs{k}.*conj(fu{k});
        sum_u=sum_u+fu{k}.*conj(fu{k});
    end
end
s7=zeros(lu*sf+ls*sf-1,1);
u7=zeros(lu*sf+ls*sf-1,1);
for i=(6*7+1+144*(7-1)):(6*19+144*(7-1))
    load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
    load(['D:\szh\test\used-data\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
    if(length(under_ch1)~=length(surf_ch1) || length(under_ch2)~=length(surf_ch2) || length(under_ch3)~=length(surf_ch3))
        disp('length error');
        break
    end

    time=fix(600/ls);
    for k=1:time-2
        if((k*lu*sf+lag+ls*sf)>120000)
            continue
        end
        uch{k}=under_ch1((k*lu*sf+1):(k*lu*sf+lu*sf));
        sch{k}=surf_ch1((k*lu*sf+lag+1):(k*lu*sf+lag+ls*sf));
        uch{k}=[uch{k};zeros(ls*sf-1,1)];
        sch{k}=[sch{k};zeros(lu*sf-1,1)];

        fu{k}=fft(uch{k});
        fs{k}=fft(sch{k});
%         s7=s7+fs{k}.*conj(fu{k});
%         u7=u7+fu{k}.*conj(fu{k});
        sum_s=sum_s+fs{k}.*conj(fu{k});
        sum_u=sum_u+fu{k}.*conj(fu{k});
    end
end
% sum_s = s6 + s7;
% sum_u = u6 + u7;
alpha=sum_s./sum_u;
Alpha=ifft(alpha);
% Alpha=filter(Hd,Alpha);

% Hd=highpass105;
% Alpha=filter(Hd,Alpha);
% alpha=fft(Alpha);

n=0:(lu+ls)*sf-2;
n=n';
t=n/sf;
f=n*sf/(lu*sf+ls*sf);
for j=1:length(n)
    if(f(j)>=20)
        N=j;
        break
    end
end
% figure(1)
% plot(f,abs(alpha))
% figure(2)
% plot(t,Alpha)
figure(3)
plot(f(1:N),abs(alpha(1:N)))

% [s,u,alpha_day6] = get_s_u(lag,name_200,folder,6*7+1+144*(6-1),6*19+144*(6-1),lu,ls);
% % sum_s = sum_s + s;
% % sum_u = sum_u + u;
% figure(11)
% subplot(3,1,1),plot(f(1:N),abs(alpha_day6(1:N)));
% 
% 
% [a,b,alpha_day7] = get_s_u(lag,name_200,folder,6*7+1+144*(7-1),6*19+144*(7-1),lu,ls);
% % sum_s = sum_s + a;
% % sum_u = sum_u + b;
% figure(11)
% subplot(3,1,2),plot(f(1:N),abs(alpha_day7(1:N)));
% 
% sum_s_all = s + a;
% sum_u_all = u + b;
% alpha_all = sum_s_all./sum_u_all;
% figure(11)
% subplot(3,1,3),plot(f(1:N),abs(alpha_all(1:N)));
% 
% figure(20)
% plot(alpha_all-alpha)