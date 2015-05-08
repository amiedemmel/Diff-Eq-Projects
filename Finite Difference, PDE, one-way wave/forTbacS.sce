clear u u1 u2 u3 tr x x1 nu
col=['-+b'; '-+g'; '-+r'; '-+c'];
iter=1;
flag=1;
lambda=input('lambda : ');

while(flag)
    h=input('Enter space step h : ');
    k=lambda*h;

    ax=-1;
    bx=3;
    at=0;
    bt=2.4;

    n=(bt-at)/k + 1;
    m=(bx-ax)/h + 1;
    
    //True Solution for comparison
    t=2.4;
    x=ax;
    for i=1:m
        tx=x-t;
        if(abs(tx)<.5)
            tr(i)=cos(%pi*tx);
        else
            tr(i)=0;
        end
        x=x+h;
    end

    u=zeros(n,m);
    x=ax;
    for i=1:m
        if abs(x)<(1/2)
            u(1,i)=(cos(%pi*x)).^2
        end
        x=x+h;
    end

    //a
    u(:,1)=0;
    for j=1:n-1
        for i=2:m
            //Forward Time/Backward Space
            u(j+1,i)=(1-lambda)*u(j,i)+lambda*u(j,i-1)
        end
    end
    x1=ax:h:bx;  
    plot(x1,u(n,:),col(iter))
    
    err1=abs(u(n,:)-tr');
    if abs(err1)<5 then
        nratio(iter)=err1(m);
        nerr1=norm(err1);
        disp(nerr1)
    else disp('u is usless');
    end
    
    iter=iter+1;
    lambda=input('lambda : ');
    if lambda == 0 then 
        flag = 0; 
    end
end

plot(x1,tr,'k')
