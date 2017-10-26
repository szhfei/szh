%人工合成数据，get error with different lu ls / number
function [error,error_smooth] = get_error(name_200,folder,lag,lu,ls,number)
l1=length(name_200);

count = 0;
sf=200;
sum_u=zeros(lu*sf+ls*sf-1,1);
sum_s=zeros(lu*sf+ls*sf-1,1);

for i=(6*7+1+144*(1-1)):(6*19+144*(7-1))
    if(count > number)
        break;
    end
    load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
    load(['D:\szh\test\used-data\test_surf\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
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
        fu{k}=fft(uch{k});
        fs{k}=fft(sch{k});
        sum_s=sum_s+fs{k}.*conj(fu{k});
        sum_u=sum_u+fu{k}.*conj(fu{k});
        count = count +1;
    end
end
alpha=sum_s./sum_u;
Alpha=ifft(alpha);

%以下修正计算的alpha
l = (lu+ls)*sf-1;

load(['D:\szh\test\used-data\test_alpha\',folder,'Alpha_test.mat'],'Alpha_test');
alpha_test = fft(Alpha_test);
lA = length(Alpha_test);

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

% error = abs(alpha_revise) - abs(alpha_test);
error = abs(alpha_revise-alpha_test);
z = smooth(abs(alpha_revise),30);
% zz = z .* alpha_revise ./ abs(alpha_revise);
% error_smooth = abs(alpha_test - zz);
error_smooth = abs(abs(alpha_test) - z);
error_ab = abs(abs(alpha_test)-abs(alpha_revise));
error_re = error_ab ./ abs(alpha_test);
end