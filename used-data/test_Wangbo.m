%test Wangbo's method
clear all

% folder='8#\';
% load('D:\szh\test\used-data\namelist\name_0928.mat','name_0928');
% name = name_0928;
folder = 'test_surf\new100-similar--noise_similar-2\';
load('D:\szh\test\used-data\namelist\name_200.mat','name_200');
name = name_200;


fs=200;
len = 4;
n = len * fs;
nfft = 2^nextpow2(n);
fc = [0.2:0.2:100]';
l = length(fc);
alpha_result = zeros(l,3);

for j = 1:l
    fu = fc(j) * 2^(1/6);
    fl = fc(j) / 2^(1/6);
    nu = round(fu * nfft / fs + 1);
    nl = round(fl * nfft / fs + 1);
    if(fu>=100)
        break
    end
    fu_ch1_filtered = zeros(nfft,1);
    fs_ch1_filtered = zeros(nfft,1);
    number = 1;
    for i=(6*(7-5)+1+2):(6*(7-5)+3)%(6*7+1+144*(4-1)):(6*8+144*(4-1))
        load(['D:\szh\test\used-data\200#\',name{i}],'under_ch1','under_ch2','under_ch3');
        load(['D:\szh\test\used-data\',folder,name{i}],'surf_ch1','surf_ch2','surf_ch3');
        [a,b] = max(abs(xcorr(surf_ch1,under_ch1)));
        lag = b - 120000;
        time=fix(600/len);
        for k=2:time-3
            if((k*n+lag+n)>120000)
                break
            end
            if((k*n+lag+1)<0)
                continue
            end
            uch1{k}=under_ch1((k*n+1):(k*n+n));
            sch1{k}=surf_ch1((k*n+lag+1):(k*n+lag+n));
            fu_ch1{k}=fft(uch1{k},nfft);
            fs_ch1{k}=fft(sch1{k},nfft);
            fu_ch1_filtered(nl:nu)=fu_ch1{k}(nl:nu);
            fu_ch1_filtered(nfft+2-nu:nfft+2-nl)=fu_ch1{k}(nfft+2-nu:nfft+2-nl);
            fs_ch1_filtered(nl:nu)=fs_ch1{k}(nl:nu);
            fs_ch1_filtered(nfft+2-nu:nfft+2-nl)=fs_ch1{k}(nfft+2-nu:nfft+2-nl);
            u_ch1_filtered = real(ifft(fu_ch1_filtered));
            s_ch1_filtered = real(ifft(fs_ch1_filtered));
            u_ch1_filtered = u_ch1_filtered(1:len*fs);
            s_ch1_filtered = s_ch1_filtered(1:len*fs);
            u_ch1_rms(j,number) = rms(u_ch1_filtered);
            s_ch1_rms(j,number) = rms(s_ch1_filtered);
            number = number + 1;
        end
    end
    alpha_result(j,1) = sum(u_ch1_rms(j,:) .* s_ch1_rms(j,:)) / sum(u_ch1_rms(j,:) .* u_ch1_rms(j,:));
    j
end
figure(1)
plot(fc,alpha_result(:,1))
figure(1000)
plot(fc,alpha_result(:,1)),xlim([0 25])
