%保存高铁事件
clear all

staNum = 20;
ch = 3;
Sta_num_1 = ch;
Sta_num_2 = 3*(staNum - 1) + ch;

list_name = ['list_T0',num2str(staNum),'_TTT'];
load(['D:\szh\test\used-data\picked_data\T\',list_name,'.mat']);
path='D:\szh\test\used-data\高铁\HSRdata_merge\SAC_T\';
len = 17280000;
fs = 200;
HD = highpassp501;

[ori_data,hd,ftime] = loaddata(path,Sta_num_1);
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


%读取另一台
[ori_data,hd2,ftime2] = loaddata(path,Sta_num_2);
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


%save data


if(strcmp(hd2.kstnm(1:4),list_name(6:9)) == 1)%check
    

folder = [hd2.kstnm(1:4),'\'];
mkdir(['picked_data\T\',hd2.kstnm])

l = length(list);
num_u = 20 * fs;
for i = 1:l
    jstart = list(i) - (istart - 1);
    jend = jstart + num_u - 1;
    
    u = uuu(jstart:jend);
    s = utest(jstart:jend);
    
    pNumber = list(i);
    
    hour = fix(pNumber / fs /3600);
    min = fix(pNumber / fs / 60 - 60*hour);
    sec = fix(pNumber / fs - hour*3600 - min*60);
    if(min >=10)
        time = ['0',num2str(hour),':',num2str(min),':',num2str(sec)];
    else
        time = ['0',num2str(hour),':0',num2str(min),':',num2str(sec)];
    end
    
    channel = hd2.kcmpnm(3);
    type = list_name(11:13);
    
    name(i).name = [type,'_',num2str(i)];
    name(i).id = i;
    name(i).pNumber = pNumber;
    name(i).time = time;
    name(i).channel = channel;
    name(i).type = type;
    
    save(['D:\szh\test\used-data\picked_data\T\',folder,name(i).name,'.mat'],'u','s','pNumber','time','channel','type');
    
    clear jstart jend u s pNumber time channel type
end
name = name(:);
save(['D:\szh\test\used-data\picked_data\T\',folder,'name_',list_name(11:13),'.mat'],'name');

end