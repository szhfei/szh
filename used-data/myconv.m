function res = myconv(a,b)
la = length(a);
lb = length(b);
l = la + lb - 1;
fa = fft(a,l);
clear a
fb = fft(b,l);
clear b
temp = fa .* fb;
clear fa fb
res = ifft(temp);
end