% WRITE HERE YOUR FUNCTION FOR EXERCISE 8

function  [imaginaryNumber, imaginaryNumberS] = sumcomplex(R,I,S)

imaginaryNumber.real = sum(R);
imaginaryNumber.img = sum(I);

imaginaryNumberS.real = 0;
imaginaryNumberS.img = 0;
for i=1:length(S)
    if S(i) > length(R)
        warning("S does not contain indices larges than lenght of R")
        return
    end
end
for i=1:length(S)
    imaginaryNumberS.real = R(S(i))+imaginaryNumberS.real;
    imaginaryNumberS.img = I(S(i))+imaginaryNumberS.img;
end

en