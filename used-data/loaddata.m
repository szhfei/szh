%load ¸ßÌú data
function [ori_data_example,hd,final_time] = loaddata(path,sta_no)
full_name=dir(fullfile(path,'*SAC*'));
[hd,ori_data_example]=load_sac([path,full_name(sta_no).name]);
delta=hd.delta;
b_time=hd.b;
e_time=hd.e;
exact_time=hd.nzhour*3600+hd.nzmin*60+hd.nzsec+hd.nzmsec/1000;
final_time=exact_time+b_time;
end