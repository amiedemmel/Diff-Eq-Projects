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
%n=input('n :');

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