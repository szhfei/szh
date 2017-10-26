%直接读mat画原始数据图

clear all
folder='3#\';
% folder = 'test_surf\3#10-04-07-19-ch2-change\';

load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% [name_200,name_3]=list('D:\szh\test\used-data\200#\',['D:\szh\test\used-data\',folder]);
% l1=length(filename_200);
% namelength=length(filename_200{1});

win = tukeywin(120000,0.5);
for i=(6*7+1+144*(4-1)):(6*23+144*(4-1))  %10-02-19
    load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
    load(['D:\szh\test\used-data\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');
% fid=fopen('problem.txt','r');
% file=textscan(fid,'%s');
% fclose(fid);
% for i=1:9
%     fname_200=file{1}{i};
%     load(['D:\szh\test\used-data\200#\',fname_200],'under_ch1','under_ch2','under_ch3');
%     load(['D:\szh\test\used-data\',folder,fname_200],'surf_ch1','surf_ch2','surf_ch3');
    
    l=120000;
    n=0:l-1;
    n=n';
    t=n/200;
    f=n*200/l;
    f20=[0:12000-1]'*200/l;
        
    Funder_ch1=fft(under_ch1 .* win);
    Funder_ch2=fft(under_ch2 .* win);
    Funder_ch3=fft(under_ch3 .* win);
    Fsurf_ch1=fft(surf_ch1 .* win);
    Fsurf_ch2=fft(surf_ch2 .* win);
    Fsurf_ch3=fft(surf_ch3 .* win);
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
    subplot(2,3,1),plot(f20,mag_under_ch1(1:12000)),axis([0 20 0 60]);
    subplot(2,3,2),plot(f20,mag_under_ch2(1:12000)),axis([0 20 0 60]);
    subplot(2,3,3),plot(f20,mag_under_ch3(1:12000)),axis([0 20 0 60]);
    subplot(2,3,4),plot(f20,mag_surf_ch1(1:12000)),axis([0 20 0 60]);
    subplot(2,3,5),plot(f20,mag_surf_ch2(1:12000)),axis([0 20 0 60]);
    subplot(2,3,6),plot(f20,mag_surf_ch3(1:12000)),axis([0 20 0 60]);
    
    Hd = lowpass2025;
    uch1=filter(Hd,under_ch1);
    uch2=filter(Hd,under_ch2);
    uch3=filter(Hd,under_ch3);
    sch1=filter(Hd,surf_ch1);
    sch2=filter(Hd,surf_ch2);
    sch3=filter(Hd,surf_ch3);
    figure(4)
    subplot(2,3,1),plot(t,uch1),axis([0 600 -0.1 0.1]);
    subplot(2,3,2),plot(t,uch2),axis([0 600 -0.1 0.1]);
    subplot(2,3,3),plot(t,uch3),axis([0 600 -0.1 0.1]);
    subplot(2,3,4),plot(t,sch1),axis([0 600 -0.1 0.1]);
    subplot(2,3,5),plot(t,sch2),axis([0 600 -0.1 0.1]);
    subplot(2,3,6),plot(t,sch3),axis([0 600 -0.1 0.1]);
    
    
    figure(5)
    subplot(2,3,1),plot(t,uch1),axis([0 600 -0.3 0.3]);
    subplot(2,3,2),plot(t,uch2),axis([0 600 -0.3 0.3]);
    subplot(2,3,3),plot(t,uch3),axis([0 600 -0.3 0.3]);
    subplot(2,3,4),plot(t,under_ch1),axis([0 600 -0.3 0.3]);
    subplot(2,3,5),plot(t,under_ch2),axis([0 600 -0.3 0.3]);
    subplot(2,3,6),plot(t,under_ch3),axis([0 600 -0.3 0.3]);
    disp(name_200{i});
    
    judge=input('y/n');
    if(judge=='y')
        continue
    else
        if(judge=='n')
%             delete(['D:\szh\test\temp\200#\',name_200]);
%             delete(['D:\szh\test\temp\',folder,name_3]);
            fid=fopen('error.txt','a+');
            fprintf(fid,'%s%s\r\n',folder,name_200{i});
            fclose(fid);
            continue
        else
            if(judge == 'd')
                fid=fopen('doubt.txt','a+');
                fprintf(fid,'%s%s\r\n',folder,name_200{i});
                fclose(fid);
                continue
            else
                break
            end
        end
    end
end

