%一次存3段 mat
[filename1,filename2]=listname();
% l1=length(filename1);
% l2=length(filename2);
% namelength1=length(filename1{1});
namelength2=length(filename2{1});
% if(l1/l2~=3)
%     disp('error');
%     return
% end

for i=1:l2
    fname1_1=filename1{3*i-2};
    fname1_2=filename1{3*i-1};
    fname1_3=filename1{3*i};
    fname2=filename2{i};
    changed_fname2=changename(fname2);
    name1_1=str2num(fname1_1(5:14));%月日时分秒
%     name1_2=str2num(fname1_2(5:14));
%     name1_3=str2num(fname1_3(5:14));
    name2=str2num(changed_fname2((namelength2-13):(namelength2-4)));%月日时分秒
    if(abs(name1_1-name2)~=0)
        disp('filename unfit');
        return
    end
%     if((name1_2-name1_1)~=1000 || (name1_3-name1_2)~=1000)
%         disp('t3w_filename discontinuous');
%         return
%     end
    [under_ch1_1,under_ch2_1,under_ch3_1]=resave(fname1_1);
    [under_ch1_2,under_ch2_2,under_ch3_2]=resave(fname1_2);
    [under_ch1_3,under_ch2_3,under_ch3_3]=resave(fname1_3);
    resave(fname2);
    judge=input('y/n');
    if(judge=='y')
        delete(fname1_1);delete(fname1_2);delete(fname1_3);
        delete(fname2);
        continue
    end
    if(judge=='1')
        fid=fopen('errorname.txt','a');
        fprintf(fid,'%s\t\t\r\n',fname1_1);
        fclose(fid);
        if(strcmp('#',fname2(5))==1)
            folder=fname2(4:5);
        else
            folder=fname2(4:6);
        end
        delete(['D:\szh\test\200#\',fname1_1(5:14),'.txt']);
        delete(['D:\szh\test\',strcat(folder,'\'),fname1_1(5:14),'.txt']);
        continue
    end
    if(judge=='2')
        fid=fopen('errorname.txt','a');
        fprintf(fid,'%s\t\t\r\n',fname1_2);
        fclose(fid);
        if(strcmp('#',fname2(5))==1)
            folder=fname2(4:5);
        else
            folder=fname2(4:6);
        end
        delete(['D:\szh\test\200#\',fname1_2(5:14),'.txt']);
        delete(['D:\szh\test\',strcat(folder,'\'),fname1_2(5:14),'.txt']);
        continue
    end
    if(judge=='3')
        fid=fopen('errorname.txt','a');
        fprintf(fid,'%s\t\t\r\n',fname1_3);
        fclose(fid);
        if(strcmp('#',fname2(5))==1)
            folder=fname2(4:5);
        else
            folder=fname2(4:6);
        end
        delete(['D:\szh\test\200#\',fname1_3(5:14),'.txt']);
        delete(['D:\szh\test\',strcat(folder,'\'),fname1_3(5:14),'.txt']);
        continue
    end
    if(judge=='s')
        break
    end
end









