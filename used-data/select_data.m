%%
%高铁事件挑选

clear all
path='D:\szh\test\used-data\高铁\HSRdata_merge\SAC_T\';
[ori_data,hd,ftime] = loaddata(path,3);

fs = 200;
len=17280000;
% t=[0:len-1]'/200;

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


istart=start + 3000 +1;
iend=ending-5000;
u=ori_data(istart:iend)-sum(ori_data(istart:iend))/len;
tt=[0:iend-istart]';
p=polyfit(tt,u,1);
uuu=u-(p(1)*tt+p(2));
clear u
HD = highpass0p5;
% aaa = myfilter(HD,uuu);
% figure(1)
% plot(tt/200,aaa)


%读取另一台作对比
[ori_data,hd2,ftime2] = loaddata(path,93);
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
x=kstart + 3000 +1;
xx=kend-5000;
u=ori_data(x:xx)-sum(ori_data(x:xx))/len;
tt=[0:xx-x]';
p=polyfit(tt,u,1);
utemp=u-(p(1)*tt+p(2));
clear u tt
utemp = myfilter(HD,utemp);
temp = zeros(17280000,1);
temp(x:xx)=utemp(1:end);
clear utemp
utest = temp(istart:iend);
clear temp


%select data point
folder = [hd.kstnm(1:4),'\'];
mkdir(['picked_data\T\',hd.kstnm])

l = 60000;
n = [0:l-1]';
num_u = 20 * fs;


lll = length(uuu);
time = fix(lll/l);

HD = highpass0p5;
yyy = myfilter(HD,uuu);

count = 1;
list = 0;
for i = 0:time-1
    pstart = i*l+1;
    pend = i*l+l;
    u = uuu(pstart:pend);
    zzz = yyy(pstart:pend);
    figure(201)
    plot(n,zzz)
    
    figure(202)
    plot(utest(pstart:pend))
     
    figure(201)
    temp = ginput();
    t = size(temp,1);
    for j = 1:t
        disp(count);
        ibegin = round(temp(j,1) - fs * 1);
        if(ibegin<0)
            ibegin = round(temp(j,1));
        end
        
        list(count,1) = pstart + ibegin + (istart-1);
        
%         under_ch1 = u(istart:istart -1 + num_u);
%         save(['D:\szh\test\used-data\picked_data\test\',folder,num2str(count),'.mat'],'under_ch1');
%         clear under_ch1 istart
        
        count = count + 1;
    end
    clear temp t j

end


