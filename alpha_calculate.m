clear all
% file1=dir('D:\szh\test\try\200#\*.mat');
% file2=dir('D:\szh\test\try\3#\*.mat');
% for i=1:90
%     name1{i}=file1(i).name;
%     name2{i}=file2(i).name;
%     for j=i+1:90
%         if(str2num(name1{i})>str2num(file1(j).name))
%             name1{i}=file1(j).name;
%         end
%         if(str2num(name2{i})>str2num(file2(j).name))
%             name2{i}=file2(j).name;
%         end
%         if(strcmp(name1{i},name2{i})==0)
%             disp('name unfit');
%             break
%         end
%     end
% end
% clear file1 file2 name2 j i
[name1,name2]=list('D:\szh\test\try\200#\','D:\szh\test\try\3#\');
sf=200;
lu=15;
ls=20;
sum_u=zeros(lu*sf+ls*sf-1,1);
sum_s=zeros(lu*sf+ls*sf-1,1);
Hd=lowpass2530;
for i=1:18
    load(['D:\szh\test\try\200#\',name1{i}],'under_ch2');
    load(['D:\szh\test\try\3#\',name2{i}],'surf_ch2');
    if(length(under_ch2)~=length(surf_ch2))
        disp('length error');
        break
    end
    under_ch2=filter(Hd,under_ch2);
    surf_ch2=filter(Hd,surf_ch2);
    time=fix(600/lu);
    for k=1:time-2
        uch{k}=under_ch2((k*lu*sf+1):(k*lu*sf+lu*sf));
        sch{k}=surf_ch2((k*lu*sf+0+1):(k*lu*sf+0+ls*sf));
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
% alpha=fft(Alpha);

n=0:(lu+ls)*sf-2;
n=n';
t=n/sf;
f=n*sf/(lu*sf+ls*sf);
for j=1:length(n)
    if(f(j)>=30)
        N=j;
        break
    end
end
figure(1)
plot(f,abs(alpha))
figure(2)
plot(t,Alpha)
figure(3)
plot(f(1:N),abs(alpha(1:N)))