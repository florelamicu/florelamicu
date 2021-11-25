% WRITE HERE YOUR FUNCTION FOR EXERCISE 6

function M = myangle(in1,in2)
if in1<in2
    min=in1;
    max=in2;
else
    min=in2;
    max=in1;
end
M(:,1) = min:1:max;
M(:,2) = M(:,1).*pi/180;
Prnt(M);
end
% Another function
function Prnt(M)
disp(M);
end