close all;

% Get the data from Simulink
% First column is the time signal
Sim_data=ty;
time = Sim_data(:,1);



length(time);
size (Sim_data)
signals = Sim_data(:,2:end);

% Plot signal
graph =[];
graph(1) = plot(time,signals(:,1));
hold on
graph(2)= plot(time,signals(:,2));
graph(2)= plot(time,signals(:,3));
graph(2)= plot(time,signals(:,4));
graph(2)= plot(time,signals(:,5));
hold off


% Lines width in the graph
%set(graph,'LineWidth',3);
% Changes linestyle. Four options are available {'-';'--';'-.';'none'}
%set(graph,{'LineStyle'},{'-';'-'});
%set(graph,{'Color'},{'r';'b'});
% Specify markers of the plot
%set(graph,{'Marker'},{'none';'x'},'Markersize',15);

% Change the hiearchy of ploted lines
uistack(graph(1), 'bottom')

% Font size of the legend
set(gca,'FontSize',15);
% Signals description and position of the legend
legend(graph ,{'input(t)','output(t)'},'Location','SouthEast');

% Axes description
xlabel('Time t[s]','FontSize',15);
ylabel('y [-]','FontSize',15);
title('Odezva systému na skok');

% Do this only if you want to change the implicit limits
%x_plot_limits = [0 10];
%y_plot_limits = [0 1.2];

%xlim(x_plot_limits);
%ylim(y_plot_limits);

% Turn on the grid
grid on; 


%% Export to files
file = 'file_to_export'
% srt dimensipon for a PDF export
set(gcf, 'PaperUnits', 'centimeters ',  'OuterPosition', [150, 50, 1300, 850], 'PaperType', 'A4', 'PaperOrientation', 'landscape');
set(gcf,'Position', [200,100,1200,800]);
%set landscape figure for pdf export
set(gcf,'PaperPositionMode','Auto', 'PaperOrientation', 'Landscape')
%save pdf
%print(gcf, '-dpdf', strcat(file, '.pdf'), '-r0');
%save eps
print(gcf, '-depsc2', strcat(file, '.eps'));
%save png
%han = getframe(gcf);
%imwrite(han.cdata, strcat(file, '.png'));