function recon_data = pca_reconstruct(pcs, cprs_data, cprs_c)
    [N,n] = size(cprs_data);
    recon_data = (cprs_data * pcs').* repmat(cprs_c(2,:), [N,1]) + repmat(cprs_c(1,:), [N,1]);
end