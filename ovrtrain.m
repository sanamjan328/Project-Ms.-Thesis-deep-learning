function [model] = ovrtrain(y, x)

labelSet = unique(y);
labelSetSize = length(labelSet);
models = cell(labelSetSize,1);

for i=1:labelSetSize
    %Train the SVM Classifier
    %models{i} = fitcsvm(x,2*(y == labelSet(i))-1,'KernelFunction','rbf');
    models{i} = fitcsvm(x,2*(y == labelSet(i))-1,'KernelFunction','mysigmoid','Standardize',true);
end

model = struct('models', {models}, 'labelSet', labelSet);