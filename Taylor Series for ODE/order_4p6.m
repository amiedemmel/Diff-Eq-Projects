%Problem 6 from Kincaid and Cheney Section 8.2
%Homework 2 for Math 6318 at UTD
%Amie Demmel
%Jan 29, 2015

%This script implements a taylor series solution to the IVP x'=(t+x)/(t-x) 
%and x(1)=0 with a given implicit solution:
%arctan(x/t)=log((x^2+t^2)^(1/2)) which I will use to gauge the accuracy of 
%the method.
%The method is a 4th order taylor series expansion around the inital value
%Output is a table of values t in [0,2]

%Initialize variables
a=0;
b=2;
h=input('Enter h value : ');
t=a:h:b;
n=(b-a)/h + 1


%Taylor Series order 4
y = (t-1).*(1+(t-1)+(2/3)*(t-1).^2+(15/12)*(t-1).^3);


%Calculate the two sides of implicit solution using calculated y values and 
%define the error as the difference between the two sides; error is not 
%calculated at t=0 since arctan is undefined at this point

a = atan(y(2:n)./t(2:n));
l = log((y(2:n).^2+t(2:n).^2).^(.5));
error =(a-l);    


%table of t, y and error in implicit solution; output to screen
p = [t; y; 0 error];
p'