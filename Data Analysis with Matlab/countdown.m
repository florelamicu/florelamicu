% WRITE HERE YOUR FUNCTION FOR EXERCISE 2
% I am getting an error when i try to call the function with the same name
% Reason why i've wrote down countdow, is displaying the result 
global i
i=5;
for i=5:-1:0
    countdow()
end

clear i
function []=countdow()
  global i
  if(i>0)
    X = [num2str(i), ' seconds left'];
    disp(X)
  else
    disp('countdown has expired')
  end
  i=i-1;
end