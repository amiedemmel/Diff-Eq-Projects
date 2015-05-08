global h x n;
a=0;
b=1;
%n=input('Enter number of sub-intervals: ');
h=(b-a)/n;

x=a:h:b;
K=zeros(n-1);
load=zeros(n-1,1);
for i=1:n-1
    load(i)=simp(x(i),x(i+1),4)+simp(x(i+1),x(i+2),5);
    for j=i:n-1
        if abs(i-j)==1
            K(i,j)=simp(x(i+1),x(i+2),1);
            K(j,i)=K(i,j);
        end
        if i==j
            K(i,j)=simp(x(i),x(i+1),2)+simp(x(i+1),x(i+2),3);
        end
    end
end

u=K\load;

g=zeros(1,n+1);
y=zeros(1,n+1);
for i=1:n-1
    g=g+u(i)*phi(i,x);
end
%Solution for inhomogenus problem:
y=g+1-x;