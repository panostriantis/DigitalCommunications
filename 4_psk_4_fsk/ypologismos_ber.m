%% function ypologismos_ber : ypologizei to BER
% BER : to bit error rate pou zhtame
% x : h arxikh akolou8ia
% received : h lhf8eisa akolou8ia
% SNR : to SNR
% type : theoritical(gia ypologismo toy 8ewrhtikou BER gia to PSK)...
% experimental(gia ypologismo tou BER peiramatika, dhladh posa la8os bit
% lhf8hkan)
function [BER] = ypologismos_ber(x,mhkos,received,SNR,type)

arxikopoihsh
No = Eb/(10^(SNR/10));
EbNo = Eb/No;
if strcmp(type,'theoritical')==1
    BER = (1/2)*erfc(sqrt(EbNo));%Ypologizw theorhtika to BER
elseif strcmp(type,'experimental')==1
    error_bit_counter = 0;%bazoyme ena counter gia na metrhsoyme me sugkrish ta la8os mpit
    for i=1:mhkos
        if x(i)~=received(i)%sygkrish stal8entos kai lhf8entos akolou8ias
            error_bit_counter = error_bit_counter+1;
        end
    end
    BER = error_bit_counter/mhkos; %Ypologizw peiramatika to BER (la8os bits)
end
end