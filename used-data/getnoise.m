%µ÷ÖÆÔëÉùÆµÆ×
function U = getnoise()
l = 120000;
sf = 200;
n = 0 : l - 1;
n = n';
t = n / sf;
f = n * sf / l;
U = wgn(120000,1,-32);
fU = fft(U);

x = zeros(l,1);
for i = 600 * 0 + 2 : 600 * 20
    x(i) = 1.5 + 0.5 / (600 * 20) * (i - 600 * 0);
    fU(i) = fU(i) / 2 * x(i);
    fU(l + 2 - i) = fU( l + 2 - i) / 2 * x(i);
end
for i = 600 * 20 + 1 : 600 * 80
    x(i) = 1 + 1 / (600 * 60) * (i - 600*20);
    fU(i) = fU(i) * x(i);
    fU(l + 2 - i) = fU( l + 2 - i) * x(i);
end
for i = 600 * 80 + 1 : 600 * 90
    x(i) = 1 + 7 / (600 * 10) * (600*90 - i);
    fU(i) = fU(i) / 4 * x(i);
    fU(l + 2 - i) = fU( l + 2 - i) / 4 * x(i);
end
for i = 600 * 90 + 1 : 600 * 100 +1
    x(i) = 1 / 4;
    fU(i) = fU(i) * x(i);
    fU(l + 2 - i) = fU( l + 2 - i) * x(i);
end
U = ifft(fU);
% 
% figure(20)
% plot(U)
% 
% figure(21)
% plot(f,abs(fU))
end