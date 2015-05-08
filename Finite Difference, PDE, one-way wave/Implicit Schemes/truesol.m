function [tr]=truesol(t,x,n)
tr=1/2;
for i=0:n
    tr=tr+2*(-1)^i*cos(pi*(2*i+1)*x)/(pi*(2*i+1))*exp(-pi^2*(2*i+1)^2*t);
end