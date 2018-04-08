clear all;
close all;

rho = 1000
g = 9.81
kc= 1

alpha = 1
beta = 1
gama =1
delata = 1



%Saturations
hoff = 1;
un = 1;


%Working point
h1 = 1; h2 = 1;
u=1;
vt = 1;
vd=1;


%Parameters to calculate
syms S Su So Sv


alpha = Su/(2*S * sqrt(2*kc/rho *(u-un)^2  - rho*g *(h1 - hoff))) * g * rho
beta  = Su/(2*S * sqrt(2*kc/rho *(u-un)^2  - rho*g *(h1 - hoff))) * 4 * kc *u / rho
gama  = St/S * sqrt(2*g) *vt / (2*sqrt(h1-h2)) %pro h2 je zaporne
delta = So/S * vd / (2*sqrt(h2))
