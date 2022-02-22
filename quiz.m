clear

%question 1

%i
pi = 1-chi2cdf(20,50)

%ii
pii = 1-chi2cdf(49,50)

%iii
pii = 1-chi2cdf(120,50)


%question 2

clear
y = [68;68.5;64.5];
x = [70.25;67;60];

% organize G

G = [x,ones(3,1)];
% L1 estimate
s_l1 = irls(G, y, 1e-3, 1e-3, 1, 50)

t_pred = G*s_l1;

q = 5000;

for i =1:q
    M (:,i)= irls(G, t_pred + 1e-3*randn(size(t_pred)), 1e-3, 1e-3, 1, 50);
end

A = M - s_l1;
cov = A*A'/q

1.96*sqrt(diag(cov))

CI = [s_l1-1.96*sqrt(diag(cov)), s_l1 + 1.96*sqrt(diag(cov))]


figure(1)
%plot the predicted data
plot(x,t_pred)
hold on 
errorbar(x,y,0.1*ones(size(y)),'o','MarkerSize',8)

%plot the qq plot
figure
subplot(1,2,1)
qqplot(M(1,:))
set(gca,'fontsize',14)
subplot(1,2,2)
qqplot(M(2,:))
set(gca,'fontsize',14)