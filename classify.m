function cw1 = classify(img1)
img = im2double(imread('Test1.jpg')); % Read the image
img = imresize(img,0.5);               % Downscale image
fvr = l_region(img,2,20);    % Get finger region
b = im2double(img);              %convert to double
thresh_level = graythresh(b);  %find best threshold level
c = b > thresh_level;          %do thresholding
% imshow(c)
%%
% *BOLD TEXT*
sigma = 3; % Parameter
v_curvature = curvature(img,c,sigma);

% Binarise the vein image
md = median(v_curvature(v_curvature>0));
v_curvature_bin = v_curvature > md; 

%% Extract veins using repeated line tracking method
max_iterations = 3000; r=1; W=17; % Parameters
v_repeated_line = miura_repeated_line_tracking(img,c,max_iterations,r,W);

% Binarise the vein image
md = median(v_repeated_line(v_repeated_line>0));
v_repeated_line_bin = v_repeated_line > md; 

%% Match
cw = 80; ch=30;
cw1 = img1;
score = miura_match(double(v_repeated_line_bin), double(v_curvature_bin), cw, ch);


%% Visualise

overlay_max_curvature = zeros([size(img) 3]);
overlay_max_curvature(:,:,1) = img+ 0.4*v_curvature_bin;
overlay_max_curvature(:,:,2) = img;
overlay_max_curvature(:,:,3) = img;


overlay_repeated_line = zeros([size(img) 3]);
overlay_repeated_line(:,:,1) = img + 0.4*v_repeated_line_bin;
overlay_repeated_line(:,:,2) = img;
overlay_repeated_line(:,:,3) = img;

v_curvature_bin = imresize(v_curvature_bin,[250 250]);
figure,imshow(v_curvature_bin);
title('\fontsize{12} \bf Binarised veins extracted Image','FontName','Latha','color','k');
disp('Accuracy');
disp(cw1);
overlay_max_curvature = imresize(overlay_max_curvature,[250 250]);
figure,imshow(overlay_max_curvature);
title('\fontsize{12} \bf veins Image','FontName','Latha','color','k');
 %v_repeated_line_bin = imresize(v_repeated_line_bin,[250 250]);
 %figure,imshow(v_repeated_line_bin);
 %overlay_repeated_line = imresize(overlay_repeated_line,[250 250]);
 %figure,imshow(overlay_repeated_line);
 %title('\fontsize{12} \bf Segmented Image','FontName','Latha','color','k');