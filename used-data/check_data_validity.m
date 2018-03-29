%检查事件是否可用，调整lag
clear all

load('D:\szh\test\used-data\picked_data\T\list_1.mat');
path='D:\szh\test\used-data\高铁\HSRdata_merge\SAC_T\';
len = 17280000;
fs = 200;
HD = highpassp501;

[ori_data,hd,ftime] = loaddata(path,3);
start=1;
while(ori_data(start)==0)
    start=start+1;
end
start
ending=len;
while(ori_data(ending)==0)
    ending=ending-1;
end
ending
istart = start + 3000 +1;
iend  = ending - 5000;
u = ori_data(istart:iend)-sum(ori_data(istart:iend))/len;
tt = [0:iend-istart]';
p = polyfit(tt,u,1);
uuu = u - (p(1) * tt + p(2));
clear u ori_data tt p
uuu_filtered = myfilter(HD,uuu);


%读取另一台作对比
[ori_data,hd2,ftime2] = loaddata(path,60);
kstart=1;
while(ori_data(kstart)==0)
    kstart=kstart+1;
end
kstart
kend=len;
while(ori_data(kend)==0)
    kend=kend-1;
end
kend
x = kstart + 3000 +1;
xx = kend - 5000;
u = ori_data(x:xx)-sum(ori_data(x:xx))/len;
tt = [0:xx-x]';
p = polyfit(tt,u,1);
utemp = u - (p(1) * tt + p(2));
clear u tt ori_data p
utemp_filtered = myfilter(HD,utemp);
temp = zeros(17280000,1);
temp(x:xx) = utemp(1:end);
clear utemp
utest = temp(istart:iend);
clear temp
temp = zeros(17280000,1);
temp(x:xx) = utemp_filtered(1:end);
clear utemp_filtered
utest_filtered = temp(istart:iend);
clear temp


num_u = 20 * fs;
list_revised = 0;
count = 1;
for i = 1:length(list)
    str = sprintf('loop i = %d',i);
    disp(str);
    str = sprintf('count = %d',count);
    disp(str);
    
    jstart = list(i) - (istart - 1);
    jend = jstart + num_u - 1;
    
    uch = uuu(jstart:jend);
    uch_filtered = uuu_filtered(jstart:jend);
    figure(10)
%     plot(uch)
    plot(uch_filtered)
    clear uch uch_filtered
    
    uuch = utest(jstart:jend);
    uuch_filtered = utest_filtered(jstart:jend);
    figure(11)
%     plot(uuch)
    plot(uuch_filtered)
    clear uuch uuch_filtered
    
    judge = input('y/n');
    if(judge == 'y')
        list_revised(count,1) = list(i);
        count = count + 1;
    elseif(judge == 'n')
        continue
    elseif(judge == 'C')
        lag = input('lag=?');
        list_revised(count,1) = list(i) + lag;
        count = count + 1;
    else
        break
    end
end