close all;


%Fyzikalni konstanty
rho = 1000
g = 9.81

%Nelinearity, offsety
hoff= 0.045 %nebo 0.5 kdo vi
uN= 0.05


%Staticka charakteristika
u= [0.3 0.35 0.4 0.45 0.5 0.55 0.6]
h= [0.067 0.123 0.1914 0.275 0.376 0.489 0.573]
kc= rho*g*(h+hoff)./(u-uN).^2
kc=  18931 


%%%%%%%%%%%%%%%%%%%%%%Prepust leva%%%%%%%%%%%%%%%%%%%%%%
load ('./WERKSPEJS/mereni_16_04/Ciste_prubehy/h2_prepust')

dhdt = (diff(h2(:))./diff(time(:)))';
c= -dhdt./sqrt(h2(1:end-1))
c_mean= mean(c)
c_rms = rms(c)
C= -0.02

%GRAPH
plot(time, h2)
hold on
%plot(time(1:end-1),  c)
t= linspace(7,64, 467)
plot(t, h2_nolinear2(:,2))
title ("Identifikace parametru c");
xlabel('Time t[s]','FontSize',12);
ylabel('h2 [m]','FontSize',12);
legend({'h2\_orig(t)', 'h2\_sim(t)'},'Location','best');
return



%%%%%%%%%%%%%%%%%%%%%%Vypust leva%%%%%%%%%%%%%%%%%%%%%%
load('./WERKSPEJS/mereni_16_04/Ciste_prubehy/h1_vypustleva')

dhdt = (diff(h1(:))./diff(time(:)))';
a= -dhdt./sqrt(h1(1:end-1) +hoff)
a_mean= mean(a)
a_rms = rms(a)
A = -0.066

%GRAPH
plot(time, h1)
hold on
%plot(time(1:end-1),  a)
t= linspace(8.4,30.4, 1550)
plot(t, h1_sim(:,2))
title ("Identifikace parametru a");
xlabel('Time t[s]','FontSize',12);
ylabel('h1 [m]','FontSize',12);
legend({'h1\_orig(t)', 'h1\_sim(t)'},'Location','best');
return



%%%%%%%%%%%%%%%%%%%%%%Vypust prava%%%%%%%%%%%%%%%%%%%%%%
load('./WERKSPEJS/mereni_16_04/Ciste_prubehy/h2_vypustprava')

dhdt = (diff(h2(:))./diff(time(:)))';
b= -dhdt./sqrt(h2(1:end-1))
b_mean= mean(b)
b_rms = rms(b(60:200))
B= -0.0144

plot(time, h2)
hold on
%plot(time(1:end-1),  b)
t= linspace(12.4,72.4, 491)
plot(t, h2_nolinear(:,2))
title ("Identifikace parametru b");
xlabel('Time t[s]','FontSize',12);
ylabel('h2 [m]','FontSize',12);
legend({'h2\_orig(t)', 'h2\_sim(t)'},'Location','best');
return
