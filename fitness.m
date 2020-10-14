
function ft=fitness(xn,nt,pd)

for i=1:nt
    x1=xn(i,1);x2=xn(i,2);
    ft(i)=(2*sqrt(2)*x1+x2)*100;
end