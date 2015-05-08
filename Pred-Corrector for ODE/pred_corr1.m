%HW 4 Problem 1 from KC Predictor-Corrector
%
%Amie Demmel
%2/9/15

%Solve x'=x+x^2; x(1)=e/16-e with Trapezoid Method
%x(n+1)=x(n)+(h/2)*(f(x(n))+f(x(n+1)))
%Predict with Euler's Method
%x(n+1)=x(n)+h*f(x(n))

%Initialize
a=input('Lower bound : ');
b=input('Upper bound : ');
h=input('Step size : ');

n=round((b-a)/h + 1);
t=a;
x=zeros(n,1);
x(1)=exp(1)/(16-exp(1));

%x vector is calculated using Euler one step and then corrected with %Trapezoid

for i=1:n-1
    %predict x(i+1) with Euler: one step
    x(i+1)=x(i)+h*func(t,x(i));
    
    %correct with more accurate Trapezoid
    x(i+1)=x(i)+(h/2)*(func(t,x(i))+func(t,x(i+1)));
    
    t=t+h;
end

%Plot Visulization of error
err=x-trueval(a:h:b)';
nerr=norm(err)
figure
plot(err);
title('One Step Euler Error');

%y vector calculated with the more accuate two steps euler for pred, %then Trapezoid for correction step 
t=a;
y=zeros(n,1);
y(1)=exp(1)/(16-exp(1));

for i=1:n-1
    %predict x(i+1) with Euler: two step- once halfway, then again at     %new y
    m=y(i)+h/2*func(t,y(i));
    y(i+1)=y(i)+h*func(t+h/2,m);
    
    %correct with more accurate Trapezoid
    y(i+1)=y(i)+(h/2)*(func(t,y(i))+func(t,y(i+1)));
    
    t=t+h;
end

%Visulize Results
err=y-trueval(a:h:b)';
nerr=norm(err)
figure
plot(a:h:b,x,a:h:b,y,a:h:b,trueval(a:h:b));
xlabel('t');
ylabel('y-value');
legend('Euler One Step','Euler Two Step','Analytic Sol');
title('Pred-Corr Problem: Two Step Euler vs One Step Euler');
figure
plot(err);
title('Two Step Euler Error');
