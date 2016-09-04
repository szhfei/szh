%只存10min mat
[filename1,filename2]=listname();
l1=length(filename1);
% l2=length(filename2);
% namelength1=length(filename1{1});
namelength2=length(filename2{1});
% if(l1/l2~=3)
%     disp('error');
%     return
% end

for i=1:l1
    fname1=filename1{i};
    kk=mod(i-1,3);
    j=(i-1-kk)/3+1;
    fname2=filename2{j};
    changed_fname2=changename(fname2);
    name1=str2num(fname1(5:14));%月日时分秒
    name2=str2num(changed_fname2((namelength2-13):(namelength2-4)));%月日时分秒
    if(abs(name1-name2)~=kk*1000)
        disp('filename unfit');
        return
    end

    [under_ch1,under_ch2,under_ch3]=resave_1(fname1,kk);
    [surf_ch1,surf_ch2,surf_ch3]=resave_1(fname2,kk);
    l=120000;
    n=0:l-1;
    n=n';
    t=n/200;
    f=n*200/l;
    f40=[0:24000-1]'*200/l;
        
    Funder_ch1=fft(under_ch1);
    Funder_ch2=fft(under_ch2);
    Funder_ch3=fft(under_ch3);
    Fsurf_ch1=fft(surf_ch1);
    Fsurf_ch2=fft(surf_ch2);
    Fsurf_ch3=fft(surf_ch3);
    mag_under_ch1=abs(Funder_ch1);
    mag_under_ch2=abs(Funder_ch2);
    mag_under_ch3=abs(Funder_ch3);
    mag_surf_ch1=abs(Fsurf_ch1);
    mag_surf_ch2=abs(Fsurf_ch2);
    mag_surf_ch3=abs(Fsurf_ch3);
    
    figure(1)
    subplot(2,3,1),plot(t,under_ch1),axis([0 600 -0.7 0.7]);
    subplot(2,3,2),plot(t,under_ch2),axis([0 600 -0.7 0.7]);
    subplot(2,3,3),plot(t,under_ch3),axis([0 600 -0.7 0.7]);
    subplot(2,3,4),plot(t,surf_ch1),axis([0 600 -0.3 0.3]);
    subplot(2,3,5),plot(t,surf_ch2),axis([0 600 -0.3 0.3]);
    subplot(2,3,6),plot(t,surf_ch3),axis([0 600 -0.3 0.3]);
    
    figure(2)
    subplot(2,3,1),plot(f,mag_under_ch1),axis([0 200 0 100]);
    subplot(2,3,2),plot(f,mag_under_ch2),axis([0 200 0 100]);
    subplot(2,3,3),plot(f,mag_under_ch3),axis([0 200 0 100]);
    subplot(2,3,4),plot(f,mag_surf_ch1),axis([0 200 0 100]);
    subplot(2,3,5),plot(f,mag_surf_ch2),axis([0 200 0 100]);
    subplot(2,3,6),plot(f,mag_surf_ch3),axis([0 200 0 100]);
    
    figure(3)
    subplot(2,3,1),plot(f40,mag_under_ch1(1:24000)),axis([0 40 0 100]);
    subplot(2,3,2),plot(f40,mag_under_ch2(1:24000)),axis([0 40 0 100]);
    subplot(2,3,3),plot(f40,mag_under_ch3(1:24000)),axis([0 40 0 100]);
    subplot(2,3,4),plot(f40,mag_surf_ch1(1:24000)),axis([0 40 0 100]);
    subplot(2,3,5),plot(f40,mag_surf_ch2(1:24000)),axis([0 40 0 100]);
    subplot(2,3,6),plot(f40,mag_surf_ch3(1:24000)),axis([0 40 0 100]);
    
    Hd=lowpass2530;
    under_ch1=filter(Hd,under_ch1);
    under_ch2=filter(Hd,under_ch2);
    under_ch3=filter(Hd,under_ch3);
    surf_ch1=filter(Hd,surf_ch1);
    surf_ch2=filter(Hd,surf_ch2);
    surf_ch3=filter(Hd,surf_ch3);
    figure(4)
    subplot(2,3,1),plot(t,under_ch1),axis([0 600 -0.5 0.5]);
    subplot(2,3,2),plot(t,under_ch2),axis([0 600 -0.5 0.5]);
    subplot(2,3,3),plot(t,under_ch3),axis([0 600 -0.5 0.5]);
    subplot(2,3,4),plot(t,surf_ch1),axis([0 600 -0.2 0.2]);
    subplot(2,3,5),plot(t,surf_ch2),axis([0 600 -0.2 0.2]);
    subplot(2,3,6),plot(t,surf_ch3),axis([0 600 -0.2 0.2]);
    
    judge=input('y/n');
    if(judge=='y')
        delete(fname1);
        if(kk==2)
            delete(fname2);
        end
        continue
    end
    if(judge=='n')
        fid=fopen('errorname.txt','a');
        fprintf(fid,'%s\t%s\r\n',fname1,fname2);
        fclose(fid);
        if(strcmp('#',fname2(5))==1)
            folder=fname2(4:5);
        else
            folder=fname2(4:6);
        end
        delete(['D:\szh\test\200#\',fname1(5:14),'.mat']);
        delete(['D:\szh\test\',strcat(folder,'\'),fname1(5:14),'.mat']);
        continue
    end

    if(judge=='s')
        delete(['D:\szh\test\200#\',fname1(5:14),'.mat']);
        delete(['D:\szh\test\',strcat(folder,'\'),fname1(5:14),'.mat']);
        break
    end
end