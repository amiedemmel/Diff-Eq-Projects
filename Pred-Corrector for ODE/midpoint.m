%HW 4 Problem 8 from KC 8.3
%
%Amie Demmel
%2/9/15

%Solve x'=-x; x(0)=1 with Midpoint Method x(n+1)=x(n-1)+2hf(x(n))

%Intialize givens
a=input('Lower bound : ');
b=input('Upper bound : ');
h=input('Step size : ');

n=(b-a)/h + 1;
t=0;
x=zeros(n,1);
x(1)=1;
%Approximation of x1
x(2)=-h+sqrt(1+h^2);


%Midpoint Method
for i=2:n-1
    x(i+1)=x(i-1)+2*h*func(t,x(i));
    t=t+h;
end

%Plots
err=x-trueval(a:h:b)';
figure
plot(a:h:b,x)
xlabel('t');
ylabel('calculated solution');
title('Problem 8: Numerical Solution to dx/dt=-x');
figure
plot(a:h:b,err)
xlabel('t');
ylabel('error: xn-exp(-t)');
title('Error to Problem 8');