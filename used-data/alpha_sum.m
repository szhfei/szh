%计算alpha，多天叠加
clear all

folder='11#\';
load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
l1=length(name_200);

sf=200;
lu=50;
ls=50;
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

% [s1,u1] = get_s_u(lag,name_200,folder,6*7+1+144*(2-1),6*11+144*(2-1),lu,ls);
% [s2,u2] = get_s_u(lag,name_200,folder,6*13+1+144*(2-1),6*19+144*(2-1),lu,ls);
% alpha_day2 = (s1 + s2)./(u1 + u2);
% sum_s = sum_s + s1 + s2;
% sum_u = sum_u + u1 + u2;

%不同天比较
if(strcmp(folder,'3#\') == 1)
    [s,u,alpha_day4] = get_s_u(200*5.31,name_200,folder,6*7+1+144*(4-1),6*22+144*(4-1),lu,ls);%3#lag =ch1 200*5.31, ,2# lag= ch1 200*-3.605 
    sum_s = sum_s + s;
    sum_u = sum_u + u;
    [s,u,alpha_day5] = get_s_u(200*5.355,name_200,folder,6*7+1+144*(5-1),6*22+144*(5-1),lu,ls);%3#lag =ch1 200*5.355, ,2# lag= ch1 200*-3.545 
    sum_s = sum_s + s;
    sum_u = sum_u + u;
    [s,u,alpha_day6] = get_s_u(200*5.415,name_200,folder,6*7+1+144*(6-1),6*22+144*(6-1),lu,ls);%3#lag =ch1 200*5.415,ch2 200*5.355,2# lag= ch1 200*-3.48 
    sum_s = sum_s + s;
    sum_u = sum_u + u;
    [s,u,alpha_day7] = get_s_u(200*5.465,name_200,folder,6*7+1+144*(7-1),6*22+144*(7-1),lu,ls);%3#lag =ch1 200*5.465,ch2 200*5.41,2# lag= ch1 200*-3.42
    sum_s = sum_s + s;
    sum_u = sum_u + u;
elseif(strcmp(folder,'2#\') == 1)
    [s,u,alpha_day4] = get_s_u(200*-3.605,name_200,folder,6*7+1+144*(4-1),6*22+144*(4-1),lu,ls);%3#lag =ch1 200*5.31, ,2# lag= ch1 200*-3.605 
    sum_s = sum_s + s;
    sum_u = sum_u + u;
    [s,u,alpha_day5] = get_s_u(200*-3.545,name_200,folder,6*7+1+144*(5-1),6*22+144*(5-1),lu,ls);%3#lag =ch1 200*5.355, ,2# lag= ch1 200*-3.545 
    sum_s = sum_s + s;
    sum_u = sum_u + u;
    [s,u,alpha_day6] = get_s_u(200*-3.48,name_200,folder,6*7+1+144*(6-1),6*22+144*(6-1),lu,ls);%3#lag =ch1 200*5.415,ch2 200*5.355,2# lag= ch1 200*-3.48 
    sum_s = sum_s + s;
    sum_u = sum_u + u;
    [s,u,alpha_day7] = get_s_u(200*-3.42,name_200,folder,6*7+1+144*(7-1),6*22+144*(7-1),lu,ls);%3#lag =ch1 200*5.465,ch2 200*5.41,2# lag= ch1 200*-3.42
    sum_s = sum_s + s;
    sum_u = sum_u + u;
elseif(strcmp(folder,'11#\') == 1)
    [s,u,alpha_day4] = get_s_u(200*4.235,name_200,folder,6*7+1+144*(4-1),6*22+144*(4-1),lu,ls);%3#lag =ch1 200*5.31, ,2# lag= ch1 200*-3.605 
    sum_s = sum_s + s;
    sum_u = sum_u + u;
    [s,u,alpha_day5] = get_s_u(200*4.305,name_200,folder,6*7+1+144*(5-1),6*22+144*(5-1),lu,ls);%3#lag =ch1 200*5.355, ,2# lag= ch1 200*-3.545 
    sum_s = sum_s + s;
    sum_u = sum_u + u;
    [s,u,alpha_day6] = get_s_u(200*4.365,name_200,folder,6*7+1+144*(6-1),6*22+144*(6-1),lu,ls);%3#lag =ch1 200*5.415,ch2 200*5.355,2# lag= ch1 200*-3.48 
    sum_s = sum_s + s;
    sum_u = sum_u + u;
    [s,u,alpha_day7] = get_s_u(200*4.43,name_200,folder,6*7+1+144*(7-1),6*22+144*(7-1),lu,ls);%3#lag =ch1 200*5.465,ch2 200*5.41,2# lag= ch1 200*-3.42
    sum_s = sum_s + s;
    sum_u = sum_u + u;
end
alpha_all = sum_s./sum_u;

Alpha_all=ifft(alpha_all);
figure(1)
plot(f,abs(alpha_all))
figure(2)
plot(t,Alpha_all)
figure(3)
plot(f(1:N),abs(alpha_all(1:N)))

figure(14)
plot(f(1:N),abs(alpha_all(1:N)),f(1:N),abs(alpha_day4(1:N)),f(1:N),abs(alpha_day5(1:N)),f(1:N),abs(alpha_day6(1:N)),f(1:N),abs(alpha_day7(1:N)))
% plot(f(1:N),abs(alpha_all(1:N)),f(1:N),abs(alpha_day6(1:N)),f(1:N),abs(alpha_day7(1:N)))

span = 30;
day4 = smooth(abs(alpha_day4),span);
day5 = smooth(abs(alpha_day5),span);
day6 = smooth(abs(alpha_day6),span);
day7 = smooth(abs(alpha_day7),span);
day_all = smooth(abs(alpha_all),span);
figure(15)
plot(f,day_all,f,day4,f,day5,f,day6,f,day7,'linewidth',1.3),xlim([0 20]),xlabel('f/Hz','fontsize',18)...
    ,ylabel('场地传递函数幅值','fontsize',18),set(gca,'fontsize',18),set(gca,'xtick',0:2:20)...
    ,legend('4天总叠加','10月4号','10月5号','10月6号','10月7号')


% %单日3小时不同时段比较
% day = 7;lag = 0;
% if(strcmp(folder,'3#\') == 1) %3# lag = day4,200*5.31  day6,200*5.415  day7,200*5.465     2# lag = day4,200*-3.605  day6,200*-3.48  day7,200*-3.42
%     if(day == 4)
%         lag = 200*5.31;
%     elseif(day == 6)
%         lag = 200*5.415;
%     elseif(day ==7)
%         lag = 200*5.465;
%     end
% else
%     if(day == 4)
%         lag = 200*-3.605;
%     elseif(day == 6)
%         lag = 200*-3.48;
%     elseif(day ==7)
%         lag = 200*-3.42;
%     end
% end
% result{1} = alpha(lag,name_200,folder,6*7+1+144*(day-1),6*10+144*(day-1),lu,ls);
% result{2} = alpha(lag,name_200,folder,6*10+1+144*(day-1),6*13+144*(day-1),lu,ls);
% result{3} = alpha(lag,name_200,folder,6*13+1+144*(day-1),6*16+144*(day-1),lu,ls);
% result{4} = alpha(lag,name_200,folder,6*16+1+144*(day-1),6*19+144*(day-1),lu,ls);
% % result{5} = alpha(lag,name_200,folder,6*19+1+144*(day-1),6*22+144*(day-1),lu,ls);
% 
% span = 30;
% for i = 1:4
%     z{i} = smooth(abs(result{i}),span);
% end
% figure(100)
% plot(f,z{1},f,z{2},f,z{3},f,z{4},'linewidth',1.3),xlim([0 20]),xlabel('f/Hz','fontsize',18)...
%     ,ylabel('场地传递函数幅值','fontsize',18),set(gca,'fontsize',18),legend('07:00-10:00','10:00-13:00','13:00-16:00','16:00-19:00')


% %单日单小时比较
% day = 4;lag = 0;
% if(strcmp(folder,'3#\') == 1) %3# lag = day4,200*5.31  day6,200*5.415  day7,200*5.465     2# lag = day4,200*-3.605  day6,200*-3.48  day7,200*-3.42
%     if(day == 4)
%         lag = 200*5.31;
%     elseif(day == 5)
%         lag = 200*5.355;
%     elseif(day == 6)
%         lag = 200*5.415;
%     elseif(day ==7)
%         lag = 200*5.465;
%     end
% elseif(strcmp(folder,'2#\') == 1)
%     if(day == 4)
%         lag = 200*-3.605;
%     elseif(day ==5)
%         lag = 200*-3.545;
%     elseif(day == 6)
%         lag = 200*-3.48;
%     elseif(day ==7)
%         lag = 200*-3.42;
%     end
% end
% result{1} = alpha(lag,name_200,folder,6*7+1+144*(day-1),6*8+144*(day-1),lu,ls);
% result{2} = alpha(lag,name_200,folder,6*8+1+144*(day-1),6*9+144*(day-1),lu,ls);
% result{3} = alpha(lag,name_200,folder,6*9+1+144*(day-1),6*10+144*(day-1),lu,ls);
% result{4} = alpha(lag,name_200,folder,6*10+1+144*(day-1),6*11+144*(day-1),lu,ls);
% result{5} = alpha(lag,name_200,folder,6*11+1+144*(day-1),6*12+144*(day-1),lu,ls);
% result{6} = alpha(lag,name_200,folder,6*12+1+144*(day-1),6*13+144*(day-1),lu,ls);
% result{7} = alpha(lag,name_200,folder,6*13+1+144*(day-1),6*14+144*(day-1),lu,ls);
% result{8} = alpha(lag,name_200,folder,6*14+1+144*(day-1),6*15+144*(day-1),lu,ls);
% result{9} = alpha(lag,name_200,folder,6*15+1+144*(day-1),6*16+144*(day-1),lu,ls);
% result{10} = alpha(lag,name_200,folder,6*16+1+144*(day-1),6*17+144*(day-1),lu,ls);
% result{11} = alpha(lag,name_200,folder,6*17+1+144*(day-1),6*18+144*(day-1),lu,ls);
% result{12} = alpha(lag,name_200,folder,6*18+1+144*(day-1),6*19+144*(day-1),lu,ls);
% result{13} = alpha(lag,name_200,folder,6*19+1+144*(day-1),6*20+144*(day-1),lu,ls);
% result{14} = alpha(lag,name_200,folder,6*20+1+144*(day-1),6*21+144*(day-1),lu,ls);
% result{15} = alpha(lag,name_200,folder,6*21+1+144*(day-1),6*22+144*(day-1),lu,ls);
% 
% span = 30;
% for i = 1:15
%     z{i} = smooth(abs(result{i}),span);
% end
% figure(99)
% plot(f,z{1},f,z{2},f,z{3},f,z{4},f,z{5},f,z{6},f,z{7},f,z{8},f,z{9},f,z{10},f,z{11},f,z{12},f,z{13},f,z{14},f,z{15},'linewidth',1.3)...
%     ,xlim([0 20]),xlabel('f/Hz','fontsize',18),ylabel('场地传递函数幅值','fontsize',18),set(gca,'fontsize',18),legend('07:00','08:00','09:00','10:00'...
%     ,'11:00','12:00','13:00','14:00','15:00','16:00','17:00','18:00','19:00','20:00','21:00')


% %多日单小时比较
% if(strcmp(folder,'3#\') == 1)
%     i = 1;
%     while(i <= 15)
%         sum_u=zeros(lu*sf+ls*sf-1,1);
%         sum_s=zeros(lu*sf+ls*sf-1,1);
%         [s,u,~] = get_s_u(200*5.31,name_200,folder,6*(i+6)+1+144*(4-1),6*(i+7)+144*(4-1),lu,ls);
%         sum_s = sum_s + s;sum_u = sum_u + u;
%         [s,u,~] = get_s_u(200*5.415,name_200,folder,6*(i+6)+1+144*(6-1),6*(i+7)+144*(6-1),lu,ls);
%         sum_s = sum_s + s;sum_u = sum_u + u;
%         [s,u,~] = get_s_u(200*5.465,name_200,folder,6*(i+6)+1+144*(7-1),6*(i+7)+144*(7-1),lu,ls);
%         sum_s = sum_s + s;sum_u = sum_u + u;
%         if(i ~= 6 && i ~= 7 && i ~= 8)
%             [s,u,~] = get_s_u(200*5.355,name_200,folder,6*(i+6)+1+144*(5-1),6*(i+7)+144*(5-1),lu,ls);
%             sum_s = sum_s + s;sum_u = sum_u + u;
%         end
%         result{i} = sum_s./sum_u;
%         i = i + 1;
%     end
% elseif(strcmp(folder,'2#\') == 1)
%     i = 1;
%     while(i <= 15)
%         sum_u=zeros(lu*sf+ls*sf-1,1);
%         sum_s=zeros(lu*sf+ls*sf-1,1);
%         [s,u,~] = get_s_u(200*-3.605,name_200,folder,6*(i+6)+1+144*(4-1),6*(i+7)+144*(4-1),lu,ls);
%         sum_s = sum_s + s;sum_u = sum_u + u;
%         [s,u,~] = get_s_u(200*-3.48,name_200,folder,6*(i+6)+1+144*(6-1),6*(i+7)+144*(6-1),lu,ls);
%         sum_s = sum_s + s;sum_u = sum_u + u;
%         [s,u,~] = get_s_u(200*-3.42,name_200,folder,6*(i+6)+1+144*(7-1),6*(i+7)+144*(7-1),lu,ls);
%         sum_s = sum_s + s;sum_u = sum_u + u;
%         if(i ~= 6 && i ~= 7 && i ~= 8)
%             [s,u,~] = get_s_u(200*-3.545,name_200,folder,6*(i+6)+1+144*(5-1),6*(i+7)+144*(5-1),lu,ls);
%             sum_s = sum_s + s;sum_u = sum_u + u;
%         end
%         result{i} = sum_s./sum_u;
%         i = i + 1;
%     end
% end
% 
% span = 30;
% for i = 1:15
%     z{i} = smooth(abs(result{i}),span);
% end
% figure(101)
% plot(f,z{1},f,z{2},f,z{3},f,z{4},f,z{5},f,z{6},f,z{7},f,z{8},f,z{9},f,z{10},f,z{11},f,z{12},f,z{13},f,z{14},f,z{15},'linewidth',1.3)...
%     ,xlim([0 20]),xlabel('f/Hz','fontsize',18),ylabel('场地传递函数幅值','fontsize',18),set(gca,'fontsize',18),set(gca,'xtick',0:2:20)...
%     %,legend('07:00','08:00','09:00','10:00','11:00','12:00','13:00','14:00','15:00','16:00','17:00','18:00','19:00','20:00','21:00')

