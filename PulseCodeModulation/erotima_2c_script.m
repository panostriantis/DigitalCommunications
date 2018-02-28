%% script poy apantaei sto erotima 2c
% ypologizetai h pi8anothta emfanishs ka8e epipedou kai apo8hkeuetai se
% cell, akomh ypologizetai h entropia ka8e epipedou kbantishs kai
% apo8hkeutai se cell kai ypologizw kai thn entropia gia N = 2:2:6 gia ka8e
% kbantismeno shma dhladh kai apo to shma pou bgazei san e3odo o
% omoiomorfos kbantisths kai o anomoiomorfos
close all; clear all; clc

sqnr_omoiomorfou_peir = zeros(3,1);
Lloyd_sqnr_peir = zeros(3,5);
[x,fs] = audioread('speech.wav');
level_entropy_omoio = cell([3,1]);
level_prob_omoio = cell([3,1]);
level_entropy_anomoio = cell([3,1]);
level_prob_anomoio = cell([3,1]);
entropy_omoio = zeros(3,1);
entropy_anomoio = zeros(3,1);
K = [2 4 6];
for i = 1:length(K)
    N = K(i);
    [xq,centers] = my_quantizer(x,N,-1,1);
    sqnr_omoiomorfou_peir(i,1) = sqnr_peiramatiko(x,xq,centers);
    [level_entropy_om,level_prob_om,entropy_om] = erotima_2c(x,xq,centers);
    level_entropy_omoio{i,1} = level_entropy_om;
    level_prob_omoio{i,1} = level_prob_om;
    entropy_omoio(i,1) = entropy_om;
    kmax = 5:5:25;
    for j = 1:length(kmax)
        [Lloyd_xq,Lloyd_centers,D] = Lloyd_Max(x,N,-1,1,kmax(j));
        Lloyd_sqnr_peir(i,j) = sqnr_peiramatiko(x,Lloyd_xq,Lloyd_centers);
        [level_entropy_anom,level_prob_anom,entropy_anom] = erotima_2c(x,Lloyd_xq,Lloyd_centers);
        level_entropy_anomoio{i,1} = level_entropy_anom;
        level_prob_anomoio{i,1}= level_prob_anom;
        entropy_anomoio(i,1) = entropy_anom;
    end
    mse_omoiom= sum((centers(xq)-x).^2)/length(x)
    mse_Lloyd= sum((Lloyd_centers(Lloyd_xq)-x).^2)/length(x)
end

for i = 1:3
    figure(i)
    plot(level_prob_omoio{i,1},'b-*')
    hold on
    plot(level_prob_anomoio{i,1},'r->')
    hold off
    title('pi8anothtes emfanishs')
    legend('omoiomorfos','Lloyd')
end