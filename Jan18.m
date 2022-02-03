
clear

%% define A

A = [1,2,-1;0,1,0;-1,2,1;2,3,-2];

%%

R = rref(A);
%% find the null space
Z = null(A);

%% find the colomn space
C = colspace(sym(A));
