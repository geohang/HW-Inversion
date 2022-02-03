clear


%% Question 1
t = [3.4935;4.2853;5.1374;5.8181;6.8632;8.1841];
x = [6;10.1333;14.2667;18.4;22.5333;26.6667];

% organize G

G = [ones(6,1),x];

% least square estimate s2

s2 = inv(G'*G)*G'*t;

t_pred = G*s2;
% plot the data and the fitted model, and the residuals.

figure(1)
subplot(1,2,1)
plot(x,t,'LineWidth',1.5)
hold on 
plot(x,t_pred,'o','MarkerSize',8)
xlabel('Distance (m)')
legend('Observed','Predicted')
ylabel('Time (s)')
xlim([5,30])
set(gca,'fontsize',14)
title('Data')
subplot(1,2,2)
plot(x,t_pred-t,'o','MarkerSize',8)
xlabel('Distance (m)')
ylabel('Time (s)')
xlim([5,30])
set(gca,'fontsize',14)
title('Residuals')

%% Question 2

sigma = 0.1;
% define weight matrix
W = 1/sigma * eye(6,6);
Gw = W*G;
dw = W*t;

s2w = inv(Gw'*Gw)*Gw'*dw;


%% Question 3

chi2 = (G*s2 - t)'*(G*s2 - t)./sigma^2

chi2w = (W*(G*s2w - t))'*(W*(G*s2w - t))

%% Question 4 Evaluate the p-value for this model. 

p = 1-chi2cdf(chi2,4)

pw = 1-chi2cdf(chi2w,4)