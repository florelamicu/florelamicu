% WRITE HERE YOUR FUNCTION FOR EXERCISE 1

function  detail = waferstore(part_numbers,quantities,costs)

if length(part_numbers)~=length(quantities)
    warning('length of array is not equal');
    return;
end

if length(part_numbers)~=length(costs)
    warning('length of array is not equal');
    return;
end

for i=1:length(costs)
    detail(i).partno = part_numbers(i);
    detail(i).quantity = quantities(i);
    detail(i).costper = costs(i);
    disp([detail(i).partno,detail(i).quantity*detail(i).costper]);
end

end