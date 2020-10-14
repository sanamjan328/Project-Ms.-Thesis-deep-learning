function [ac, decv] = ovrpredict(y, x, model)

labelSet = model.labelSet;
labelSetSize = length(labelSet);
models = model.models;
%decv= zeros(size(y, 1), labelSetSize);

%for i=1:labelSetSize
%  scores1 = predict(models{i},x); % The scores
%  decv(:, i) = scores1 .* (y == labelSet(i));
  %decv(:, i) = scores1;
%end
%[tmp,pred] = max(decv, [], 2);
%pred = labelSet(pred);
%ac = sum(y==pred) / size(x, 1);
%ac = sum(sum(decv > 0)) / labelSetSize;
decv = [];
for i=1:labelSetSize
  CVSVMModel1 = crossval(models{i});
  decv(i) = kfoldLoss(CVSVMModel1);
end

ac = 1 - mean(decv);