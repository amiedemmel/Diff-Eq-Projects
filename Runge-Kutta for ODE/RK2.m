%a=input('Enter a : ');
%b=input('b : ');
a=0;
b=5;
h=input('step-size : ');
%x0=input('inital x value : ');
x0=0;
%lamb=input('lamda value : ');

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
    true=zeros(1,n);
    true(1)=x0;
    x = zeros(1,n);
    x(1)=x0;
    %test function f= lamb*x+cos(t)-lamb*sin(t)

    t=t0;
    for i=1:n-1
    %These F1-F4 are specific to the IVP.  you will need to change them
    %based on your test function.  Also the true function is specific to
    %IVP problem
        F1 = h*func2(t,x(i),lamb);
        F2 = h*func2(t+.5*h,x(i)+.5*F1,lamb);
        F3 = h*func2(t+.5*h,x(i)+.5*F2,lamb);
        F4 = h*func2(t+h,x(i)+F3,lamb);

        x(i+1)=x(i)+(F1 + 2*F2 + 2*F3 + F4)/6;
        t=t+h;
        true(i+1)=sin(t);
    end

    %true=12*(exp(t1))./(1+exp(t1)).^2;
    error=abs(x-true);
    nerror=norm(x-true)
end

plot(t1,x,t1,true)
