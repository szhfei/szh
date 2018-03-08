%plot data with different total time length
clear all

folder='3#\';
load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
l1=length(name_200);

sf=200;
lu=20;
ls=20;
lag=000;%时间延迟
sum_u=zeros(lu*sf+ls*sf-1,1);
sum_s=zeros(lu*sf+ls*sf-1,1);

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
if(strcmp(folder,'3#\') == 1)
    alpha_day4=alpha(200*5.31,name_200,folder,6*7+1+144*(4-1),6*19+144*(4-1),lu,ls);
    alpha_day5=alpha(200*5.355,name_200,folder,6*7+1+144*(5-1),6*19+144*(5-1),lu,ls);
    alpha_day6=alpha(200*5.415,name_200,folder,6*7+1+144*(6-1),6*19+144*(6-1),lu,ls);
    alpha_day7=alpha(200*5.465,name_200,folder,6*7+1+144*(7-1),6*19+144*(7-1),lu,ls);
elseif(strcmp(folder,'2#\') == 1)
    alpha_day4=alpha(200*-3.605,name_200,folder,6*7+1+144*(4-1),6*19+144*(4-1),lu,ls);
    alpha_day5=alpha(200*-3.545,name_200,folder,6*7+1+144*(5-1),6*19+144*(5-1),lu,ls);
    alpha_day6=alpha(200*-3.48,name_200,folder,6*7+1+144*(6-1),6*19+144*(6-1),lu,ls);
    alpha_day7=alpha(200*-3.42,name_200,folder,6*7+1+144*(7-1),6*19+144*(7-1),lu,ls);
end

span = 30;
day4 = smooth(abs(alpha_day4),span);
day5 = smooth(abs(alpha_day5),span);
day6 = smooth(abs(alpha_day6),span);
day7 = smooth(abs(alpha_day7),span);
% day_all = smooth(abs(alpha_all),span);
figure(20)
plot(f,day4,f,day5,f,day6,f,day7,'linewidth',1.3),xlim([0 20]),xlabel('f/Hz','fontsize',18)...
    ,ylabel('alpha','fontsize',18),set(gca,'fontsize',18),legend('10月4号','10月5号','10月6号','10月7号')




%     sday2=alpha(lag,name_200,folder,6*7+1+144*(7-1),6*19+144*(7-1),50,50);
% n=0:(100)*sf-2;
% n=n';
% t=n/sf;
% f2=n*sf/(100*sf-1);
% for j=1:length(n)
%     if(f2(j)>=20)
%         N2=j-1;
%         break
%     end
% end
%     sday4=alpha(lag,name_200,folder,6*7+1+144*(7-1),6*19+144*(7-1),60,60);
% n=0:(120)*sf-2;
% n=n';
% t=n/sf;
% f4=n*sf/(120*sf-1);
% for j=1:length(n)
%     if(f4(j)>=20)
%         N4=j-1;
%         break
%     end
% end
%     sday6=alpha(lag,name_200,folder,6*7+1+144*(7-1),6*19+144*(7-1),80,80);
% n=0:(160)*sf-2;
% n=n';
% t=n/sf;
% f6=n*sf/(160*sf-1);
% for j=1:length(n)
%     if(f6(j)>=20)
%         N6=j-1;
%         break
%     end
% end
%     sday7=alpha(lag,name_200,folder,6*7+1+144*(7-1),6*19+144*(7-1),100,100);
%     
% n=0:(200)*sf-2;
% n=n';
% t=n/sf;
% f7=n*sf/(200*sf-1);
% for j=1:length(n)
%     if(f7(j)>=20)
%         N7=j-1;
%         break
%     end
% end

% figure(10)
% plot(f(1:N),abs(day4{1}(1:N)),f(1:N),abs(day4{2}(1:N)))
% plot(f(1:N),abs(day1{1}(1:N)),f(1:N),abs(day1{2}(1:N)),f(1:N),abs(day1{3}(1:N)),f(1:N),abs(day1{4}(1:N)),f(1:N),abs(day1{5}(1:N)))
% % plot(f(1:N),abs(day1{1}(1:N)),f(1:N),abs(day1{2}(1:N)),f(1:N),abs(day1{3}(1:N)),f(1:N),abs(day1{4}(1:N)))
% 
% figure(11)
% plot(f(1:N),abs(day4{1}(1:N)),f(1:N),abs(day4{2}(1:N)),f(1:N),abs(day4{3}(1:N)),f(1:N),abs(day4{4}(1:N)),f(1:N),abs(day4{5}(1:N)))
% % plot(f(1:N),abs(day4{1}(1:N)),f(1:N),abs(day4{2}(1:N)),f(1:N),abs(day4{3}(1:N)),f(1:N),abs(day4{4}(1:N)))
% 
% figure(12)
% plot(f(1:N),abs(day7{1}(1:N)),f(1:N),abs(day7{2}(1:N)),f(1:N),abs(day7{3}(1:N)),f(1:N),abs(day7{4}(1:N)),f(1:N),abs(day7{5}(1:N)))
% % plot(f(1:N),abs(day7{1}(1:N)),f(1:N),abs(day7{2}(1:N)),f(1:N),abs(day7{3}(1:N)),f(1:N),abs(day7{4}(1:N)))

% figure(13)
% plot(f(1:N),abs(sday1(1:N)),f(1:N),abs(sday4(1:N)),f(1:N),abs(sday7(1:N)))
% plot(f(1:N),abs(sday6(1:N)),f(1:N),abs(sday7(1:N)))
% plot(f(1:N),abs(sday2(1:N)),f(1:N),abs(sday3(1:N)),f(1:N),abs(sday4(1:N)),f(1:N),abs(sday6(1:N)),f(1:N),abs(sday7(1:N)))
% plot(f(1:N),abs(sday2(1:N)),f(1:N),abs(sday4(1:N)),f(1:N),abs(sday6(1:N)),f(1:N),abs(sday7(1:N)))
% plot(f(1:N),abs(sday2(1:N)))

% plot(f2(1:N2),abs(sday2(1:N2)),f4(1:N4),abs(sday4(1:N4)),f6(1:N6),abs(sday6(1:N6)),f7(1:N7),abs(sday7(1:N7)))