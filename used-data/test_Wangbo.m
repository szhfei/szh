%%
% %test Wangbo's method
% clear all
% 
% % folder='8#\';
% % load('D:\szh\test\used-data\namelist\name_0928.mat','name_0928');
% % name = name_0928;
% surf_folder = '10s0-50Hz双峰传递函数\';
% load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
% alpha_test = fft(Alpha_test);
% lA = length(Alpha_test);
% nA = 0:lA-1;
% nA = nA';
% tA = nA / 200;
% fA = nA * 200 / lA;
% 
% fs=200;
% len = 4;
% n = len * fs;
% nfft = 2^nextpow2(n);
% fc = [0.2:0.2:100]';
% l = length(fc);
% alpha_result = zeros(l,3);
% 
% 
% load(['D:\szh\test\used-data\200#constantly\200#10-04\uch1.mat'],'uch1');
% load(['D:\szh\test\used-data\test\',surf_folder,'sch1.mat'],'sch1');
% ll = 120000;
% sum_u = zeros(lu*sf+ls*sf-1,1);
% sum_s = zeros(lu*sf+ls*sf-1,1);
% t1 = 6 * 7 + 1;
% t2 = 6 * 7 + 1;
% x1 = (t1-1)*ll;
% x2 = t2*ll;
% 
% for j = 1:l
%     fu = fc(j) * 2^(1/6);
%     fl = fc(j) / 2^(1/6);
%     nu = round(fu * nfft / fs + 1);
%     nl = round(fl * nfft / fs + 1);
%     if(fu>=100)
%         break
%     end
%     fu_ch1_filtered = zeros(nfft,1);
%     fs_ch1_filtered = zeros(nfft,1);
%     number = 1;
%     for i=(6*(7-5)+1+2):(6*(7-5)+3)%(6*7+1+144*(4-1)):(6*8+144*(4-1))
%         [a,b] = max(abs(xcorr(sch1,uch1)));
%         lag = b - 120000;
%         time=fix(600/len);
%         for k=2:time-3
%             if((k*n+lag+n)>120000)
%                 break
%             end
%             if((k*n+lag+1)<0)
%                 continue
%             end
%             uch{k}=uch1((k*n+1):(k*n+n));
%             sch{k}=sch1((k*n+lag+1):(k*n+lag+n));
%             fu_ch1{k}=fft(uch{k},nfft);
%             fs_ch1{k}=fft(sch{k},nfft);
%             fu_ch1_filtered(nl:nu)=fu_ch1{k}(nl:nu);
%             fu_ch1_filtered(nfft+2-nu:nfft+2-nl)=fu_ch1{k}(nfft+2-nu:nfft+2-nl);
%             fs_ch1_filtered(nl:nu)=fs_ch1{k}(nl:nu);
%             fs_ch1_filtered(nfft+2-nu:nfft+2-nl)=fs_ch1{k}(nfft+2-nu:nfft+2-nl);
%             u_ch1_filtered = real(ifft(fu_ch1_filtered));
%             s_ch1_filtered = real(ifft(fs_ch1_filtered));
%             u_ch1_filtered = u_ch1_filtered(1:len*fs);
%             s_ch1_filtered = s_ch1_filtered(1:len*fs);
%             u_ch1_rms(j,number) = rms(u_ch1_filtered);
%             s_ch1_rms(j,number) = rms(s_ch1_filtered);
%             number = number + 1;
%         end
%     end
%     alpha_result(j,1) = sum(u_ch1_rms(j,:) .* s_ch1_rms(j,:)) / sum(u_ch1_rms(j,:) .* u_ch1_rms(j,:));
%     j
% end
% figure(1)
% plot(fc,alpha_result(:,1),fA,abs(alpha_test))




%%
%test Wangbo's method
clear all


% surf_folder = '10s双峰传递函数 简单相位2\';
surf_folder = '10s梯形传递函数 简单相位1\';
load(['D:\szh\test\used-data\test\',surf_folder,'Alpha_test.mat'],'Alpha_test');
alpha_test = fft(Alpha_test);
lA = length(Alpha_test);
nA = 0:lA-1;
nA = nA';
tA = nA / 200;
fA = nA * 200 / lA;


load(['D:\szh\test\used-data\200#constantly\200#10-04\uch1.mat'],'uch1');
load(['D:\szh\test\used-data\test\',surf_folder,'sch1.mat'],'sch1');
ll = 120000;
t1 = 6 * 12 + 5;
t2 = 6 * 12 + 5;
x1 = (t1-1)*ll;
x2 = t2*ll;
lag = 400;
u = uch1(x1+1:x2);
s = sch1(x1+1+lag:x2+lag);


fs=200;
dt = 4;
dl = dt * fs;
nfft = x2-x1;%2^nextpow2(n);
fc = [0.2:0.2:80]';
l = length(fc);
alpha_wangbo = zeros(l,1);

% u_spectrum = fft(u,nfft);
% s_spectrum = fft(s,nfft);
u_spectrum = fft(u .* tukeywin(nfft,0.2),nfft);
s_spectrum = fft(s .* tukeywin(nfft,0.2),nfft);

for j = 1:l
    fu = fc(j) * 2^(1/6);
    fl = fc(j) / 2^(1/6);
    nu = fix(fu * nfft / fs + 1);
    nl = round(fl * nfft / fs + 1);
    if(fu>=100)
        break
    end
    fu_filtered = zeros(nfft,1);
    fs_filtered = zeros(nfft,1);
    fu_filtered(nl:nu) = u_spectrum(nl:nu);
    fu_filtered(nfft+2-nu:nfft+2-nl) = u_spectrum(nfft+2-nu:nfft+2-nl);
    fs_filtered(nl:nu) = s_spectrum(nl:nu);
    fs_filtered(nfft+2-nu:nfft+2-nl) = s_spectrum(nfft+2-nu:nfft+2-nl);
    u_filtered = real(ifft(fu_filtered));
    s_filtered = real(ifft(fs_filtered));
%     u_filtered = u_filtered(1:nfft);
%     s_filtered = s_filtered(1:nfft);
            
    time=fix(nfft/dl);
    u_rms = zeros(time-2,1);
    s_rms = zeros(time-2,1);
    for k=1:time-2
        du = u_filtered(k*dl+1:k*dl+dl);
        ds = s_filtered(k*dl+1:k*dl+dl);
        u_rms(k) = rms(du);
        s_rms(k) = rms(ds);
    end
    alpha_wangbo(j) = sum(u_rms .* s_rms) / sum(u_rms .* u_rms);
    j
end
figure(1)
plot(fc,alpha_wangbo,fA,abs(alpha_test)),xlim([.1 50])

