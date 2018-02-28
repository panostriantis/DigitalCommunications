%% function spectrum
% s : spectrum
% ypologismos fasmatos isxyos
% x : to arxiko mas binary
% Es : energeia / symbol
% Eb : energeia / bit
% T_symb : T symbol
% fc : f ferousas
% type : PSK || FSK

function [spec] = spectrum(x,Es,Eb,T_symb,fc,type)

if type=='psk'
    [symb,~]=mapper(x,'psk');
    [~,s_m]=modulator(symb,10,Es,Eb,T_symb,fc,'psk');
elseif type=='fsk'
    [symb,~]=mapper(x,'psk');
    [~,s_m]=modulator(symb,10,Es,Eb,T_symb,fc,'fsk');
end
length_s_m = length(s_m);
s_m_reshaped = reshape(s_m',1,length_s_m*40);
length_reshaped = length(s_m_reshaped);
r = 2048 - mod(length_s_m*40,2048);%Gia na vrw tis epipleon 8eseis pou prepei
%na eisagw mhdenika sto dianusma s_m_reshaped.
for i = length_reshaped:length_reshaped+(r-1) %Sumplhrwnw me mhdenika tis upoloipes 8eseis
    s_m_reshaped(i+1) = 0;%tou neou dianusmatos
end
%Arxikopoiw to prwto sector apo ta 2048 me apeu8eias timh
sector(1:2048,1) = abs(fft(s_m_reshaped(1:2048))).^2;
for i = 2:(length_reshaped/2048)-1%Ypologizw ta upoloipa 2047 tmhmata kai ta vazw sto
    %dianusma sector
    sector(1:2048,i)=abs(fft(s_m_reshaped((2048*i)+1:2048*(i+1)))).^2;
end
for i = 1:2048 %Gia ta 2048 tmhmata pou upologisame parapanw vriskoume thn
    %mesh timh tous
    athroisma=0;
    for j = 1:length_reshaped/2048-1
        athroisma = sector(i,j)+athroisma;
    end
    spec(i,1) = athroisma/2048;
end
end