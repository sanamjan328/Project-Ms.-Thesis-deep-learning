
function [x l u]=init(nt,pd)


l=[0 0];%lower bound of parameters
u=[1 1];%upper bound of parameters

c=0;
while c~=nt

    for j=1:pd
        xc(j)=[u(j)-(u(j)-l(j))*rand];
    end

    x1=xc(1);
    x2=xc(2);

    if 2*(sqrt(2)*x1+x2)/(sqrt(2)*x1^2+2*x1*x2)-2<=0 & 2*x2/(sqrt(2)*x1^2+2*x1*x2)-2<=0 & 2/(sqrt(2)*x2+x1)-2<=0 & x1>=0 & x1<=1 & x2>=0 & x2<=1
        c=c+1;
        x(c,:)=xc;
    end
end




