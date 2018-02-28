%% mapper function
% symb : symbola poy ana8etei o mapper sthn akoloy8ia mas pou eisagoyme
% mhkos : mhkos ths akoloy8ias
% bin : dyadikh akoloy8ia
% type : kwdikopoihsh gia PSK or FSK (gia psk xrhsimopoioyme Gray enw gia
% fsk ginetai kanonika h antitoixish
function [symb,mhkos] = mapper(bin,type)

mhkos = length(bin);
rem = mod(mhkos,2);
new_len = (mhkos-rem)/2;
if rem == 0  % An o arxikos ari8mos einai zugos,
    x_new = reshape(bin,2,new_len); % anasxhmatizw to dianusma x se 2 grammes
    %kai new_len sthles.
else % An einai monos anasxhmatizw pali to dianusma x ektos apo to teleutaio stoixeio tou.
    x_new = reshape(bin(1:mhkos-1,1),2,new_len);
end
% Antistoixish ka8e dyadas bits se sumvola.
for i = 1:new_len
    if x_new(1,i)==0 && x_new(2,i)==0
        symb(i) = 0;
    elseif x_new(1,i)==0 && x_new(2,i)==1
        symb(i) = 1;
    elseif x_new(1,i)==1 && x_new(2,i)==0
        if type=='psk'
                symb(i) = 3; % gray
        elseif type=='fsk'
                symb(i) = 2;
        end
    elseif x_new(1,i)==1 && x_new(2,i)==1
        if type=='psk'
            symb(i) = 2; % gray
    elseif type=='fsk'
            symb(i) = 3;
        end
    end
end
% mia akolou8ia pou exei mono ari8mo bit sto teleutaio p einai mono toy
% ana8etoume mia tyxaia timh dyadas
if rem==1
symb(new_len+1)=randsrc(1,1,[0 3]);
end
end