function Alpha_final = cut_smooth_alpha(Alpha,len,span)
Alpha_cut = Alpha(1:len);
alpha_cut = fft(Alpha_cut);
temp = smooth(abs(alpha_cut),span) .* (alpha_cut ./ abs(alpha_cut));
Alpha_final = real(ifft(temp));
alpha_final = fft(Alpha_final);
end