% Write your code here

function membersplot(st1,st2)
X = categorical({'ME';'BM';'CE';'EE'});
X = reordercats(X,{'ME';'BM';'CE';'EE'});
dept = ['ME';'BM';'CE';'EE'];
qty = [22;45;23;33];
 
subplot(1,2,1)
switch st1
    case 'bar'
        bar(X,qty)
        grid on
        ylabel 'Number of faculty menbers'
    case 'barh'
        
        barh(X,qty)
        grid on
        xlabel 'Number of faculty menbers'
    case 'pie'
        pie(qty,dept)
        title ('Faculty members by department')
end


subplot(1,2,2)
switch st2
    case 'bar'
        bar(X,qty)
        grid on
        ylabel 'Number of faculty menbers'
    case 'barh'
        
        barh(X,qty)
        grid on
        xlabel 'Number of faculty menbers'
    case 'pie'
        pie(qty,dept)
        title ('Faculty members by department')
end

end

