function [alpha] = test_iter_alpha(uch,sch,day,t1,t2,lu,ls,channel)
sf = 200;
l = 120000;
sum_u = zeros(lu*sf+ls*sf-1,1);
sum_s = zeros(lu*sf+ls*sf-1,1);
t1 = t1 - 144*(day-1) -6*7;
t2 = t2 - 144*(day-1) -6*7;
x1 = (t1-1)*l;
x2 = t2*l;
time = fix((x2-x1)/(200*ls));
window_u = tukeywin(200*lu,0.2);
window_s = tukeywin(200*ls,0.2);

if(channel == 'ch1')
    uch1 = uch;
    sch1 = sch;
    clear sch uch
    for k=1:time-2
        uch{k}=uch1((x1+k*lu*sf+1):(x1+k*lu*sf+lu*sf));
        sch{k}=sch1((x1+k*lu*sf+1):(x1+k*lu*sf+ls*sf));
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
    uch2 = uch;
    sch2 = sch;
    clear sch uch
    for k=1:time-2
        uch{k}=uch2((x1+k*lu*sf+1):(x1+k*lu*sf+lu*sf));
        sch{k}=sch2((x1+k*lu*sf+1):(x1+k*lu*sf+ls*sf));
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
    uch3 = uch;
    sch3 = sch;
    clear sch uch
    for k=1:time-2
        uch{k}=uch3((x1+k*lu*sf+1):(x1+k*lu*sf+lu*sf));
        sch{k}=sch3((x1+k*lu*sf+1):(x1+k*lu*sf+ls*sf));
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