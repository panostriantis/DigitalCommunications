%% SQNR_THEWR H sunarthsh auth upologizei th 8ewrhtikh timh gia to SQNR 
% sthn e3odo tou kvantisth kai epistrefei thn timh auth se db
% OUTPUTS
% sqnr_thewr: H 8ewrhtikh timh tou SQNR sthn e3odo tou kvantisth
function [sqnr_thewr] = sqnr_thewrhtiko( N,centers,min_value,max_value )
syms x;
P=eval(int(x^2*exp(-x),x,min_value,max_value));
P2=eval(int(x^2*exp(-x),x,max_value,inf));
P=P+P2;
Nq=0;
for i=1:2^N-1
res=int((x-centers(i))^2*exp(-x),min_value+(i-1)*((max_value-min_value)/2^(N)),min_value+(i)*((max_value-min_value)/2^(N)));
Nq=Nq+eval(res);
end
temp=eval(int((x-centers(length(centers)))^2*exp(-x),x,max_value,inf));
Nq=Nq+temp;
sqnr_thewr=10*log10(P/Nq);
end