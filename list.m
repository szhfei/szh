function [filename1,filename2]=list(x1,x2)   %直接从小到大排序转存为mat格式的文件
file1=dir([x1,'*.mat']);
file2=dir([x2,'*.mat']);
l1=length(file1);
l2=length(file2);
if(l1~=l2)
    disp('file number unfit');
    return
end
for i=1:l1
    filename1{i}=file1(i).name;
    for j=i+1:l1
        if(str2num(filename1{i})>str2num(file1(j).name))
            filename1{i}=file1(j).name;
            file1(j).name=file1(i).name;
            file1(i).name=filename1{i};
        end
    end
end
for i=1:l2
    filename2{i}=file2(i).name;
    for j=i+1:l1
        if(str2num(filename2{i})>str2num(file2(j).name))
            filename2{i}=file2(j).name;
            file2(j).name=file2(i).name;
            file2(i).name=filename2{i};
        end
    end
end
for i=1:l1
    if(strcmp(filename1{i},filename2{i})~=1)
        disp('排序错误，文件名不一致');
        clear all
        return
    end
end
end