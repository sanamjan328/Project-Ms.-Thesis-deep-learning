
imageDim = 256;      % image dimension  
filterDim = 8;   % filter features diminition       
numFilters = 50; % number of feature maps       

numImages = 6000;    % number of images

poolDim = 3;          

addpath(genpath('../../Train'));
images = '../../Dataset';
%images = reshape(images,imageDim,imageDim,1,numImages);
 images = double(images) / 255;
W = randn(filterDim,filterDim,1,numFilters);
b = rand(numFilters);




convImages = images(:, :, 1); 

% NOTE: Implement cnnConvolve in cnnConvolve.m first!
convolvedFeatures = cnnConvolve(convImages, W, b);



for i = 2   
    filterNum = randi([1, numFilters]);
    imageNum = randi([1, 8]);
    imageRow = randi([1, imageDim - filterDim + 1]);
    imageCol = randi([1, imageDim - filterDim + 1]);    
   
   

    feature = sum(sum(W(:,:,1,filterNum)))+b(filterNum);
%     feature = 1./(1+exp(-feature));
    
     if  abs(feature) > 1e-9
       
        fprintf('Filter Number    : %d\n', filterNum);
        fprintf('Image Number      : %d\n', imageNum);
        fprintf('Image Row         : %d\n', imageRow);
        fprintf('Image Column      : %d\n', imageCol);
        fprintf('num batches       : %d\n', numbatches);
        fprintf('Test feature : %0.5f\n', feature);       

     end 
end


pooledFeatures = cnnPool([poolDim poolDim], convolvedFeatures, 'maxpool');


testMatrix = reshape(1:64, 8, 8);
expectedMatrix = [mean(mean(testMatrix(1:4, 1:4))) mean(mean(testMatrix(1:4, 5:8))); ...
                  mean(mean(testMatrix(5:8, 1:4))) mean(mean(testMatrix(5:8, 5:8))); ];
            
testMatrix = reshape(testMatrix, 8, 8, 1, 1);
        
pooledFeatures = squeeze(cnnPool([4 4], testMatrix, 'maxpool'));
    fprintf('pooledFeatures feature : %0.5f\n', pooledFeatures);       


if ~isequal(pooledFeatures, expectedMatrix)
    disp('Pooling incorrect');
    disp('Expected');
    disp(expectedMatrix);
    disp('Got');
    disp(pooledFeatures);
else
  
end
