//Strikwerda 1.3 Prob 1
//Amie Demmel
//2/19/15

//Finite Difference Schemes: Leapfrog
//Implements Leapfrog scheme for a given lambda and h value for the one-way//wave equation, ut+ux=0.  with solution u0(0,x)=cos(pi*x)^2

//initialize
col=['-+b'; '-+g'; '-+r'; '-+c'];
iter=1;
flag=1;
lambda=input('lambda : ');

//loop while a valid lambda is called
while(flag)
    h=input('Enter space step h : ');
    k=lambda*h;

    ax=-1;
    bx=3;
    at=0;
    bt=2.4;

    n=(bt-at)/k + 1;
    m=(bx-ax)/h + 1;
    
    //True Solution for comparison at t=2.4
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

//inital condition loop
    u=zeros(n,m);
    x=ax;
    for i=1:m
        if abs(x)<(1/2)
            u(1,i)=(cos(%pi*x)).^2
        end
        x=x+h;
    end

    //d
    for j=1:n-1
        for i=2:m-1
            //Leapfrog
            if j==1
                //aproximate 2nd step of time with forward time/center space
                u(j+1,i)=u(j,i)-lambda/2*(u(j,i+1)-u(j,i-1))
            else
                //evaluate new time based off of two previous times
                u(j+1,i)=u(j-1,i)-lambda*(u(j,i+1)-u(j,i-1))
            end
        end
        //boundry condition
        u(j+1,m)=u(j+1,m-1);
    end
    x1=ax:h:bx;  
    plot(x1,u(n,:),col(iter))
    
    //error analysis for lamda/h pair
    //decide if usless - defined at abs(u(t,x))>5
    err4=abs(u(n,:)-tr');
    if abs(err4)<5 then
        nratio4(iter)=err4(m);
        nerr4=norm(err4);
        disp(nerr4)
    else disp('scheme is usless');
    end
    
    //increment
    iter=iter+1;
    lambda=input('lambda : ');
    if lambda == 0 then 
        flag = 0; 
    end
end

//plot true solution with the other calculated solutions
plot(x1,tr,'k')
