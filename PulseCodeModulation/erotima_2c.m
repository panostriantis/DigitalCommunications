%% ypologismos entropias kai pi9anothtas emfanishs ka8e epipedou kbantishs
% input x,xq,centers
% x : arxiko shma, xq : kbantismeno shma, centers : ypologismena kentra
% output level_entropy,level_prob,entropy
% level_entropy : entropia ka8e epipedou kbantishs
% level_prob : pithanothta emfanishs ka8e epipedou
% entropy : h synolikh entropia
function [level_entropy,level_prob,entropy] = erotima_2c(x,xq,centers)


y = unique(centers(xq));
count = zeros(length(y),1);
for i = 2:length(y)
    counter = 0;
    for j = 1:length(x)
        if y(i-1,1)<=x(j) && x(j)<=y(i,1)
            counter = counter + 1;
        end
        count(i-1) = counter;
        if i == length(y)
            count(i) = counter;
        end
    end
end

level_prob = count./sum(count);
entropy = 0;
for i = 1:length(level_prob)
    if level_prob(i)~=0
    entropy = entropy + (-level_prob(i)*log2(level_prob(i)));
    end
end
level_entropy = zeros(length(y),1);
for i = 1:length(level_prob)
    if level_prob(i)~=0
    level_entropy(i) = -level_prob(i)*log2(level_prob(i));
    end
end
end