function [under_ch1,under_ch2,under_ch3,surf_ch1,surf_ch2,surf_ch3]=tempchange(fileName1,fileName2,X)   %未修改文件名
[under_ch1, under_ch2, under_ch3, bn, under_sf, under_btime] = t3w(fileName1);
clear bn

Hd = testfilter100;
under_ch1=filter(Hd,under_ch1);
under_ch2=filter(Hd,under_ch2);
under_ch3=filter(Hd,under_ch3);

load(fileName2,'D_a','sf');
if(X==1)
    surf_ch1=D_a(1:120000,1);
    surf_ch2=D_a(1:120000,2);
    surf_ch3=D_a(1:120000,3);
end
if(X==2)
    surf_ch1=D_a(120001:240000,1);
    surf_ch2=D_a(120001:240000,2);
    surf_ch3=D_a(120001:240000,3);
end
if(X==3)
    surf_ch1=D_a(240001:360000,1);
    surf_ch2=D_a(240001:360000,2);
    surf_ch3=D_a(240001:360000,3);
end

surf_ch1=filter(Hd,surf_ch1);
surf_ch2=filter(Hd,surf_ch2);
surf_ch3=filter(Hd,surf_ch3);

if(under_sf~=sf)
    clear all
    return
end
Funder_ch1=fft(under_ch1);
Funder_ch2=fft(under_ch2);
Funder_ch3=fft(under_ch3);
Fsurf_ch1=fft(surf_ch1);
Fsurf_ch2=fft(surf_ch2);
Fsurf_ch3=fft(surf_ch3);
mag_under_ch1=abs(Funder_ch1);
mag_under_ch2=abs(Funder_ch2);
mag_under_ch3=abs(Funder_ch3);
mag_surf_ch1=abs(Fsurf_ch1);
mag_surf_ch2=abs(Fsurf_ch2);
mag_surf_ch3=abs(Fsurf_ch3);

l=length(under_ch1);
n=0:l-1;
t=n/sf;
f=n*sf/l;
f40=[0:24000-1]*sf/l;

figure(1)
subplot(2,3,1),plot(t,under_ch1),axis([0 600 -0.7 0.7]);
subplot(2,3,2),plot(t,under_ch2),axis([0 600 -0.7 0.7]);
subplot(2,3,3),plot(t,under_ch3),axis([0 600 -0.7 0.7]);
subplot(2,3,4),plot(t,surf_ch1),axis([0 600 -0.3 0.3]);
subplot(2,3,5),plot(t,surf_ch2),axis([0 600 -0.3 0.3]);
subplot(2,3,6),plot(t,surf_ch3),axis([0 600 -0.3 0.3]);

figure(2)
subplot(2,3,1),plot(f,mag_under_ch1),axis([0 200 0 100]);
subplot(2,3,2),plot(f,mag_under_ch2),axis([0 200 0 100]);
subplot(2,3,3),plot(f,mag_under_ch3),axis([0 200 0 100]);
subplot(2,3,4),plot(f,mag_surf_ch1),axis([0 200 0 100]);
subplot(2,3,5),plot(f,mag_surf_ch2),axis([0 200 0 100]);
subplot(2,3,6),plot(f,mag_surf_ch3),axis([0 200 0 100]);

figure(3)
subplot(2,3,1),plot(f40,mag_under_ch1(1:24000)),axis([0 40 0 100]);
subplot(2,3,2),plot(f40,mag_under_ch2(1:24000)),axis([0 40 0 100]);
subplot(2,3,3),plot(f40,mag_under_ch3(1:24000)),axis([0 40 0 100]);
subplot(2,3,4),plot(f40,mag_surf_ch1(1:24000)),axis([0 40 0 100]);
subplot(2,3,5),plot(f40,mag_surf_ch2(1:24000)),axis([0 40 0 100]);
subplot(2,3,6),plot(f40,mag_surf_ch3(1:24000)),axis([0 40 0 100]);


fid=fopen(['D:\szh\test\200#\',fileName1(5:14),'.txt'],'r');
if(fid==-1)
    fid=fopen(['D:\szh\test\200#\',fileName1(5:14),'.txt'],'w+');
    fprintf(fid,'%s:00\r\n',under_btime);
    for i=1:l
        fprintf(fid,'%.20f\t',under_ch1(i));
        fprintf(fid,'%.20f\t',under_ch2(i));
        fprintf(fid,'%.20f\r\n',under_ch3(i));
    end
end
fclose(fid);

namelength=length(fileName2);
if(strcmp('#',fileName2(5))==1)
    folder=fileName2(4:5);
else
    folder=fileName2(4:6);
end
filename=fileName2((namelength-13):(namelength-4));
year=fileName2((namelength-17):(namelength-14));month=filename(1:2);day=filename(3:4);hour=filename(5:6);minute=filename(7:8);second=filename(9:10);
if(X==1)
    fid=fopen(['D:\szh\test\',strcat(folder,'\'),filename,'.txt'],'r');
    if(fid==-1)
        fid=fopen(['D:\szh\test\',strcat(folder,'\'),filename,'.txt'],'w+');
        fprintf(fid,'%s-%s-%s %s:%s:%s\r\n',year,month,day,hour,minute,second);
        for i=1:120000
            fprintf(fid,'%.20f\t',surf_ch1(i));
            fprintf(fid,'%.20f\t',surf_ch2(i));
            fprintf(fid,'%.20f\r\n',surf_ch3(i));
        end
    end
    fclose(fid);
end
if(X==2)
    tempt=str2num(minute);
    if(tempt<50)
        minute=num2str(tempt+10);
    else
        minute=num2str(tempt-50);
        if(length(minute)==1)
            minute=strcat('0',minute);
        end
        tempt=str2num(hour);
        hour=num2str(tempt+1);
        if(length(hour)==1)
            hour=strcat('0',hour);
        end
    end
    filename=strcat(month,day,hour,minute,second);
    fid=fopen(['D:\szh\test\',strcat(folder,'\'),filename,'.txt'],'r');
    if(fid==-1)
        fid=fopen(['D:\szh\test\',strcat(folder,'\'),filename,'.txt'],'w+');
        fprintf(fid,'%s-%s-%s %s:%s:%s\r\n',year,month,day,hour,minute,second);
        for i=1:120000
            fprintf(fid,'%.20f\t',surf_ch1(i));
            fprintf(fid,'%.20f\t',surf_ch2(i));
            fprintf(fid,'%.20f\r\n',surf_ch3(i));
        end
    end
    fclose(fid);
end
if(X==3)
    tempt=str2num(minute);
    if(tempt<40)
        minute=num2str(tempt+20);
    else
        minute=num2str(tempt-40);
        tempt=str2num(hour);
        hour=num2str(tempt+1);
        if(length(hour)==1)
            hour=strcat('0',hour);
        end
    end
    filename=strcat(month,day,hour,minute,second);
    fid=fopen(['D:\szh\test\',strcat(folder,'\'),filename,'.txt'],'r');
    if(fid==-1)
        fid=fopen(['D:\szh\test\',strcat(folder,'\'),filename,'.txt'],'w+');
        fprintf(fid,'%s-%s-%s %s:%s:%s\r\n',year,month,day,hour,minute,second);
        for i=1:120000
            fprintf(fid,'%.20f\t',surf_ch1(i));
            fprintf(fid,'%.20f\t',surf_ch2(i));
            fprintf(fid,'%.20f\r\n',surf_ch3(i));
        end
    end
    fclose(fid);
end







end