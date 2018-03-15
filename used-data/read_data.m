% clear all
% path='D:\szh\test\used-data\高铁\HSRdata_merge\SAC_M\';
% full_name=dir(fullfile(path,'*SAC*'));
% [hd,ori_data_example]=load_sac([path,full_name(145).name]);
% delta=hd.delta;
% b_time=hd.b;
% e_time=hd.e;
% exact_time=hd.nzhour*3600+hd.nzmin*60+hd.nzsec+hd.nzmsec/1000;
% % time=exact_time+b_time:delta:exact_time+e_time;
% 
% 
% len=17280000;
% t=[0:len-1]'/200;
% 
% start=1;
% while(ori_data_example(start)==0)
% start=start+1;
% end
% start
% over=len;
% while(ori_data_example(over)==0)
% over=over-1;
% end
% over
% 
% % %for M001-M024
% % istart=1e6;
% % iend=4.6e6-1;
% % u=ori_data_example(istart:iend)-sum(ori_data_example(istart:iend))/len;
% % tt=[0:iend-istart]';
% % p=polyfit(tt,u,1);
% % uuu=u-(p(1)*tt+p(2));
% % clear u
% 
% %for M025-M036
% if(over-start<3.6e6)
%     istart=start+1e5;
%     iend=istart+4*60*60*200-1;
% else
%     istart=start+1e5;
%     iend=istart+5*60*60*200-1;
% end
% u=ori_data_example(istart:iend)-sum(ori_data_example(istart:iend))/len;
% tt=[0:iend-istart]';
% p=polyfit(tt,u,1);
% uuu=u-(p(1)*tt+p(2));
% clear u
% 
% % figure(1)
% % plot(tt/200,uuu)
% 
% 
% 
% %pick data and save
% folder = [hd.kstnm(1:4),'\'];
% mkdir(['picked_data\test\',hd.kstnm])
% 
% l = 60000;
% n = [0:l-1]';
% fs = 200;
% num_u = 20 * fs;
% count = 1;
% 
% lll = length(uuu);
% time = lll/l;
% 
% HD = highpass0p5;
% yyy = myfilter(HD,uuu);
% 
% for i = 0:time-1
%     u = uuu(i*l+1:i*l+l);
%     zzz = yyy(i*l+1:i*l+l);
%        
%     figure(201)
%     plot(n,zzz)
%      
%     figure(201)
%     temp = ginput();
%     t = size(temp,1);
%     for j = 1:t
%         disp(count);
%         istart = round(temp(j,1) - fs * 2);
%         if(istart<0)
%             istart = round(temp(j,1));
%         end
%         under_ch1 = u(istart:istart -1 + num_u);
%         save(['D:\szh\test\used-data\picked_data\test\',folder,num2str(count),'.mat'],'under_ch1');
%         clear under_ch1 istart
%         count = count + 1;
%         
%     end
%     clear temp t j
% %     close all
% end
% 



%%
%生成连续高铁信号
file=dir('D:\szh\test\used-data\picked_data\test');

test = zeros(17280000,1);

count = 0;
for i = 3:50
    name=dir(['D:\szh\test\used-data\picked_data\test\',file(i).name]);
    n = length(name);
    for j = 3:n
        load(['D:\szh\test\used-data\picked_data\test\',file(i).name,'\',name(j).name])
        if(max(under_ch1)<=2e6)
            under_ch1 = under_ch1 / 1e6;
        end
        if(max(under_ch1)>2e6)
            under_ch1 = under_ch1 /1e7;
        end
        test(count*4000+1:count*4000+4000) = under_ch1;
        clear under_ch1
        count = count + 1;
    end
end

temp = count *4000;
test(temp+1:temp*2)=test(1:temp);
xxx = 17280000 -2 *temp;
test(2*temp+1:end) = test(1:xxx);