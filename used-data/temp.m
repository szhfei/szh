%直接读mat画图，判断数据是否可用
[filename1,filename2]=list('D:\szh\test\changed-data\200#\','D:\szh\test\changed-data\3#\');
% l1=length(filename1);
namelength=length(filename1{1});

for i=1:30  %0点-5点
    fname1=filename1{i};
    fname2=filename2{i};
    load(['D:\szh\test\changed-data\200#\',fname1],'under_ch1','under_ch2','under_ch3');
    load(['D:\szh\test\changed-data\3#\',fname2],'surf_ch1','surf_ch2','surf_ch3');

    l=120000;
    n=0:l-1;
    n=n';
    t=n/200;
    f=n*200/l;
    f40=[0:24000-1]'*200/l;
        
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
    
    figure(1)
    subplot(2,3,1),plot(t,under_ch1),axis([0 600 -0.3 0.3]);
    subplot(2,3,2),plot(t,under_ch2),axis([0 600 -0.3 0.3]);
    subplot(2,3,3),plot(t,under_ch3),axis([0 600 -0.3 0.3]);
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
    
    Hd=lowpass2530;
    under_ch1=filter(Hd,under_ch1);
    under_ch2=filter(Hd,under_ch2);
    under_ch3=filter(Hd,under_ch3);
    surf_ch1=filter(Hd,surf_ch1);
    surf_ch2=filter(Hd,surf_ch2);
    surf_ch3=filter(Hd,surf_ch3);
    figure(4)
    subplot(2,3,1),plot(t,under_ch1),axis([0 600 -0.1 0.1]);
    subplot(2,3,2),plot(t,under_ch2),axis([0 600 -0.1 0.1]);
    subplot(2,3,3),plot(t,under_ch3),axis([0 600 -0.1 0.1]);
    subplot(2,3,4),plot(t,surf_ch1),axis([0 600 -0.1 0.1]);
    subplot(2,3,5),plot(t,surf_ch2),axis([0 600 -0.1 0.1]);
    subplot(2,3,6),plot(t,surf_ch3),axis([0 600 -0.1 0.1]);
    
    judge=input('y/n');
    if(judge=='y')
        continue
    else
        if(judge=='n')
            delete(['D:\szh\test\temp\200#\',fname1]);
            delete(['D:\szh\test\temp\3#\',fname2]);
            fid=fopen('problem.txt','w');
            fprintf(fid,'%s\t',fname1);
            fclose(fid);
            continue
        else
            break
        end
    end
end
clear all
% [fname1,fname2]=list('D:\szh\test\temp\200#\','D:\szh\test\temp\3#\');
% l=length(fname1);
% for i=1:l
%     if(strcmp(fname1,fname2)==0)
%         disp('error');
%         return
%     end
% end