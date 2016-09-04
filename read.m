function [under_ch1,under_ch2,under_ch3,surf_ch1,surf_ch2,surf_ch3]=read(fileName1,fileName2,X)
[under_ch1, under_ch2, under_ch3, bn, under_sf, under_btime] = t3w(fileName1);
clear bn under_btime

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

lu1=length(under_ch1);
lu2=length(under_ch2);
lu3=length(under_ch3);
if(lu1~=lu2 || lu1~=lu3)
    disp('length error');
    return
end
l=lu1;
n=0:l-1;
n=n';
t=n/sf;
f=n*sf/l;
f40=[0:24000-1]'*sf/l;

p=polyfit(t,under_ch1,1);
under_ch1=under_ch1-(p(1)*t+p(2));
p=polyfit(t,under_ch2,1);
under_ch2=under_ch2-(p(1)*t+p(2));
p=polyfit(t,under_ch3,1);
under_ch3=under_ch3-(p(1)*t+p(2));

under_ch1=under_ch1-sum(under_ch1)/l;
under_ch2=under_ch2-sum(under_ch2)/l;
under_ch3=under_ch3-sum(under_ch3)/l;

Hd = highpass105;
under_ch1=filter(Hd,under_ch1);
under_ch2=filter(Hd,under_ch2);
under_ch3=filter(Hd,under_ch3);

p=polyfit(t,surf_ch1,1);
surf_ch1=surf_ch1-(p(1)*t+p(2));
p=polyfit(t,surf_ch2,1);
surf_ch2=surf_ch2-(p(1)*t+p(2));
p=polyfit(t,surf_ch3,1);
surf_ch3=surf_ch3-(p(1)*t+p(2));

surf_ch1=surf_ch1-sum(surf_ch1)/l;
surf_ch2=surf_ch2-sum(surf_ch2)/l;
surf_ch3=surf_ch3-sum(surf_ch3)/l;

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

% figure(3)
% subplot(2,3,1),plot(f40,mag_under_ch1(1:24000)),axis([0 40 0 100]);
% subplot(2,3,2),plot(f40,mag_under_ch2(1:24000)),axis([0 40 0 100]);
% subplot(2,3,3),plot(f40,mag_under_ch3(1:24000)),axis([0 40 0 100]);
% subplot(2,3,4),plot(f40,mag_surf_ch1(1:24000)),axis([0 40 0 100]);
% subplot(2,3,5),plot(f40,mag_surf_ch2(1:24000)),axis([0 40 0 100]);
% subplot(2,3,6),plot(f40,mag_surf_ch3(1:24000)),axis([0 40 0 100]);

end