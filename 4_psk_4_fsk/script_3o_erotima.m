%% script ylopoihshs gia to erwthma 3

close all; clear all; clc

% oi arxikopoihseis pou xreiazontai
T_symb=40;          %T symbol
T_samp=1;           %T sample
Tc=4;               %T ferousas
fc=1/Tc;            %f ferousas
Es=1;               %Energeia / symbol
Eb=Es/2;            %Energeia / bit

x = randsrc(1.0e5,1,[0 1]); % h binary akolou8ia mas
SNR = [0:2:8]; 

[psk_symb,mhkos1] = mapper(x,'psk');
[fsk_symb,mhkos2] = mapper(x,'fsk');

for i = 1:length(SNR)
    %% psk
    [psk_signal,~] = modulator(psk_symb,SNR(i),Es,Eb,T_symb,fc,'psk');
    [psk_r] = demodulator(psk_signal,Es,T_symb,fc,'psk');
    [psk_symb_teliko] = fwraths(psk_r,'psk');
    [psk_received] = demapper(psk_symb_teliko,mhkos1,'psk');
    psk_BER_exp(i) = ypologismos_ber(x,mhkos1,psk_received,SNR(i),'experimental');
    psk_BER_theor(i) = ypologismos_ber(x,mhkos1,psk_received,SNR(i),'theoritical');
    
    %% fsk
    [fsk_signal,~] = modulator(fsk_symb,SNR(i),Es,Eb,T_symb,fc,'fsk');
    [fsk_r] = demodulator(fsk_signal,Es,T_symb,fc,'fsk');
    [fsk_symb_teliko] = fwraths(fsk_r,'fsk');
    [fsk_received] = demapper(fsk_symb_teliko,mhkos2,'fsk');
    fsk_BER_exp(i) = ypologismos_ber(x,mhkos2,fsk_received,SNR(i),'experimental');
    
end

semilogy(SNR',psk_BER_exp,'r:>',SNR',fsk_BER_exp,'m-*',SNR',psk_BER_theor,'b-o');
legend('BER psk','BER fsk','BER psk theor');
xlabel('SNR(dB)');
ylabel('BER');
title('Erotima 3 - BER');