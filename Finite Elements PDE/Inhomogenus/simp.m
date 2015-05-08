%Simpson's Rule
function [S]=simp(a,b,test)
n=(b-a)/6;
f1=f(a,a,b,test);
f2=f((a+b)/2,a,b,test);
f3=f(b,a,b,test);
S=n*(f1+4*f2+f3);
end

function [f]=f(x,a,b,test)
global h;
%Kij : (1+x)dg/dx*dv/dx+g*v
if test==1
    f=-1*(1+x)*(1/h)^2-(1/h)^2*(x-b)*(x-a);
end
%Kii two parts for the two halves
if test==2
    f=(1+x)*(1/h)^2+(1/h)^2*(x-a)^2;
end
if test==3
    f=(1+x)*(1/h)^2+(1/h)^2*(x-b)^2;
end
%load intergral functions : (1+x)*dv/dx+(x-1)v
if test==4
    f=(1+x)*(1/h) + (x-1)*(x-a)/h;
end
if test==5
    f=(1+x)*(-1/h) + (x-1)*(b-x)/h;
end
%f=sin(x);
end