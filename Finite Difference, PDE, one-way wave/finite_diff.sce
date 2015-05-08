//Strikwerda 1.3 prob 1

//similar code to the leapfrog in all of these except
//  replace section d with the following sections
//forTbacS.m (forward time/backward space)
//forTcenS.m (forward time/center space)
//lax_fried.m (lax_friedriechs)

//a : forTbacS.m
u(:,1)=0;
for j=1:n-1
    for i=2:m
        //Forward Time/Backward Space
        u(j+1,i)=(1-lambda)*u(j,i)+lambda*u(j,i-1)
    end
end


//b : forTcenS.m
for j=1:n-1
    for i=2:m-1
        //Forward Time/Central Space
        u(j+1,i)=u(j,i)-lambda/2*(u(j,i+1)-u(j,i-1))
    end
    u(j+1,m)=u(j+1,m-1);
end


//c : lax_fried.m
for j=1:n-1
    for i=2:m-1
        //Lax-Friedrichs
        u(j+1,i)=(1-lambda)/2*u(j,i+1)+(1+lambda)/2*u(j,i-1)
    end
    u(j+1,m)=u(j+1,m-1);
end
