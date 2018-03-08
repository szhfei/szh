function res = myfilter(hd,xxx)
    res = filter(hd,xxx);
    res = flipud(res);
    res = filter(hd,res);
    res = flipud(res);
end