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


[U,S,V] = svd(G);

j = 1:length(diag(S));
c = S(1,1);

figure(1)
plot(diag(S),'lineWidth',1.5)
hold on
plot(c./j.^1,'lineWidth',1.5)
hold on
plot(c./j.^2,'lineWidth',1.5)
hold on
plot(c./j.^3,'lineWidth',1.5)
hold on
plot(c./j.^4,'lineWidth',1.5)

legend('Singular value','O(1/j^1)','O(1/j^2)','O(1/j^3)','O(1/j^4)')
set(gca,'FontSize',14)
%% question 2

semilogy(diag(S),'lineWidth',1.5)
xlabel('i')
ylabel('Magnitude')
set(gca,'fontsize',14)

%% question 3

i = 20;

ratio = U(:,1:i)'*d./diag(S(1:i,1:i));

figure
semilogy(abs(ratio),'lineWidth',1.5)
xlabel('i')
ylabel('Magnitude')
set(gca,'fontsize',14)
%% question 4

for p = 1:6
Vp=V(:,1:p);
Sp = S(1:p,1:p);
Up=U(:,1:p);
m = Vp*Sp^(-1)*Up'*d;
subplot(2,3,p)
plot(m)
title(['p=',num2str(p)])
set(gca,'fontsize',14)
end
figure
for p = 1:6
Vp=V(:,1:p);
Sp = S(1:p,1:p);
Up=U(:,1:p);
m = Vp*Sp^(-1)*Up'*d;
subplot(2,3,p)
plot(G*m)
hold on
plot(d)
title(['p=',num2str(p)])
set(gca,'fontsize',14)
end
legend('Predicted','Observed')
%% question 5
p=4;
Vp=V(:,1:p);
Sp = S(1:p,1:p);
Up=U(:,1:p);
m = Vp*Sp^(-1)*Up'*d;

mt = exp(-10*(x-0.2).^2) + 0.4*exp(-10*(x-0.9).^2);
figure;
plot(m,'o')
hold on
plot(mt)
legend('Estimated','True')
set(gca,'Fontsize',14)