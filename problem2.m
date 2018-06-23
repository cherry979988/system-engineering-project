load data_16d.mat
flow_50link_sample = reshape(flow_50link,[288,16*50]);

%% Compression
[pcs, cprs_data, cprs_c] = pca_compress(flow_50link_sample',0.99);
ratio = (bytes(pcs)+bytes(cprs_data)+bytes(cprs_c)) / bytes(flow_50link_sample);

%% Reconstruction
rdata1 = pca_reconstruct(pcs, cprs_data, cprs_c);
rmse = sqrt(mean(mean((rdata1-flow_50link_sample').^2)));

%% Plot the first 3 principal components
for i=1:3
    figure(i),
    plot(pcs(:,i));
    axis([1,288,-0.2,0.2]);
end
