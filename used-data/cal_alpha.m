function [alpha] = cal_alpha(lag,surf_folder,day,t1,t2,lu,ls,channel)
sf = 200;
l = 120000;
sum_u = zeros(lu*sf+ls*sf-1,1);
sum_s = zeros(lu*sf+ls*sf-1,1);
t1 = t1 - 144*(day-1);
t2 = t2 - 144*(day-1);
x1 = (t1-1)*l;
x2 = t2*l;
time = fix((x2-x1)/(200*ls));

window_u = tukeywin(200*lu,0.5);
window_s = tukeywin(200*ls,0.5);

if(channel == 'ch1')
    load(['D:\szh\test\used-data\200#constantly\200#10-0',num2str(day),'\uch1.mat'],'uch1');
    load(['D:\szh\test\used-data\test\',surf_folder,'sch1.mat'],'sch1');
    for k=1:time-2
        uch{k}=uch1((x1+k*lu*sf+1):(x1+k*lu*sf+lu*sf));
        sch{k}=sch1((x1+k*lu*sf+lag+1):(x1+k*lu*sf+lag+ls*sf));
        uch{k} = uch{k} .* window_u;
        sch{k} = sch{k} .* window_s;
        uch{k}=[uch{k};zeros(ls*sf-1,1)];
        sch{k}=[sch{k};zeros(lu*sf-1,1)];
        fu{k}=fft(uch{k});
        fs{k}=fft(sch{k});
        sum_s=sum_s+fs{k}.*conj(fu{k});
        sum_u=sum_u+fu{k}.*conj(fu{k});
    end
elseif(channel == 'ch2')
    load(['D:\szh\test\used-data\200#constantly\200#10-0',num2str(day),'\uch2.mat'],'uch2');
    load(['D:\szh\test\used-data\test\',surf_folder,'sch2.mat'],'sch2');
    for k=1:time-2
        uch{k}=uch2((x1+k*lu*sf+1):(x1+k*lu*sf+lu*sf));
        sch{k}=sch2((x1+k*lu*sf+lag+1):(x1+k*lu*sf+lag+ls*sf));
        uch{k} = uch{k} .* window_u;
        sch{k} = sch{k} .* window_s;
        uch{k}=[uch{k};zeros(ls*sf-1,1)];
        sch{k}=[sch{k};zeros(lu*sf-1,1)];
        fu{k}=fft(uch{k});
        fs{k}=fft(sch{k});
        sum_s=sum_s+fs{k}.*conj(fu{k});
        sum_u=sum_u+fu{k}.*conj(fu{k});
    end
elseif(channel == 'ch3')
    load(['D:\szh\test\used-data\200#constantly\200#10-0',num2str(day),'\uch3.mat'],'uch3');
    load(['D:\szh\test\used-data\test\',surf_folder,'sch3.mat'],'sch3');
    for k=1:time-2
        uch{k}=uch3((x1+k*lu*sf+1):(x1+k*lu*sf+lu*sf));
        sch{k}=sch3((x1+k*lu*sf+lag+1):(x1+k*lu*sf+lag+ls*sf));
        uch{k} = uch{k} .* window_u;
        sch{k} = sch{k} .* window_s;
        uch{k}=[uch{k};zeros(ls*sf-1,1)];
        sch{k}=[sch{k};zeros(lu*sf-1,1)];
        fu{k}=fft(uch{k});
        fs{k}=fft(sch{k});
        sum_s=sum_s+fs{k}.*conj(fu{k});
        sum_u=sum_u+fu{k}.*conj(fu{k});
    end
end
alpha=sum_s./sum_u;
end