function [ output_args ] = VienFeatureExtraction( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%I = imread('Test1.jpg')
img = im2double(I); % Read the image
img = imresize(img,0.5);               % Downscale image


fvr = l_region(img,4,40);    % Get finger region


sigma = 3; % Parameter
v_max_curvature = curvature(img,fvr,sigma);

% Binarise the vein image
md = median(v_max_curvature(v_max_curvature>0));
v_max_curvature_bin = v_max_curvature > md; 

%% Extract veins 
max_iterations = 3000; r=1; W=17; % Parameters
v_repeated_line = miura_repeated_line_tracking(img,fvr,max_iterations,r,W);

% Binarise the vein image
md = median(v_repeated_line(v_repeated_line>0));
v_repeated_line_bin = v_repeated_line > md; 

%% Match
cw = 80; ch=30;
% Note that the match score is between 0 and 0.5
score = miura_match(double(v_repeated_line_bin), double(v_max_curvature_bin), cw, ch);
fprintf('Match score: %6.4f %%\n', score);

%% Visualise
% Overlay the extracted veins on the original image
overlay_max_curvature = zeros([size(img) 3]);
overlay_max_curvature(:,:,1) = img;
overlay_max_curvature(:,:,2) = img + 0.4*v_max_curvature_bin;
overlay_max_curvature(:,:,3) = img;

% Overlay the extracted veins on the original image
overlay_repeated_line = zeros([size(img) 3]);
overlay_repeated_line(:,:,1) = img;
overlay_repeated_line(:,:,2) = img + 0.4*v_repeated_line_bin;
overlay_repeated_line(:,:,3) = img;

figure;
subplot(3,2,1)
  imshow(img,[])
  title('Original captured image')
  subplot(3,2,2)
  imshow(fvr)
  title('Detected finger region') 
subplot(3,2,3)
  imshow(v_repeated_line_bin)
  title('Thining')
  subplot(3,2,4)
  imshow(overlay_repeated_line)
  title('ROI Feature Extraction')

end

