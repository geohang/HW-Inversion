clear

%% solving for (a)
m_true = [0.18;16.21;9.81];


t = linspace(0,3,20)';

G = [ones(20,1),t,-1/2*t.^2];


d_true = G*m_true;

d_noise = d_true + 2*randn(20,1);

figure(1)
plot(t,d_true,'o','MarkerSize',8)
hold on
plot(t,d_noise,'*','MarkerSize',8)
xlabel('t')
ylabel('y')
legend('d_{True}','d_{noise}')
set(gca,'fontsize',16)
%% solving for (b)

m_est = G\d_noise;


figure(2)
plot(t,G*m_true,'-.','LineWidth',2)
hold on
plot(t,G*m_est,'--','LineWidth',2)
xlabel('t')
ylabel('y')
legend('y_{True}','y_{Estimation}')
set(gca,'fontsize',16)