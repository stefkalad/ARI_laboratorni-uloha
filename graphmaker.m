close all;

%load ('./WERKSPEJS/mereni_16_04/Test_data/ventil_test')
%load ('./WERKSPEJS/okoli_prac_bodu_vse_otevrene')
%ty= linearni_model;
%ty2 = model_nelinearni
%[sim_u sim_vo sim_vt sim_h1 sim_h2]= parse2simulink(ty);
ty=ScopeData1;


%% Plot PD
graph =[];
time = ty(:,1);
graph(1) = plot(time, ty(:,2),'LineWidth',2);   %h2_linear
hold on
graph(2) = plot(time, 0.3*ty(:,3), 'LineWidth',2,'LineStyle',':');  %u_linear
graph(3) = plot(time, ty(:,4),'LineWidth',2);       %h2_nolinear
graph(4) = plot(time, 0.3*ty(:,5),'LineWidth',2,'LineStyle',':');       %u_nolinear
graph(5) = plot(time, ty(:,6),'LineWidth',2); %h_real
graph(6) = plot(time, 0.3*ty(:,7),'LineWidth',2, 'LineStyle',':'); %u_real

hold off
grid on;
ylim([-, 0.35]);
xlabel('Time t[s]','FontSize',15);
ylabel('Amplitude [-]','FontSize',15);
legend({'h2\_linear(t)','0.5 * u\_linear(t)','h2\_nolinear(t)','0.5* u\_nolinear(t)','h\_real', 'u\_real'},'Location','best');
title('Test PD regulátoru');
return





%% Plot PI
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
ylim([0, 0.35]);
xlabel('Time t[s]','FontSize',15);
ylabel('Amplitude [-]','FontSize',15);
legend({'h2\_linear(t)','0.5 * u\_linear(t)','h2\_nolinear(t)','0.5* u\_nolinear(t)','h\_real', 'u\_real'},'Location','best');
title('Test PI regulátoru');
return

%% Plot signal from simulink parse
graph =[];
graph(1) = plot(sim_u(:,1), sim_u(:,2));
hold on
graph(2) = plot(sim_h1(:,1), sim_h1(:,2));
graph(3) = plot(sim_h2(:,1), sim_h2(:,2));
graph(4) = plot(sim_vo(:,1), sim_vo(:,2));
graph(5) = plot(sim_vt(:,1), 0.3*sim_vt(:,2));
hold off
grid on; 


