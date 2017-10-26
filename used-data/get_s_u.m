function [sum_s,sum_u,alpha]=get_s_u(lag,name_200,folder,t1,t2,lu,ls)%·µ»Øsum_s,sum_u
sf=200;
sum_u=zeros(lu*sf+ls*sf-1,1);
sum_s=zeros(lu*sf+ls*sf-1,1);
i = t1;
while(i <= t2)
    if(i == 649)%10-05-12:00-14:50 cut
        i = 667;
        continue
    end
    if(strcmp(name_200{i},'1004193000.mat')==1 || strcmp(name_200{i},'1004194000.mat')==1 || strcmp(name_200{i},'1004195000.mat')==1)
        i = i + 3;
        continue
    end
    if(strcmp(name_200{i},'1005103000.mat')==1 || strcmp(name_200{i},'1005104000.mat')==1 || strcmp(name_200{i},'1005105000.mat')==1)
        i = i + 3;
        continue
    end
    if(strcmp(folder,'3#\') == 1)
        if(strcmp(name_200{i},'1006200000.mat')==1 || strcmp(name_200{i},'1006201000.mat')==1 || strcmp(name_200{i},'1006202000.mat')==1)
            i = i + 3;
            continue
        end
    elseif(strcmp(folder,'2#\') == 1)
        if(strcmp(name_200{i},'1006200000.mat')==1 || strcmp(name_200{i},'1006201000.mat')==1 || strcmp(name_200{i},'1006202000.mat')==1)
            i = i + 3;
            continue
        end
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
        uch{k}=under_ch1((k*lu*sf+1):(k*lu*sf+lu*sf));
        sch{k}=surf_ch1((k*lu*sf+lag+1):(k*lu*sf+lag+ls*sf));
        uch{k}=[uch{k};zeros(ls*sf-1,1)];
        sch{k}=[sch{k};zeros(lu*sf-1,1)];
        %         uch{k}=filter(Hd,uch{k});
        %         sch{k}=filter(Hd,sch{k});
        fu{k}=fft(uch{k});
        fs{k}=fft(sch{k});
        sum_s=sum_s+fs{k}.*conj(fu{k});
        sum_u=sum_u+fu{k}.*conj(fu{k});
    end
    i = i + 1;
end
alpha=sum_s./sum_u;
% Alpha=ifft(alpha);
% Alpha=filter(Hd,Alpha);

% Hd=highpass105;
% Alpha=filter(Hd,Alpha);
% alpha=fft(Alpha);
end