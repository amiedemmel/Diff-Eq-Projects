%Problem 1 from Kincaid and Cheney Section 8.2
%Homework 2 for Math 6318 at UTD
%Amie Demmel
%Jan 29, 2015

%This script implements a taylor series solution to the IVP x'=x+exp(t)+tx 
%and x(1)=2
%Two approaches are calculated on in which the taylor series is centered 
%around the last step in the interation and a taylor series centered around 
%the initial value

%Initialize variables
a=1;
b=3;
h=input('Enter h value : ');
n=((b-a)/h)+1;
t1=[a:h:b];

y =zeros(1,n);
t=a;
y(1)=2;

%Taylor Series order 5 centered around the last step interation
for i=1:n-1
    f = (1+t)*y(i) + exp(t);
    f1 = (1+t)*f + exp(t) + y(i);
    f2 = (1+t)*f1 + 2*f + exp(t);
    f3 = (1+t)*f2 + 3*f2 + exp(t);
    f4 = (1+t)*f3 + 4*f3 + exp(t);
    
    y(i+1)= y(i) + h*f + h^2/2*f1 + h^3/6*f2 + h^4/24*f3 + h^5/120*f4;
    t=t+h;
end

%Re-initinalize variables t and y0 and calculate numerical values of %derivatives at inital value
t=1;
y0=2;
f = (1+t)*y0 + exp(t);
f1 = (1+t)*f + exp(t) + y0;
f2 = (1+t)*f1 + 2*f + exp(t);
f3 = (1+t)*f2 + 3*f2 + exp(t);
f4 = (1+t)*f3 + 4*f3 + exp(t);

%calculate taylor series order 5 centerd around inital value
x=y0 + f*(t1-1) + f1/2*(t1-1).^2 + f2/6*(t1-1).^3 + f3/24*(t1-1).^4 + f4/120*(t1-1).^5;

%vector of the difference of the two approaches
diff=x-y;