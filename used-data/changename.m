function name=changename(filename)%修改文件名为整点时间
l=length(filename);
fname=filename((l-13):(l-4));
prefix=filename(1:(l-18));
year=filename((l-17):(l-14));month=fname(1:2);day=fname(3:4);hour=fname(5:6);min=fname(7:8);sec=fname(9:10);
Sec=str2num(sec);
if((Sec>3 && Sec<57) || (Sec>=60))
    disp('error,too long time lag');
    clear all
    name=0;
    return
else
if(Sec==0)
    name=filename;
else
    if(Sec<60 && Sec>=58)
        sec='00';
        Min=str2num(min)+1;
        if(Min<60 && Min>=10)
            min=num2str(Min);
        else
            if(Min<10)
                min=strcat('0',num2str(Min));
            end
        end
        if(Min==60)
            min='00';
            Hour=str2num(hour)+1;
            if(Hour>=10 && Hour<24)
                hour=num2str(Hour);
            else
                if(Hour<10)
                    hour=strcat('0',num2str(Hour));
                end
            end
            if(Hour==24)
                hour='00';
                Day=str2num(day)+1;
                if(Day>=10 && Day<=30)
                    day=num2str(Day);
                else
                    if(Day<10)
                        day=strcat('0',num2str(Day));
                    end
                end
                if(Day==31)
                    Month=str2num(month);
                    if(Month==10 || Month==12)
                        day=num2str(Day);
                    end
                    if(Month==9 || Month==11)
                        day='01';
                        Month=Month+1;
                        if(Month<10)
                            month=strcat('0',num2str(Month));
                        else
                            if(Month>=10 && Month<=12)
                                month=num2str(Month);
                            end
                        end
                        if(Month==13)
                            month='01';
                            Year=str2num(year)+1;
                            year=num2str(Year);
                        end
                    end
                end
                if(Day==32)
                    day='01';
                    Month=str2num(month)+1;
                    if(Month<10)
                        month=strcat('0',num2str(Month));
                    else
                        if(Month>=10 && Month<=12)
                            month=num2str(Month);
                        end
                    end
                    if(Month==13)
                        month='01';
                        Year=str2num(year)+1;
                        year=num2str(Year);
                    end
                end
            end
        end
    end
    if(Sec<=3)
        sec='00';
    end
    name=strcat(prefix,year,month,day,hour,min,sec,'.mat');
    if(length(name)~=l)
        disp('name length error');
        return
    end
    clear prefix year month day hour min sec fname filename l Year Month Day Hour Min Sec
end
end
end