clear
clc
%% question 1
load('ifk.mat')

delta = 1/20;

% median points
x = [0:delta:1-delta]+delta/2;
y = x;%x;

% samping the analytic solution with higher frequency
% delta = 1/40;
% % median points
% x = [0:delta:1-delta]+delta/2;
% y = x;%x;
% d2 = interp1(y2,d,y,'linear','extrap');
% d = d2.';

[x1,y1] = meshgrid(x,y);

G(:,:) = x1.*exp(-x1.*y1)*delta;
[U,S,V] = svd(G);

sigma = 5e-5;
% p = 2
p=2;
Vp=V(:,1:p);
Sp = S(1:p,1:p);
Up=U(:,1:p);
m = Vp*Sp^(-1)*Up'*d;

chi2_1 = (d - G*m)'*(d - G*m)/sigma^2;

% p = 4
p = 4;
Vp=V(:,1:p);
Sp = S(1:p,1:p);
Up=U(:,1:p);
m = Vp*Sp^(-1)*Up'*d;

chi2_2 = (d - G*m)'*(d - G*m)/sigma^2;

% true model
mt = exp(-10*(x-0.2).^2) + 0.4*exp(-10*(x-0.9).^2);
chi2_3 = (d - G*mt')'*(d - G*mt')/sigma^2;



%% question 2

alpha = [1e-1,1e-3,1e-5];
figure
for i =1:3
    si = diag(S);
    fi = si.^2./(si.^2+alpha(i)^2);
    Pr = fi.*U'*d./si;
    subplot(1,3,i)
    semilogy(abs(Pr))
    title(['\alpha = ',num2str(alpha(i))])
    set(gca,'Fontsize',14)
end

%% question 3

m_1 = inv(G'*G + alpha(1).^2*eye(size(G'*G)))*G'*d;

m_2 = inv(G'*G + alpha(2).^2*eye(size(G'*G)))*G'*d;

m_3 = inv(G'*G + alpha(3).^2*eye(size(G'*G)))*G'*d;

figure;
plot(m_1,'o')
hold on
plot(m_2,'*')
hold on
plot(m_3,'+')
hold on
plot(mt)
legend('\alpha = 10^{-1}','\alpha = 10^{-3}','\alpha = 10^{-5}','True')
set(gca,'Fontsize',14)

% b

chi2_new1 = (d - G*m_1)'*(d - G*m_1)/sigma^2
chi2_new2 = (d - G*m_2)'*(d - G*m_2)/sigma^2
chi2_new3 = (d - G*m_3)'*(d - G*m_3)/sigma^2

%% samping with higher frequency

delta = 1/20;
% median points
x2 = [0:delta:1-delta]+delta/2;
y2 = x2;%x;

% samping the analytic solution with higher frequency
delta = 1/40;
% median points
x = [0:delta:1-delta]+delta/2;
y = x;%x;
d2 = interp1(y2,d,y,'linear','extrap');
d = d2.';

[x1,y1] = meshgrid(x,y);

G2(:,:) = x1.*exp(-x1.*y1)*delta;

mt = exp(-10*(x-0.2).^2) + 0.4*exp(-10*(x-0.9).^2);
chi2_3_new = (d - G2*mt')'*(d - G2*mt')/sigma^2
