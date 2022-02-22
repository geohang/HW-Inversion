clear

%%
% Now we have 78 equations
% we also 160 model parameters
% so our G should 78*256 matrix

% G*m = t
load('colscan.mat')
load('diag1scan')
load('diag2scan')

G = zeros(78,256);
ds = sqrt(2);

% for the column scan
for i=1:16
    G(i,(i-1)*16+1:i*16) = 1.;
end

% for the diag scan 1
for i=1:16
    G(i+16,i+(0:i-1)*15) = ds;
end

for i=1:15
    G(i+32,(i+1)*16+(0:15-i)*15) = ds;
end

% for the diag scan 2
for i=1:16
   G(i+47,17-i+17*(0:i-1)) = ds;
end

for i=1:15
    G(i+63,(i*16)+1+17*(0:15-i)) = ds;
end

%% question b
% find the rank of G
p=rank(G);

% svd
[U,S,V] = svd(G);
Vp=V(:,1:p);
Up=U(:,1:p);
temp = diag(S);
Sp = diag(temp(1:p));


% find the model null space
figure;
clf
colormap('gray')
imagesc(reshape(V(:,p+1),16,16))
% caxis([-0.5 0.5]);
set(colorbar,'Fontsize',18);
set(gca,'xtick',[1:16]);
set(gca,'ytick',[1:16]);
xlabel('j')
ylabel('i')
title('Reshaped Null Space Model V.,75');

% find the data null space
figure;
plot(U(:,p+1))
title('Null Space Data U.,75');

% ii

dtest = [colscan(:,5);diag1scan(:,5);diag2scan(:,5)];
m = Vp*Sp^-1*Up'*dtest;

figure
imagesc(reshape(m,16,16))
set(gca,'xtick',[1:16]);
set(gca,'ytick',[1:16]);
colorbar
xlabel('j')
ylabel('i')
% iii

Rm=Vp*Vp';

figure
colormap('gray')
imagesc(reshape(diag(Rm),16,16))
set(colorbar,'Fontsize',18);
set(gca,'xtick',[1:16]);
set(gca,'ytick',[1:16]);
xlabel('j')
ylabel('i')
title('Model Resolution Matrix')


%% question c

% slowness plot
figure
imagesc(reshape(m,16,16))
set(gca,'xtick',[1:16]);
set(gca,'ytick',[1:16]);
colorbar
xlabel('j')
ylabel('i')
title(['Slowness model ','Max:',num2str(max(m)),' Min',num2str(min(m))])

% slowness plot
figure
imagesc(reshape(1./(1./3000 + m),16,16))
set(gca,'xtick',[1:16]);
set(gca,'ytick',[1:16]);
colorbar
xlabel('j')
ylabel('i')
title('Velocity model')

% data fit
figure
errorbar(dtest,ones(size(dtest))*1.5e-5,'o')
hold on
plot(G*m,'LineWidth',1.5)
legend('Observed','Predicted')

%% d

% any LS solution add model null space could be the model
% slowness plot
figure
imagesc(reshape(m,16,16) + 1e3*reshape(V(:,p+1),16,16))
set(gca,'xtick',[1:16]);
set(gca,'ytick',[1:16]);
colorbar
xlabel('j')
ylabel('i')
title('Wild model')

% Wild model data fit
figure
errorbar(dtest,ones(size(dtest))*1.5e-5,'o')
hold on
plot(G*(m+ 1e3*V(:,p+1)),'LineWidth',1.5)
legend('Observed','Predicted')
title('Wild model data fit')

%% e Plot and interpret the correlation matrix.

% the covariance
Cov = 1.5e-5*Vp*Sp^(-2)*Vp';
for i =1:256
    for j =1: 256
        correlation(i,j) = Cov(i,j)/sqrt(Cov(i,i)*Cov(j,j));
    end
end
figure
colormap('gray')
imagesc(correlation)
set(colorbar,'Fontsize',18);
xlabel('j')
ylabel('i')
title('Model correlation Matrix')

%% f Quantify and discuss stability of slowness perturbation estimates.
cond = max(diag(Sp))/min(diag(Sp))
