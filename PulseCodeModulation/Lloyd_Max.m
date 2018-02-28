%% Lloyd_Max : h synarthsh gia ton anomoiomorfo kbantisth
% input x,N,min_value,max_value,Kmax
% output xq,centers,D

function [xq,centers,D] = Lloyd_Max(x,N,min_value,max_value,Kmax)
n = 2 ^ N;
%arxikopoihsh metablhtwn
x1=zeros(size(x));
xq=zeros(size(x));
centers=zeros(n,1);
centers1=zeros(n,1);
T=zeros(n-1,1);
D = zeros(Kmax,1);
%tropopoihsh tou x wste efarmozei sta oria
for i=1:size(x),
if (x(i) > max_value)
x1(i) = max_value;
elseif (x(i) < min_value)
x1(i) = min_value;
else
x1(i) = x(i);
end
end
%arxikopoihsh tou T
for i = 1 : (n-1),
T(i) = i*(max_value - min_value) / n;
end
T=flipud(T); %ton anapodogyrizoume
%arxikopoihsh kentrwn
%an yparxoun x pou anhkoun sto anwtato diasthma vres to kentroeides
if numel(x1(x1<=max_value & x1>T(1))) > 0
centers1(1) = mean(x1(x1<=max_value & x1>T(1)));
%an den uparxoun vale to prwto kentroeides sto meso ths prwths zwnhs
else
centers1(1) = (T(1)+max_value)/2;
end
%an yparxoun x pou anhkoun sto katwtato diasthma vres to kentroeides
if numel(x1(x1<=T(n-1) & x1>=min_value))
centers1(n) = mean(x1(x1<=T(n-1) & x1>=min_value));
%an den uparxoun vale to prwto kentroeides sto meso ths
%teleutaias zwnhs
else
centers1(n) = (T(n-1)+min_value)/2;
end
%gia oles tis upoloipes zwnes kanw to idio
for i = 2 : (n-1)
if numel(x1(x1<=T(i-1) & x1>T(i))) > 0
centers1(i) = mean(x1(x1<=T(i-1) & x1>T(i)));
else
centers1(i) = (T(i-1)+T(i))/2;
end
end
k=2;
D(1) = 0;
D(2) = 1;
%oso h diafora tou distortion apo auto ths prohgoumenou iteration
%den exei
%pesei katw apo ena katw orio = 10^-9, epanelave ta vhmata tou
%Lloyd-Max
while k < Kmax && norm( D(k) - D(k-1) ) >= 10^-7
k = k + 1;
centers=centers1;
%epanaupologismos twn akrwn twn zwnwn
for i = 1 : (n-1),
T(i) = (centers(i) + centers(i+1)) / 2;
end
%calc xq
xq(x1<=max_value & x1>T(1)) = 1;
xq(x1<=T(n-1) & x1>=min_value) = n;
for i = 2 : (n-1),
xq(x1<=T(i-1) & x1>T(i)) = i;
end
%ypologismos paramorfwshs
D(k) = mean( (x1 - centers(xq)) .^ 2 );
%% update to akrwtato kentroeides
if numel(x1(x1<=max_value & x1>T(1))) > 0
centers1(1) = mean(x1(x1<=max_value & x1>T(1)));
else
centers1(1) = centers(1);
end
%gia to katw akrwtato
if numel(x1(x1<=T(n-1) & x1>=min_value))
centers1(n) = mean(x1(x1<=T(n-1) & x1>=min_value));
else
centers1(n) = centers(n);
end
%gia ola ta alla
for i = 2 : (n-1),
if numel(x1(x1<=T(i-1) & x1>T(i))) > 0
centers1(i) = mean(x1(x1<=T(i-1) & x1>T(i)));
else
% centers1(i) = centers(i);
end
end
end
D = D';