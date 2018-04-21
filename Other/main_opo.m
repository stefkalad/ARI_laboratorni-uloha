% sloupce 1:t, 2:motor, 3: h1, 4:h2, 5: vypust, 6: proporcionalni

%TODO: zmerit offset u h2

saturace_motor = [0,1]; %[min,max]
saturace_ventil = [0.31,1]; %[min,max]
offset1 = 0.07637 % odecteno
offset2 = -0.06864 % pri zadani 0.226 na pump
h2 = 0.006

%total_offset = offset2 - offset1
u = [ 0.045 0.048 0.05 0.053 0.055 0.08 0.065 0.072 0.07 0.068 0.066 0.065 0.09 0.3 0.5 0.6 0.61 0.65 1 0.605 0.35 0.25 0.2 0.4];
h1 = [0.029 0.029 0.029 0.029 0.029 0.0312 0.0298 0.0314 0.030 0.030 0.030 0.029 0.032 0.1374 0.44 0.678 0.7 0.7 0.7 0.7 0.21 0.10 0.07 0.2779];
u_N = 0.066
u = sort(u)
h1 = sort(h1)
plot(u,h1,'LineWidth',1.5)
hold on;
koef = polyfit(u,h1,2)
x = 0 : 0.01 : 1;
%plot(x,x.^2*koef(3) + x * koef(2) + koef(1))
%%
%proporcionální na 1
h_1_pok = 0.766 
h_2_pok = 0.729  
delta_t=76.25
st_1 = 1/((delta_t-su*sqrt(2*h_1_pok/g))* 1/sqrt(2*h_2_pok/g))
%------------
%proporcionální na 0.75
h_1_pok = 0.766 
h_2_pok = 0.729  
delta_t=78.75
st_075 = 1/((delta_t-su*sqrt(2*h_1_pok/g))* 1/sqrt(2*h_2_pok/g))
%-----------------------
polyfit([1 0.75 0.5],[st_1 st_075 st_05],2)
fit = polyval(polyfit([1 0.75 0.5 0.32],[st_1 st_075 st_05 0],3 ),[1,0.75,0.5,0.32])
plot([1 0.75 0.5 0.32],fit,[1,0.75,0.5,0.32],[st_1 st_075 st_05 0])
legend('1','2')
% otevreny proporcionalni velntyl na 0.5
u = [0 0.2 0.3 0.35 0.4 0.6 0.63];
h1 = [0.045 0.016 0.044 0.097 0.160 0.553 0.642];
h2 = [0 0 0.037 0.087 0.153 0.551 0.642];
x_1_0 = 0.16
x_2_0 = 0.153
%% static
plot(u,h1,u,h2,'LineWidth',1.5)
title('statická pøevodní chrakteristika')
xlabel('vstupní signál èerpadla [-]')
ylabel('výstupní signál výšky hladiny [-]')
legend('h_1 pøi v_t = 0','h_1 pøi v_T = 0.5', 'h_2 pøi v_T = 0.5', 'Location','southeast')
grid on


%%
u_0 = 0.4
rho = 1000
g = 9.81
v_T_0 = 0.5
v_o_0 = 1
kc = (1000*9.81*(0.5344+offset1))/(0.55-u_N)^2
prac_in = [u_0; v_T_0; v_o_0]
prac_out = [x_1_0;x_2_0]

A = [(-su*(g/(sqrt((2/rho)*(kc*(u_0-u_N)^2 - rho*g*(x_1_0+offset1)))))-(v_T_0*st)*(g/(sqrt(2*g*(x_1_0-x_2_0))))) ((v_T_0*st)*(g/(sqrt(2*g*(x_1_0-x_2_0)))));
     ((v_T_0*st)*(g/(sqrt(2*g*(x_1_0-x_2_0))))) (-(v_T_0*st)*(g/(sqrt(2*g*(x_1_0-x_2_0))))-((v_o_0*so*g)/(sqrt(2*g*(x_2_0+offset2)))))]
 

B = [su*(2/rho * kc *(u_0 - u_N))/(sqrt(2/rho * (kc * (u_0 - u_N)^2 - rho * g * (x_1_0 - offset1)))) -st * sqrt(2*g*(x_1_0 - x_2_0)) 0;
     0 st*sqrt(2*g*(x_1_0-x_2_0)) -so*sqrt(2*g*(x_2_0-offset2))]
C = eye(2)
D = zeros(2,3)
%% konstanty
tu = 56.3 - 34.5
hu = 0.5346 - 0.02811
g = 9.81;
su = 1.1*sqrt(2*hu/g)/tu

to = 207-108.2
ho = 0.5003 - 0.07055
so = 1.1*sqrt(2*ho/g)/to

ts = abs(301.2 - 376)
hs2 = 0.5082 - 0.07282;
hs1 = 0.5164 - 0.02974
st_05 = 1.1/((ts-su*sqrt(2*hs1/g))* 1/sqrt(2*hs2/g))
st = st_05/(0.5-saturace_ventil(1))*(1-saturace_ventil(1))

