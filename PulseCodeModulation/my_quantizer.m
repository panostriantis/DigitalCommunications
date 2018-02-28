%% my_quantizer : synarthsh tou omoiomorfou kbantisth
% input x,N,min_value,max_value
% output xq,centers

function [xq,centers] = my_quantizer( x,N,min_value,max_value )
%Ypologizoume tis apodektes times toy shmatos me vash tis akraies tou
%shmatos eisodou
x(x>max_value)=max_value; %vriskw th max timh tou input
x(x<min_value)=min_value; %vriskw th min timh tou input
%Ypologizoume to vhma kvantismou
D=(max_value-min_value)/2^(N);
%Ypologizw ta akra twn diasthmatwn a(1)-a(N+1)
a(1)=min_value;
for i=2:2^(N)+1
a(i)=a(i-1)+D;
end
%Ypologizw ta kentra twn diasthmatwn
for i=1:2^N
centers(i)=(a(i)+a(i+1))/2;
end
%Antoistixizw kathe deigma sthn perioxh pou anhkei
%kai katalhgw sthn eksodo xq.To
%dianusma auto periexei enan akeraio pou apotelei deikth sto dianusma
%twn kentrwn kai leei poio kentro (apo ta 2^N)
%antistoixizetai to sugkekrimeno deigma
xlen=max(size(x,1),size(x,2));
%Arxikopoiw to dianusma twn lusewn
xq=zeros(xlen,1);
for i=1:xlen
flag=true;
k=1;
while(flag)
if(x(i)<=a(k+1))
xq(i)=k;
flag=false;
else
k=k+1;
end
end
end
centers=centers';
end