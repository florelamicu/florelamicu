function [mu,Xmu] = subtractMean(X)
mu = mean(X);
Xmu = bsxfun(@minus, X, mean(X));

end

