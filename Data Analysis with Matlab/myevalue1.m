% WRITE HERE YOUR SCRIPT FOR EXERCISE 7

n=0;
err = 1;
while err >= 1e-5
    apx = (1-1/n)^n;
    err = abs(apx - 1/exp(1));
    n=n+1;
    
end
disp("approximate value ")
disp(vpa(apx,5))
disp("inverse of e is ")
disp(vpa(1/exp(1),5))
disp("n is :")
disp(n)