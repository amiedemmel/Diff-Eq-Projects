%run.m
%Amie Demmel
%Hw 10: p200 problem 3
%
%This is the master script to run the galerkin method as many times as
%wanted, the script terminates when n<=1 (where galerkin method fails)
n=input('n : ');

while(n<=1)
    %Generate a new figure window to plot solution
    figure
    
    %method
    galerkin
    
    %Estimate the exponent on the error ~O(1/n^p)
    p=log(1/err)/log(n)
    
    %Determine weather to terminate or run again with new n.
    n=input('n : ');
end

--------------------------------------------------------------------------
%galerkin.m
%
%This is the main method.  I tried to put problem specific parts in other
%scripts/functions.  However, the boundary and true solution remain.
%Galerkin uses basis functions to approximate the solution in a finite
%dimensional subspace.

%Global variables
global x h;

%These are specfic to the problem
ax=0;
bx=1;
step=.0001;

%user defines number of finite elements to use
n=input('n :');

h=(bx-ax)/(n+1);
x=ax:h:bx;

%call the function to set up stiffness matrix and load vector for specific
%problem/finite elements used
[K,f]=loader(n);

%Solve for coefficients
a=K\f;

%Plotting true and calculated solutions
%Find the error as maximum absolute value of the difference
x1=ax:step:bx;
m=size(x1);
%specfic to problem
tr=(x1)/12-(x1.^4)/12;

%y is the calculated solution, the linear combination of basis functions
%phi
y=zeros(1,m(2));
for i=1:n
    y=y+a(i)*phi(i,x1);
end

errv=tr-y;
err=max(abs(tr-y))
plot(x1,y,x1,tr);
legend('calculated','true');

-------------------------------------------------------------------------
%phi.m
%
%This is where you define the phi, or basis functions for the FEM
%We are using a piecewise linear finite element phi
function [phi]=phi(i,c)
global x h;
%ith basis function, will return scalar or vector values
n=size(c);
phi=zeros(1,n(2));
for k=1:n(2)
    if (c(k)>=x(i))&&(c(k)<x(i+1))
        phi(k)=(c(k)-x(i))/h;
    end
    if (c(k)>=x(i+1))&&(c(k)<x(i+2))
        phi(k)=(x(i+2)-c(k))/h;
    end
end
-------------------------------------------------------------------------
%loader.m
%
%This function calculates the stiffness and load vector needed for this
%problem using piecewise linear finite elements
function [K,f]=loader(n)
global x h;
%Load Vector, f
f=zeros(n,1);
for i=1:n
    f(i)=((x(i+1))^4)/2-((x(i+2)+x(i))*x(i+1)^3)/3+((x(i))^4+(x(i+2))^4)/12;
    f(i)=f(i)/h;
end
%Stiffness Matrix, K
g=zeros(1,n);
g(1)=2/h;
g(2)=-1/h;
K=toeplitz(g);