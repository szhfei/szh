%Ƶ�������������
%10-04 07-19���ݲ���
clear all
folder = '2#10-04-07-19\';
% folder = '2#10-04-07-19\';

sf=200;
lu=20;
ls=20;
lag=000;%ʱ���ӳ�
day = 4;
t1 = 6*7+1+144*(4-1);
t2 = 6*19+0+144*(4-1);

channel = 'ch3';

load(['D:\szh\test\used-data\test\',folder,'s',channel,'.mat']);
load(['D:\szh\test\used-data\test\',folder,'u',channel,'.mat']);
if(strcmp(channel,'ch1') == 1)
    uch = uch1;clear uch1;
    sch = sch1;clear sch1;
elseif(strcmp(channel,'ch2') == 1)
    uch = uch2;clear uch2;
    sch = sch2;clear sch2;
elseif(strcmp(channel,'ch3') == 1)
    uch = uch3;clear uch3;
    sch = sch3;clear sch3;
end


alpha_initial=test_iter_alpha(uch,sch,day,t1,t2,lu,ls,channel);
Alpha_initial=ifft(alpha_initial);

l = (lu+ls)*sf-1;
n=0:l-1;
n=n';
t=n/sf;
f=n*sf/l;
figure(1)
plot(f,abs(alpha_initial)),xlim([0.1 25])


count = 5;
istart = 120000*(5+6*0)+1+20000;%0700-0710
iend = istart + 120000-1;

lll = length(sch) + length(Alpha_initial) - 1;
%�ر���λ
fsch = fft(sch,lll);
phase = fsch ./ abs(fsch);
% %������λ
% fuch = fft(uch,lll);
% phase = fuch ./ abs(fuch);

sch_left = myfreq(uch,sch,fftshift(Alpha_initial),phase);
u = uch(istart:iend);
s = sch(istart:iend);
s_left{1} = sch_left(istart:iend);
alpha_left{1}=test_iter_alpha(uch,sch_left,day,t1,t2,lu,ls,channel);

for i = 2:count
    Alpha_left{i-1} = ifft(alpha_left{i-1});
    sch_left = myfreq(uch,sch_left,fftshift(Alpha_left{i-1}),phase);
    s_left{i} = sch_left(istart:iend);
    alpha_left{i}=test_iter_alpha(uch,sch_left,day,t1,t2,lu,ls,channel);
    i
end

% for i = 1:count
% figure(100+i)
% plot(f,abs(alpha_left{i})),xlim([0 15]),ylim([0 .7])
% end


Hd = bandpass2_6;
% Hd = bandpass2_10;
% for i = 1:count
% figure(200+i)
% plot(filter(Hd,s_left{i})),ylim([-.04 .04])
% end

time = [0:120000-1]'/200;
% for i = 1:count
% figure(300+i)
% subplot(3,1,1),plot(time,filter(Hd,u)),ylim([-0.03 0.03]);
% % subplot(4,1,2),plot(time,filter(Hd,s_u{i})),ylim([-0.03 0.03]);
% subplot(3,1,2),plot(time,filter(Hd,s)),ylim([-0.03 0.03]);
% subplot(3,1,3),plot(time,filter(Hd,s_left{i})),ylim([-0.03 0.03]);
% handle_2 = get(gcf,'children');
% axes(handle_2(3));title('����ԭʼ��¼');
% % axes(handle_2(3));title('��������ɷ�');
% axes(handle_2(2));title('����ԭʼ��¼');
% axes(handle_2(1));title('����ʣ�µĵ��������ɷ�');
% end

% %%���ݺ���ֱ�����
% test{1} = alpha_initial;
% for i = 1:count
% test{i+1} = test{i} + alpha_left{i};
% Atest{i} = ifft(test{i});
% sch_other{i} = myfreq(uch,sch,ifftshift(Atest{i}));
% res{i} = sch_other{i}(istart:iend);
% end

%%���ݺ�������ֵ���
phase_alpha = alpha_initial ./ abs(alpha_initial);
test{1} = abs(alpha_initial);
for i = 1:count
test{i+1} = test{i} + abs(alpha_left{i});
Atest{i} = ifft(test{i} .* phase_alpha);
sch_other{i} = myfreq(uch,sch,fftshift(Atest{i}),phase);
res{i} = sch_other{i}(istart:iend);
end


% figure(400)
% subplot(3,1,1),plot(time,filter(Hd,u)),ylim([-0.03 0.03]);
% % subplot(4,1,2),plot(time,filter(Hd,s_u{i})),ylim([-0.03 0.03]);
% subplot(3,1,2),plot(time,filter(Hd,s)),ylim([-0.03 0.03]);
% subplot(3,1,3),plot(time,filter(Hd,res{2})),ylim([-0.03 0.03]);
% handle_2 = get(gcf,'children');
% axes(handle_2(3));title('����ԭʼ��¼');
% % axes(handle_2(3));title('��������ɷ�');
% axes(handle_2(2));title('����ԭʼ��¼');
% axes(handle_2(1));title('����ʣ�µĵ��������ɷ�');

figure(2000)%ÿ�ε������룬���������ɷ�
for i=1:count
    subplot(count,1,i),plot(time,filter(Hd,s_left{i})),ylim([-0.03 0.03]),ylabel('���ٶ�/gal','fontsize',12);
end
xlabel('ʱ��/s','fontsize',12)
handle_4 = get(gcf,'children');
axes(handle_4(5));title('������ݺ���ֱ�ӷ��룬���������ɷ�');
axes(handle_4(4));title('��һ�ε����󣬵��������ɷ�');
axes(handle_4(3));title('�ڶ��ε����󣬵��������ɷ�');
axes(handle_4(2));title('�����ε����󣬵��������ɷ�');
axes(handle_4(1));title('���Ĵε����󣬵��������ɷ�');

% figure(3000)%ǰn�ε������룬���������ɷ�
% for i=1:count
%     subplot(count,1,i),plot(time,filter(Hd,res{i})),ylim([-0.03 0.03]);
% end

cor = zeros(count,1);
for i = 1:count
    cor(i) = corr(filter(Hd,s_left{i}),filter(Hd,s-s_left{i}));
end
% figure(4000)
% plot([0:count-1]',abs(cor),'-p'),xlabel('��������','fontsize',22),ylabel('���ϵ������ֵ','fontsize',22)...
%     ,set(gca,'fontsize',22),legend('��������ɷ�����������ɷ����ϵ��')

figure(4001)
plot([0:count-1]',cor,'-p',[0:count-1]',abs(cor),'-p'),xlabel('��������','fontsize',22)...
    ,set(gca,'fontsize',22),set(gca,'xtick',[0:4]),legend('���ϵ��','���ϵ������ֵ'),title('��������ɷ�����������ɷ����ϵ��')

[~,aaa] = min(abs(cor));
figure(1000)
subplot(4,1,1),plot(time,filter(Hd,u)),ylim([-0.03 0.03]),ylabel('���ٶ�/gal','fontsize',12);
subplot(4,1,2),plot(time,filter(Hd,s)),ylim([-0.03 0.03]),ylabel('���ٶ�/gal','fontsize',12);
subplot(4,1,3),plot(time,filter(Hd,s-res{aaa})),ylim([-0.03 0.03]),ylabel('���ٶ�/gal','fontsize',12);
subplot(4,1,4),plot(time,filter(Hd,res{aaa})),ylim([-0.03 0.03]),ylabel('���ٶ�/gal','fontsize',12),xlabel('ʱ��/s','fontsize',12);
handle_2 = get(gcf,'children');
axes(handle_2(4));title('�������ź�');
axes(handle_2(3));title('�������ź�');
axes(handle_2(2));title('�����񶯵ĵ����ɷ�');
axes(handle_2(1));title('����ʣ�µĵ����񶯵������ɷ�');

figure(1001)
plot(f,abs(alpha_initial),f,abs(test{aaa})),xlim([.1 25]),xlabel('f/Hz','fontsize',22),ylabel('��ֵ','fontsize',22)...
    ,set(gca,'fontsize',22),legend('����õ��Ĵ��ݺ�����ֵ','���յ�����Ĵ��ݺ�����ֵ'),set(gca,'xtick',[0.1 5 10 15 20 25])

% figure(1002)
% subplot(3,1,1),plot(time,filter(Hd,s_left{aaa})),ylim([-0.03 0.03]);
% subplot(3,1,2),plot(time,filter(Hd,res{aaa})),ylim([-0.03 0.03]);
% subplot(3,1,3),plot(time,s_left{aaa}-res{aaa}),ylim([-0.03 0.03]);
% handle_3 = get(gcf,'children');
% axes(handle_3(3));title('��ε����������ĵر������ɷ�');
% axes(handle_3(2));title('�����еõ��Ĵ��ݺ�����ӣ�һ���Է�����ĵر������ɷ�');
% axes(handle_3(1));title('����֮��');
% 
% figure(100)
% plot(f,abs(alpha_initial),f,abs(alpha_left{1}),f,abs(alpha_left{2}),f,abs(alpha_left{3}),f,abs(alpha_left{4})),xlim([0.1 25])...
%     ,xlabel('f/Hz','fontsize',22),ylabel('���ش��ݺ�����ֵ','fontsize',22),set(gca,'fontsize',22)...
%     ,legend('������ݺ���','��1�ε���','��2�ε���','��3�ε���','��4�ε���'),title('ÿ�εõ��Ĵ��ݺ���')



% alpha_final = test{aaa};
% save(['D:\szh\test\used-data\test\result\',folder,channel,'.mat'],'alpha_initial','alpha_final');
