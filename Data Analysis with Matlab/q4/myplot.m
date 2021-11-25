% Write your code here

function myplot(x,y)
load('plot_properties.mat')

subplot(3,1,1)
plot(x,y,'Color',plot_properties(1).plotproperties.Color,'LineWidth',plot_properties(1).plotproperties.LineWidth,'LineStyle',plot_properties(1).plotproperties.LineStyle)
subplot(3,1,2)
bar(x,y,'BarWidth',plot_properties(2).plotproperties.BarWidth,'FaceColor',plot_properties(2).plotproperties.FaceColor,'EdgeColor',plot_properties(2).plotproperties.EdgeColor)
subplot(3,1,3)
barh(x,y,'BarWidth',plot_properties(3).plotproperties.BarWidth,'FaceColor',plot_properties(3).plotproperties.FaceColor,'EdgeColor',plot_properties(3).plotproperties.EdgeColor)
end

