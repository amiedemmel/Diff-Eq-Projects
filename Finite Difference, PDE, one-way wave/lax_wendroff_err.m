%HW 8 Problem 3.1.2 part b
%Amie Demmel
%lax_wendroff.m
%
%This script impliments lax_wendroff scheme to solve ut+a*ux=0

%Initialize
clear Lerr merr;
col=['b'; 'g'; 'r'; 'c'];
iter=1;
flag=1;
a=input('wave speed : ');
lb=input('lambda : ');

ax=-1;
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

    %Initial data
    u=zeros(n,m);
    x=ax;
    for i=1:m
        u(1,i)=sin(2*pi*x);
        x=x+h;
    end

    %Scheme calculate
    for j=1:n-1
        for i=2:m-1
            %Lax-Wendroff
            L1=a*lb/2;
            L2=(a*lb)^2/2;
            u(j+1,i)=(1-2*L2)*u(j,i)+(L2-L1)*u(j,i+1)+(L2+L1)*u(j,i-1);
        end
        %since scheme requires m+1 to calculate m, we can not calculate m gird directly,
        %it also requires m-1 to calculate m, so we can not calculate 1
        %grid directly... so approximated m grid point by m-1 and then set
        %grid 1 to grid m to satisfy periodic boundries
        u(j+1,m)=u(j,m-1);
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
    lb=input('lambda : ');
    if lb == 0
        flag = 0; 
    end
end

plot(x1,tr,'k')
hold off