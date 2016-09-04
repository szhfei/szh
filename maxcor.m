function [n,x]=maxcor(cor)
l=length(cor);
x=cor(1);
for i=1:l
    if(abs(x)<=abs(cor(i)))
        n=i;
        x=cor(i);
    end
end
end