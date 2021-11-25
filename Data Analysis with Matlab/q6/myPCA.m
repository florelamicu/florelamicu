% Write your code here

function [U,S] = myPCA(Xmu)
    C = cov(Xmu);
    % U = Principal Components; S = Corresponding Eigen Values
    [U,S] = eig(C,'matrix');
    [S,ind] = sort(diag(S), 'descend');
    U=U(:,ind);
end

