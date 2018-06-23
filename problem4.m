close all; clear all;
load data_16d.mat

period = 5;
% data = flow_50link;
t = permute(flow_50link,[2,1,3]);
m = floor(period/5);
tn = size(flow_50link,1);

for i=1:size(t,1)
    for j=1:floor(tn/m)
        u(i,j,:)=sum(t(i,(j-1)*m+1:j*m,:),2);
    end
end

flow_50link_sample = reshape(u,[16,floor(tn/m)*50])';


trainX = flow_50link_sample(:,1:7);
trainY = flow_50link_sample(:,8:9);

testX = flow_50link_sample(:,8:14);
testY = flow_50link_sample(:,15:16);

tic
net = fitnet(12);
net = train(net,trainX', trainY');
toc

Y_pred = net(testX')';
figure(),
Y1_pred = Y_pred(:,1);
rmse1 = sqrt(sum((Y1_pred - testY(:,1)).^2)/size(testY,1))
mape1 = sum(abs(Y1_pred-testY(:,1))./testY(:,1))/size(testY,1)
are1 = sum((Y1_pred-testY(:,1))./testY(:,1))/size(testY,1)
subplot(2,1,1);hold on;plot(testY(:,1));plot(Y1_pred);
axis([0,size(Y1_pred,1),0,m*1200]);legend('Real Traffic','Predicted Traffic');

Y2_pred = Y_pred(:,2);
rmse2 = sqrt(sum((Y2_pred - testY(:,2)).^2)/size(testY,1))
mape2 = sum(abs(Y2_pred-testY(:,2))./testY(:,2))/size(testY,1)
are2 = sum((Y2_pred-testY(:,2))./testY(:,2))/size(testY,1)
subplot(2,1,2);hold on;plot(testY(:,2));plot(Y2_pred);
axis([0,size(Y2_pred,1),0,m*1200]);legend('Real Traffic','Predicted Traffic');
