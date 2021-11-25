% WRITE HERE YOUR SCRIPT FOR EXERCISE 7

n=1;
err = 1;
apx = 1;
while err >= 1e-5
    apx = apx+(1/factorial(n));
    err = abs(apx - exp(1));
    n=n+1;
    
end
disp("approximate value ")
disp(vpa(apx,5))
disp("Value of e is ")
disp(vpa(exp(1),5))
disp("n is :")
disp(n)