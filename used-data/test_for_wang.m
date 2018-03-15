%****************************4s均匀分段线性模型****************************************************
clear all;
% close all;
% clc;
Disk='F';
%****************************读取数据、1-30Hz滤波、时域对齐预处理***********************************************

fs=200;dt=1/fs;pi2=2*pi;
n=120000;
% nwl=2^floor(log2(nl))*2;
nw=2^floor(log2(n))*2;
w=(1:nw)*fs/nw;
t=(1:n)*dt;

nt=n-40000;
nwt=2^floor(log2(nt))*2;
wt=(1:nwt)*fs/nwt;
nc=n-60000;
nwc=2^floor(log2(nc))*2;
wc=(1:nwc)*fs/nwc;
t0t=150;%30
n0t=floor(t0t/dt)+1;
t0c=50;%10
n0c=floor(t0c/dt)+1;
tt=(1:nt)*dt;
tc=(1:nc)*dt;

w01=1;w02=90;
num01=floor(w01*nwc/fs);
num02=floor(w02*nwc/fs);
% num01=floor(w01*nwt/fs);
% num02=floor(w02*nwt/fs);

dimianname='X:\Axx\Axx_xx00';
%           123456789012345
ditiename='X:\A_200\A200_xx20';
%          123456789012345678
outfilename='X:\Result\Rxx\Rxxx_x.txt';
%            12345678901234567890

no_sta='04';
for fenliang=1:1
dimianname(1)=Disk;ditiename(1)=Disk;outfilename(1)=Disk;
dimianname(5:6)=no_sta;
dimianname(9:10)=no_sta;
outfilename(12:13)=no_sta;
outfilename(17:18)=no_sta;
outfilename(20)=num2str(fenliang);

% rf2=fopen(outfilename,'wt');

for time=12:12
    if time<=9
        time_s='0x';
        time_s(2)=num2str(time);
    else
        time_s=num2str(time);
    end
    
    dimianname(12:13)=time_s;
    ditiename(15:16)=time_s;
    
    % load H:\A08\A08_0700;
    % sf31=XAD(n+1:2*n,3);
    load(dimianname);
    sf31=XAD(0*n+1:1*n,fenliang);
    % load H:\A07\A07_0830;
    % sf31=XAD(2*n+1:3*n,2);
    % load H:\A09\A09_0830;
    % sf31=XAD(2*n+1:3*n,2);
    % load H:\A10\A10_0830;
    % sf31=XAD(2*n+1:3*n,1);
    % load J:\A08\A08_0300;
    % sf31=XAD(1:n,2);

    load(ditiename);
    sb11=A_200(:,fenliang);
    % load H:\A_201\A201_0820;
    % sb11=A_200(:,1);

%     figure(2);
%     subplot(2,1,1);plot(t,sb11);
%     subplot(2,1,2);plot(t,sf31);

    x11=sb11(n0t:n0t+nt-1);
    x31=sf31(n0t:n0t+nt-1);

    [c,lag]=xcorr(x31,x11,'coeff');
    % c=abs(c);
    imax= c==max(c);
    naa=floor(lag(imax));

%     figure(88);
%     plot(lag,c);
%     if strcmp(no_sta,'07') && (time==6 || time==11 || time ==13 )
%         if fenliang==3
%             naa=-2079;
%         elseif fenliang==2
%             naa=-2102;
%         else
%             naa=-2123;
%         end
%     elseif strcmp(no_sta,'10')
%         if fenliang==3
%             naa=-4932;
%         elseif fenliang==2
%             naa=-4978;
%         else
%             naa=-4991;
%         end
%     elseif strcmp(no_sta,'09') && (time==9 || time==14)
%         if fenliang==2
%             naa=-2579;
%         end
%     end
    x31=sf31(n0t+naa:n0t+naa+nt-1);
    [c,lag]=xcorr(x31,x11,'coeff');
    % c=abs(c);
    imax= c==max(c);
    naa1=floor(lag(imax));
    % x31=sf31(n0t+naa+naa1:n0t+naa+naa1+nt-1);
    [c,lag]=xcorr(x31,x11,'coeff');
%     figure(1);
%     plot(lag,c);

    %截取后的时域
%     figure(5);
%     subplot(2,1,1);plot(tt,x11);
%     subplot(2,1,2);plot(tt,x31);

    xc1=x11(n0c:n0c+nc-1);
    xc3=x31(n0c:n0c+nc-1);
    [c,lag]=xcorr(xc3,xc1,'coeff');
    % c=abs(c);
    imax=find(c==max(c));
    naa2=floor(lag(imax));
    % xc3=x31(n0c+naa2:n0c+nc-1+naa2);
%     figure(7);
%     plot(lag,c);
%     figure(5);
%     subplot(2,1,1);plot(tc,xc1);
%     subplot(2,1,2);plot(tc,xc3);

    y1=fft(xc1,nwc);
    y3=fft(xc3,nwc);
    a1=zeros(1,nwc);
    a3=zeros(1,nwc);
    % a1(num01:num02)=y1(num01:num02);
    % a1(nwt-num02+1:nwt-num01+1)=y1(nwt-num02+1:nwt-num01+1);
    % a3(num01:num02)=y3(num01:num02);
    % a3(nwt-num02+1:nwt-num01+1)=y3(nwt-num02+1:nwt-num01+1);
    a1(num01:num02)=y1(num01:num02);
    a1(nwc-num02+1:nwc-num01+1)=y1(nwc-num02+1:nwc-num01+1);
    a3(num01:num02)=y3(num01:num02);
    a3(nwc-num02+1:nwc-num01+1)=y3(nwc-num02+1:nwc-num01+1);
%     figure(17);
%     plot(wc,abs(a3));


    x1=real(ifft(a1,nwc));
    x1=x1(1:nc);
    x3=real(ifft(a3,nwc));
    x3=x3(1:nc);
    ay1=abs(a1);gy1=angle(a1);
    ay3=abs(a3);gy3=angle(a3);

    %**********************************************我是华丽的分界线****************************************************
    %***************************以下是三分之一倍频程谱的参数设定&计算**************************************************
    df=0.2;df2=df*2;
%     f3=1.2:df:25;
    f3=[1:df:80];
    t4=4;
    n4=floor(t4/dt);
    nf3=length(f3);
    oc6=2^(1/6);
    alpha_co4_min=zeros(size(f3));
    yf3_1=zeros(size(f3));
    yf3_3=yf3_1;
    tn4=floor(nc/n4);%一共多少段
    t4list=(1:tn4)*t4;
    yf3_14=zeros(1,tn4);
    yf3_34=zeros(1,tn4);
    alpha3=yf3_1;
    b=zeros(1,nwc);
    b10=zeros(1,nwc);
    for j=1:nf3
        fl=f3(j)/oc6;
        fu=f3(j)*oc6;
        nl=round(fl*nwc/fs+1);
        nu=round(fu*nwc/fs+1);
        b1=zeros(1,nwc);
        b3=zeros(1,nwc);

        b1(nl:nu)=a1(nl:nu);
        b1(nwc-nu+1:nwc-nl+1)=a1(nwc-nu+1:nwc-nl+1);
        c1=real(ifft(b1,nwc));
        c1=c1(1:nc);
        ab1=abs(b1(nl:nu));gb1=angle(b1(nl:nu));

        b3(nl:nu)=a3(nl:nu);
        b3(nwc-nu+1:nwc-nl+1)=a3(nwc-nu+1:nwc-nl+1);
        c3=real(ifft(b3,nwc));
        c3=c3(1:nc);
        ab3=abs(b3(nl:nu));gb3=angle(b3(nl:nu));

%         figure(8);subplot(2,1,1);plot(tc,c1,'k');subplot(2,1,2);plot(tc,c3,'r');legend('地铁振源','地面记录',0);%gtext(['f_0=',num2str(f3(j)),'Hz']);
%         pause;
    %     yf3_1(j)=sqrt(var(real(b1)));
    
        %信号分段
        for jj=1:tn4
            c14=c1(1+(jj-1)*n4:jj*n4);
            c34=c3(1+(jj-1)*n4:jj*n4);
            %求每段信号的标准差
            yf3_14(jj)=sqrt(var(c14));%地铁
            yf3_34(jj)=sqrt(var(c34));%地表
        end
%         figure(3);plot(t4list,yf3_14,'.-k',t4list,yf3_34,'.-r');legend('地铁振源','地面记录',0);gtext(['f_0=',num2str(f3(j)),'Hz']);
%         pause;
        yf3_1(j)=sqrt(var(c1));
        yf3_3(j)=sqrt(var(c3));
%         pause;
        ak=0:0.001:1;co4_0=zeros(size(ak));
        for jj=1:length(ak)
            co4=xcorr(yf3_14,ak(jj)*yf3_14-yf3_34,'coeff');
            co4_0(jj)=abs(co4(tn4));
        end
%         fprintf(rf2,'%8.4f',co4_0(1));
%         figure(4);plot(ak,co4_0,'.-k');set(gca,'FontName','Times New Roman');%gtext(['f_0=',num2str(f3(j)),'Hz'])
%         pause;
        alpha_co4_min(j)=ak(co4_0==min(co4_0));

        alpha3(j)=sum(ab1.*ab3.*cos(gb3-gb1))/sum(ab1.^2);
    %     alpha3(j)=sum(ab1.*ab3)/sum(ab1.^2);
    %     alpha3(j)=yf3_3(j)/yf3_1(j);

    %     b(nl:nu)=b3(nl:nu)-alpha3(j)*b1(nl:nu);
    %     b(nwc-nu+1:nwc-nl+1)=b3(nwc-nu+1:nwc-nl+1)-alpha3(j)*b1(nwc-nu+1:nwc-nl+1);
    %     b10(nl:nu)=alpha3(j)*b1(nl:nu);
    %     b10(nwc-nu+1:nwc-nl+1)=alpha3(j)*b1(nwc-nu+1:nwc-nl+1);

        b(nl:nu)=b3(nl:nu)-alpha_co4_min(j)*b1(nl:nu);
        b(nwc-nu+1:nwc-nl+1)=b3(nwc-nu+1:nwc-nl+1)-alpha_co4_min(j)*b1(nwc-nu+1:nwc-nl+1);
        b10(nl:nu)=alpha_co4_min(j)*b1(nl:nu);
        b10(nwc-nu+1:nwc-nl+1)=alpha_co4_min(j)*b1(nwc-nu+1:nwc-nl+1);

    end
%     fprintf(rf2,'\n');
    alpha_co4_min;
%     figure(22);plot(f3,alpha_co4_min,'.-r');axis([1 25 0 0.5]);
%     gtext('21:20');xlabel('f/Hz');ylabel('\alpha');
    % saveas(gcf,'J:\环境振动\图片\4s三分之一倍频程\3号2120_1','fig');
%     fprintf(rf2,'%8.3f',alpha_co4_min);
%     fprintf(rf2,'\n');
%     pause;
    disp(['time= #',time_s,' completed']);
end

fclose all;
end

% disp(f3);
% disp(alpha_co4_min);

figure(9);
plot(f3,yf3_1,'k',f3,yf3_3,'r');
legend('地铁振动','地面振动');
figure(10);
plot(f3,alpha3);

x21=real(ifft(b,nwc));
x21=x21(1:nc);

x10=real(ifft(b10,nwc));
x10=x10(1:nc);

figure(6);
subplot(4,1,1);plot(tc,x1,'k');
subplot(4,1,2);plot(tc,x3,'k');
% subplot(4,1,3);plot(tc,xc3-alpha_e*xc1);
subplot(4,1,3);plot(tc,x21,'k');
subplot(4,1,4);plot(tc,x3-x21,'k');

figure(22)
plot(f3,alpha_co4_min),xlim([.1 50])
%****************************************************华丽的分界线again******************************