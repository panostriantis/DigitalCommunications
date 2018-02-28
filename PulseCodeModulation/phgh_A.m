%% script pou dhmioyrgei thn phgh A, xrhsimopoiwntas ton omoiomorfo kbantisth
% kwdikopoiei thn phgh kai ypologizei to SQNR kai oti zhteitai sto 1a kai
% 1b erwthma

close all; clear all; clc
M = 1e4;

t = (randn(M,1)+sqrt(-1)*randn(M,1))/sqrt(2);
x= abs(t) .^ 2;
% arxikopoihsh pinakwn gia thn apo8hkeush apotelesmatwn
sqnr_peir = zeros(2,1);
sqnr_thewr = zeros(2,1);
D = zeros(2,1);
% dianysma pou periexei ta diafora N (bits) pou 8eloume na kanoyme th
% kwdikopoihsh ths phghs
K = [4 6];
for i = 1:length(K)
    N = K(i);
    display(N)
    [xq,centers] = my_quantizer( x,N,0,4 );
    [sqnr_peir(i)] = sqnr_peiramatiko( x,xq,centers );
    display(sqnr_peir)
    [sqnr_thewr(i)] = sqnr_thewrhtiko( N,centers,0,4 );
    display(sqnr_thewr)
    D(i) = mean(x-centers(xq)).^2;
    display(D)
    figure(i)
    subplot(2,1,1)
    plot(x)
    subplot(2,1,2)
    plot(centers(xq))
end
% arxikopoiw enan counter o opoios metraei poia stoixeia einai ektos apo ta
% oria 0 kai 4 pou exoume (min_value - max_value)
counter = 0;
for y = 1:length(x)
    if x(y)<0 || x(y)>4
        counter = counter + 1;
    end
end
% edw ypologizetai h peiramatikh pi8anothta yperfortwshs me xrhsh tou counter
pi8anothta_yperfortwshs_peir = counter/length(x)