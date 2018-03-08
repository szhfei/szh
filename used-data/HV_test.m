%H/V test
clear all
folder = '3#\';
load('D:\szh\test\used-data\namelist\name_200.mat','name_200');

sf = 200;
len = 20;
f = [0:len*sf-1]'/(len*sf)*sf;
win = tukeywin(len*sf,0.2);

count = 1;
res = zeros(len*sf,1);
for i=(6*0+4+144*(4-1)):(6*3+4+144*(4-1))
    load(['D:\szh\test\used-data\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
    
    time = fix(600/len);
    for k=0:time-1
        sch1 = surf_ch1((k*len*sf+1):(k*len*sf+len*sf));
        sch2 = surf_ch2((k*len*sf+1):(k*len*sf+len*sf));
        sch3 = surf_ch3((k*len*sf+1):(k*len*sf+len*sf));
        
        sch1 = sch1 .* win;
        sch2 = sch2 .* win;
        sch3 = sch3 .* win;
        
        fch1 = abs(fft(sch1));
        fch2 = abs(fft(sch2));
        fch3 = abs(fft(sch3));
        
        H{count} = sqrt(fch1 .^2 + fch2 .^2) ./ fch3;
        res = res + H{count};
        count = count + 1;
    end
end
res = res / (count - 1);


figure(1000)
plot(f,res),xlim([1 10]),ylim([0 7])

% figure(1001)
% hold on
% for i=1:length(H)
%     plot(f,H{i}),xlim([0.1 20])
% end