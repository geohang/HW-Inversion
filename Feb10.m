
clear
clc

% define the G
s2=sqrt(2);
G = [1,0,0,1,0,0,1,0,0;
     0,1,0,0,1,0,0,1,0;
     0,0,1,0,0,1,0,0,1;
     1,1,1,0,0,0,0,0,0;
     0,0,0,1,1,1,0,0,0;
     0,0,0,0,0,0,1,1,1;
     s2,0,0,0,s2,0,0,0,s2;
     0,0,0,0,0,0,0,0,s2];

[U,S,V] = svd(G);

p=rank(G);

%% question 1

Vp=V(:,1:p);
Rm=Vp*Vp';
% find the trace
trace(Rm)

figure
colormap('gray')
imagesc(reshape(diag(Rm),3,3))
set(colorbar,'Fontsize',18);
set(gca,'xtick',[1,2,3,4,5,6,7,8,9]);
set(gca,'ytick',[1,2,3,4,5,6,7,8,9]);
xlabel('j')
ylabel('i')
%% question 2
Up=U(:,1:p);
Rd=Up*Up';


figure
plot(diag(Rd))
ylabel('Data resolution')
xlabel('Points')
set(gca,'fontsize',14)

%find the trace
trace(Rd)


%% Question 3

Bias = Rm - eye(size(Rm))

Bias1 = -V(:,p+1:end)*V(:,p+1:end)'

figure
subplot(1,2,1)
heatmap(Bias)
title ('The Bias matrix')
subplot(1,2,2)
heatmap(Bias - Bias1)
title ('The difference between Rm −I and −V_0V^T_0,')
% get norm
norm(Bias)
norm(Bias1)

%% Question 4

spikemodel = reshape([0,0,0;0,1,0;0,0,0],9,1);

dtest = G*spikemodel;

Up = U(:,1:p);
temp = diag(S);
Sp = diag(temp(1:p));
Vp = V(:,1:p);
m = Vp*Sp^-1*Up'*dtest;

figure
subplot(1,2,1)
imagesc(reshape(spikemodel,3,3))
set(colorbar,'Fontsize',18);
set(gca,'xtick',[1,2,3,4,5,6,7,8,9]);
set(gca,'ytick',[1,2,3,4,5,6,7,8,9]);
xlabel('j')
ylabel('i')
title('Original model')
colormap('gray')
subplot(1,2,2)
colormap('gray')
imagesc(reshape(m,3,3))
set(colorbar,'Fontsize',18);
set(gca,'xtick',[1,2,3,4,5,6,7,8,9]);
set(gca,'ytick',[1,2,3,4,5,6,7,8,9]);
xlabel('j')
ylabel('i')
title('Estimated model')
%% question 5
% condiction of G
cond(G)

% condiction of G'
cond(Vp*Sp^-1*Up')