%plot data with different lag
clear all
folder='3#\';
sf=200;
lu=4;
ls=4;

% [name_200,name_3]=list('D:\szh\test\used-data\200#\',['D:\szh\test\used-data\',folder]);
load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
l1=length(name_200);


for i=0:200:1200
    lag = i;
    al{i/200+1} = alpha(i, name_200, folder, 6 * 7 + 1, 6 * 19 + 0, lu, ls);
end


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
plot(f(1:N),abs(al{1}(1:N)),f(1:N),abs(al{2}(1:N)),f(1:N),abs(al{3}(1:N)),f(1:N),abs(al{4}(1:N)),f(1:N),abs(al{5}(1:N)),f(1:N),abs(al{6}(1:N)),f(1:N),abs(al{7}(1:N)))
% plot(f(1:N),abs(al{5}(1:N)),f(1:N),abs(al{6}(1:N)),f(1:N),abs(al{7}(1:N)),f(1:N),abs(al{8}(1:N)),f(1:N),abs(al{9}(1:N)),f(1:N),abs(al{10}(1:N)),f(1:N),abs(al{11}(1:N)))

% figure(11)
% plot(f(1:N),abs(al{1}(1:N)),f(1:N),abs(al{2}(1:N)),f(1:N),abs(al{3}(1:N)),f(1:N),abs(al{4}(1:N)),f(1:N),abs(al{5}(1:N)))
% % plot(f(1:N),abs(al{1}(1:N)),f(1:N),abs(al{2}(1:N)),f(1:N),abs(al{3}(1:N)),f(1:N),abs(al{4}(1:N)))
% 
% figure(12)
% plot(f(1:N),abs(al{1}(1:N)),f(1:N),abs(al{2}(1:N)),f(1:N),abs(al{3}(1:N)),f(1:N),abs(al{4}(1:N)),f(1:N),abs(al{5}(1:N)))
% % plot(f(1:N),abs(al{1}(1:N)),f(1:N),abs(al{2}(1:N)),f(1:N),abs(al{3}(1:N)),f(1:N),abs(al{4}(1:N)))
% 
% figure(13)
% plot(f(1:N),abs(al(1:N)),f(1:N),abs(al(1:N)),f(1:N),abs(al(1:N)))
% % plot(f(1:N),abs(sal(1:N)),f(1:N),abs(sal(1:N)))