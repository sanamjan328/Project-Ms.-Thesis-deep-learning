x = imread('peppers.png') ;
% Convert to single format
x = im2single(x) ;

% Visualize the input x
figure(1) ; clf ; imshow(x);
% Create a bank of linear filters
w = randn(5,5,3,10,'single') ;
% Apply the convolution operator
y = vl_nnconv(x, w, []) ;
% Visualize the output y
figure(2) ; clf ; vl_imarraysc(y) ; colormap gray ;