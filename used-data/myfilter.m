function res = myfilter(hd,xxx)
    temp = filter(hd,xxx);
    res = flipud(temp);
    temp = filter(hd,res);
    res = flipud(temp);
end