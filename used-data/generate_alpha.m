%%
% %生成梯形频谱波形
% clear all
% l = 2000;
% f = [0:l-1]'/l*200;
% alpha_test = zeros(l,1);
% for j = 1:fix(l/200*10)
%     alpha_test(j) = j/fix(l/200*10);
% end
% for j = fix(l/200*10)+1:fix(l/200*35)
%     alpha_test(j) = 1;
% end
% for j = fix(l/200*35)+1:fix(l/200*50);
%     alpha_test(j) = (fix(l/200*50)-j)/(fix(l/200*50)-fix(l/200*35));
% end
% alpha_test = alpha_test*2;
% 
% %线性相位
% phase = random('unif',0,2*pi,l/2,1);
% for j = 2:fix(l/200*100)
% %     alpha_test(j) = alpha_test(j) * exp(1i * -(13*pi*j/l+pi/15));
% %     alpha_test(j) = alpha_test(j) * exp(1i*(pi*i*1/3+pi/2));
%     alpha_test(j) = alpha_test(j)*exp(-1i*(pi*j*2/5+pi/4));
%     
% % %随机相位
% %     alpha_test(j) = alpha_test(j) * exp(1i * phase(j));
%     alpha_test(l+2-j) = conj(alpha_test(j));
% end
% Alpha_test = ifft(alpha_test);
% 
% % %实际结果相位
% % load('D:\szh\test\used-data\Alpha_ch1.mat');
% % % win=tukeywin(l,1);
% % % shift=400;
% % % temp=zeros(l,1);
% % % temp(1:shift)=Alpha_ch1(end-shift+1:end);
% % % temp(1:end-shift)=Alpha_ch1(1:l-shift);
% % % temp = temp .* win;
% % % phase = fft(temp,l) ./ abs(fft(temp,l));
% % ll=length(Alpha_ch1);
% % win=tukeywin(ll,1);
% % shift=400;
% % temp=zeros(ll,1);
% % temp(1:shift)=Alpha_ch1(end-shift+1:end);
% % temp(1:end-shift)=Alpha_ch1(1:ll-shift);
% % temp = temp .* win;
% % phase = fft(temp) ./ abs(fft(temp));
% % for j = 2:fix(l/200*100)
% %     alpha_test(j) = alpha_test(j) * phase(j+300);
% %     alpha_test(l+2-j) = conj(alpha_test(j));
% % end
% 
% 
% Alpha_test = real(ifft(alpha_test));
% 
% 
% lag=100;
% z = zeros(l,1);
% z(1:lag)=Alpha_test(end-lag+1:end);
% z(lag+1:end)=Alpha_test(1:end-lag);
% figure(4)
% plot(f,angle(fft(z)))
% 
% Alpha_test = z;
% alpha_test = fft(Alpha_test);
% figure(1)
% plot(Alpha_test)
% figure(2)
% plot(f,abs(alpha_test))
% figure(3)
% plot(f,angle(alpha_test))

%%
% %生成钟型频谱
% clear all
% l = 3000;
% a = -50:0.02:70;
% b = exp(-0.2*a.^2);
% alpha_test = zeros(l,1);
% alpha_test(1:l) = b(2100+1:2100+l);
% for i = 1:fix(l/2)+1
%     alpha_test(i) = alpha_test(i)*(1+1i);
% end
% for i = 2:fix(l/2)+1
%     alpha_test(l+2-i) = conj(alpha_test(i));
% end
% Alpha_test = real(ifft(alpha_test));
% shift=400;
% z(1:shift)=Alpha_test(l-shift+1:l);
% z(shift+1:l)=Alpha_test(1:l-shift);
% Alpha_test=z;
% alpha_test = fft(Alpha_test);
% figure(1)
% plot(abs(alpha_test))
% figure(2)
% plot(Alpha_test)

% Alpha_test = zeros(l,1);
% Alpha_test(1:l) = b(2100+1:2100+l);
% figure(1)
% plot(Alpha_test)
% figure(2)
% plot(abs(fft(Alpha_test)))

%%
% %生成双峰频谱
% a = [-40:0.005:40]';
% b = exp(-0.015*a.^2);
% c = exp(-0.05*a.^2);
% figure(1)
% plot(b)
% figure(2)
% plot(c)
% 
% shift = 2500;
% d = c(5500:length(c));
% d = d + 0.7*b(shift:shift-1+length(d));
% figure(3)
% plot(d)
% 
% lA = 1000;
% alpha_test = zeros(lA,1);
% for i = 1:fix(lA/2)+1
%     alpha_test(i) = d(20*i-19);
% end
% load('D:\szh\test\used-data\test_alpha\3#10-04-07-19-ch3\Alpha_test.mat');
% phase = angle(fft(Alpha_test));
% phase = phase(1:lA);
% alpha_test = alpha_test.*exp(-1i*phase);
% % for i = 1:fix(lA/2)+1
% %     alpha_test(i) = alpha_test(i)*exp(-1i*(pi*i*2/5+pi/4));
% % end
% for i = 2:fix(lA/2)
%     alpha_test(lA+2-i) = conj(alpha_test(i));
% end
% Alpha_test = real(ifft(alpha_test));
% alpha_test = fft(Alpha_test);
% figure(4)
% plot(abs(alpha_test))
% figure(5)
% plot(Alpha_test)

%%
% %生成双峰频谱 0-20Hz
% clear all
% a = [-40:0.005:40]';
% b = exp(-0.03*a.^2);
% c = exp(-0.05*a.^2);
% figure(1)
% plot(b)
% figure(2)
% plot(c)
% 
% shift = 1500;
% d = c(4500:length(c));
% d = d + 0.5*b(shift:shift-1+length(d));
% figure(3)
% plot(d)
% 
% e = zeros(70100,1);
% e(1:10500) = d(1:10500);
% e = e .* 2;
% 
% 
% lA = 2000;
% alpha_test = zeros(lA,1);
% for i = 1:fix(lA/2)+1
%     alpha_test(i) = e(70*i-69);
% end
% load('D:\szh\test\used-data\test_alpha\3#10-04-07-19-ch3\Alpha_test.mat');
% Hd = lowpass2025;
% xxx = filter(Hd,Alpha_test);
% Alpha = xxx(401:lA+400) .* tukeywin(lA,0.2);
% alpha_phase = fft(Alpha) ./ abs(fft(Alpha));
% for i = 1:lA
%     alpha_test(i) = alpha_test(i).* alpha_phase(i);
% end
% % for i = 1:fix(lA/2)+1
% %     alpha_test(i) = alpha_test(i)*exp(-1i*(pi*i*2/5+pi/4));
% % end
% for i = 2:fix(lA/2)
%     alpha_test(lA+2-i) = conj(alpha_test(i));
% end
% Alpha_test = real(ifft(alpha_test));
% alpha_test = fft(Alpha_test);
% figure(4)
% plot(abs(alpha_test)),xlim([0 200])
% figure(5)
% plot(Alpha_test)
% figure(6)
% plot(abs(fft(Alpha_test .* tukeywin(lA,0.2))))

%%
%生成双峰频谱 0-50Hz
clear all

a = [-40:0.005:40]';
b = exp(-0.03*a.^2);
c = exp(-0.05*a.^2);
figure(1)
plot(b)
figure(2)
plot(c)

shift = 1500;
d = c(4500:length(c));
d = d + 0.5*b(shift:shift-1+length(d));
figure(3)
plot(d)

e = zeros(21000,1);
e(1:10500) = d(1:10500);
e = e .* 2;
figure(4)
plot(e)

lA = 2000;
alpha_test = zeros(lA,1);
for i = 1:fix(lA/2)
    alpha_test(i) = e(21*i-20);
end

%简单相位
for i = 2:fix(lA/2)
%     alpha_test(i) = alpha_test(i)*exp(-1i*(pi*i*2/5+pi/4));
    alpha_test(i) = alpha_test(i)*exp(1i*(pi*i*2/lA));
    alpha_test(lA+2-i) = conj(alpha_test(i));
end

% %实际结果相位
% load('D:\szh\test\used-data\Alpha_ch1.mat');
% % win=tukeywin(l,1);
% % shift=400;
% % temp=zeros(l,1);
% % temp(1:shift)=Alpha_ch1(end-shift+1:end);
% % temp(1:end-shift)=Alpha_ch1(1:l-shift);
% % temp = temp .* win;
% % phase = fft(temp,l) ./ abs(fft(temp,l));
% ll=length(Alpha_ch1);
% win=tukeywin(ll,0.2);
% shift=400;
% temp=zeros(ll,1);
% temp(1:shift)=Alpha_ch1(end-shift+1:end);
% temp(1:end-shift)=Alpha_ch1(1:ll-shift);
% temp = temp .* win;
% phase = fft(temp) ./ abs(fft(temp));
% for j = 2:fix(lA/200*100)
%     alpha_test(j) = alpha_test(j) * phase(2*j+300);
%     alpha_test(lA+2-j) = conj(alpha_test(j));
% end


Alpha_test = real(ifft(alpha_test));
lag=200;
z = zeros(lA,1);
z(1:lag)=Alpha_test(end-lag+1:end);
z(lag+1:end)=Alpha_test(1:end-lag);
Alpha_test = z;
alpha_test = fft(Alpha_test);

figure(5)
plot(Alpha_test)
figure(6)
plot(abs(fft(Alpha_test .* tukeywin(lA,0.2))))
figure(10)
plot(angle(alpha_test))

%%
% %test
% clear all
% 
% a = [-40:0.005:40]';
% b = exp(-0.03*a.^2);
% c = exp(-0.05*a.^2);
% figure(1)
% plot(b)
% figure(2)
% plot(c)
% 
% shift = 1500;
% d = c(4500:length(c));
% d = d + 0.5*b(shift:shift-1+length(d));
% figure(3)
% plot(d)
% 
% e = zeros(21000,1);
% e(1:10500) = d(1:10500);
% e = e .* 2;
% figure(4)
% plot(e)
% 
% lA = 2000;
% alpha_test = zeros(lA,1);
% for i = 1:fix(lA/2)
%     alpha_test(i) = e(21*i-20);
% end
% 
% %简单相位
% for i = 2:fix(lA/2)
% %     alpha_test(i) = alpha_test(i)*exp(-1i*(pi*i*2/5+pi/4));
%     alpha_test(i) = alpha_test(i)*exp(1i*(pi*i*2/lA));
%     alpha_test(lA+2-i) = conj(alpha_test(i));
% end
% 
% %实际结果相位
% load('D:\szh\test\used-data\Alpha_ch1.mat');
% % win=tukeywin(l,1);
% % shift=400;
% % temp=zeros(l,1);
% % temp(1:shift)=Alpha_ch1(end-shift+1:end);
% % temp(1:end-shift)=Alpha_ch1(1:l-shift);
% % temp = temp .* win;
% % phase = fft(temp,l) ./ abs(fft(temp,l));
% ll=length(Alpha_ch1);
% win=tukeywin(ll,0.2);
% shift=400;
% temp=zeros(ll,1);
% temp(1:shift)=Alpha_ch1(end-shift+1:end);
% temp(1:end-shift)=Alpha_ch1(1:ll-shift);
% temp = temp .* win;
% phase = fft(temp) ./ abs(fft(temp));
% for j = 2:fix(lA/200*100)
%     alpha_test(j) = alpha_test(j) * phase(j+300);
%     alpha_test(lA+2-j) = conj(alpha_test(j));
% end
% 
% 
% Alpha_test = real(ifft(alpha_test));
% lag=200;
% z = zeros(lA,1);
% z(1:lag)=Alpha_test(end-lag+1:end);
% z(lag+1:end)=Alpha_test(1:end-lag);
% Alpha_test = z;
% alpha_test = fft(Alpha_test);
% 
% figure(5)
% plot(Alpha_test)
% figure(6)
% plot(abs(fft(Alpha_test .* tukeywin(lA,0.2))))
% figure(10)
% plot(angle(alpha_test))