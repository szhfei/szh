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

    lag=0;
    day1{1}=alpha(lag,name_200,folder,7*6+1,10*6);
    day1{2}=alpha(lag,name_200,folder,10*6+1,13*6);
    day1{3}=alpha(lag,name_200,folder,13*6+1,16*6);
    day1{4}=alpha(lag,name_200,folder,16*6+1,19*6);
    day1{5}=alpha(lag,name_200,folder,19*6+1,22*6);
    day4{1}=alpha(lag,name_200,folder,7*6+1+144,10*6+144);
    day4{2}=alpha(lag,name_200,folder,10*6+1+144,13*6+144);
    day4{3}=alpha(lag,name_200,folder,13*6+1+144,16*6+144);
    day4{4}=alpha(lag,name_200,folder,16*6+1+144,19*6+144);
    day4{5}=alpha(lag,name_200,folder,19*6+1+144,22*6+144);
    day7{1}=alpha(lag,name_200,folder,7*6+1+288,10*6+288);
    day7{2}=alpha(lag,name_200,folder,10*6+1+288,13*6+288);
    day7{3}=alpha(lag,name_200,folder,13*6+1+288,16*6+288);
    day7{4}=alpha(lag,name_200,folder,16*6+1+288,19*6+288);
    day7{5}=alpha(lag,name_200,folder,19*6+1+288,22*6+288);
    
    sday1=alpha(lag,name_200,folder,7*6+1,22*6);
    sday4=alpha(lag,name_200,folder,7*6+1+144,22*6+144);
    sday7=alpha(lag,name_200,folder,7*6+1+288,22*6+288);
%     sd4=alpha(lag,name_200,folder,0*6+1+144,5*6+144);


sf=200;
lu=15;
ls=20;
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

figure(10)
plot(f(1:N),abs(day1{1}(1:N)),f(1:N),abs(day1{2}(1:N)),f(1:N),abs(day1{3}(1:N)),f(1:N),abs(day1{4}(1:N)),f(1:N),abs(day1{5}(1:N)))
% plot(f(1:N),abs(day1{1}(1:N)),f(1:N),abs(day1{2}(1:N)),f(1:N),abs(day1{3}(1:N)),f(1:N),abs(day1{4}(1:N)))

figure(11)
plot(f(1:N),abs(day4{1}(1:N)),f(1:N),abs(day4{2}(1:N)),f(1:N),abs(day4{3}(1:N)),f(1:N),abs(day4{4}(1:N)),f(1:N),abs(day4{5}(1:N)))
% plot(f(1:N),abs(day4{1}(1:N)),f(1:N),abs(day4{2}(1:N)),f(1:N),abs(day4{3}(1:N)),f(1:N),abs(day4{4}(1:N)))

figure(12)
plot(f(1:N),abs(day7{1}(1:N)),f(1:N),abs(day7{2}(1:N)),f(1:N),abs(day7{3}(1:N)),f(1:N),abs(day7{4}(1:N)),f(1:N),abs(day7{5}(1:N)))
% plot(f(1:N),abs(day7{1}(1:N)),f(1:N),abs(day7{2}(1:N)),f(1:N),abs(day7{3}(1:N)),f(1:N),abs(day7{4}(1:N)))

figure(13)
plot(f(1:N),abs(sday1(1:N)),f(1:N),abs(sday4(1:N)),f(1:N),abs(sday7(1:N)))
% plot(f(1:N),abs(sday4(1:N)),f(1:N),abs(sday7(1:N)))