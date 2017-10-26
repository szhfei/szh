%最终结果画图
clear all

load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
l1=length(name_200);

sf=200;
lu=50;
ls=50;

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

% %不同天比较
% folder = '3#\';
% %'ch1'
% sum_u=zeros(lu*sf+ls*sf-1,1);
% sum_s=zeros(lu*sf+ls*sf-1,1);
% [s,u,alpha_day4_3_ch1] = get_alpha(200*5.31,name_200,folder,6*7+1+144*(4-1),6*22+144*(4-1),lu,ls,'ch1');%3#lag =ch1 200*5.31, ,2# lag= ch1 200*-3.605 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day5_3_ch1] = get_alpha(200*5.355,name_200,folder,6*7+1+144*(5-1),6*22+144*(5-1),lu,ls,'ch1');%3#lag =ch1 200*5.355, ,2# lag= ch1 200*-3.545 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day6_3_ch1] = get_alpha(200*5.415,name_200,folder,6*7+1+144*(6-1),6*22+144*(6-1),lu,ls,'ch1');%3#lag =ch1 200*5.415,ch2 200*5.355,2# lag= ch1 200*-3.48 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day7_3_ch1] = get_alpha(200*5.465,name_200,folder,6*7+1+144*(7-1),6*22+144*(7-1),lu,ls,'ch1');%3#lag =ch1 200*5.465,ch2 200*5.41,2# lag= ch1 200*-3.42
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% alpha_3_ch1 = sum_s./sum_u;
% %'ch2'
% sum_u=zeros(lu*sf+ls*sf-1,1);
% sum_s=zeros(lu*sf+ls*sf-1,1);
% [s,u,alpha_day4_3_ch2] = get_alpha(200*5.31,name_200,folder,6*7+1+144*(4-1),6*22+144*(4-1),lu,ls,'ch2');%3#lag =ch1 200*5.31, ,2# lag= ch1 200*-3.605 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day5_3_ch2] = get_alpha(200*5.355,name_200,folder,6*7+1+144*(5-1),6*22+144*(5-1),lu,ls,'ch2');%3#lag =ch1 200*5.355, ,2# lag= ch1 200*-3.545 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day6_3_ch2] = get_alpha(200*5.415,name_200,folder,6*7+1+144*(6-1),6*22+144*(6-1),lu,ls,'ch2');%3#lag =ch1 200*5.415,ch2 200*5.355,2# lag= ch1 200*-3.48 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day7_3_ch2] = get_alpha(200*5.465,name_200,folder,6*7+1+144*(7-1),6*22+144*(7-1),lu,ls,'ch2');%3#lag =ch1 200*5.465,ch2 200*5.41,2# lag= ch1 200*-3.42
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% alpha_3_ch2 = sum_s./sum_u;
% %'ch3'
% sum_u=zeros(lu*sf+ls*sf-1,1);
% sum_s=zeros(lu*sf+ls*sf-1,1);
% [s,u,alpha_day4_3_ch3] = get_alpha(200*5.31,name_200,folder,6*7+1+144*(4-1),6*22+144*(4-1),lu,ls,'ch3');%3#lag =ch1 200*5.31, ,2# lag= ch1 200*-3.605 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day5_3_ch3] = get_alpha(200*5.355,name_200,folder,6*7+1+144*(5-1),6*22+144*(5-1),lu,ls,'ch3');%3#lag =ch1 200*5.355, ,2# lag= ch1 200*-3.545 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day6_3_ch3] = get_alpha(200*5.415,name_200,folder,6*7+1+144*(6-1),6*22+144*(6-1),lu,ls,'ch3');%3#lag =ch1 200*5.415,ch2 200*5.355,2# lag= ch1 200*-3.48 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day7_3_ch3] = get_alpha(200*5.465,name_200,folder,6*7+1+144*(7-1),6*22+144*(7-1),lu,ls,'ch3');%3#lag =ch1 200*5.465,ch2 200*5.41,2# lag= ch1 200*-3.42
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% alpha_3_ch3 = sum_s./sum_u;
% 
% folder = '2#\';
% %'ch1'
% sum_u=zeros(lu*sf+ls*sf-1,1);
% sum_s=zeros(lu*sf+ls*sf-1,1);
% [s,u,alpha_day4_2_ch1] = get_alpha(200*-3.605,name_200,folder,6*7+1+144*(4-1),6*22+144*(4-1),lu,ls,'ch1');%3#lag =ch1 200*5.31, ,2# lag= ch1 200*-3.605 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day5_2_ch1] = get_alpha(200*-3.545,name_200,folder,6*7+1+144*(5-1),6*22+144*(5-1),lu,ls,'ch1');%3#lag =ch1 200*5.355, ,2# lag= ch1 200*-3.545 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day6_2_ch1] = get_alpha(200*-3.48,name_200,folder,6*7+1+144*(6-1),6*22+144*(6-1),lu,ls,'ch1');%3#lag =ch1 200*5.415,ch2 200*5.355,2# lag= ch1 200*-3.48 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day7_2_ch1] = get_alpha(200*-3.42,name_200,folder,6*7+1+144*(7-1),6*22+144*(7-1),lu,ls,'ch1');%3#lag =ch1 200*5.465,ch2 200*5.41,2# lag= ch1 200*-3.42
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% alpha_2_ch1 = sum_s./sum_u;
% %'ch2'
% sum_u=zeros(lu*sf+ls*sf-1,1);
% sum_s=zeros(lu*sf+ls*sf-1,1);
% [s,u,alpha_day4_2_ch2] = get_alpha(200*-3.605,name_200,folder,6*7+1+144*(4-1),6*22+144*(4-1),lu,ls,'ch2');%3#lag =ch1 200*5.31, ,2# lag= ch1 200*-3.605 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day5_2_ch2] = get_alpha(200*-3.545,name_200,folder,6*7+1+144*(5-1),6*22+144*(5-1),lu,ls,'ch2');%3#lag =ch1 200*5.355, ,2# lag= ch1 200*-3.545 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day6_2_ch2] = get_alpha(200*-3.48,name_200,folder,6*7+1+144*(6-1),6*22+144*(6-1),lu,ls,'ch2');%3#lag =ch1 200*5.415,ch2 200*5.355,2# lag= ch1 200*-3.48 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day7_2_ch2] = get_alpha(200*-3.42,name_200,folder,6*7+1+144*(7-1),6*22+144*(7-1),lu,ls,'ch2');%3#lag =ch1 200*5.465,ch2 200*5.41,2# lag= ch1 200*-3.42
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% alpha_2_ch2 = sum_s./sum_u;
% %'ch3'
% sum_u=zeros(lu*sf+ls*sf-1,1);
% sum_s=zeros(lu*sf+ls*sf-1,1);
% [s,u,alpha_day4_2_ch3] = get_alpha(200*-3.605,name_200,folder,6*7+1+144*(4-1),6*22+144*(4-1),lu,ls,'ch3');%3#lag =ch1 200*5.31, ,2# lag= ch1 200*-3.605 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day5_2_ch3] = get_alpha(200*-3.545,name_200,folder,6*7+1+144*(5-1),6*22+144*(5-1),lu,ls,'ch3');%3#lag =ch1 200*5.355, ,2# lag= ch1 200*-3.545 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day6_2_ch3] = get_alpha(200*-3.48,name_200,folder,6*7+1+144*(6-1),6*22+144*(6-1),lu,ls,'ch3');%3#lag =ch1 200*5.415,ch2 200*5.355,2# lag= ch1 200*-3.48 
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% [s,u,alpha_day7_2_ch3] = get_alpha(200*-3.42,name_200,folder,6*7+1+144*(7-1),6*22+144*(7-1),lu,ls,'ch3');%3#lag =ch1 200*5.465,ch2 200*5.41,2# lag= ch1 200*-3.42
% sum_s = sum_s + s;
% sum_u = sum_u + u;
% alpha_2_ch3 = sum_s./sum_u;
% 
% span = 30;
% day4_3_ch1 = smooth(abs(alpha_day4_3_ch1),span);day4_3_ch2 = smooth(abs(alpha_day4_3_ch2),span);day4_3_ch3 = smooth(abs(alpha_day4_3_ch3),span);
% day5_3_ch1 = smooth(abs(alpha_day5_3_ch1),span);day5_3_ch2 = smooth(abs(alpha_day5_3_ch2),span);day5_3_ch3 = smooth(abs(alpha_day5_3_ch3),span);
% day6_3_ch1 = smooth(abs(alpha_day6_3_ch1),span);day6_3_ch2 = smooth(abs(alpha_day6_3_ch2),span);day6_3_ch3 = smooth(abs(alpha_day6_3_ch3),span);
% day7_3_ch1 = smooth(abs(alpha_day7_3_ch1),span);day7_3_ch2 = smooth(abs(alpha_day7_3_ch2),span);day7_3_ch3 = smooth(abs(alpha_day7_3_ch3),span);
% day_3_ch1 = smooth(abs(alpha_3_ch1),span);day_3_ch2 = smooth(abs(alpha_3_ch2),span);day_3_ch3 = smooth(abs(alpha_3_ch3),span);
% day4_2_ch1 = smooth(abs(alpha_day4_2_ch1),span);day4_2_ch2 = smooth(abs(alpha_day4_2_ch2),span);day4_2_ch3 = smooth(abs(alpha_day4_2_ch3),span);
% day5_2_ch1 = smooth(abs(alpha_day5_2_ch1),span);day5_2_ch2 = smooth(abs(alpha_day5_2_ch2),span);day5_2_ch3 = smooth(abs(alpha_day5_2_ch3),span);
% day6_2_ch1 = smooth(abs(alpha_day6_2_ch1),span);day6_2_ch2 = smooth(abs(alpha_day6_2_ch2),span);day6_2_ch3 = smooth(abs(alpha_day6_2_ch3),span);
% day7_2_ch1 = smooth(abs(alpha_day7_2_ch1),span);day7_2_ch2 = smooth(abs(alpha_day7_2_ch2),span);day7_2_ch3 = smooth(abs(alpha_day7_2_ch3),span);
% day_2_ch1 = smooth(abs(alpha_2_ch1),span);day_2_ch2 = smooth(abs(alpha_2_ch2),span);day_2_ch3 = smooth(abs(alpha_2_ch3),span);
% 
% figure(99)
% subplot(2,3,1),plot(f,day4_2_ch1,f,day5_2_ch1,f,day6_2_ch1,f,day7_2_ch1,'linewidth',1.4),hold on
%     plot(f,day_2_ch1,'linewidth',3),xlim([0 20]),ylim([0 2.5]),set(gca,'fontsize',18),set(gca,'xtick',0:2:20)...
%         ,legend('10月4号','10月5号','10月6号','10月7号','4天总叠加'),set(legend,'fontsize',8),title('2# NS')...
%         ,ylabel('场地传递函数幅值','fontsize',18),xlabel('频率 f/Hz','fontsize',18)
% subplot(2,3,2),plot(f,day4_2_ch2,f,day5_2_ch2,f,day6_2_ch2,f,day7_2_ch2,'linewidth',1.3),hold on
%     plot(f,day_2_ch2,'linewidth',3),xlim([0 20]),ylim([0 1.5]),set(gca,'fontsize',18),set(gca,'xtick',0:2:20)...
%         ,legend('10月4号','10月5号','10月6号','10月7号','4天总叠加'),set(legend,'fontsize',8),title('2# EW')...
%         ,ylabel('场地传递函数幅值','fontsize',18),xlabel('频率 f/Hz','fontsize',18)
% subplot(2,3,3),plot(f,day4_2_ch3,f,day5_2_ch3,f,day6_2_ch3,f,day7_2_ch3,'linewidth',1.3),hold on
%     plot(f,day_2_ch3,'linewidth',3),xlim([0 20]),ylim([0 1]),set(gca,'fontsize',18),set(gca,'xtick',0:2:20)...
%         ,legend('10月4号','10月5号','10月6号','10月7号','4天总叠加'),set(legend,'fontsize',8),title('2# UD')...
%         ,ylabel('场地传递函数幅值','fontsize',18),xlabel('频率 f/Hz','fontsize',18)
% subplot(2,3,4),plot(f,day4_3_ch1,f,day5_3_ch1,f,day6_3_ch1,f,day7_3_ch1,'linewidth',1.3),hold on
%     plot(f,day_3_ch1,'linewidth',3),xlim([0 20]),ylim([0 2]),set(gca,'fontsize',18),set(gca,'xtick',0:2:20)...
%         ,legend('10月4号','10月5号','10月6号','10月7号','4天总叠加'),set(legend,'fontsize',8),title('3# NS')...
%         ,ylabel('场地传递函数幅值','fontsize',18),xlabel('频率 f/Hz','fontsize',18)
% subplot(2,3,5),plot(f,day4_3_ch2,f,day5_3_ch2,f,day6_3_ch2,f,day7_3_ch2,'linewidth',1.3),hold on
%     plot(f,day_3_ch2,'linewidth',3),xlim([0 20]),ylim([0 1.5]),set(gca,'fontsize',18),set(gca,'xtick',0:2:20)...
%         ,legend('10月4号','10月5号','10月6号','10月7号','4天总叠加'),set(legend,'fontsize',8),title('3# EW')...
%         ,ylabel('场地传递函数幅值','fontsize',18),xlabel('频率 f/Hz','fontsize',18)
% subplot(2,3,6),plot(f,day4_3_ch3,f,day5_3_ch3,f,day6_3_ch3,f,day7_3_ch3,'linewidth',1.3),hold on
%     plot(f,day_3_ch3,'linewidth',3),xlim([0 20]),ylim([0 1]),set(gca,'fontsize',18),set(gca,'xtick',0:2:20)...
%         ,legend('10月4号','10月5号','10月6号','10月7号','4天总叠加'),set(legend,'fontsize',8),title('3# UD')...
%         ,ylabel('场地传递函数幅值','fontsize',18),xlabel('频率 f/Hz','fontsize',18)




%多日单小时比较
folder = '2#\';
%'ch1'
i = 1;
while(i <= 15)
    sum_u=zeros(lu*sf+ls*sf-1,1);
    sum_s=zeros(lu*sf+ls*sf-1,1);
    [s,u,~] = get_alpha(200*-3.605,name_200,folder,6*(i+6)+1+144*(4-1),6*(i+7)+144*(4-1),lu,ls,'ch1');
    sum_s = sum_s + s;sum_u = sum_u + u;
    [s,u,~] = get_alpha(200*-3.48,name_200,folder,6*(i+6)+1+144*(6-1),6*(i+7)+144*(6-1),lu,ls,'ch1');
    sum_s = sum_s + s;sum_u = sum_u + u;
    [s,u,~] = get_alpha(200*-3.42,name_200,folder,6*(i+6)+1+144*(7-1),6*(i+7)+144*(7-1),lu,ls,'ch1');
    sum_s = sum_s + s;sum_u = sum_u + u;
    if(i ~= 6 && i ~= 7 && i ~= 8)
        [s,u,~] = get_alpha(200*-3.545,name_200,folder,6*(i+6)+1+144*(5-1),6*(i+7)+144*(5-1),lu,ls,'ch1');
        sum_s = sum_s + s;sum_u = sum_u + u;
    end
    result{i,1,1} = sum_s./sum_u;
    i = i + 1;
end
%'ch2'
i = 1;
while(i <= 15)
    sum_u=zeros(lu*sf+ls*sf-1,1);
    sum_s=zeros(lu*sf+ls*sf-1,1);
    [s,u,~] = get_alpha(200*-3.605,name_200,folder,6*(i+6)+1+144*(4-1),6*(i+7)+144*(4-1),lu,ls,'ch2');
    sum_s = sum_s + s;sum_u = sum_u + u;
    [s,u,~] = get_alpha(200*-3.48,name_200,folder,6*(i+6)+1+144*(6-1),6*(i+7)+144*(6-1),lu,ls,'ch2');
    sum_s = sum_s + s;sum_u = sum_u + u;
    [s,u,~] = get_alpha(200*-3.42,name_200,folder,6*(i+6)+1+144*(7-1),6*(i+7)+144*(7-1),lu,ls,'ch2');
    sum_s = sum_s + s;sum_u = sum_u + u;
    if(i ~= 6 && i ~= 7 && i ~= 8)
        [s,u,~] = get_alpha(200*-3.545,name_200,folder,6*(i+6)+1+144*(5-1),6*(i+7)+144*(5-1),lu,ls,'ch2');
        sum_s = sum_s + s;sum_u = sum_u + u;
    end
    result{i,1,2} = sum_s./sum_u;
    i = i + 1;
end
%'ch3'
i = 1;
while(i <= 15)
    sum_u=zeros(lu*sf+ls*sf-1,1);
    sum_s=zeros(lu*sf+ls*sf-1,1);
    [s,u,~] = get_alpha(200*-3.605,name_200,folder,6*(i+6)+1+144*(4-1),6*(i+7)+144*(4-1),lu,ls,'ch3');
    sum_s = sum_s + s;sum_u = sum_u + u;
    [s,u,~] = get_alpha(200*-3.48,name_200,folder,6*(i+6)+1+144*(6-1),6*(i+7)+144*(6-1),lu,ls,'ch3');
    sum_s = sum_s + s;sum_u = sum_u + u;
    [s,u,~] = get_alpha(200*-3.42,name_200,folder,6*(i+6)+1+144*(7-1),6*(i+7)+144*(7-1),lu,ls,'ch3');
    sum_s = sum_s + s;sum_u = sum_u + u;
    if(i ~= 6 && i ~= 7 && i ~= 8)
        [s,u,~] = get_alpha(200*-3.545,name_200,folder,6*(i+6)+1+144*(5-1),6*(i+7)+144*(5-1),lu,ls,'ch3');
        sum_s = sum_s + s;sum_u = sum_u + u;
    end
    result{i,1,3} = sum_s./sum_u;
    i = i + 1;
end

folder = '3#\';
%'ch1'
i = 1;
while(i <= 15)
    sum_u=zeros(lu*sf+ls*sf-1,1);
    sum_s=zeros(lu*sf+ls*sf-1,1);
    [s,u,~] = get_alpha(200*5.31,name_200,folder,6*(i+6)+1+144*(4-1),6*(i+7)+144*(4-1),lu,ls,'ch1');
    sum_s = sum_s + s;sum_u = sum_u + u;
    [s,u,~] = get_alpha(200*5.415,name_200,folder,6*(i+6)+1+144*(6-1),6*(i+7)+144*(6-1),lu,ls,'ch1');
    sum_s = sum_s + s;sum_u = sum_u + u;
    [s,u,~] = get_alpha(200*5.465,name_200,folder,6*(i+6)+1+144*(7-1),6*(i+7)+144*(7-1),lu,ls,'ch1');
    sum_s = sum_s + s;sum_u = sum_u + u;
    if(i ~= 6 && i ~= 7 && i ~= 8)
        [s,u,~] = get_alpha(200*5.355,name_200,folder,6*(i+6)+1+144*(5-1),6*(i+7)+144*(5-1),lu,ls,'ch1');
        sum_s = sum_s + s;sum_u = sum_u + u;
    end
    result{i,2,1} = sum_s./sum_u;
    i = i + 1;
end
%'ch2'
i = 1;
while(i <= 15)
    sum_u=zeros(lu*sf+ls*sf-1,1);
    sum_s=zeros(lu*sf+ls*sf-1,1);
    [s,u,~] = get_alpha(200*5.31,name_200,folder,6*(i+6)+1+144*(4-1),6*(i+7)+144*(4-1),lu,ls,'ch2');
    sum_s = sum_s + s;sum_u = sum_u + u;
    [s,u,~] = get_alpha(200*5.415,name_200,folder,6*(i+6)+1+144*(6-1),6*(i+7)+144*(6-1),lu,ls,'ch2');
    sum_s = sum_s + s;sum_u = sum_u + u;
    [s,u,~] = get_alpha(200*5.465,name_200,folder,6*(i+6)+1+144*(7-1),6*(i+7)+144*(7-1),lu,ls,'ch2');
    sum_s = sum_s + s;sum_u = sum_u + u;
    if(i ~= 6 && i ~= 7 && i ~= 8)
        [s,u,~] = get_alpha(200*5.355,name_200,folder,6*(i+6)+1+144*(5-1),6*(i+7)+144*(5-1),lu,ls,'ch2');
        sum_s = sum_s + s;sum_u = sum_u + u;
    end
    result{i,2,2} = sum_s./sum_u;
    i = i + 1;
end
%'ch3'
i = 1;
while(i <= 15)
    sum_u=zeros(lu*sf+ls*sf-1,1);
    sum_s=zeros(lu*sf+ls*sf-1,1);
    [s,u,~] = get_alpha(200*5.31,name_200,folder,6*(i+6)+1+144*(4-1),6*(i+7)+144*(4-1),lu,ls,'ch3');
    sum_s = sum_s + s;sum_u = sum_u + u;
    [s,u,~] = get_alpha(200*5.415,name_200,folder,6*(i+6)+1+144*(6-1),6*(i+7)+144*(6-1),lu,ls,'ch3');
    sum_s = sum_s + s;sum_u = sum_u + u;
    [s,u,~] = get_alpha(200*5.465,name_200,folder,6*(i+6)+1+144*(7-1),6*(i+7)+144*(7-1),lu,ls,'ch3');
    sum_s = sum_s + s;sum_u = sum_u + u;
    if(i ~= 6 && i ~= 7 && i ~= 8)
        [s,u,~] = get_alpha(200*5.355,name_200,folder,6*(i+6)+1+144*(5-1),6*(i+7)+144*(5-1),lu,ls,'ch3');
        sum_s = sum_s + s;sum_u = sum_u + u;
    end
    result{i,2,3} = sum_s./sum_u;
    i = i + 1;
end

% span = 30;
% for i = 1:15
%     z{i,1,1} = smooth(abs(result{i,1,1}),span);z{i,1,2} = smooth(abs(result{i,1,2}),span);z{i,1,3} = smooth(abs(result{i,1,3}),span);
%     z{i,2,1} = smooth(abs(result{i,2,1}),span);z{i,2,2} = smooth(abs(result{i,2,2}),span);z{i,2,3} = smooth(abs(result{i,2,3}),span);
% end
% 
% figure(101)
% for i = 1:3
%     subplot(2,3,i)
%     plot(f,z{1,1,i},f,z{2,1,i},f,z{3,1,i},f,z{4,1,i},f,z{5,1,i},f,z{6,1,i},f,z{7,1,i},f,z{8,1,i},f,z{9,1,i},f,z{10,1,i},...
%         f,z{11,1,i},f,z{12,1,i},f,z{13,1,i},f,z{14,1,i},f,z{15,1,i},'linewidth',1.3),xlim([0 20])...
%         ,set(gca,'fontsize',18),set(gca,'xtick',0:2:20),xlabel('频率 f/Hz','fontsize',18),ylabel('场地传递函数幅值','fontsize',18)
% end
% for i = 1:3
%     subplot(2,3,i+3)
%     plot(f,z{1,2,i},f,z{2,2,i},f,z{3,2,i},f,z{4,2,i},f,z{5,2,i},f,z{6,2,i},f,z{7,2,i},f,z{8,2,i},f,z{9,2,i},f,z{10,2,i},...
%         f,z{11,2,i},f,z{12,2,i},f,z{13,2,i},f,z{14,2,i},f,z{15,2,i},'linewidth',1.3),xlim([0 20])...
%         ,set(gca,'fontsize',18),set(gca,'xtick',0:2:20),xlabel('频率 f/Hz','fontsize',18),ylabel('场地传递函数幅值','fontsize',18)
% end
% handle = get(gcf,'children');
% axes(handle(6));title('2# NS');set(handle(6),'ytick',0:0.5:3);
% axes(handle(5));title('2# EW');
% axes(handle(4));title('2# UD');
% axes(handle(3));title('3# NS');
% axes(handle(2));title('3# EW');
% axes(handle(1));title('3# UD');


for i = 1:15
    z{i,1,1} = abs(result{i,1,1});z{i,1,2} = abs(result{i,1,2});z{i,1,3} = abs(result{i,1,3});
    z{i,2,1} = abs(result{i,2,1});z{i,2,2} = abs(result{i,2,2});z{i,2,3} = abs(result{i,2,3});
end
figure(102)
for i = 1:3
    subplot(2,3,i)
    plot(f,z{1,1,i},f,z{2,1,i},f,z{3,1,i},f,z{4,1,i},f,z{5,1,i},f,z{6,1,i},f,z{7,1,i},f,z{8,1,i},f,z{9,1,i},f,z{10,1,i},...
        f,z{11,1,i},f,z{12,1,i},f,z{13,1,i},f,z{14,1,i},f,z{15,1,i},'linewidth',1.3),xlim([0 20])...
        ,set(gca,'fontsize',18),set(gca,'xtick',0:2:20),xlabel('频率 f/Hz','fontsize',18),ylabel('场地传递函数幅值','fontsize',18)
end
for i = 1:3
    subplot(2,3,i+3)
    plot(f,z{1,2,i},f,z{2,2,i},f,z{3,2,i},f,z{4,2,i},f,z{5,2,i},f,z{6,2,i},f,z{7,2,i},f,z{8,2,i},f,z{9,2,i},f,z{10,2,i},...
        f,z{11,2,i},f,z{12,2,i},f,z{13,2,i},f,z{14,2,i},f,z{15,2,i},'linewidth',1.3),xlim([0 20])...
        ,set(gca,'fontsize',18),set(gca,'xtick',0:2:20),xlabel('频率 f/Hz','fontsize',18),ylabel('场地传递函数幅值','fontsize',18)
end
handle = get(gcf,'children');
axes(handle(6));title('2# NS');set(handle(6),'ytick',0:0.5:3);
axes(handle(5));title('2# EW');
axes(handle(4));title('2# UD');
axes(handle(3));title('3# NS');
axes(handle(2));title('3# EW');
axes(handle(1));title('3# UD');

% load('测试数据总图.mat');
% figure(10)
% subplot(2,2,1),plot(fA,abs(z_1_test),fA,abs(z_1_revise),'linewidth',1.4),xlabel('频率 f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('真实值','估计值'),xlim([0 100]),set(legend,'fontsize',15)
% subplot(2,2,2),plot(fA,abs(z_1_test),fA,z_1_smooth,'linewidth',1.4),xlabel('频率 f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('真实值','平滑后的估计值'),xlim([0 100]),xlim([0 100]),set(legend,'fontsize',15)
% subplot(2,2,3),plot(fA,abs(z_2_test),fA,abs(z_2_revise),'linewidth',1.4),xlabel('频率 f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('真实值','估计值'),xlim([0 100]),xlim([0 100]),set(legend,'fontsize',15)
% subplot(2,2,4),plot(fA,abs(z_2_test),fA,z_2_smooth,'linewidth',1.4),xlabel('频率 f/Hz','fontsize',22),ylabel('场地传递函数幅值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('真实值','平滑后的估计值'),xlim([0 100]),xlim([0 100]),set(legend,'fontsize',15)




% figure(102)
% for i = 1:3
%     subplot(2,3,i)
%     plot(f,result{1,1,i},f,result{2,1,i},f,result{3,1,i},f,result{4,1,i},f,result{5,1,i},f,result{6,1,i},f,result{7,1,i},f,result{8,1,i},f,result{9,1,i},f,result{10,1,i},...
%         f,result{11,1,i},f,result{12,1,i},f,result{13,1,i},f,result{14,1,i},f,result{15,1,i},'linewidth',1.3),xlim([0 20])...
%         ,set(gca,'fontsize',18),set(gca,'xtick',0:2:20),xlabel('频率 f/Hz','fontsize',18),ylabel('场地传递函数幅值','fontsize',18)
% end
% for i = 1:3
%     subplot(2,3,i+3)
%     plot(f,result{1,2,i},f,result{2,2,i},f,result{3,2,i},f,result{4,2,i},f,result{5,2,i},f,result{6,2,i},f,result{7,2,i},f,result{8,2,i},f,result{9,2,i},f,result{10,2,i},...
%         f,result{11,2,i},f,result{12,2,i},f,result{13,2,i},f,result{14,2,i},f,result{15,2,i},'linewidth',1.3),xlim([0 20])...
%         ,set(gca,'fontsize',18),set(gca,'xtick',0:2:20),xlabel('频率 f/Hz','fontsize',18),ylabel('场地传递函数幅值','fontsize',18)
% end