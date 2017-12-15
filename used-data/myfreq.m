function [sch_left] = myfreq(uch,sch,Alpha,phase)
lu = length(uch);
len = length(Alpha) + lu - 1;
fuch = fft(uch,len);
clear uch

% %用地面相位
% fsch = fft(sch,len);
% phase = fsch ./ abs(fsch);

% load('D:\szh\test\used-data\test\3#10-04-07-19\sch1.mat','sch1');
% fsch = fft(sch1,len);
% phase = fsch ./ abs(fsch);
% clear sch1 fsch


% %用地铁相位
% phase = fuch ./ abs(fuch);

alpha = fft(Alpha,len);
s_u = real(ifft(abs(fuch) .* abs(alpha) .* phase));
% sch_left = real(ifft(phase .* (abs(fsch)-abs(fuch .* alpha))));
% sch_left = sch_left(1:lu);
s_u = s_u(1:lu);
sch_left = sch - s_u;
end