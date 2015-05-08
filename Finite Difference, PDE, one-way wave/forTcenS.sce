clear u u1 u2 u3 tr x x1 nu
col=['-+b'; '-+g'; '-+r'; '-+c'];
iter=1;
flag=1;
ax=-1;
bx=3;
at=0;
bt=2.4;
lambda=input('lambda : ');

while(flag)
    h=input('Enter space step h : ');
    k=lambda*h;

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

    //b
    for j=1:n-1
        for i=2:m-1
            //Forward Time/Central Space
           u(j+1,i)=u(j,i)-lambda/2*(u(j,i+1)-u(j,i-1))
        end
        u(j+1,m)=u(j+1,m-1);
    end
    x1=ax:h:bx;
    plot(x1,u(n,:),col(iter))
    
    err2=abs(u(n,:)-tr');
    if abs(err2)<5 then
        nratio2(iter)=err2(m);
        nerr2=norm(err2);
        disp(nerr2)
    else disp('scheme is usless');
    end
    
    iter=iter+1;
    lambda=input('lambda : ');
    if lambda == 0 then 
        flag = 0; 
    end
end

plot(x1,tr,'k')
