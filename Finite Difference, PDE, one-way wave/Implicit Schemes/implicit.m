clear Lerr merr;
col=['b'; 'g'; 'r'; 'c'];
iter=1;
flag=1;

%Set up for specfic problem
ax=-1;
bx=1;
at=0;
bt=1/2;

%Assumptions
b=1;
mu=input('Input constant mu: ');
lb=input('Input constant lambda: ');
max=1000;

%Pick h
h=input('Enter h: ');

figure
hold on
while(flag)
    %Use h and either lb or mu assumed and find n & m
    if lb==0
        k=mu*h^2;
    else
        k=lb*h;
        mu=lb/h;
    end
    
    n=round((bt-at)/k+1);
    m=round((bx-ax)/h+1);

    %Set up matrices; n+1 time level
    r=zeros(1,m);
    r(1)=1+b*mu;
    r(2)=-1/2*b*mu;
    New=toeplitz(r);
    New(1,1)=1;
    New(1,2)=0;
    New(m,m)=1;
    New(m,m-1)=0;

    %n time level
    r(1)=1-b*mu;
    r(2)=-r(2);
    Old=toeplitz(r);
    Old(1,:)=0;
    Old(m,:)=0;
    
    %boundry condition initialized
    bnd=zeros(m,1);

    %Initial Data
    x=ax:h:bx;
    u=zeros(n,m);

    for i=1:m
        if abs(x(i)) < 1/2
            u(1,i)=1;
        else if abs(x(i)) == 1/2
               u(1,i)=1/2;
            end
        end
    end

    %For each time level, find the boundaries and solve matrix system for
    %next time level, increment t;
    t=at;
    for j=1:n-1
        bnd(1)=truesol(t,-1,max);
        bnd(m)=truesol(t,1,max);
        right=Old*u(j,:)'+bnd;
        u(j+1,:)=New\right;
        t=t+k;
    end
    
    %Visualize Solutions and Calculate Error
    plot(x,u(n,:),col(iter))
    
    tr=truesol(.5,x,max);
    err1=abs(u(n,:)-tr);
   
    Lerr(iter)=(h*sum((err1).^2))^1/2;
    merr(iter)=norm(err1,Inf);

    iter=iter+1;
    h=input('h : ');
    if h == 0
        flag = 0; 
    end
end

%Plot True Solution for comparision
plot(x,tr,'k')
hold off