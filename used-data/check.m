clear all
folder='11#\';
% [name_200,name_3]=list('D:\szh\test\used-data\200#\','D:\szh\test\used-data\3#\');
% name_200=listmat('D:\szh\test\used-data\200#\');
name_11=listmat(['D:\szh\test\used-data\',folder]);
load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% load('D:\szh\test\used-data\namelist\name_3.mat','name_3');
[filename1,filename2]=listname('D:\szh\test\used-data\','D:\szh\test\used-data\');
l=length(name_200);
count=0;
% for i=289:l
%     load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
%     a=under_ch1;b=under_ch2;c=under_ch3;
%     [under_ch1, under_ch2, under_ch3, bn, sf, under_btime] = t3w(filename1{i-288});
% %     load(['D:\szh\test\used-data\111111\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
%     ll=length(under_ch1);
%     n=0:ll-1;
%     n=n';
%     t=n/200;
%     %f=n*sf/l;
%     
%     p=polyfit(t,under_ch1,1);
%     under_ch1=under_ch1-(p(1)*t+p(2));
%     p=polyfit(t,under_ch2,1);
%     under_ch2=under_ch2-(p(1)*t+p(2));
%     p=polyfit(t,under_ch3,1);
%     under_ch3=under_ch3-(p(1)*t+p(2));
% 
%     under_ch1=under_ch1-sum(under_ch1)/ll;
%     under_ch2=under_ch2-sum(under_ch2)/ll;
%     under_ch3=under_ch3-sum(under_ch3)/ll;
%     a=a-under_ch1;b=b-under_ch2;c=c-under_ch3;
%     for j=1:ll
%         if(a(i)~=0 || b(i)~=0 || c(i)~=0)
%             disp('error');
%             count=count+1;
%             return
%         end
%     end
% end
for i=1:48
    load(['D:\szh\test\used-data\',filename2{i}],'D_a');
    for k=1:3
        load(['D:\szh\test\used-data\',folder,name_11{0+i*3-3+k}],'surf_ch1','surf_ch2','surf_ch3');
        a=surf_ch1;b=surf_ch2;c=surf_ch3;
        surf_ch1=D_a(((k-1)*120000+1):(k*120000),1);
        surf_ch2=D_a(((k-1)*120000+1):(k*120000),2);
        surf_ch3=D_a(((k-1)*120000+1):(k*120000),3);
        ll=length(surf_ch1);
        n=0:ll-1;
        n=n';
        t=n/200;
        %f=n*sf/l;
        
        p=polyfit(t,surf_ch1,1);
        surf_ch1=surf_ch1-(p(1)*t+p(2));
        p=polyfit(t,surf_ch2,1);
        surf_ch2=surf_ch2-(p(1)*t+p(2));
        p=polyfit(t,surf_ch3,1);
        surf_ch3=surf_ch3-(p(1)*t+p(2));
        
        surf_ch1=surf_ch1-sum(surf_ch1)/ll;
        surf_ch2=surf_ch2-sum(surf_ch2)/ll;
        surf_ch3=surf_ch3-sum(surf_ch3)/ll;
        
        a=a-surf_ch1;b=b-surf_ch2;c=c-surf_ch3;
        for j=1:ll
            if(a(i)~=0 || b(i)~=0 || c(i)~=0)
                disp('error');
                count=count+1;
                return
            end
        end
    end
end