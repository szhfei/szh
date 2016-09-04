function [ch1,ch2,ch3]=resave(filename)%存t3w 直接把mat分3个文件存
l=length(filename);
postfix=filename((l-2):l);
if(strcmp(postfix,'t3w')==1)%t3w 转存
    [under_ch1, under_ch2, under_ch3, bn, sf, under_btime] = t3w(filename);
    clear bn under_btime
    lu1=length(under_ch1);
    lu2=length(under_ch2);
    lu3=length(under_ch3);
    if(sf~=200)
        disp('frequency error');
        return
    end
    if(lu1~=120000 || lu2~=120000  || lu3~=120000)
        disp('length error');
        return
    end
    l=lu1;
    clear lu1 lu2 lu3
    
    n=0:l-1;
    n=n';
    t=n/sf;
    %f=n*sf/l;
    
    p=polyfit(t,under_ch1,1);
    under_ch1=under_ch1-(p(1)*t+p(2));
    p=polyfit(t,under_ch2,1);
    under_ch2=under_ch2-(p(1)*t+p(2));
    p=polyfit(t,under_ch3,1);
    under_ch3=under_ch3-(p(1)*t+p(2));

    under_ch1=under_ch1-sum(under_ch1)/l;
    under_ch2=under_ch2-sum(under_ch2)/l;
    under_ch3=under_ch3-sum(under_ch3)/l;

    Hd = highpass105;
    under_ch1=filter(Hd,under_ch1);
    under_ch2=filter(Hd,under_ch2);
    under_ch3=filter(Hd,under_ch3);
    
%     fid=fopen(['D:\szh\test\200#\',filename(5:14),'.txt'],'r');
%     if(fid==-1)
%         fid=fopen(['D:\szh\test\200#\',filename(5:14),'.txt'],'w+');
%         %fprintf(fid,'%s:00\r\n',under_btime);
%         for i=1:l
%             fprintf(fid,'%.20f\t',under_ch1(i));
%             fprintf(fid,'%.20f\t',under_ch2(i));
%             fprintf(fid,'%.20f\r\n',under_ch3(i));
%         end
%     end
%     fclose(fid);
    save(['D:\szh\test\200#\',filename(5:14),'.mat'],'under_ch1','under_ch2','under_ch3');
    
    ch1=under_ch1;
    ch2=under_ch2;
    ch3=under_ch3;
    clear under_ch1 under_ch2 under_ch3 Hd p l n t sf
end

if(strcmp(postfix,'mat')==1)%mat 转存
    load(filename,'D_a','sf');
    if(sf~=200)
        disp('frequency error');
        return
    end
    ch1=D_a(:,1);
    ch2=D_a(:,2);
    ch3=D_a(:,3);
    clear D_a
    l1=length(ch1);
    l2=length(ch2);
    l3=length(ch3);
    if(l1~=360000 || l2~=360000 || l3~=360000)
        disp('length error')
        return
    end
    l=l1/3;
    clear l1 l2 l3
    n=0:l-1;
    n=n';
    t=n/sf;
    %f=n*sf/l;
    
    changed_filename=changename(filename);
    namelength=length(changed_filename);
    fname=changed_filename((namelength-13):(namelength-4));
    clear namelength
    month=fname(1:2);day=fname(3:4);hour=fname(5:6);min=fname(7:8);sec=fname(9:10);
    if(strcmp('#',changed_filename(5))==1)
        folder=changed_filename(4:5);
    else
        folder=changed_filename(4:6);
    end
    
    for kk=0:2
        surf_ch1=ch1((kk*l+1):(kk*l+l));
        surf_ch2=ch2((kk*l+1):(kk*l+l));
        surf_ch3=ch3((kk*l+1):(kk*l+l));
        
        p=polyfit(t,surf_ch1,1);
        surf_ch1=surf_ch1-(p(1)*t+p(2));
        p=polyfit(t,surf_ch2,1);
        surf_ch2=surf_ch2-(p(1)*t+p(2));
        p=polyfit(t,surf_ch3,1);
        surf_ch3=surf_ch3-(p(1)*t+p(2));

        surf_ch1=surf_ch1-sum(surf_ch1)/l;
        surf_ch2=surf_ch2-sum(surf_ch2)/l;
        surf_ch3=surf_ch3-sum(surf_ch3)/l;
        
        Hd=highpass105;
        surf_ch1=filter(Hd,surf_ch1);
        surf_ch2=filter(Hd,surf_ch2);
        surf_ch3=filter(Hd,surf_ch3);
        
        ch1((kk*l+1):(kk*l+l))=surf_ch1;
        ch2((kk*l+1):(kk*l+l))=surf_ch2;
        ch3((kk*l+1):(kk*l+l))=surf_ch3;
        
        Min=str2num(min)+kk*10;
        if(Min==0)
            Min='00';
        else
            Min=num2str(Min);
        end
        
%         fid=fopen(['D:\szh\test\',strcat(folder,'\'),month,day,hour,Min,sec,'.txt'],'r');
%         if(fid==-1)
%             fid=fopen(['D:\szh\test\',strcat(folder,'\'),month,day,hour,Min,sec,'.txt'],'w+');
%             for i=1:120000
%                 fprintf(fid,'%.20f\t',surf_ch1(i));
%                 fprintf(fid,'%.20f\t',surf_ch2(i));
%                 fprintf(fid,'%.20f\r\n',surf_ch3(i));
%             end
%         end
%         fclose(fid);
        save(['D:\szh\test\',strcat(folder,'\'),month,day,hour,Min,sec,'.mat'],'surf_ch1','surf_ch2','surf_ch3');
        
    end
    clear surf_ch1 surf_ch2 surf_ch3 kk l n t sf Hd folder fname year month day hour min sec
end

end