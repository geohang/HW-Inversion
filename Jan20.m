clear

%%

data = [-0.4326 -1.6656 0.1253 0.2877 -1.1465 1.1909 1.1892 -0.0376 0.3273 0.1746];
mu = mean(data);
sigma = std(data);

lower = mu - 2.262*sigma/sqrt(10)
upper = mu + 2.262*sigma/sqrt(10)

%% Q3
for i =1:1000
    X = exprnd(10,5,1);
    meanX(i) = mean(X);
end

figure;
histogram(meanX)
xlabel('Value')
ylabel('Counts')
set(gca,'fontsize',14)

figure;
qqplot(meanX)
set(gca,'fontsize',14)
%% Q4
for i =1:1000
    X = exprnd(10,50,1);
    meanX(i) = mean(X);
end

figure;
histogram(meanX)
xlabel('Value')
ylabel('Counts')
set(gca,'fontsize',14)

figure;
qqplot(meanX)
set(gca,'fontsize',14)