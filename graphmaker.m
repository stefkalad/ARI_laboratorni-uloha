close all;

%load ('./WERKSPEJS/mereni_16_04/Test_data/ventil_test')
load ('./WERKSPEJS/okoli_prac_bodu_vse_otevrene')
ty= linearni_model;
%ty2 = model_nelinearni
[sim_u sim_vo sim_vt sim_h1 sim_h2]= parse2simulink(ty);


%% Plot signal directly
graph =[];
time = ty(:,1);
graph(1) = plot(time, ty(:,2),'LineWidth',2);
hold on
graph(2) = plot(time, ty(:,3), 'LineWidth',2);
%graph(3) = plot(time, ty2(:,3), 'LineWidth',2);
graph(4) = plot(time, ty(:,4),'LineWidth',2);
graph(5) = plot(time, ty(:,5),'LineWidth',2);
%5graph(6) = plot(time, ty2(:,5), 'LineWidth',2)
graph(7) = plot(time, 0.5*ty(:,6),'LineWidth',2,'LineStyle',':');
graph(8) = plot(time, 0.5*ty(:,7),'LineWidth',2,'LineStyle',':');
graph(9) = plot(time, ty(:,8),'LineWidth',2, 'LineStyle','--');
hold off
grid on;
ylim([0, 0.55]);
xlabel('Time t[s]','FontSize',15);
ylabel('h [m]','FontSize',15);
legend({'h1\_orig(t)','h1\_linear(t)','h2\_orig(t)','h2\_linear(t)','0.5*proportional','0.5* digital','u(t)'},'Location','best');
title('Test lineárního modelu');
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


