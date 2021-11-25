% WRITE HERE YOUR FUNCTION FOR EXERCISE 4

function A = buildrandomstrings(n)

if n>0
    
    for i=1:n
        A(i) = cellstr(char(randi([97 122],1,i)));
    end
else 
    for i=abs(n):-1:1
        A(-i+abs(n)+1) = cellstr(char(randi([97 122],1,i)));
    end
    
end