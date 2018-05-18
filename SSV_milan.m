clear all; close all; clc;


%% Calculate state space matrixes
% A= [-1.08 0.022; 0.022 -0.051]
% B= [0.848 -0.0057 0; 0 0.0057 -0.0058];
% C= [0 0; 0 1]

a_con = 0.075;
c_con = 0.02;
b_con = 0.013;
d_con = 2.4;

a= a_con; b= b_con;
c= c_con; d= d_con;

h2off = 0;
h1off = 0.045;
uN = 0.05;

u0 = 0.4;
h10 = 0.18;
h20 = 0.08;
vT = 1;
vO = 1;

dh1dh1 = -a*( 1/( 2*sqrt( abs(d*(u0 - uN)^2 -(h10 + h1off) ) )) ) - vT*b*( 1/(2*sqrt(h10-h20)) )
dh1dh2 = vT*b*( 1/(2*sqrt(h10-h20)) )

dh2dh1 = vT*c*( 1/(2*sqrt(h10-h20)) )
dh2dh2 = -vT*c*( 1/(2*sqrt( h10 - h20 )) ) - vO*b*(1/(2*sqrt(h20)))

dh1du = a*( ( d*(u0 - uN) )/(( sqrt(d*(u0-uN)^2 - ( h10 - h1off ) ) ) ) )
dh1dvt = -c*sqrt(h10 - h20)
dh1dvo = 0;

dh2du = 0;
dh2dvt = c*sqrt(h10 - h20)
dh2dvo = -b*sqrt(h20 - h2off)

A = [dh1dh1 dh1dh2; dh2dh1 dh2dh2]
B = [ dh1du dh1dvt dh1dvo; dh2du dh2dvt dh2dvo ]
C = [1 0; 0 1];
D = [ 0 0 0; 0 0 0];


%%
Ts= 30;
OS= 20;
zeta = -log(OS/100)/sqrt(pi^2 + (log(OS/100))^2);
omega= 4/(zeta * Ts);

pCL(1) = -zeta*omega + i*omega*sqrt(1-zeta^2)
pCL(2) = -zeta*omega - i*omega*sqrt(1-zeta^2)
pCL(3) = -1
%Kn=acker(A,B(:,1),[pCL(1),pCL(2),pCL(3)])

% transfer u to h2
Hol = tf(ss(A,B(:,1),C(2,:),0))
[b,a] = ss2tf(A,B(:,1),C(2,:),0)

%[At, Bt, Ct, Dt] = tf2ss(b,a)

An = [A zeros(2,1); -C(2,:) 0]
Bn = [B(:,1); 0]
Cn = [C(2,:) 0];

Cr = [Bn An*Bn An*An*Bn]

Kn=acker(An,Bn,[pCL(1),pCL(2),pCL(3)])
Kn= [5 5 -1.4]

%% PD regulator
Hreg = tf([4],[1 2.82 4])
PM = atan(2*zeta/(sqrt(-2*zeta^2 + sqrt(1+4*zeta^4))))
angle = PM/pi*180
H = Hol*Hreg
%bode(H)
%grid on

omegad = 0.5
abs_H_dB = -35.7
abs_H = 10^(abs_H_dB/20)

kp_PD = 1/(sqrt(2)*abs_H)
kd_PD = 1/(omegad*sqrt(2)*abs_H)

load("WERKSPEJS_REGULATORS/pd_test")
siz=0;
for i=1:size(ty(:,1))
    if ty(i,4) >= 0
        siz = siz+1;
    end
end
h2_real_PD = zeros(siz,2);
u_real_PD=zeros(siz,2);

counter=0;
for i=1:size(ty(:,1))
    if ty(i,4)>=0
        counter = counter+1;
        h2_real_PD (counter,2) = ty(i,4);
        h2_real_PD (counter,1) = ty(counter,1);
        u_real_PD (counter,2) = ty(i,2);
        u_real_PD (counter,1) = ty(counter,1);
      
    end
end


%h2_real_PD=[ty(:,1) ty(:,4)];
%u_real_PD=[ty(:,1) ty(:,2)];

%% PID regulator
load("WERKSPEJS_REGULATORS/pid_test")
%h2_real_PID=[ty(:,1) ty(:,4)];
%u_real_PID=[ty(:,1) ty(:,2)];

siz=0;
for i=1:size(ty(:,1))
    if ty(i,4) >= 0
        siz = siz+1;
    end
end
h2_real_PID = zeros(siz,2);
u_real_PID=zeros(siz,2);

counter=0;
for i=1:size(ty(:,1))
    if ty(i,4)>=0
        counter = counter+1;
        h2_real_PID (counter,2) = ty(i,4);
        h2_real_PID (counter,1) = ty(counter,1);
        u_real_PID (counter,2) = ty(i,2);
        u_real_PID (counter,1) = ty(counter,1);
      
    end
end


[Ku, Fk, wu, wf] = margin(H)
Tu = 2*pi/wu
%kp_PID = 0.6*Ku
%ki_PID = Tu/2
%kd_PID = Tu / 8
kp_PID = 7
ki_PID = 0.8
kd_PID = 30

%% PI regulator
load("WERKSPEJS_REGULATORS/pi_test")

siz=0;
for i=1:size(ty(:,1))
    if ty(i,4) >= 0
        siz = siz+1;
    end
end
h2_real_PI = zeros(siz,2);
u_real_PI=zeros(siz,2);

counter=0;
for i=1:size(ty(:,1))
    if ty(i,4)>=0
        counter = counter+1;
        h2_real_PI (counter,2) = ty(i,4);
        h2_real_PI (counter,1) = ty(counter,1);
        u_real_PI (counter,2) = ty(i,2);
        u_real_PI (counter,1) = ty(counter,1);
      
    end
end
    
%h2_real_PI=[ty(:,1) ty(:,4)];
%u_real_PI=[ty(:,1) ty(:,2)];
%kp_PI = 4.4816;
%ki_PI = 0.2801
%konstanty odladene
%REAL MODEL 
kp_PI=2.6
ki_PI=0.3
%OUR MODEL
kp_PI=6.74
ki_PI=0.561



