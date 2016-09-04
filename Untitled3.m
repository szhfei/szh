t=0:0.01:1;
a=sin(2*pi*t);
b=cos(2*pi*t);
c=xcorr(a,b);
figure(1)
plot(c)

A=[a,zeros(1,100)];
B=[b,zeros(1,100)];

D=fftshift(fft(A));
B=conj(B);
E=fftshift(fft(B));
F=ifft(D.*E);
figure(3)
plot(abs(fft(c)))

C=fft(A).*conj(fft(B));
C=ifft(C);
figure(2)
plot(fftshift(C))