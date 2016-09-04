function alpha=alpha(lag,name_200,folder,t1,t2,lu,ls)%计算alpha，t1 t2代替对应时间
sf=200;
sum_u=zeros(lu*sf+ls*sf-1,1);
sum_s=zeros(lu*sf+ls*sf-1,1);
% Hd=lowpass2530;
for i=t1:t2
    if(strcmp(name_200{i},'1004193000.mat')==1 || strcmp(name_200{i},'1004194000.mat')==1 || strcmp(name_200{i},'1004195000.mat')==1)   % 3# 2# 11#\10-04-19:30 data error
        continue
    end
%     if(strcmp(name_200{i},'1004190000.mat')==1 || strcmp(name_200{i},'1004191000.mat')==1 || strcmp(name_200{i},'1004192000.mat')==1)   % 1#\10-04-19:00 data error
%         continue
%     end
    load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch2');
    load(['D:\szh\test\used-data\',folder,name_200{i}],'surf_ch2');
    if(length(under_ch2)~=length(surf_ch2))
        disp('length error');
        break
    end
    %     under_ch2=filter(Hd,under_ch2);
    %     surf_ch2=filter(Hd,surf_ch2);
    time=fix(600/ls);
    for k=1:time-2
        if((k*lu*sf+lag+ls*sf)>length(under_ch2))
            continue
        end
        uch{k}=under_ch2((k*lu*sf+1):(k*lu*sf+lu*sf));
        sch{k}=surf_ch2((k*lu*sf+lag+1):(k*lu*sf+lag+ls*sf));
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
% Alpha=ifft(alpha);
% Alpha=filter(Hd,Alpha);

% Hd=highpass105;
% Alpha=filter(Hd,Alpha);
% alpha=fft(Alpha);
end