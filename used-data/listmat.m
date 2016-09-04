function filename=listmat(x)   %直接从小到大排序转存为mat格式的文件,文件名格式1001000000.mat
file=dir([x,'*.mat']);
l=length(file);
for i=1:l
    filename{i}=file(i).name;
    for j=i+1:l
        if(str2num(filename{i})>str2num(file(j).name))
            filename{i}=file(j).name;
            file(j).name=file(i).name;
            file(i).name=filename{i};
        end
    end
end
end