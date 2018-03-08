% %pick data and save
% clear all
% folder='3#\';
% load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% 
% l = 120000;
% n = [0:l-1]';
% fs = 200;
% num_u = 30 * fs;
% num_s = 30 * fs;
% count = 0;
% 
% for i = 6*12+2+144*(4-1):6*22+1+144*(4-1)
%     disp(name_200{i})
%     load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
%     load(['D:\szh\test\used-data\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
%     u1 = under_ch1;u2 = under_ch2;u3 = under_ch3;
%     s1 = surf_ch1;s2 = surf_ch2;s3 = surf_ch3;
%     clear under_ch1 under_ch2 under_ch3 surf_ch1 surf_ch2 surf_ch3
%     
%     Hd = bandpass1_20;
%     uch1=filter(Hd,u1);
%     uch1=flipud(uch1);
%     uch1=filter(Hd,uch1);
%     uch1=flipud(uch1);
%     uch2=filter(Hd,u2);
%     uch2=flipud(uch2);
%     uch2=filter(Hd,uch2);
%     uch2=flipud(uch2);
%     uch3=filter(Hd,u3);
%     uch3=flipud(uch3);
%     uch3=filter(Hd,uch3);
%     uch3=flipud(uch3);
%     sch1=filter(Hd,s1);
%     sch1=flipud(sch1);
%     sch1=filter(Hd,sch1);
%     sch1=flipud(sch1);
%     sch2=filter(Hd,s2);
%     sch2=flipud(sch2);
%     sch2=filter(Hd,sch2);
%     sch2=flipud(sch2);
%     sch3=filter(Hd,s3);
%     sch3=flipud(sch3);
%     sch3=filter(Hd,sch3);
%     sch3=flipud(sch3);
%     
%     figure(201)
%     subplot(3,1,1),plot(u1),axis([0 l -0.1 0.1]);
%     subplot(3,1,2),plot(uch1),axis([0 l -0.1 0.1]);
%     subplot(3,1,3),plot(sch1),axis([0 l -0.1 0.1]);
%     figure(202)
%     subplot(3,1,1),plot(u2),axis([0 l -0.2 0.2]);
%     subplot(3,1,2),plot(uch2),axis([0 l -0.2 0.2]);
%     subplot(3,1,3),plot(sch2),axis([0 l -0.2 0.2]);
%     figure(203)
%     subplot(3,1,1),plot(u3),axis([0 l -0.2 0.2]);
%     subplot(3,1,2),plot(uch3),axis([0 l -0.2 0.2]);
%     subplot(3,1,3),plot(sch3),axis([0 l -0.2 0.2]);
%      
%     figure(201)
%     temp = ginput();
%     t = size(temp,1);
%     for j = 1:t
%         istart = round(temp(j,1) - fs * 2);
%         under_ch1 = u1(istart:istart -1 + num_u);
%         under_ch2 = u2(istart:istart -1 + num_u);
%         under_ch3 = u3(istart:istart -1 + num_u);
%         surf_ch1 = s1(istart:istart -1 + num_s);
%         surf_ch2 = s2(istart:istart -1 + num_s);
%         surf_ch3 = s3(istart:istart -1 + num_s);
%         save(['D:\szh\test\used-data\picked_data\',folder,name_200{i}(1:8),'_',num2str(j),'.mat'],'under_ch1','under_ch2','under_ch3','surf_ch1','surf_ch2','surf_ch3','istart');
%         clear under_ch1 under_ch2 under_ch3 surf_ch1 surf_ch2 surf_ch3 istart
%         count = count + 1;
%         name_new{count} = [name_200{i}(1:8),'_',num2str(j),'.mat'];
%     end
%     clear temp t j
% %     close all
% end

%%
%挑出的地铁数据计算
clear all
folder = '3#\';

load('D:\szh\test\used-data\picked_data\name.mat','name');
sf = 200;
l = 120000;
lag = 1062;
lu = 20;
ls = 20;
channel = 'ch1';
istart = '0700';
iend = '1900';
t1 = str2num(istart(1:2))*6 + str2num(istart(3));
t2 = str2num(iend(1:2))*6 + str2num(iend(3));


sum_u = zeros(lu*sf + ls*sf -1,1);
sum_s = zeros(lu*sf + ls*sf -1,1);

win_u = tukeywin(lu*sf,0.2);
win_s = tukeywin(ls*sf,0.2);
count = 0;
for i = 1:length(name)
    temp = str2num(name{i}(5:6))*6 + str2num(name{i}(7));
    if(temp < t1)
        continue;
    elseif(temp >= t2)
        break;
    else
        load(['D:\szh\test\used-data\picked_data\',folder,name{i}]);
        if(strcmp(channel,'ch1') == 1)
%             cor = xcorr(surf_ch1,under_ch1);
%             [~,b] = max(cor);
%             lag = b - length(under_ch1);
            uch = under_ch1(1:lu*sf);
            sch = surf_ch1(1+lag:ls*sf+lag);
            uch = uch .* win_u;
            sch = sch .* win_s;
            fu = fft(uch,lu*sf+ls*sf-1);
            fs = fft(sch,lu*sf+ls*sf-1);
            sum_u = sum_u + fu .* conj(fu);
            sum_s = sum_s + fs .* conj(fu);
            count = count + 1;
        elseif(strcmp(channel,'ch2') == 1)
            uch = under_ch2(1:lu*sf);
            sch = surf_ch2(1+lag:ls*sf+lag);
            uch = uch .* win_u;
            sch = sch .* win_s;
            fu = fft(uch,lu*sf+ls*sf-1);
            fs = fft(sch,lu*sf+ls*sf-1);
            sum_u = sum_u + fu .* conj(fu);
            sum_s = sum_s + fs .* conj(fu);
        elseif(strcmp(channel,'ch3') == 1)
            uch = under_ch3(1:lu*sf);
            sch = surf_ch3(1+lag:ls*sf+lag);
            uch = uch .* win_u;
            sch = sch .* win_s;
            fu = fft(uch,lu*sf+ls*sf-1);
            fs = fft(sch,lu*sf+ls*sf-1);
            sum_u = sum_u + fu .* conj(fu);
            sum_s = sum_s + fs .* conj(fu);
        end
    end
end
alpha = sum_s ./ sum_u;
Alpha = ifft(alpha);

f = [0:length(alpha)-1]'/length(alpha)*200;
% figure(1)
% plot(f,abs(alpha))
figure(2)
plot(Alpha)
figure(3)
plot(f,abs(alpha)),xlim([0.1 15])



load(['D:\szh\test\used-data\picked_data\',folder,name{1}]);

Hd = bandpass2_10;

uuu = under_ch1;
sss = surf_ch1;

len = length(Alpha);
temp = conv(fftshift(Alpha),uuu);
sch_left = sss - temp(lag+1+(len-1)/2:lag+length(uuu)+(len-1)/2);

u = myfilter(Hd,uuu);
s = myfilter(Hd,sss);
left = myfilter(Hd,sch_left);

figure(100)
subplot(3,1,1),plot(u)
subplot(3,1,2),plot(s)
subplot(3,1,3),plot(left)
