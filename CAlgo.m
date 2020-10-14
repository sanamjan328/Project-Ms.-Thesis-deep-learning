function [ output_args ] = CAlgo( img )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% Test;
I = imread('Test1.jpg');
ntr=350; % number of runs
m = zeros(size(I,1),size(I,2));          %-- create initial mask
m(111:222,123:234) = 1;
I = imresize(I,.5);  %-- make image smaller 
m = imresize(m,.5);  %     for fast computation

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
% ng=find(fitn==min(fitn));
% gbest=g_best(ng(1),:)
% Best=min(fitn)% return best performance
% Wrst=max(fitn);% return worst performance
% Mean=mean(fitn); % return mean
% Std=std(fitn,1); % return std

seg = region_seg(I, m, ntr);
%subplot(2,2,3); imshow(seg);
%title('Region Of Interest');
vein(seg);
end

