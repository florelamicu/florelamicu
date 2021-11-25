function X_rec = recoverData(Z, U, K, mu)
%
%   X_rec = RECOVERDATA(Z, U, K, mu) recovers an approximation to the 
%   original data that has been reduced to K dimensions. It returns the
%   approximate reconstruction in X_rec.
%
%   Z is the projected data
%   U are is a matrix whose columns are the eigenvectors, ordered according
%     to corresponding eigenvalues in decreasing order
%   K is the size of the projected space
%   mu is the mean of the original data
%


X_rec = Z * U(:,1:K)' + repmat(mu, size(Z, 1), 1);

end
