%run.m
%Amie Demmel
%Hw 10: p200 problem 3
%
%This is the master script to run the galerkin method as many times as
%wanted, the script terminates when n<=1 (where galerkin method fails)
n=input('n : ');

while(n>=2)
    %Generate a new figure window to plot solution
    figure
    
    %method
    galerkin
    
    %Estimate the exponent on the error ~O(1/n^p)
    p=log(1/err)/log(n)
    
    %Determine weather to terminate or run again with new n.
    n=input('n : ');
end