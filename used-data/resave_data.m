[filename1,filename2]=listname('D:\szh\test\used-data\','D:\szh\test\used-data\');
l1=length(filename1);
l2=length(filename2);

% for i=1:l1
%     fname1=filename1{i};
%     resave(fname1);
% end

for i=1:l2
    fname2=filename2{i};
    resave(fname2);
end