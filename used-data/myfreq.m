function [sch_left] = myfreq(uch,sch,Alpha)
lu = length(uch);
len = length(Alpha) + lu - 1;
fuch = abs(fft(uch,len));
clear uch
fsch = fft(sch,len);
% clear sch
phase = fsch ./ abs(fsch);
alpha = abs(fft(Alpha,len));
s_u = real(ifft(abs(fuch .* alpha) .* phase));
% sch_left = real(ifft(phase .* (abs(fsch)-abs(fuch .* alpha))));
% sch_left = sch_left(1:lu);
s_u = s_u(1:lu);
sch_left = sch - s_u;
end