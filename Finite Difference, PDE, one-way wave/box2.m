%HW 8 Problem 3.1.4 part b
%Amie Demmel
%box2.m
%
%This script impliments scheme 2.2.4 box method for ut+a*ux=f where f is
%defined in f.m

%Initialize
col=['b'; 'g'; 'r'; 'c'];
iter=1;
flag=1;
a=input('wave speed : ');
lb=input('lambda : ');

ax=0;
bx=1;
at=0;
bt=1.2;

figure
hold on
while(flag)
    h=input('Enter space step h : ');
    k=lb*h;

    n=round((bt-at)/k + 1);
    m=round((bx-ax)/h + 1);

    u=zeros(n,m);
    x1=ax:h:bx;
    %initial data
    u(1,:)=sin(x1);

    t=at;
    x=ax;
    
    %3.1.4
    for j=1:n-1
        %boundry conditions for x=0 at k*j;
        tt=t+k;
        u(j+1,1)=-1*(1+tt)*sin(tt);
        for i=1:m-1
            %Box Scheme 2.2.4
            u(j+1,i+1)=(1-a*lb)*u(j,i+1)+(1+a*lb)*u(j,i)-(1-a*lb)*u(j+1,i)+2*k*f(t,x);
            u(j+1,i+1)=u(j+1,i+1)/(1+a*lb);
            
            x=x+h;
        end
        t=t+k;
        x=ax;
    end
    %Visulize and calculate error of solution both L-norm (Lerr) and max
    %norm (merr)
    plot(x1,u(n,:),col(iter))
    
    tr=truesol(t,x1);
    err1=abs(u(n,:)-tr);
   
    Lerr(iter)=(h*sum((err1).^2))^1/2;
    merr(iter)=norm(err1,Inf);
    iter=iter+1;
    lb=input('lambda : ');
    if lb == 0
        flag = 0; 
    end
end

plot(x1,tr,'k')
hold off