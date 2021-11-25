% Write your code here

function myplotarea(file_name,n)

file= readtable(file_name);
X = file{:,2};
Y = file{:,4};
if n>length(X)
    warning(" value of n is greater ")
    return
end
area(X(1:n),Y(1:n));
xlabel 'x';
ylabel 'y';

title(n+" data Points")


end