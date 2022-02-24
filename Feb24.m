clear
clc

%% question 1
load('ifk.mat')

delta = 1/20;

% median points
x = [0:delta:1-delta]+delta/2;
y = x;%x;

[x1,y1] = meshgrid(x,y);

G(:,:) = x1.*exp(-x1.*y1)*delta;

n = size(G,2);

% get L1
L1 = zeros(n-1,n);

for i=1:n-1
    L1(i,i) = -1;
    L1(i,i+1) = 1; 
end

% get L2
L2 = zeros(n-2,n);

for i = 1:n-2
    L2(i,i) = 1;
    L2(i,i+1) = -2;
    L2(i,i+2) = 1;
end

%% question 2

