function [ output_args ] = vein( img1 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

img = im2double(imread('Test1.jpg')); % Read the image
img = imresize(img,0.5);               % Downscale image
fvr = l_region(img,2,20);    % Get finger region
% b = im2double(img);              %convert to double
% thresh_level = graythresh(b);  %find best threshold level
% c = b > thresh_level;          %do thresholding
% imshow(c)
sigma = 3; % Parameter
v_curvature = curvature(img,img1,sigma);
% figure,imshow(v_max_curvature);
% Binarise the vein image
md = median(v_curvature(v_curvature>0));
v_curvature_bin = v_curvature > md;
v_curvature_bin = imresize(v_curvature_bin,[250 250]);
figure,imshow(v_curvature_bin);
title('\fontsize{12} \bf Veins Extraction Image','FontName','Latha','color','k');
[B,L,N,A] = bwboundaries(v_curvature_bin);
figure,imshow(v_curvature_bin); hold on;
colors='r';
for k=1:length(B),
  boundary = B{k};
  cidx = mod(k,length(colors))+1;
  plot(boundary(:,2), boundary(:,1),...
       colors(cidx),'LineWidth',2);
  %randomize text position for better visibility
  rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
  col = boundary(rndRow,2); row = boundary(rndRow,1);
%   h = text(col+1, row-1, num2str(L(row,col)));
%   set(h,'Color',colors(cidx),'FontSize',14,'FontWeight','bold');
end
title('\fontsize{12} \bf Veins Extraction Image','FontName','Latha','color','k');
% [B,L,N] = bwboundaries(v_max_curvature_bin);
% figure,imshow(v_max_curvature_bin); hold on;
% for k=1:length(B),
%    boundary = B{k};
%    if(k > N)
%      plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
%    else
%      plot(boundary(:,2), boun dary(:,1), 'r','LineWidth',2);
%    end
% end
end

