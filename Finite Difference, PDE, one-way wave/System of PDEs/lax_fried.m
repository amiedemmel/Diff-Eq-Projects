%lax_fried.m
%Problem 1.3 #2 Strikwerda
%Amie Demmel
%2/26/15
%
%This script applies the Lax-Friedman scheme to a system of equations
%The boundries are given in problem

%Initialize variables
lambda=1/2;
h=1/20;
k=lambda*h;

ax=-3;
bx=3;
at=0;
bt=2;

n=round((bt-at)/k + 1);
m=round((bx-ax)/h + 1);

%Initialize data u(0,x) and w(0,x)
u=zeros(n,m);
w=zeros(n,m);
x=ax;
for i=1:m
    u(1,i)=1-abs(x);
    w(1,i)=1-2*abs(x);
    if u(1,i)<0
        u(1,i)=0;
    end
    if w(1,i)<0
        w(1,i)=0;
    end
    x=x+h;
end
    
t=0;
for j=1:n-1
    for i=2:m-1
       %Lax-Friedrichs for u and w (see paper work for derviation of
       %form)
        L1=lambda/6*(t-2);
        L2=lambda/3*(t+1);
        u(j+1,i)=(.5-L1)*u(j,i+1)+(.5+L1)*u(j,i-1)-k*u(j,i)/3+L2*(w(j,i-1)-w(j,i+1));
        L1=lambda/6*(2*t-1);
        L2=lambda/6*(t+1);
        w(j+1,i)=(.5-L1)*w(j,i+1)+(.5+L1)*w(j,i-1)+k*w(j,i)/3+L2*(u(j,i-1)-u(j,i+1));
    end
    %boundry condition at n; u=0 and w is last calculated point
    u(j+1,m)=0;
    w(j+1,m)=w(j+1,m-1);
    t=t+k;
end

%visulize the last 10 time steps of u(t,x) and w(t,x) for this particular 
%problem: t in [1.75,2]
figure
subplot(2,1,1);
plot(ax:h:bx,u(n-9:n,:))
xlabel('x');
ylabel('u(t,x)');
title('u(t,x)');

subplot(2,1,2);
plot(ax:h:bx,w(n-9:n,:))
xlabel('x');
ylabel('w(t,x)');
title('w(t,x)');