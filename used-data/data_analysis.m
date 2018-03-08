%原始数据画图分析

clear all
folder='3#\';
% folder = 'test_surf\3#10-04-07-19-ch2-change\';

load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
% [name_200,name_3]=list('D:\szh\test\used-data\200#\',['D:\szh\test\used-data\',folder]);
% l1=length(filename_200);
% namelength=length(filename_200{1});

win = tukeywin(120000,0.5);
i = 6*15 + 4 + 144*(4-1);
load(['D:\szh\test\used-data\200#\',name_200{i}],'under_ch1','under_ch2','under_ch3');
load(['D:\szh\test\used-data\',folder,name_200{i}],'surf_ch1','surf_ch2','surf_ch3');

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

Hd = bandpass1_20;
uch1=filter(Hd,under_ch1);
    uch1=flipud(uch1);
    uch1=filter(Hd,uch1);
    uch1=flipud(uch1);
uch2=filter(Hd,under_ch2);
    uch2=flipud(uch2);
    uch2=filter(Hd,uch2);
    uch2=flipud(uch2);
uch3=filter(Hd,under_ch3);
    uch3=flipud(uch3);
    uch3=filter(Hd,uch3);
    uch3=flipud(uch3);
sch1=filter(Hd,surf_ch1);
    sch1=flipud(sch1);
    sch1=filter(Hd,sch1);
    sch1=flipud(sch1);
sch2=filter(Hd,surf_ch2);
    sch2=flipud(sch2);
    sch2=filter(Hd,sch2);
    sch2=flipud(sch2);
sch3=filter(Hd,surf_ch3);
    sch3=flipud(sch3);
    sch3=filter(Hd,sch3);
    sch3=flipud(sch3);

% figure(1)
% subplot(2,3,1),plot(t,under_ch1),axis([0 600 -0.3 0.3]);
% subplot(2,3,2),plot(t,under_ch2),axis([0 600 -0.3 0.3]);
% subplot(2,3,3),plot(t,under_ch3),axis([0 600 -0.3 0.3]);
% subplot(2,3,4),plot(t,surf_ch1),axis([0 600 -0.3 0.3]);
% subplot(2,3,5),plot(t,surf_ch2),axis([0 600 -0.3 0.3]);
% subplot(2,3,6),plot(t,surf_ch3),axis([0 600 -0.3 0.3]);
% 
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

% figure(4)
% subplot(2,3,1),plot(t,uch1),axis([0 600 -0.1 0.1]);
% subplot(2,3,2),plot(t,uch2),axis([0 600 -0.1 0.1]);
% subplot(2,3,3),plot(t,uch3),axis([0 600 -0.1 0.1]);
% subplot(2,3,4),plot(t,sch1),axis([0 600 -0.1 0.1]);
% subplot(2,3,5),plot(t,sch2),axis([0 600 -0.1 0.1]);
% subplot(2,3,6),plot(t,sch3),axis([0 600 -0.1 0.1]);
% 
% figure(5)
% subplot(2,3,1),plot(t,uch1),axis([0 600 -0.3 0.3]);
% subplot(2,3,2),plot(t,uch2),axis([0 600 -0.3 0.3]);
% subplot(2,3,3),plot(t,uch3),axis([0 600 -0.3 0.3]);
% subplot(2,3,4),plot(t,under_ch1),axis([0 600 -0.3 0.3]);
% subplot(2,3,5),plot(t,under_ch2),axis([0 600 -0.3 0.3]);
% subplot(2,3,6),plot(t,under_ch3),axis([0 600 -0.3 0.3]);    

figure(100)
subplot(3,1,1),plot(t,uch1),axis([0 600 -0.1 0.1]);
subplot(3,1,2),plot(t,uch2),axis([0 600 -0.1 0.1]);
subplot(3,1,3),plot(t,uch3),axis([0 600 -0.1 0.1]);

figure(101)
subplot(2,1,1),plot(t,uch1),axis([0 600 -0.1 0.1]);
subplot(2,1,2),plot(t,sch1),axis([0 600 -0.1 0.1]);
figure(102)
subplot(2,1,1),plot(t,uch2),axis([0 600 -0.1 0.1]);
subplot(2,1,2),plot(t,sch2),axis([0 600 -0.1 0.1]);
figure(103)
subplot(2,1,1),plot(t,uch3),axis([0 600 -0.1 0.1]);
subplot(2,1,2),plot(t,sch3),axis([0 600 -0.1 0.1]);

figure(200)
subplot(3,1,1),plot(t,under_ch1),axis([0 600 -0.2 0.2]);
subplot(3,1,2),plot(t,under_ch2),axis([0 600 -0.2 0.2]);
subplot(3,1,3),plot(t,under_ch3),axis([0 600 -0.2 0.2]);

figure(201)
subplot(3,1,1),plot(t,under_ch1),axis([0 600 -0.1 0.1]);
subplot(3,1,2),plot(t,uch1),axis([0 600 -0.1 0.1]);
subplot(3,1,3),plot(t,sch1),axis([0 600 -0.1 0.1]);
figure(202)
subplot(3,1,1),plot(t,under_ch2),axis([0 600 -0.2 0.2]);
subplot(3,1,2),plot(t,uch2),axis([0 600 -0.2 0.2]);
subplot(3,1,3),plot(t,sch2),axis([0 600 -0.2 0.2]);
figure(203)
subplot(3,1,1),plot(t,under_ch3),axis([0 600 -0.2 0.2]);
subplot(3,1,2),plot(t,uch3),axis([0 600 -0.2 0.2]);
subplot(3,1,3),plot(t,sch3),axis([0 600 -0.2 0.2]);