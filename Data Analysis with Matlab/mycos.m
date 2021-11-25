% WRITE HERE YOUR FUNCTION FOR EXERCISE 3

function mycos(num1,num2)

Color = input("Select any one color (Red==1/Green==2/Blue==3): ");
Style = input("Select style of points (Circle==1/ Star==2): ");
if Color == 1
    if Style ==1
        S = 'r-*';
    else
        S= 'r-o';
    end
    
elseif Color == 2
    if Style ==1
        S = 'g-*';
    else
        S= 'g-o';
    end
    
else
    if Style ==1
        S = 'b-*';
    else
        S= 'b-o';
    end
    
end

subplot(2,1,1);
plot(cos([-pi:2*pi/(num1-1):pi]),S)
title([num1,"points"]);

subplot(2,1,2);
plot(cos([-pi:2*pi/(num2-1):pi]),S)
title([num2,"points"]);

end