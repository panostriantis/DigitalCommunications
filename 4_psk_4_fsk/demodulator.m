%% demodulator function
% r : dianysma meta thn apodiamorfwsh
% signal : to shma mas
% Es : energeia / symbol
% T_symb : T symbol
% fc : f ferousas
% type : PSK or FSK

function [r] = demodulator(signal,Es,T_symb,fc,type)

gt = sqrt(2*Es/T_symb);%Orthogwnios palmos.
%Apodiamorfwsh shmatos.
if type=='psk'
%Pollaplasiazw tis 2 sunistwses ths ferousas me ton orthogwnio palmo kai
%ta apotelesmata ta ekxwrw sta dianusmata y1 kai y2.
    for t = 1:40
        y1(t,1) = gt*cos(2*pi*fc*t);
        y2(t,1) = gt*sin(2*pi*fc*t);
    end
%Susxetizw to shma pou elava me tis 2 sunistwses opote prokuptoun
%oi r1,r2.
    r1 = signal*y1;
    r2 = signal*y2;
%Vriskw to dianusma r einai h ektimhtheisa timh tou trexontos
%sumvolou panw ston asterismo tou 4-PSK.
    r = [r1,r2];
elseif type=='fsk'
%Gia to ka8e sumvolo (0 ews 3,) pollaplasiazw thn antistoixh sunistwsa
%ths ferousas me ton orthogwnio palmo kai to apotelesma to ekxwrw sto
%dianusma y.
    for m = 0:3
        for t = 1:40
            y(t,m+1) = gt*cos(2*pi*(fc + m/40)*t);
        end
    end
%Vriskw to dianusma r pou einai h ektimhtheisa timh tou trexontos
%sumvolou panw ston asterismo tou 4-FSK.
    r = signal*y;
end
end