%% function demmaper
% received : shma pou lhf8hke
% symb_teliko : ta symbola pou apofasise o fwraths
% mhkos : mhkos ths arxikhs akolou8ias bits
% type : PSK || FSK (gia ton psk xrhsimopoioume edw apokwdikopoioume me
% bash to kwdika gray enw gia fsk apokwdikopoioume kanonika

function [received] = demapper(symb_teliko,mhkos,type)

len = length(symb_teliko);  %To megethos twn sumvolwn.
rem = mod(mhkos,2); %Vriskw an einai zugos h' monos ari8mos h arxikh akolou8ia.
x_tel = zeros(2,len-rem);   %Arxikopoihsh toy dianusmatos
for i=1:len
    if symb_teliko(i)==0
        x_tel(1,i)=0; x_tel(2,i)=0;
    elseif symb_teliko(i)==1
        x_tel(1,i)=0; x_tel(2,i)=1;
    elseif symb_teliko(i)==2
        if type=='psk'
            x_tel(1,i)=1; x_tel(2,i)=1; %gray
        elseif type=='fsk'
            x_tel(1,i)=1; x_tel(2,i)=0;
        end
    else
        if type=='psk'
            x_tel(1,i)=1; x_tel(2,i)=0; %gray
        elseif type=='fsk'
            x_tel(1,i)=1; x_tel(2,i)=1;
        end
    end
end
%Anasxhmatizw pali to dianusma x_tel se 2*len grammes kai 1 sthlh,gia na
%dhmiourghsw to received
received = reshape(x_tel,2*len,1);
if rem==1
    received(2*len+1) = randsrc(1,1,[0 1]);
    received=received(1:2*len+1);
end
end