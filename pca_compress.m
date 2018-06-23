function [pcs, cprs_data, cprs_c] = pca_compress(data,rerr)
    [N,n] = size(data);
    
    cprs_c(1,:) = mean(data,1);
    cprs_c(2,:) = sqrt(var(data,1));
    data = (data - repmat(cprs_c(1,:),[N,1]))./repmat(cprs_c(2,:),[N,1]);
    
    [U,S,~]=svd(data' * data);
    Evalues = diag(S);
    m = find(cumsum(Evalues)>sum(Evalues)*rerr, 1, 'first'); 
    
    pcs = U(:,1:m);
    cprs_data = data * pcs;
end