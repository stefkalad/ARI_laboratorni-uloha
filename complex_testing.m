%load ('./WERKSPEJS/mereni_16_04/Test_data/complex_test')
%load ('./WERKSPEJS/mereni_16_04/Test_data/ventil_test')
%load ('./WERKSPEJS/test_vt')
%load ('./WERKSPEJS/okolo_prac_bodu')
%graph created for linear model
%load ('./WERKSPEJS/okoli_prac_bodu_vse_otevrene')


load ('./WERKSPEJS/meranie_23_04/cut_test_okolie_PB_1_propor_0_digital')
%ty= vypustleva;
[sim_u sim_vo sim_vt sim_h1 sim_h2]= parse2simulink(ty);

%simulink run

sim('MIMO_linearized_simulink_model.slx');

%% Identification graphs
%Levý tank
time = ty(:,1);
plot (time,ty(:,2),'LineWidth',2); %VOLTAGE
hold on
plot (time,ty(:,3), 'LineWidth',2, 'LineStyle','-');    %H1
plot (time,0.5 *ty(:,4), 'LineWidth',2);   %H2
plot (h1_lin_sim.time,h1_lin_sim.data);
plot (h2_lin_sim.time,h2_lin_sim.data);

y_plot_limits = [0 1];
ylim(y_plot_limits)
grid on; 
%legend({'u(t)', 'h1\_orig','h1nolinear\_(t)'},'Location','best');
title("Vypouštění a napouštění levého tanku");
xlabel('Time t[s]','FontSize',12);
ylabel('h1 [m]','FontSize',12);
return




