clear all; close all; clc;
%% Calculate state space matrixes
a = 0.078;
c = 0.02;
b = 0.013;
d = 2.2;

h2off = 0;
h1off = 0.04;
uN = 0.05;
5
u0 = 0.4;
h10 = 0.17;
h20 = 0.05;
vT = 1;
vO = 1;

dh1dh1 = -a*( 1/( 2*sqrt( abs(d*(u0 - uN)^2 -(h10 + h1off) ) )) ) - vT*b*( 1/(2*sqrt(h10-h20)) )
dh1dh2 = vT*b*( 1/(2*sqrt(h10-h20)) )

dh2dh1 = vT*c*( 1/(2*sqrt(h10-h20)) )
dh2dh2 = -vT*c*( 1/(2*sqrt( h10 - h20 )) ) - vO*b*(1/(2*sqrt(h20)))

dh1du  = a*( ( d*(u0 - uN) )/(( sqrt(d*(u0-uN)^2 - ( h10 - h1off ) ) ) ) )
dh1dvt = -c*sqrt(h10 - h20)
dh1dvo = 0;

dh2du = 0;
dh2dvt = c*sqrt(h10 - h20)
dh2dvo = -b*sqrt(h20 - h2off)

A = [dh1dh1 dh1dh2; dh2dh1 dh2dh2]
B = [ dh1du dh1dvt dh1dvo; dh2du dh2dvt dh2dvo ]
C = [1 0; 0 1];
D = [ 0 0 0; 0 0 0];








