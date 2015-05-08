clear u u1 u2 u3 tr x x1 nu
col=['-+b'; '-+g'; '-+r'; '-+c'];
iter=1;
flag=1;
//lambda=input('lambda : ');

while(flag)
    //h=input('Enter space step h : ');
    h=1/20;
    k=lambda*h;

    ax=-3;
    bx=3;
    at=0;
    bt=2;

    n=(bt-at)/k + 1;
    m=(bx-ax)/h + 1;
    
    //True Solution for comparison
    //t=2;
    //x=ax;
    //for i=1:m
    //    tx=x-t;
    //    if(abs(tx)<.5)
    //        tr(i)=cos(%pi*tx);
    //    else
    //        tr(i)=0;
    //    end
    //    x=x+h;
    //end

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

    for j=1:n-1
        for i=2:m-1
            //Lax-Friedrichs
            u(j+1,i)=(1-lambda)/2*u(j,i+1)+(1+lambda)/2*u(j,i-1)
        end
        u(j+1,m)=u(j+1,m-1);
    end
    x1=ax:h:bx;  
    plot(x1,u(n,:),col(iter))
    
    //err3=abs(u(n,:)-tr');
    //if abs(err3)<5 then
    //    nratio3(iter)=err3(m);
    //    nerr3=norm(err3);
    //    disp(nerr3)
    //else disp('u is usless');
    //end
    
    iter=iter+1;
    lambda=input('lambda : ');
    if lambda == 0 then 
        flag = 0; 
    end
end

plot(x1,tr,'k')
