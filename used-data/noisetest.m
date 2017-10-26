%²âÊÔ£¬°×ÔëÉùºÍµØÌúµþ¼ÓÊÇ·ñÇ÷ÓÚ0
clear all

% folder='wgn-db_-27\';
folder = 'noise-similar\';
load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
l1=length(name_200);

sf=200;
lu=50;
ls=50;
lag=0;%Ê±¼äÑÓ³Ù
sum_u=zeros(lu*sf+ls*sf-1,1);
sum_s=zeros(lu*sf+ls*sf-1,1);

for i=(6*7+1+144*(6-1)):(6*19+144*(6-1))
    load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
    load(['D:\szh\test\used-data\test_noise\',folder,name_200{i}],'noise_ch1','noise_ch2','noise_ch3');
    if(length(under_ch1)~=length(noise_ch1) || length(under_ch2)~=length(noise_ch2) || length(under_ch3)~=length(noise_ch3))
        disp('length error');
        break
    end
%     under_ch2=filter(Hd,under_ch2);
%     noise_ch2=filter(Hd,noise_ch2);
    time=fix(600/ls);
    for k=1:time-2
        if((k*lu*sf+lag+ls*sf)>120000)
            continue
        end
        uch{k}=under_ch1((k*lu*sf+1):(k*lu*sf+lu*sf));
        sch{k}=noise_ch1((k*lu*sf+lag+1):(k*lu*sf+lag+ls*sf));
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

% for i=(6*7+1+144*(3-1)):(6*19+144*(3-1))
%     load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
%     load(['D:\szh\test\used-data\',folder,name_200{i}],'noise_ch1','noise_ch2','noise_ch3');
%     if(length(under_ch1)~=length(noise_ch1) || length(under_ch2)~=length(noise_ch2) || length(under_ch3)~=length(noise_ch3))
%         disp('length error');
%         break
%     end
% %     under_ch2=filter(Hd,under_ch2);
% %     noise_ch2=filter(Hd,noise_ch2);
%     time=fix(600/ls);
%     for k=1:time-2
%         if((k*lu*sf+lag+ls*sf)>120000)
%             continue
%         end
%         uch{k}=under_ch1((k*lu*sf+1):(k*lu*sf+lu*sf));
%         sch{k}=noise_ch1((k*lu*sf+lag+1):(k*lu*sf+lag+ls*sf));
%         uch{k}=[uch{k};zeros(ls*sf-1,1)];
%         sch{k}=[sch{k};zeros(lu*sf-1,1)];
% %         uch{k}=filter(Hd,uch{k});
% %         sch{k}=filter(Hd,sch{k});
%         fu{k}=fft(uch{k});
%         fs{k}=fft(sch{k});
%         sum_s=sum_s+fs{k}.*conj(fu{k});
%         sum_u=sum_u+fu{k}.*conj(fu{k});
%     end
% end

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
