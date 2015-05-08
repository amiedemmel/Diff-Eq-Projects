%phi.m
%
%This is where you define the phi, or basis functions for the FEM
%We are using a piecewise linear finite element phi
function [phi]=phi(i,c)
global x h;
%ith basis function, will return scalar or vector values
n=size(c);
phi=zeros(1,n(2));
for k=1:n(2)
    if (c(k)>=x(i))&&(c(k)<x(i+1))
        phi(k)=(c(k)-x(i))/h;
    end
    if (c(k)>=x(i+1))&&(c(k)<x(i+2))
        phi(k)=(x(i+2)-c(k))/h;
    end
end