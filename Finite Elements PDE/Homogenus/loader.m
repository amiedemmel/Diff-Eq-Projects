%loader.m
%
%This function calculates the stiffness and load vector needed for this
%problem using piecewise linear finite elements
function [K,f]=loader(n)
global x h;
%Load Vector, f
f=zeros(n,1);
for i=1:n
    f(i)=((x(i+1))^4)/2-((x(i+2)+x(i))*x(i+1)^3)/3+((x(i))^4+(x(i+2))^4)/12;
    f(i)=f(i)/h;
end
%Stiffness Matrix, K
g=zeros(1,n);
g(1)=2/h;
g(2)=-1/h;
K=toeplitz(g);