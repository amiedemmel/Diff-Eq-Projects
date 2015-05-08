%Problem 6 from Kincaid and Cheney Section 8.2
%Homework 2 for Math 6318 at UTD
%Amie Demmel
%Jan 29, 2015

%This script implements a taylor series solution to the IVP x'=(t+x)/(t-x) 
%and x(1)=0 with a given implicit solution:
%arctan(x/t)=log((x^2+t^2)^(1/2)) which I will use to gauge the accuracy of 
%the method.
%The method is a 4th order taylor series expansion around the inital value
%and 4th order taylor series expansion around the last calculated term
%Output is a table of values t in [0,2]

%Initialize variables
a=0;
b=2;
h=input('Enter h value : ');
t=a:h:b;
n=(b-a)/h + 1


%Taylor Series order 4 - centered round inital value
y = (t-1).*(1+(t-1)+(2/3)*(t-1).^2+(15/12)*(t-1).^3);


%Calculate the two sides of implicit solution using calculated y values and 
%define the error as the difference between the two sides; error is not 
%calculated at t=0 since arctan is undefined at this point

a = atan(y(2:n)./t(2:n));
l = log((y(2:n).^2+t(2:n).^2).^(.5));
error = abs(a-l);    


%table of t, y and error in implicit solution; output to screen
%p = [t;y;0 error];
%p'

%Taylor series order 4 - centered round the last step
%initalize new variables
x = zeros(1,n);
ax = zeros(1,n);
lx = zeros(1,n);
errorx = zeros(1,n);

%since the initial point is in the middle of the region, we will want to
%step forward half the time and backward half the time, so designate the
%approprieate halfway term.
if mod(n,2)
    m = n/2 +.5;
else 
    m = n/2;
end

%in the loop both forward and backwards steps are calculated based on the
%last given step, each time the f must be recalculated if we are centered
%around the last step; the error based off implicit solution is also
%calculated for each step as well
for i=0:m-2
    f = (t(m+i)+x(m+i))/(t(m+i)-x(m+i));
    f1 = (2*(t(m+i)*f-x(m+i)))/(t(m+i)-x(m+i))^2;
    f2 = 2*(t(m+i)*f1*(t(m+i)-x(m+i))-2*(t(m+i)*f-x(m+i))*(1-f))/(t(m+i)-x(m+i))^3;
    f3 = 2*((f1+2*t(m+i)*f2)*(t(m+i)-x(m+i))-2*t(m+i)*f1*(1-x(m+i)))/(t(m+i)-x(m+i))^3-4*((f1*x(m+i)+f1*t(m+i)*(1-2*f)*(t(m+i)-x(m+i)))-3*(1-f)^2*(t(m+i)*f-x(m+i)))/(t(m+i)-x(m+i))^4;
    
    x(m+i+1)=x(m+i)+h*f+.5*h^2*f1+(1/6)*h^3*f2+(1/24)*h^4*f3;
    ax(m+i) = atan(x(m+i)./t(m+i));
    lx(m+i) = log((x(m+i).^2+t(m+i).^2).^(.5));
    errorx(m+i) = abs(ax(m+i)-lx(m+i));  
          
    f = (t(m-i)+x(m-i))/(t(m-i)-x(m-i));
    f1 = (2*(t(m-i)*f-x(m-i)))/(t(m-i)-x(m-i))^2;
    f2 = 2*(t(m-i)*f1*(t(m-i)-x(m-i))-2*(t(m-i)*f-x(m-i))*(1-f))/(t(m-i)-x(m-i))^3;
    f3 = 2*((f1+2*t(m-i)*f2)*(t(m-i)-x(m-i))-2*t(m-i)*f1*(1-x(m-i)))/(t(m-i)-x(m-i))^3-4*((f1*x(m-i)+f1*t(m-i)*(1-2*f)*(t(m-i)-x(m-i)))-3*(1-f)^2*(t(m-i)*f-x(m-i)))/(t(m-i)-x(m-i))^4;
    
    x(m-i-1)=x(m-i)-(h*f+.5*h^2*f1+(1/6)*h^3*f2+(1/24)*h^4*f3);
    ax(m-i-1) = atan(x(m-i-1)./t(m-i-1));
    lx(m-i-1) = log((x(m-i-1).^2+t(m-i-1).^2).^(.5));
    errorx(m-i-1) = abs(ax(m-i-1)-lx(m-i-1));    
end

%All the data is reported in a matrix: t,y,x,error(1st method),error(2nd
%method); output to screen
disp('Columns of d: t,  i.v.,  l.v.,  error-i.v.,  error-l.v.')
d = [t;y;x;0 error; errorx]'