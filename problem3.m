load data_16d.mat
close all
% flow_50link_sample = reshape(flow_50link,[288,16*50]);

%% Data Prep
flow_morning = zeros(50, 384);
flow_morning_daily = [];
for i=1:50
    t = flow_50link(73:96,:,i);
    flow_morning(i,:) = t(:);
    flow_morning_daily = [flow_morning_daily; t'];
end

flag = 0; % 0 for subtask 1, 1 for subtask 2
if flag
    data = flow_morning;
else
    data = flow_morning_daily;
end

%% Clustering on a daily basis
num_max = 7;
err = zeros(1,num_max);
for num = 2:num_max
    [~, ~, err(num)] = kmeans_clustering(data,num);
end

plot(2:1:num_max, err(2:end),'bo-')

%% Visualizing Results (using PCA to create 2D mapping)
num_chosen = 4;
[middle, label, err] = kmeans_clustering(data,num_chosen);

[pcs, cprs_data, cprs_c] = pca_compress(data,0.99);

figure();
middle2 = [];
for i=1:num_chosen
    hold on
    temp = cprs_data(label==i,:);
    plot(temp(:,1),temp(:,2),'.')
    middle2(i,:)=mean(cprs_data(label==i,:));
    plot(middle2(i,1),middle2(i,2),'o','MarkerFaceColor','b','MarkerSize',6);
end

figure();
for i=1:num_chosen
    subplot(1,num_chosen,i);
    plot(middle(i,:));
    axis([1,size(middle,2),0,1000]);
    title(['Class ',num2str(i)]);
end
