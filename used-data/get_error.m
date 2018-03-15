%人工合成数据，get error with different lu ls / number
% function [error,error_smooth] = get_error(name_200,folder,lag,lu,ls,number)
% l1=length(name_200);
% 
% count = 0;
% sf=200;
% sum_u=zeros(lu*sf+ls*sf-1,1);
% sum_s=zeros(lu*sf+ls*sf-1,1);
% 
% for i=(6*7+1+144*(1-1)):(6*19+144*(7-1))
%     if(count > number)
%         break;
%     end
%     load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
%     load(['D:\szh\test\used-data\test_surf\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
%     if(length(under_ch1)~=length(surf_ch1) || length(under_ch2)~=length(surf_ch2) || length(under_ch3)~=length(surf_ch3))
%         disp('length error');
%         break
%     end
% %     under_ch2=filter(Hd,under_ch2);
% %     surf_ch2=filter(Hd,surf_ch2);
%     time=fix(600/ls);
%     for k=1:time-2
%         if((k*lu*sf+lag+ls*sf)>120000)
%             continue
%         end
%         uch{k}=under_ch1((k*lu*sf+1):(k*lu*sf+lu*sf));
%         sch{k}=surf_ch1((k*lu*sf+lag+1):(k*lu*sf+lag+ls*sf));
%         uch{k}=[uch{k};zeros(ls*sf-1,1)];
%         sch{k}=[sch{k};zeros(lu*sf-1,1)];
%         fu{k}=fft(uch{k});
%         fs{k}=fft(sch{k});
%         sum_s=sum_s+fs{k}.*conj(fu{k});
%         sum_u=sum_u+fu{k}.*conj(fu{k});
%         count = count +1;
%     end
% end
% alpha=sum_s./sum_u;
% Alpha=ifft(alpha);
% 
% %以下修正计算的alpha
% l = (lu+ls)*sf-1;
% 
% load(['D:\szh\test\used-data\test_alpha\',folder,'Alpha_test.mat'],'Alpha_test');
% alpha_test = fft(Alpha_test);
% lA = length(Alpha_test);
% 
% Alpha_revise = zeros(lA,1);
% if(lag == 0)
%     Alpha_revise(1:lA) = Alpha(1:lA);
% elseif(lag >= lA)
%     Alpha_revise(1:lA) = Alpha(l-lag+1:l-lag+lA);
% else
%     Alpha_revise(1:lag) = Alpha(l-lag+1:l);
%     Alpha_revise(lag+1:lA) = Alpha(1:lA-lag);
% end
% alpha_revise = fft(Alpha_revise);
% 
% % error = abs(alpha_revise) - abs(alpha_test);
% error = abs(alpha_revise-alpha_test);
% z = smooth(abs(alpha_revise),30);
% % zz = z .* alpha_revise ./ abs(alpha_revise);
% % error_smooth = abs(alpha_test - zz);
% error_smooth = abs(abs(alpha_test) - z);
% error_ab = abs(abs(alpha_test)-abs(alpha_revise));
% error_re = error_ab ./ abs(alpha_test);
% end

function [alpha] = get_error(lag,surf_folder,day,t1,t2,lu,ls,channel,number)
sf = 200;
l = 120000;
sum_u = zeros(lu*sf+ls*sf-1,1);
sum_s = zeros(lu*sf+ls*sf-1,1);
t1 = t1 - 144*(day-1);
t2 = t2 - 144*(day-1);
x1 = (t1-1)*l;
x2 = t2*l;
time = fix((x2-x1)/(200*ls));

window_u = tukeywin(200*lu,0.2);
window_s = tukeywin(200*ls,0.2);
count = 0;
if(channel == 'ch1')
%     load(['D:\szh\test\used-data\200#constantly\200#10-0',num2str(day),'\uch1.mat'],'uch1');
    load('D:\szh\test\used-data\test_11.mat');
    load(['D:\szh\test\used-data\test\',surf_folder,'sch1.mat'],'sch1');
    for k=1:time-2
        count = count + 1;
        if(count > number)
            break;
        end
        uch{k}=uch1((x1+k*lu*sf+1):(x1+k*lu*sf+lu*sf));
        sch{k}=sch1((x1+k*lu*sf+lag+1):(x1+k*lu*sf+lag+ls*sf));
        uch{k} = uch{k} .* window_u;
        sch{k} = sch{k} .* window_s;
        uch{k}=[uch{k};zeros(ls*sf-1,1)];
        sch{k}=[sch{k};zeros(lu*sf-1,1)];
        fu{k}=fft(uch{k});
        fs{k}=fft(sch{k});
        sum_s=sum_s+fs{k}.*conj(fu{k});
        sum_u=sum_u+fu{k}.*conj(fu{k});
    end
elseif(channel == 'ch2')
    load(['D:\szh\test\used-data\200#constantly\200#10-0',num2str(day),'\uch2.mat'],'uch2');
    load(['D:\szh\test\used-data\test\',surf_folder,'sch2.mat'],'sch2');
    for k=1:time-2
        count = count + 1;
        if(count > number)
            break;
        end
        uch{k}=uch2((x1+k*lu*sf+1):(x1+k*lu*sf+lu*sf));
        sch{k}=sch2((x1+k*lu*sf+lag+1):(x1+k*lu*sf+lag+ls*sf));
        uch{k} = uch{k} .* window_u;
        sch{k} = sch{k} .* window_s;
        uch{k}=[uch{k};zeros(ls*sf-1,1)];
        sch{k}=[sch{k};zeros(lu*sf-1,1)];
        fu{k}=fft(uch{k});
        fs{k}=fft(sch{k});
        sum_s=sum_s+fs{k}.*conj(fu{k});
        sum_u=sum_u+fu{k}.*conj(fu{k});
    end
elseif(channel == 'ch3')
    load(['D:\szh\test\used-data\200#constantly\200#10-0',num2str(day),'\uch3.mat'],'uch3');
    load(['D:\szh\test\used-data\test\',surf_folder,'sch3.mat'],'sch3');
    for k=1:time-2
        count = count + 1;
        if(count > number)
            break;
        end
        uch{k}=uch3((x1+k*lu*sf+1):(x1+k*lu*sf+lu*sf));
        sch{k}=sch3((x1+k*lu*sf+lag+1):(x1+k*lu*sf+lag+ls*sf));
        uch{k} = uch{k} .* window_u;
        sch{k} = sch{k} .* window_s;
        uch{k}=[uch{k};zeros(ls*sf-1,1)];
        sch{k}=[sch{k};zeros(lu*sf-1,1)];
        fu{k}=fft(uch{k});
        fs{k}=fft(sch{k});
        sum_s=sum_s+fs{k}.*conj(fu{k});
        sum_u=sum_u+fu{k}.*conj(fu{k});
    end
end
alpha=sum_s./sum_u;

c=1;
f=[0:length(alpha)-1]'/length(alpha)*sf;
while(f(c)<80)
    c=c+1;
end
for i=c:length(alpha)+2-c
    alpha(i)=0;
end
end