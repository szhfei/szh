%get error with different lu ls / number
clear all

folder = 'doublepeak-noise-similar-2\';
% folder = 'new100-similar--noise_similar-2\';
% folder = 'doublepeak-5s+5s_0\';
% folder = 'doublepeak-5s\';
% folder='new100\';
% folder='3#10-04-07-19-ch2-change\';
% [name_200,name_3]=list('D:\szh\test\used-data\200#\',['D:\szh\test\used-data\',folder]);
load('D:\szh\test\used-data\namelist\name_200.mat','name_200');

% error_1 = get_error(name_200,folder,1000,20,20,1000);
% error_2 = get_error(name_200,folder,1000,50,50,1000);
% error_3 = get_error(name_200,folder,1000,100,100,1000);
% sf = 200;
% lA = length(error_1);
% nA = 0:lA-1;
% nA = nA';
% tA = nA / sf;
% fA = nA * sf / lA;
% for j=1:length(nA)
%     if(fA(j)>=20)
%         NA=j-1;
%         break
%     end
% end
% figure(100)
% plot(fA,error_1,fA,error_2,fA,error_3,'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('误差的绝对值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('20s','50s','100s')%,title('相同叠加次数下时窗长度对误差的影响')

[error_1,error_1_smooth] = get_error(name_200,folder,1000,50,50,50);
[error_2,error_2_smooth] = get_error(name_200,folder,1000,50,50,100);
[error_3,error_3_smooth] = get_error(name_200,folder,1000,50,50,400);
[error_4,error_4_smooth] = get_error(name_200,folder,1000,20,20,1000);
[error_5,error_5_smooth] = get_error(name_200,folder,1000,50,50,1000);
[error_6,error_6_smooth] = get_error(name_200,folder,1000,100,100,1000);
sf = 200;
lA = length(error_1);
nA = 0:lA-1;
nA = nA';
tA = nA / sf;
fA = nA * sf / lA;
for j=1:length(nA)
    if(fA(j)>=20)
        NA=j-1;
        break
    end
end

figure(20)
subplot(1,2,1),plot(fA,error_4,fA,error_5,fA,error_6,'linewidth',1.3),xlim([0 100]),xlabel('频率 f/Hz','fontsize',22),ylabel('误差的绝对值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('20s','50s','100s')%,title('相同叠加次数下时窗长度对误差的影响')
subplot(1,2,2),plot(fA,error_1,fA,error_2,fA,error_3,'linewidth',1.3),xlim([0 100]),xlabel('频率 f/Hz','fontsize',22),ylabel('误差的绝对值','fontsize',22)...
    ,set(gca,'fontsize',22),legend('50','100','400')%,title('相同时窗长度下叠加次数对误差的影响')


% figure(21)
% plot(fA,error_1_smooth,fA,error_2_smooth,fA,error_3_smooth,'linewidth',1.3),xlim([0 100]),xlabel('f/Hz','fontsize',22),ylabel('误差的绝对值','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('50','100','400')%,title('相同时窗长度下叠加次数对误差的影响')
