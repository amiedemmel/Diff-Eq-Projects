%HW 8 Problem 3.1.2 part a
%Amie Demmel
%lax_wendroff.m
%
%This script impliments forward-time backward-space scheme to solve ut+a*ux=0

%Initialize
clear Lerr merr;
col=['b'; 'g'; 'r'; 'c'];
iter=1;
flag=1;
a=input('wave speed : ');
lambda=input('lambda : ');

ax=-1;
bx=1;
at=0;
bt=1.2;

figure
hold on
while(flag)
    h=input('Enter space step h : ');
    k=lambda*h;

    n=round((bt-at)/k + 1);
    m=round((bx-ax)/h + 1);

    %Initial data
    u=zeros(n,m);
    x=ax;
    for i=1:m
        u(1,i)=sin(2*pi*x);
        x=x+h;
    end

    %Scheme
    for j=1:n-1
        for i=2:m
            %Forward Time/Backward Space
            u(j+1,i)=(1-lambda*a)*u(j,i)+lambda*a*u(j,i-1);
        end
        %periodic boundry condition
        u(j+1,1)=u(j+1,m);
    end
    %Visulize and calculate error of solution both L-norm (Lerr) and max
    %norm (merr)
    x1=ax:h:bx;  
    plot(x1,u(n,:),col(iter))
    
    tr=initialu(x1-bt);
    err1=abs(u(n,1:m-1)-tr(1:m-1));
   
    Lerr(iter)=(h*sum((err1).^2))^1/2;
    merr(iter)=norm(err1,Inf);
    iter=iter+1;
    lambda=input('lambda : ');
    if lambda == 0
        flag = 0; 
    end
end

plot(x1,tr,'k')
hold off