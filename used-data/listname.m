function [filename1,filename2]=listname(x1,x2)   %从小到大，同时排序未转存的两种文件
file1=dir([x1,'*.t3w']);
file2=dir([x2,'*.mat']);
l1=length(file1);
l2=length(file2);
% if(l1/l2~=3)
%     disp('t3w and mat numbers unfit');
%     return
% end
namelength1=length(file1(1).name);
namelength2=length(file2(1).name);
for i=1:l1
    filename1{i}=file1(i).name;
    for j=i+1:l1
        if(str2num(file1(i).name((namelength1-17):(namelength1-8)))>str2num(file1(j).name((namelength1-17):(namelength1-8))))%月日时分秒
            filename1{i}=file1(j).name;
            file1(j).name=file1(i).name;
            file1(i).name=filename1{i};
        end
    end
    fname1(i)=str2num(filename1{i}((namelength1-17):(namelength1-8)));
end
for i=1:l2
    filename2{i}=file2(i).name;
    for j=i+1:l2
        if(str2num(file2(i).name((namelength2-13):(namelength2-4)))>str2num(file2(j).name((namelength2-13):(namelength2-4))))%月日时分秒
            filename2{i}=file2(j).name;
            file2(j).name=file2(i).name;
            file2(i).name=filename2{i};
        end
    end
    temp=changename(filename2{i});
    fname2(i)=str2num(temp((namelength2-13):(namelength2-4)));
end
clear temp

% for i=1:l1-1
%     if((fname1(i+1)-fname1(i))~=1000 && (fname1(i+1)-fname1(i))~=5000)%未考虑月日
%         disp('t3w discontinuous');
%         return
%     end
% end
% for i=1:l2-1
%     if((fname2(i+1)-fname2(i))~=3000 && (fname2(i+1)-fname2(i))~=7000)%未考虑月日
%         disp('mat discontinuous');
%     end
% end

end