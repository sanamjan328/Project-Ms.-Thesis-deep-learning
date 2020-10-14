function dk = test_CNN(img)

load Test;
t_x = t_x(1:6000,:);
te_x =te_x(1:1000,:);
t_y = t_y(1:6000,:);
te_y = te_y(1:1000,:);
t_x = double(reshape(t_x',28,28,6000))/255;
te_x = double(reshape(te_x',28,28,1000))/255;
t_y = double(t_y');
te_y = double(te_y');
im = img;
rand('state',0)

cnn.layers = {
    struct('type', 'i') %input layer
    struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %sub sampling layer
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
    %struct('type', 'c', 'outputmaps', 18, 'kernelsize', 5) %convolution layer
    %struct('type', 's', 'scale', 2) %subsampling layer
    
};


opts.alpha = 1;
opts.batchsize = 50;
cnn = cnnsetup(cnn, t_x, t_y);
for i=1:5
    %tic ;
    opts.numepochs = i;
    cnn = cnntrain(cnn, t_x, t_y, opts);

    [er, bad,dk] = cnntest(cnn, te_x, te_y);
    disp('Allruntime=')      ;
    ccnn_Time  = toc ;        % Run Time          % Set QGA Time
    disp(['Accuracy Epoch ', num2str(i),' = ', mat2str(dk), '%  ,Time ', num2str(ccnn_Time)]);
end

%plot mean squared error
 figure; plot(cnn.rL);
assert(er<0.12, 'Too big error');
