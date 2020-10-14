function [ output_args ] = gra( a,b,c )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
x = a*100;
y = b*100;
z = c*100;
z = [x; y; z];
figure;
hold on
for i = 1:length(z)
    z1=bar(i,z(i));
    if i == 1 
         set(z1,'FaceColor','r');
    elseif i == 2
         set(z1,'FaceColor','g');
    else
        set(z1,'FaceColor','b');
    end
end
hold off
legend('PCA + Euclidian Distance','PCA + SVM','CNN');
grid
ylabel('Comparison of Accuracy(%)');
set(gca,'XTickLabel',{'',''})
title('Performance Graphs','Fontsize',16,'FontName','Latha','color','k');
end

