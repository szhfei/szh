[uch1,uch2,uch3,sch1,sch2,sch3]=read('20121001070000.200.t3w','acc3#_III-7022_20121001065959.mat',1);
% Hd=lowpass2530;
% uch1=filter(Hd,under_ch1);
% uch2=filter(Hd,under_ch2);
% uch3=filter(Hd,under_ch3);
% sch1=filter(Hd,surf_ch1);
% sch2=filter(Hd,surf_ch2);
% sch3=filter(Hd,surf_ch3);
t=[0:1/200:600-1/200]';
% figure(4)
% plot(t,uch1)
% figure(5)
% plot(t,uch2)
% figure(6)
% plot(t,uch3)
% figure(7)
% plot(t,sch1)
% figure(8)
% plot(t,sch2)
% figure(9)
% plot(t,sch3)

% figure(4)
% subplot(2,1,1),plot(t,uch1),title('uch1');
% subplot(2,1,2),plot(t,sch1),title('sch1');
% figure(5)
% subplot(2,1,1),plot(t,uch2),title('uch2');
% subplot(2,1,2),plot(t,sch2),title('sch2');
% figure(6)
% subplot(2,1,1),plot(t,uch3),title('uch3');
% subplot(2,1,2),plot(t,sch3),title('sch3');
figure(4)
subplot(2,3,1),plot(t,uch1),title('uch1'),axis([0 600 -0.6 0.6]);
subplot(2,3,2),plot(t,uch2),title('uch2'),axis([0 600 -0.6 0.6]);
subplot(2,3,3),plot(t,uch3),title('uch3'),axis([0 600 -0.6 0.6]);
subplot(2,3,4),plot(t,sch1),title('sch1'),axis([0 600 -0.2 0.2]);
subplot(2,3,5),plot(t,sch2),title('sch2'),axis([0 600 -0.2 0.2]);
subplot(2,3,6),plot(t,sch3),title('sch3'),axis([0 600 -0.2 0.2]);

% figure(7)
% subplot(2,1,1),plot(uch1(110001:120000));
% subplot(2,1,2),plot(sch1(110001:120000));
% figure(8)
% subplot(2,1,1),plot(uch2(110001:120000));
% subplot(2,1,2),plot(sch2(110001:120000));
% figure(9)
% subplot(2,1,1),plot(uch3(110001:120000));
% subplot(2,1,2),plot(sch3(110001:120000));

c11=xcorr(sch1,uch1);
c22=xcorr(sch2,uch2);
c33=xcorr(sch3,uch3);
% tt=[-(600-1/200):1/200:(600-1/200)]';
% figure(10)
% plot(tt,c11)
% figure(11)
% plot(tt,c22)
% figure(12)
% plot(tt,c33)

c12=xcorr(sch1,uch2);
c13=xcorr(sch1,uch3);
c21=xcorr(sch2,uch1);
c23=xcorr(sch2,uch3);
c31=xcorr(sch3,uch1);
c32=xcorr(sch3,uch2);

% figure(13)
% subplot(3,3,1),plot(c11),title('c11');
% subplot(3,3,2),plot(c12),title('c12');
% subplot(3,3,3),plot(c13),title('c13');
% subplot(3,3,4),plot(c21),title('c21');
% subplot(3,3,5),plot(c22),title('c22');
% subplot(3,3,6),plot(c23),title('c23');
% subplot(3,3,7),plot(c31),title('c31');
% subplot(3,3,8),plot(c32),title('c32');
% subplot(3,3,9),plot(c33),title('c33');
figure(13)
subplot(3,1,1),plot(c11),title('sch1-uch1');
subplot(3,1,2),plot(c22),title('sch2-uch2');
subplot(3,1,3),plot(c33),title('sch3-uch3');

C11=c11(120901:121200);
C12=c12(120901:121200);
C13=c13(120901:121200);
C21=c21(120901:121200);
C22=c22(120901:121200);
C23=c23(120901:121200);
C31=c31(120901:121200);
C32=c32(120901:121200);
C33=c33(120901:121200);

% figure(14)
% subplot(3,3,1),plot(C11),title('C11');
% subplot(3,3,2),plot(C12),title('C12');
% subplot(3,3,3),plot(C13),title('C13');
% subplot(3,3,4),plot(C21),title('C21');
% subplot(3,3,5),plot(C22),title('C22');
% subplot(3,3,6),plot(C23),title('C23');
% subplot(3,3,7),plot(C31),title('C31');
% subplot(3,3,8),plot(C32),title('C32');
% subplot(3,3,9),plot(C33),title('C33');
figure(14)
subplot(3,1,1),plot(C11),title('sch1-uch1');
subplot(3,1,2),plot(C22),title('sch2-uch2');
subplot(3,1,3),plot(C33),title('sch3-uch3');
