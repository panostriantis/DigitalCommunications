%% script gia th phgh B kai kalyptei ta erwthmata 2a - 2b

close all; clear all; clc

% arxikopoihsh pinakwn gia thn apo8hkeush apotelesmatwn
sqnr_omoiomorfou_peir = zeros(3,1); 
Lloyd_sqnr_peir = zeros(3,5);
apodosh_om = zeros(3,1);
apodosh_anom = zeros(3,1);
apd_ws_pros_arxiko = zeros(3,1);
apd_ws_pros_arxiko_Lloyd = zeros(3,1);
% xrhsimopoioume thn audioread epeidh etsi epideiknyei h matlab
[x,fs] = audioread('speech.wav');
% dianysma pou periexei ta diafora N (bits) pou 8eloume na kanoyme th
% kwdikopoihsh ths phghs
K = [2 4 6];
for i = 1:length(K)
    N = K(i);
    [xq,centers] = my_quantizer(x,N,-1,1);
    sqnr_omoiomorfou_peir(i,1) = sqnr_peiramatiko(x,xq,centers);
    kmax = 5:5:25;
    for j = 1:length(kmax)
        [Lloyd_xq,Lloyd_centers,D] = Lloyd_Max(x,N,-1,1,kmax(j));
        Lloyd_sqnr_peir(i,j) = sqnr_peiramatiko(x,Lloyd_xq,Lloyd_centers);
    end
    display(N)
    sxq = 10*log10(var(x-centers(xq))/var(x))
    apd_ws_pros_arxiko(i) = sxq;
    ll_sxq = 10*log10(var(x-Lloyd_centers(Lloyd_xq))/var(x))
    apd_ws_pros_arxiko_Lloyd(i) = ll_sxq;
end
figure(1)
plot(kmax,Lloyd_sqnr_peir(1,:),'r-*')
hold on
plot(kmax,Lloyd_sqnr_peir(2,:),'b-o')
hold on
plot(kmax,Lloyd_sqnr_peir(3,:),'k-x')
hold off
legend('N=2','N=4','N=6')
title('Metabolh SQNR')
xlabel('plh8os epanalhpsewn')
ylabel('SQNR(dB)')

figure(2)
N = 2:2:6;
plot(N,Lloyd_sqnr_peir(:,5),'r-*')
hold on
plot(N,sqnr_omoiomorfou_peir(:,:),'b-o')
hold off
legend('Lloyd','omoiomorfos')
title('Diafores SQNR')
xlabel('N(bits)')
ylabel('SQNR(dB)')