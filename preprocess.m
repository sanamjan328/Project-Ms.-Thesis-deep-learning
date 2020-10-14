function [ output_args ] = preprocess( img  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%
I = img;
FDetect = vision.CascadeObjectDetector;

%Read the input image
% I = imread('FacialImages/11.jpg');

%Returns Bounding Box values based on number of objects
BB = [117.5 61.5 101 121];
figure,imshow(I, 'border', 'tight');
hold on
rectange = rectangle('Position', BB);
hold off

% for i = 1:size(BB,1)
%     rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
% end


crob=imcrop(I,BB);
figure;imshow(crob),title('Crob Image');
imwrite(crob,'Process_Image\Crop.jpg','jpg');
B = imrotate(crob,90); %angle 90 degree
figure;imshow(B),title('Rotate Image');
imwrite(B,'Process_Image\Rotate.jpg','jpg');
resize=imresize(crob,[250 250]); %% resized  250 X 250
figure;imshow(resize),title('Resize Image');
imwrite(resize,'Process_Image\Resize.jpg','jpg');
imwrite(resize,'Test1.jpg','jpg');
end

