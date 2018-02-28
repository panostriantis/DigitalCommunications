%% script ylopoihshs gia to erwthma 4

close all; clear all; clc

% oi arxikopoihseis pou xreiazontai
T_symb=40;          %T symbol
T_samp=1;           %T sample
Tc=4;               %T ferousas
fc=1/Tc;            %f ferousas
Es=1;               %Energeia / symbol
Eb=Es/2;            %Energeia / bit

x = randsrc(1.0e5,1,[0 1]);

[psk_spec] = spectrum(x,Es,Eb,T_symb,fc,'psk');
[fsk_spec] = spectrum(x,Es,Eb,T_symb,fc,'fsk');

n = [1:1:2048]; %oi times pou 8elw na valw ston x'x a3ona
semilogy(n,psk_spec, 'r',n,fsk_spec,'b:');
title('Erotima 4 - Spectrum');
xlabel('samples');
ylabel('power spectrum');
legend('PSK Power Spectrum','FSK Power Spectrum');