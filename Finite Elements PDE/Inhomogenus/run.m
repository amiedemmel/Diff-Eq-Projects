%run.m
global n;

n=input('Enter number of sub-intervals: ');
col=['b','r','k'];
max=3;
iter=0;

figure
hold on
while((n>=2)&&(iter<max))
    iter=iter+1;
    FEM
    plot(x,y,col(iter));
    n=input('Enter number of sub-intervals: ');
end
hold off
xlabel('x');
ylabel('calculated solutions');
title('FEM of various n values');
leg=input('Enter legend: ');
legend(leg);