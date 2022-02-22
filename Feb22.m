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

[U,s,V] = csvd(G);

figure
[alpha_L,rho,eta,reg_param] = l_curve(U,s,d,'Tikh');
set(gca,'fontsize',14)

%% question 2
sigma = 5e-5;
%(a)
delta = (sigma*sqrt(20))^2;

%(b)
m_a = inv(G'*G + alpha_L.^2*eye(size(G'*G)))*G'*d;
res = norm((G*m_a-d),2)^2

%(c)
fun = @(alpha)fun1(alpha,G,d);
x0 = 1e-5;
options = optimoptions('fsolve','FunctionTolerance',1e-16);
x = fsolve(fun,x0,options)

fun1(x,G,d)/1e9
fun1(alpha_L,G,d)/1e9


%% question 3
%(a)
delta_reg = 20; % the value for m

%(b)



function output = fun1(alpha,G,d)
sigma = 5e-5;
%(a)
delta = (sigma*sqrt(20))^2;
m_a = inv(G'*G + alpha.^2*eye(size(G'*G)))*G'*d;
res = norm(G*m_a-d,2)^2;
output = (res - delta)*1e9;
end


