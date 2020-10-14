function [outputImage] = BBHE (img)
tic;
img = imread(img);

sz = size(img);

o_mean = round(mean(img(:)));

%  HISTOGRAM

h_l = zeros(256,1);

h_u = zeros(256,1);

for i = 1:sz(1)
    for j = 1:sz(2)
        
        g_val = img(i,j);
        
        if(g_val<=o_mean)
           h_l(g_val+1) = h_l(g_val+1) + 1;
        else
            h_u(g_val+1) = h_u(g_val+1)+ 1;
        end
        
    end
end

% NORMALIZED HISTOGRAM OR PDF

nh_l = h_l/sum(h_l);
nh_u = h_u/sum(h_u);

% CDF

hist_l_cdf = double(zeros(256,1));
hist_u_cdf = double(zeros(256,1));

hist_l_cdf(1) = nh_l(1);
hist_u_cdf(1) = nh_u(1);

for k = 2:256
    hist_l_cdf(k) =  hist_l_cdf(k-1) + nh_l(k);
    hist_u_cdf(k) =  hist_u_cdf(k-1) + nh_u(k);
end

% IMAGE MODIFICATION

equalized_img = zeros(sz);

range_l = [0 o_mean];
range_u = [(o_mean+1) 255];

for i =1:sz(1)
    for j =1:sz(2)
        g_val = img(i,j);
        
        if(g_val<=o_mean)
           equalized_img(i,j) = range_l(1) + round(((range_l(2)-range_l(1))*hist_l_cdf(g_val+1))); 
        else
           equalized_img(i,j) = range_u(1) + round(((range_u(2)-range_u(1))*hist_u_cdf(g_val+1))); 
        end
        
    end
end

outputImage=(uint8(equalized_img));

toc;