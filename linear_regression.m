function result = linear_regression(Y,X,alpha)
	[n,N] = size(X); 
	
	%% normalization
	X_mean = mean(X,2);
	X_stddev = std(X,0,2);
	Y_mean = mean(Y,2);
	Y_stddev = std(Y,0,2);
	
	X_norm = (X-repmat(X_mean,[1,N]))./repmat(X_stddev,[1,N]);
	Y_norm = (Y-repmat(Y_mean,[1,N]))./repmat(Y_stddev,[1,N]);
	
	%% ill-conditioned detection / dimensionality reduction 
    rerr = 0.95;
	[U,S,~]=svd(X_norm*X_norm');
    Evalues = diag(S);
    m = find(cumsum(Evalues)>sum(Evalues)*rerr, 1, 'first'); 
	Qm = U(:,1:m);
	d_hat = inv(S(1:m,1:m))*Qm'*X_norm*Y_norm';
	c_hat = Qm * d_hat;
	
	%% Test of Significance
	Y_predict = (c_hat' * X_norm) * Y_stddev + Y_mean;
	%Y_mean = mean(Y);
	ESS = sum((Y_predict - Y_mean).^2);
	RSS = sum((Y - Y_predict).^2);
	TSS = sum((Y - Y_mean).^2);
	f_sample = (N-n-1) * ESS / (n * RSS);
	f_critical = finv(1-alpha,n,N-n-1);
	%if (f_critical < f_sample)
	%disp('H0 is rejected; There is linear relationship between x and y')
	%else
	%disp('H0 is accepted. There is no linear relationship between x and y')
	%end
	
	%% printing the regression result
	const = Y_mean - Y_stddev * sum(c_hat.*X_mean./X_stddev);
	coeff = Y_stddev*(c_hat./X_stddev);
	result = [const;coeff];
	
	%% precision analysis
	z = norminv(1-alpha/2,0,1);
	s_delta = sqrt(RSS/(N-n-1));
	% disp(['Confidence zone: +/- ',num2str(z*s_delta)]);

end