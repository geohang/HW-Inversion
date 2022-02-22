%

clear
clc
%% question 3 (a)

% Construct system matrix for the ray path models
s2=sqrt(2);
G = [1,0,0,1,0,0,1,0,0;
     0,1,0,0,1,0,0,1,0;
     0,0,1,0,0,1,0,0,1;
     1,1,1,0,0,0,0,0,0;
     0,0,0,1,1,1,0,0,0;
     0,0,0,0,0,0,1,1,1;
     s2,0,0,0,s2,0,0,0,s2;
     0,0,0,0,0,0,0,0,s2];

t = [6e-06,-1.7e-05,4e-06,-4e-06,0,1.9e-05,-5e-06,5e-06].'; 

% Find and display system rank
p=rank(G);

% for question i
[U,S,V] = svd(G);
Up = U(:,1:p);
temp = diag(S);
Sp = diag(temp(1:p));
Vp = V(:,1:p);
m = Vp*Sp^-1*Up'*t;

% for question ii
m2 = G\t;

figure
subplot(1,2,1)
colormap('gray')
imagesc(reshape(m,3,3))
caxis([min([m;m2]),max([m;m2])]);
set(colorbar,'Fontsize',18);
set(gca,'xtick',[1,2,3,4,5,6,7,8,9]);
set(gca,'ytick',[1,2,3,4,5,6,7,8,9]);
xlabel('j')
ylabel('i')
title('Estimation from generalized inverse of G')
set(gca,'fontsize',14)
subplot(1,2,2)
colormap('gray')
imagesc(reshape(m2,3,3))
caxis([min([m;m2]),max([m;m2])]);
set(colorbar,'Fontsize',18);
set(gca,'xtick',[1,2,3,4,5,6,7,8,9]);
set(gca,'ytick',[1,2,3,4,5,6,7,8,9]);
xlabel('j')
ylabel('i')
title('Estimation from backslash operator in MATLAB')
set(gca,'fontsize',14)


figure
plot(t,'o','MarkerSize',8)
hold on 
plot(G*m,'LineWidth',1.5)
hold on 
plot(G*m2,'LineWidth',1.5)
xlabel('Distance (m)')
legend('Observed','Predicted from generalized inverse of G', ...
    'Predicted from backslash operator in MATLAB')
ylabel('Time (s)')
set(gca,'fontsize',14)

%% Question 3 (b)

% Display data space null vector
disp('Data null space vector')
U(:,p+1)
figure
imagesc(U(:,p+1))
set(gca,'ytick',[1,2,3,4,5,6,7,8]);
set(colorbar,'Fontsize',18);
set(gca,'fontsize',14)

%% Question (c)

% Display null space vectors reshaped to match tomography example geometry
disp('Model null space vectors reshaped into matrices')
m01=reshape(V(:,p+1),3,3)'
m02=reshape(V(:,p+2),3,3)'

figure
subplot(1,2,1)
colormap('gray')
imagesc(m01)
caxis([-0.5 0.5]);
set(colorbar,'Fontsize',18);
set(gca,'xtick',[1,2,3]);
set(gca,'ytick',[1,2,3]);
xlabel('j')
ylabel('i')
set(gca,'fontsize',14)
title('Reshaped Null Space Model V.,8');
subplot(1,2,2)
colormap('gray')
imagesc(m02)
caxis([-0.5 0.5]);
set(colorbar,'Fontsize',18);
set(gca,'xtick',[1,2,3]);
set(gca,'ytick',[1,2,3]);
xlabel('j')
ylabel('i')
title('Reshaped Null Space Model V.,9');
set(gca,'fontsize',14)




