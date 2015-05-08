%%Hw 3 Problem 2 from Kincaid and Chaney Ch 8.3
%%Amie Demmel
%%2/5/15
%
%RK2.m
%This script impliments the Runge-Kutta Method order 4 for some function as %as defined in func2.m file.  Modified RK_order4.m to evaluate at various 
%values of lambda as defined in for loop

%Initilize values

a=0;
b=5;
h=input('step-size : ');
x0=0;
%lamb=input('lamda value : ');

%if h is neg, the inital t value is upper bound; h pos, iv is lower b
if h < 0
   t0=b;
   t1=t0:h:a;
else
   t0=a;
   t1=t0:h:b;
end

n = (b-a)/abs(h) + 1;

for lamb=[5 -5 -10 -100]
    lamb

    %initalize vectors
    true=zeros(1,n);
    true(1)=x0;
    x = zeros(1,n);
    x(1)=x0;

    %Calculate the F1,F2,F3,F4 to get next step and the true sol(if known)
    t=t0;
    for i=1:n-1

        F1 = h*func2(t,x(i),lamb);
        F2 = h*func2(t+.5*h,x(i)+.5*F1,lamb);
        F3 = h*func2(t+.5*h,x(i)+.5*F2,lamb);
        F4 = h*func2(t+h,x(i)+F3,lamb);

        x(i+1)=x(i)+(F1 + 2*F2 + 2*F3 + F4)/6;
        t=t+h;
        true(i+1)=sin(t);
    end

    %Calculate error, and norm of error, plot solution and true(if known)
    error=abs(x-true);
    nerror=norm(error)
end

plot(t1,x,t1,true)

___________________________________________________________________________
%func2.m
function [f] = func2(t,x,l)
f=l*x+cos(t)-l*sin(t);