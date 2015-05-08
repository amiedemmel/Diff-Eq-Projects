function [f] = func1(t,x)
f=x*(1-exp(t))/(1+exp(t));