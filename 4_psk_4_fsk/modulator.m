%% modulator function
% signal : to en8oryvo shma
% s_m : to shma prin prote8ei o 8oryvos
% symb : h e3odos symbolwn meta ton mapper
% SNR
% Es : energeia / symbol
% Eb : energeia / bit
% T_symb : T symbol
% fc : f ferousas
% type : PSK or FSK

function [signal,s_m] = modulator(symb,SNR,Es,Eb,T_symb,fc,type)


length_symb = length(symb);%To mhkos ths akolou8ias sumvolwn.
g_t = sqrt(2*Es/T_symb);%Orthogwnios palmos.
s_m = zeros(length_symb,40); %Arxikopoiw me mhden to shma pou prokeitai na steilw.
s = zeros(4,2);%Arxikopoiw to dianusma pou periexei tis 2 sunistwses,
%gia ka8e sumvolo.
if type=='psk'
%Ka8e sumvolo ths diamorfwshs 4-PSK orizetai apo 2 sunistwses, tis opoies
%vriskw ws ekshs:
    for m = 1:4
        s(m,1) = cos((2*pi*(m-1))/4);
        s(m,2) = sin((2*pi*(m-1))/4);
    end
%Gia na upologisw to zwnoperato shma
    for i = 1:length_symb
        for t = 1:40 %1 ews T_symb
            k_n = symb(i)+1;%Gia na paroume tis swstes sunistwses s
            %pros8etoume to 1 se ka8e sumvolo
            s_m(i,t) = s(k_n,1)*g_t*cos(2*pi*fc*t) + s(k_n,2)*g_t*sin(2*pi*fc*t);
        end
    end
elseif type=='fsk'
    for i = 1:length_symb
        for t = 1:40 %1 ews T_symb
            s_m(i,t) = g_t*cos(2*pi*(fc + symb(i)/40)*t);
        end
    end
end
No = Eb/(10^(SNR/10));
noise = sqrt(No/2)*randn(length_symb,40); %Ypologismos tou AWGN 8oruvou me vash
%to SNR pou eisagoume kai kanonikopoihsh gia na ginei h pros8esh me to shma
%mas
signal = s_m + noise; % en8oruvo shma
end