close all;

%% Plot SZV
ty=ScopeData3;
graph =[];
time = ty(:,1);
graph(1) = plot(time, ty(:,2),'LineWidth',2);   %h2_linear
hold on
graph(2) = plot(time, 0.5*ty(:,3), 'LineWidth',2,'LineStyle',':');  %u_linear
graph(3) = plot(time, ty(:,4),'LineWidth',2);       %h2_nolinear
graph(4) = plot(time, 0.5*ty(:,5),'LineWidth',2,'LineStyle',':');       %u_nolinear

hold off
grid on;
ylim([0, 0.27]);
xlabel('Time t[s]','FontSize',15);
ylabel('Amplitude [-]','FontSize',15);
legend({'h2\_linear(t)','0.5 * u\_linear(t)','h2\_nolinear(t)','0.5* u\_nolinear(t)',},'Location','best');
title('Test Regulátoru navrženým stavovou zpětnou vazbou');

return

%% Plot PID
ty=ScopeData1;
graph =[];
time = ty(:,1);
graph(1) = plot(time, ty(:,2),'LineWidth',2);   %h2_linear
hold on
graph(2) = plot(time, 0.5*ty(:,3), 'LineWidth',2,'LineStyle',':');  %u_linear
graph(3) = plot(time, ty(:,4),'LineWidth',2);       %h2_nolinear
graph(4) = plot(time, 0.5*ty(:,5),'LineWidth',2,'LineStyle',':');       %u_nolinear
graph(5) = plot(time, ty(:,6),'LineWidth',2); %h_real
graph(6) = plot(time, 0.5*ty(:,7),'LineWidth',2, 'LineStyle',':'); %u_real

hold off
grid on;
ylim([-0.1, 0.35]);
xlabel('Time t[s]','FontSize',15);
ylabel('Amplitude [-]','FontSize',15);
legend({'h2\_linear(t)','0.5 * u\_linear(t)','h2\_nolinear(t)','0.5* u\_nolinear(t)','h\_real', 'u\_real'},'Location','best');
title('Test PID regulátoru');

return




%% Plot PD
ty=ScopeData2;
graph =[];
time = ty(:,1);
graph(1) = plot(time, ty(:,2),'LineWidth',2);   %h2_linear
hold on
graph(2) = plot(time, 0.3*ty(:,3), 'LineWidth',2,'LineStyle',':');  %u_linear
graph(3) = plot(time, ty(:,4),'LineWidth',2);       %h2_nolinear
graph(4) = plot(time, 0.3*ty(:,5),'LineWidth',2,'LineStyle',':');       %u_nolinear
graph(5) = plot(time, ty(:,6),'LineWidth',2); %h_real
%graph(6) = plot(time, 0.3*ty(:,7),'LineWidth',2, 'LineStyle',':'); %u_real

hold off
grid on;
ylim([-0.1, 0.35]);
xlabel('Time t[s]','FontSize',15);
ylabel('Amplitude [-]','FontSize',15);
legend({'h2\_linear(t)','0.5 * u\_linear(t)','h2\_nolinear(t)','0.5* u\_nolinear(t)','h\_real', 'u\_real'},'Location','best');
title('Test PD regulátoru');



%% Plot PI
ty=ScopeData;
graph =[];
time = ty(:,1);
graph(1) = plot(time, ty(:,2),'LineWidth',2);   %h2_linear
hold on
graph(2) = plot(time, 0.5*ty(:,3), 'LineWidth',2,'LineStyle',':');  %u_linear
graph(3) = plot(time, ty(:,4),'LineWidth',2);       %h2_nolinear
graph(4) = plot(time, 0.5*ty(:,5),'LineWidth',2,'LineStyle',':');       %u_nolinear
graph(5) = plot(time, ty(:,6),'LineWidth',2); %h_real
graph(6) = plot(time, 0.5*ty(:,7),'LineWidth',2, 'LineStyle',':'); %u_real

hold off
grid on;
ylim([-0.1, 0.35]);
xlabel('Time t[s]','FontSize',15);
ylabel('Amplitude [-]','FontSize',15);
legend({'h2\_linear(t)','0.5 * u\_linear(t)','h2\_nolinear(t)','0.5* u\_nolinear(t)','h\_real', 'u\_real'},'Location','best');
title('Test PI regulátoru');
return


