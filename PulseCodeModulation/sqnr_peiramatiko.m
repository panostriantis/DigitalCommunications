%% SQNR_PEIR H sunarthsh auth upologizei th peiramatikh timh gia to SQNR 
% sthn e3odo tou kvantisth kai epistrefei thn timh auth se db
% OUTPUTS
% sqnr_peir: H peiramatikh timh tou SQNR sthn e3odo tou kvantisth
function [sqnr_peir] = sqnr_peiramatiko( x,xq,centers )
P = mean(x.^2);
xq = centers(xq); %to kvantismeno shma
Nq = mean((x-xq).^2);
%upologismos tou sqnr se db
sqnr_peir = 10*log10(P/Nq);
end