clear u u1 u2 u3 tr x x1 nu
//col1=['-+b'; '-+g'; '-+r'; '-+c'];
//col2=['-ob'; '-og'; '-or'; '-oc'];
iter=1;
flag=1;
lambda=input('lambda : ');

while(flag)
    h=1/20;
    k=lambda*h;

    ax=-3;
    bx=3;
    at=0;
    bt=2;

    n=(bt-at)/k + 1;
    m=(bx-ax)/h + 1;

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
            //Lax-Friedrichs
            L1=lambda/6*(t-2);
            L2=lambda/3*(t+1);
            u(j+1,i)=(.5-L1)*u(j,i+1)+(.5+L1)*u(j,i-1)-k*u(j,i)/3-L2*(w(j,i+1)-w(j,i-1));
            L1=lambda/6*(2*t-1);
            L2=lambda/6*(t+1);
            w(j+1,i)=(.5-L1)*w(j,i+1)+(.5+L1)*w(j,i-1)+k*w(j,i)/3-L2*(u(j,i+1)-u(j,i-1));
        end
        u(j+1,m)=0;
        w(j+1,m)=w(j+1,m-1);
        t=t+k;
    end
    
    iter=iter+1;
    lambda=input('lambda : ');
    if lambda == 0 then 
        flag = 0; 
    end
end
