function [er, bad,ds] = cnntest(net, x, y)
    %  feedforward
    [net,b] = cnnff(net, x);
    [~, h] = max(net.o);
    [~, a] = max(y);
    bad = find(h ~= a);
    er = numel(bad) / size(y, 2);
    ds = classify(b);
end
