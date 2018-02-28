%% function fwrath
% symb_teliko : ta symbola pou apofasizei o fwraths oti exei stalei
% r : to dianysma pou einai e3odos tou demodulator
% type : PSK || FSK

function [symb_teliko] = fwraths(r,type)

len = length(r);
if type=='psk'
    for m = 1:4
        s(m,1) = cos((2*pi*(m-1))/4);
        s(m,2) = sin((2*pi*(m-1))/4);
    end
%Ypologizw thn apostash tou s apo to r. Auto (to dianusma) me thn mikroterh
%apostash apo to r, antistoixei sto sumvolo pou stal8hke
    for i = 1:len
        min = 1.0e3; %Thetw enan polu megalo arithmo ws min
        position = 1; %Apo8hkeuei th thesh tou distance pou vre8hke h mikroterh
%apostash k to arxikopoiw me 1
    for m = 1: 4
        distance(m, 1) = norm([r(i,1), r(i,2)] - s(m,:));
        if distance(m,1) < min
            min = distance(m,1);
            position = m-1; %Vazw m-1 giati ta sumvola pou exw einai apo 0
%ews 3, enw oi 8eseis tou dianusmatos apo 1 ews 4
        end
    end
%H thesh tou distance pou periexei th mikroterh apostash, antiprosopeuei
%kai to sumvolo pou stal8hke
        symb_teliko(i,1) = position;
    end
elseif type=='fsk'
    for i = 1:len
        max = -1.0e3; %Thetw enan polu mikro arithmo ws max
        position = 1; %Apo8hkeuei th thesh tou r, pou vre8hke h megaluterh timh
%k to arxikopoiw me 1
        for j = 1:4
            if r(i,j) > max
                max = r(i,j);
                position = j-1;
            end
        end
        symb_teliko(i,1) = position;
    end
end
end