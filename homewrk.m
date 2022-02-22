load colscan.mat
load diag1scan.mat
load diag2scan.mat

% create matrix G
G = zeros(78,16*16);


for i=1:16
    G(i,i:16:256) = 1.;
end

ds = sqrt(2);

% diagonal scan c
for j=1:16
    G(16+j, j+(0:j-1)*15)=ds;
end

for j = 1:15
    G(32+j, (j+1)*16 + (0:15-j)*15) = ds;
end

% diagonal scan d
for j=1:15
    G(63-j,16*j+1:17:256) = ds;
end

for j =1:16
    G(62+j,j:17:16*(16-j+1)) = ds;
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

%%

dtest = [colscan(:,5);diag1scan(:,5);diag2scan(:,5)];
m = Vp*Sp^-1*Up'*dtest;

figure 
imagesc(reshape(m,16,16))
xlabel('m')
ylabel('m')