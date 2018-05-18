clear;clc;close all;
syms s
format compact

A =	[-0.1013  0.0420; 0.0420 -0.0997];
B = [0.1410 -0.0039 0;0 0.0039 -0.0250];
C = [1 0; 0 1];
D = [0 0 0 ;0 0 0];
filter = tf([4],[1 2.82 4]);

h=tf(ss(A,B,C,D));
set(h,'InputName',{'voltage','transfer ventil','output ventil'},...
        'OutputName',{'height 1','height 2'})
display(h(2,1));
G=h(2,1);
Gf = G*filter

%% pi regulator
prekmit = 20;
zeta = (-1*log(prekmit/100))/(sqrt(pi^2 + (log(prekmit/100))^2));
PM = (atan((2*zeta)/(sqrt(-2*zeta^2+sqrt(1+4*zeta^4)))))*180/pi;

%root locus
disp('pi rl');
% rltool(Gf)%dumping ratio 0.4559, add integrator, add real zero -0.065 zosilenie 0.23982
rlocus(Gf*tf([0.23982/0.065 0.065],[1 0]))
Kp=0.23982/0.065;
Ki=0.065;
C = tf([Kp Ki],[1 0]);
step((Gf*C)/(1+Gf*C))
title('pi root locus')

%frekvencna metoda
disp('pi frek')
omega=0.08071;
gain=2.75;
bodePI(Gf,gain,omega,PM);
Kp1=gain/sqrt(2)
Ki1=omega*Kp1
C1 = tf([Kp1 Ki1],[1 0]);figure;
step((Gf*C1)/(1+Gf*C1))
title('pi frekvencna')



%% pd regulator
prekmit = 20;
zeta = (-1*log(prekmit/100))/(sqrt(pi^2 + (log(prekmit/100))^2));
PM = (atan((2*zeta)/(sqrt(-2*zeta^2+sqrt(1+4*zeta^4)))))*180/pi;

%frekvencna metoda
disp('pd frek')
omega = 0.505;
gain=44.412;
bodePD(Gf,gain,omega,PM);
Kp=gain/sqrt(2)
Kd=Kp/omega
C = tf([Kd Kp],[1]);
figure;
step((Gf*C)/(1+Gf*C))
title('pd frekvencna')

%root locus
disp('pd rl')
% rltool(Gf)%dumping ratio 0.4559, add real zero -0.6 zosilenie 21.814
Kp1=21.814
Kd1=21.814/0.6
C1 = tf([Kd1 Kp1],[1]);
figure;
step((Gf*C1)/(1+Gf*C1))
title('pd root locus')


%% PID regulator siegler-nichoslova metoda
prekmit = 20;
bode(Gf)
zeta = (-1*log(prekmit/100))/(sqrt(pi^2 + (log(prekmit/100))^2));
PM = (atan((2*zeta)/(sqrt(-2*zeta^2+sqrt(1+4*zeta^4)))))*180/pi;

%frekvencna metoda
disp('pid frek')
bode(Gf)
omega_d = 0.432;
omegai=0.1*omega_d
gain=33.4965;
Kd1=gain/omega_d/sqrt(2)
Kp1 = 1.1*omega_d*Kd1
Ki1=0.1*Kd1*omega_d^2
C1 = tf([Kd1 Kp1 Ki1],[1 0]);
bodePID(Gf,gain,omega_d,omegai,PM);
figure;
step((Gf*C1)/(1+Gf*C1))
title('pid fekvencna')


%siegler nicholson some overshoot
disp('pid s-n no overshoot')
[Gm,~,omega_Gm,~] = margin(Gf)
Tk = 2*pi/omega_Gm;
Kp = 0.33*Gm
Ti = 0.5*Tk;
Td = 0.33*Tk;
Ki = Kp/Ti
Kd = Kp*Td
C = tf([Kd Kp Ki],[1 0]);
step((Gf*C)/(1+Gf*C))
title('pid s-n no overshoot')


%siegler nichols classic
disp('pid s-n nclassic')
Kp2 = 0.7*Gm
Ti2 = 0.5*Tk;
Td2 = 0.125*Tk;
Ki2 = Kp2/Ti2
Kd2 = Kp2*Td2
C2 = tf([Kd2 Kp2 Ki2],[1 0]);
figure
step((Gf*C2)/(1+Gf*C2))
title('pid s-n nclassic')


%% stavova spatna vazba
A =	[-0.1013  0.0420; 0.0420 -0.0997];
B = [0.1410 -0.0039 0;0 0.0039 -0.0250];
C = [1 0; 0 1];
D = [0 0 0 ;0 0 0];
% vypocet polov cl
prekmit = 20;
zeta = (-1*log(prekmit/100))/(sqrt(pi^2 + (log(prekmit/100))^2))
doba_ustalenia = 40;%odhad
omeg = 4/zeta/doba_ustalenia
pol_1 = -zeta*omeg + i*omeg*sqrt(1-zeta^2)
pol_2 = -zeta*omeg - i*omeg*sqrt(1-zeta^2)
pol_3 = -1


a = A
b = B(:,1)
c = C(2,:)
d = 0

%nove matice
An = [a zeros(2,1);-c 0]
Bn = [b; 0]
Cn = [c  0]
Dn = [0]

% matica riaditelnosti
Cc = [Bn An*Bn An*An*Bn]

% charakteristicky polynom CL
acl = conv([1 2*zeta*omeg omeg^2],[1 -pol_3])

% matica An dosadena do acl
cAn = acl(1)*An^3 + acl(2)*An^2 + acl(3)*An + acl(4)*eye(3)

% vektor stavovej SV
K = [0 0 1]*(Cc\cAn)
K = acker(An,Bn,[pol_1,pol_2,pol_3])


% ustalena odchylka
x = 1 + Cn*((An - Bn*K)\[0;0;1])



%% nic podstatne
% % vypocet polov cl
% prekmit = 20;
% zeta = (-1*log(prekmit/100))/(sqrt(pi^2 + (log(prekmit/100))^2))
% doba_ustalenia = 40;%odhad
% omeg = 4/zeta/doba_ustalenia
% pol_1 = -zeta*omeg + i*omeg*sqrt(1-zeta^2)
% pol_2 = -zeta*omeg - i*omeg*sqrt(1-zeta^2)
% pol_3 = -1
% pol_4 = -1
% pol_5 = -1
% 
% [num denum] = tfdata(Gf,'v')
% [a b c d]=tf2ss(num,denum)
% 
% %nove matice
% An = [a zeros(4,1);-c 0]
% Bn = [b; 0]
% Cn = [c  0]
% Dn = [0]
% 
% % matica riaditelnosti
% Cc = [Bn An*Bn An*An*Bn An*An*An*Bn An*An*An*An*Bn]
% 
% % charakteristicky polynom CL
% acl = conv(conv(conv([1 2*zeta*omeg omeg^2],[1 -pol_3]),[1 -pol_4]),[1 -pol_5])
% 
% % matica An dosadena do acl
% cAn = acl(1)*An^5 + acl(2)*An^4 + acl(3)*An^3 + acl(4)*An^2 + acl(5)*An + acl(6)
% 
% % vektor stavovej SV
% K = [0 0 0 0 1]*(Cc\cAn)
% K = acker(An,Bn,[pol_1,pol_2,pol_3,pol_4,pol_5])
% 
% 
% % ustalena odchylka
% x = 1 + Cn*((An - Bn*K)\[0;0;0;0;1])




% latex(vpa(sym(A),3))
% latex(vpa(sym(B),3))
% latex(vpa(sym(C),3))
% latex(vpa(sym(D),3))
% latex(vpa(sym(a),3))
% latex(vpa(sym(b),3))
% latex(vpa(sym(c),3))
% latex(vpa(sym(d),3))
% latex(vpa(sym(An),3))
% latex(vpa(sym(Bn),3))
% latex(vpa(sym(Cn),3))
% latex(vpa(sym(Dn),3))


