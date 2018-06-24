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

% u = permute(u,[1,3,2]);
% flow_50link_sample = reshape(u,[16,floor(tn/m)*50])';

Y1_pred = []
Y2_pred = []
Y1_real = []
Y2_real = []

tic

for i=1:50
    trainX = u(1:7,:,i);
    trainY = u(8:9,:,i);

    testX = u(8:14,:,i);
    testY = u(15:16,:,i);

    result1 = linear_regression(trainY(1,:),trainX,0.95);
    result2 = linear_regression(trainY(2,:),trainX,0.95);
    
    Y1_pred=[Y1_pred;testX'*result1(2:end)+result1(1)];
    Y2_pred=[Y2_pred;testX'*result2(2:end)+result2(1)];
    Y1_real=[Y1_real;testY(1,:)'];
    Y2_real=[Y2_real;testY(2,:)'];
end

toc

figure(),
% Y1_pred = testX*result1(2:end)+result1(1);
rmse1 = sqrt(sum((Y1_pred - Y1_real).^2)/size(Y1_real,1))
mape1 = sum(abs(Y1_pred-Y1_real)./Y1_real)/size(Y1_real,1)
are1 = sum((Y1_pred-Y1_real)./Y1_real)/size(Y1_real,1)
subplot(2,1,1);hold on;plot(Y1_real);plot(Y1_pred);
axis([0,size(Y1_pred,1),0,m*1200]);legend('Real Traffic','Predicted Traffic');

% Y2_pred = testX*result2(2:end)+result2(1);
rmse2 = sqrt(sum((Y2_pred - Y2_real).^2)/size(Y2_real,1))
mape2 = sum(abs(Y2_pred-Y2_real)./Y2_real)/size(Y2_real,1)
are2 = sum((Y2_pred-Y2_real)./Y2_real)/size(Y2_real,1)
subplot(2,1,2);hold on;plot(Y2_real);plot(Y2_pred);
axis([0,size(Y2_pred,1),0,m*1200]);legend('Real Traffic','Predicted Traffic');

suptitle(['Period=',num2str(period)])