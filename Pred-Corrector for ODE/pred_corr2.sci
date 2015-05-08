//HW 4 Problem 1 from KC Predictor-Corrector
//
//Amie Demmel
//%2/9/15

//%Solve x'=x+x^2; x(1)=e/16-e with Trapezoid Method
//%x(n+1)=x(n)+(h/2)*(f(x(n))+f(x(n+1)))
//%Predict with Euler's Method
//%x(n+1)=x(n)+h*f(x(n))

exec func.sci
exec trueval.sci

a=input('Lower bound : ');
b=input('Upper bound : ');
h=input('Step size : ');

n=(b-a)/h + 1;
t=a;
x=zeros(n,1);
x(1)=exp(1)/(16-exp(1));

for i=1:n-1
    //%predict x(i+1) with Euler: two step
    m=x(i)+h/2*func(t,x(i));
    x(i+1)=x(i)+h*func(t+h/2,m);
    
    //%correct with more accurate Trapezoid
    x(i+1)=x(i)+(h/2)*(func(t,x(i))+func(t,x(i+1)));
    
    t=t+h;
end

err=x-trueval(a:h:b)';
nerr=norm(err)
disp(nerr)
figure
plot(a:h:b,x,a:h:b,trueval(a:h:b));
figure
plot(err);
