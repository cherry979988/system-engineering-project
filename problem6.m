load data_16d.mat
close all
% flow_50link_sample = reshape(flow_50link,[288,16*50]);

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
    size = 8;
else
    data = flow_morning_daily;
    size = 5;
end

%% Train SOM Net
net = selforgmap([size, size]);
net = train(net, data');

y = net(data');
classes = vec2ind(y);
[pcs, cprs_data, cprs_c] = pca_compress(data,0.99);
gscatter(cprs_data(:,1),cprs_data(:,2),classes,[],[],[],'off');