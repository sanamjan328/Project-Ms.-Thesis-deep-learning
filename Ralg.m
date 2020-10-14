function [ output_args ] = Ralg( input_args )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
img = im2double(imread('Test1.jpg')); % Read the image
img = imresize(img,0.5);               % Downscale image
fvr = l_region(img,2,20);    % Get finger region
b = im2double(img);              %convert to double
thresh_level = graythresh(b);  %find best threshold level
c = b > thresh_level;          %do thresholding
sigma = 3; % Parameter
v_max_curvature = curvature(img,c,sigma);
% Binarise the vein image
md = median(v_max_curvature(v_max_curvature>0));
v_max_curvature_bin = v_max_curvature > md;
v_max_curvature_bin = imresize(v_max_curvature_bin,[250 250]);
I = v_max_curvature_bin;
ntr=200; % number of runs
m = zeros(size(I,1),size(I,2));          %-- create initial mask
m(111:222,123:234) = 1;
I = imresize(I,.5);  %-- make image smaller 
m = imresize(m,.5);  %     for fast computation
cd cnn
load('Test.mat')
t_x = train_x;
t_y = train_y;
te_x = test_x;
te_y = test_y;
cd ..
save('Test','t_x','t_y','te_x','te_y')
for tr=ntr
    ton=cputime;
    pd=2; % problem dimension
    nt=50; % flock size
    AP=0.1;%awareness probability
    [x l u]=init(nt,pd); % initialization function
    xn=x;
    ft=fitness(xn,nt,pd); % fitness function evaluation
    mem=x;
    fit_mem=ft;
    tmax=500; % maximum number of iterations
    for t=1:tmax

        num=ceil(nt*rand(1,nt));
        for i=1:nt
            if rand>AP
                xnew(i,:)= x(i,:)+2*rand*(mem(num(i),:)-x(i,:));
            else
                for j=1:pd
                    xnew(i,j)=[u(j)-(u(j)-l(j))*rand];
                end
            end
        end
        xn=xnew;
        ft=fitness(xn,nt,pd); 
        % update position
        for i=1:nt
            x1=xnew(i,1);x2=xnew(i,2);
            if 2*(sqrt(2)*x1+x2)/(sqrt(2)*x1^2+2*x1*x2)-2<=0 & 2*x2/(sqrt(2)*x1^2+2*x1*x2)-2<=0 & 2/(sqrt(2)*x2+x1)-2<=0 & x1>=0 & x1<=1 & x2>=0 & x2<=1

                x(i,:)=xnew(i,:);
                if ft(i)<fit_mem(i)
                    mem(i,:)=xnew(i,:);
                    fit_mem(i)=ft(i);
                end
            end
        end
        ffit(t)=min(fit_mem);
        min(fit_mem);
    end
    F(tr,:)=ffit;
    fitn(tr)= min(fit_mem)
    ngbest=find(fit_mem== min(fit_mem));
    g_best(tr,:)=mem(ngbest(1),:);
    toff(tr)=cputime-ton;
end

end

