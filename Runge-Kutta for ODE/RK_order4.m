%%Hw 3 Problem 1 from Kincaid and Chaney Ch 8.3
%%Amie Demmel
%%2/5/15
%
%RK_order4.m
%This script impliments the Runge-Kutta Method order 4 for some function as %as defined in func1.m file.  The true solution is defined in true.m file.
%h is allowed to be pos or neg; to step up or down with inital value t %defined as either the upper or lower bound as needed

%Initilize values
a=input('Enter lower bound : ');
b=input('Enter upper bound : ');
h=input('step-size : ');
%t0=input('inital t value : ');
x0=input('inital x value : ');


%if h is negative, then inital t value is upper bound; h pos, iv is lower b
if h < 0
   t0=b;
   t1=t0:h:a;
else
   t0=a;
   t1=t0:h:b;
end

n = (b-a)/abs(h) + 1;

%initalize vectors
true=zeros(1,n);
true(1)=x0;
x = zeros(1,n);
x(1)=x0;

%Calculate the F1,F2,F3,F4 to get next step and the true sol(if known)
t=t0;
for i=1:n-1

    F1 = h*func1(t,x(i));
    F2 = h*func1(t+.5*h,x(i)+.5*F1);
    F3 = h*func1(t+.5*h,x(i)+.5*F2);
    F4 = h*func1(t+h,x(i)+F3);

    x(i+1)=x(i)+(F1 + 2*F2 + 2*F3 + F4)/6;
    t=t+h;

    true(i+1)=tr(t);
end


%calculate error, and norm of error, plot solution and true(if known)
error=abs(x-true);
nerror=norm(error)

plot(t1,x,t1,true)
