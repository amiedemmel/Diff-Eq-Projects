%Problem 3 from Kincaid and Cheney Section 8.2
%Homework 2 for Math 6318 at UTD
%Amie Demmel
%Jan 29, 2015

%This script implements a taylor series solution to the IVP x'=exp(-t^2) 
%and x(0)=0 with a given "true value" x(2)=0.8820813907
%Two approaches are calculated on in which the taylor series is centered 
%around the last step in the interation and a taylor series centered around 
%the initial value

%Initialize variables
format long;
a=0;
b=2;
tableval=0.8820813907;
h=input('enter h value : ');

t1=[a:h:b];
n=(b-a)/h + 1;
y=zeros(1,n);
t=0;

%Taylor Series centered around last step taken

for i=1:n-1
    f= exp(-t^2);
    f1=-2*t*f;
    f2=(-2+4*t^2)*f;
    f3=(12*t-8*t^3)*f;
   y(i+1) = y(i) + h*f + h^2*f1/2 + h^3*f2/6 + h^4*f3/24;
   t=t+h;
end

%%Calculation of error based off the given x(2) value, output both to %%screen
y(n)
error=norm(tableval-y(n))

%Taylor series centered around initial value for the first four non-zero %terms and the calculation of error

x=t1-(t1.^3)./3 + (t1.^5)./10 - (t1.^7)./120;
x(n)
errorx=norm(tableval-x(n))