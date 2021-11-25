% WRITE HERE YOUR FUNCTION FOR EXERCISE 5

function calctrianglearea(mat)

n=length(mat);

if rem(n,3)~=0
    a=n-rem(n,3);
    disp("not used points are: ")
    disp(mat(a+1,:))
    if n-a==2
        disp(mat(a+2,:))        
    end
end

i=1;
for j=1:((n-rem(n,3))/3)
    a=calctriangledist(mat(i+0,1),mat(i+1,1),mat(i+0,2),mat(i+1,2));
    b=calctriangledist(mat(i+2,1),mat(i+1,1),mat(i+2,2),mat(i+1,2));
    c=calctriangledist(mat(i+0,1),mat(i+2,1),mat(i+0,2),mat(i+2,2));
    s=(a+b+c)/2;
    area = sqrt(s*(s-a)*(s-c)*(s-c));
    d=sprintf('area of triangle %d is',j);
% In my understanding i should use display not fprintf as the system is
% suggesting 
    disp(d)
    disp(area)
    i=i+3;
end

end

function dist = calctriangledist(x1,x2,y1,y2)
dist = sqrt(((x1-x2)^2)+((y1-y2)^2));
end