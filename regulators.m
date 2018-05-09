

POLE = -1
%A= [-1.08 0.022; 0.022 -0.051]
%B= [0.848 -0.0057 0; 0 0.0057 -0.0058];
%C= [0 0; 0 1]

%Vypocet charakteristickeho polynomu
Ts= 30;
OS= 20;
zeta = log(OS)/sqrt(pi^2 + (log(OS))^2);
omega= 4/(zeta * Ts);
%poles = -zeta*omega +i*omega*sqrt(1-zeta^2)



%charakteristicky polynom CL
aCL= [1 2*zeta*omega omega^2];
[zCL,pCL,KCL]= tf2zp(1,aCL)


%charakteristicky polynom OL
[b, a] = ss2tf(A,B,C,[0 0; 0 0]');
[z,p,k]= tf2zp(b,a);



%% ACKER
%Acker from noncanonical
Kn=acker(A,B,[pCL(1),pCL(2)])

%Transformace souradnic
Ax= [-a(2) -a(3); 1 0];
Bx= [1; 0];
Cx= [b(2) b(3)];
[b,a] = ss2tf(Ax, Bx, Cx,0);
%Acker from canonical
Kc=acker(Ax,Bx,[pCL(1),pCL(2)])


CON= [B A*B];
CONx= [Bx Ax*Bx];
T= CON*inv(CONx);
K1= [aCL(2)-a(2) aCL(3)-a(3)]
K= K1*inv(T)


%% INTEGRALNI RIZENI

%01 Rozsireni popisu - velka matice
An= [A zeros(2,1); -C 0];
Bn= [B; 0]; Cn= [C 0]; Bref= [0;0;1];

%charakteristicky polynom CL
aCL= conv([1 2*zeta*omega omega^2],[1 -POLE]);
[zCL,pCL,KCL]= tf2zp(1,aCL);

%charakteristicky polynom OL
[b, a] = ss2tf(An,Bn,Cn,0)
[z,p,k]= tf2zp(b,a);


%Acker from noncanonical
KIn=acker(An,Bn,[pCL(1),pCL(2), pCL(3)])

%Transformace souradnic
Cx= [b(2) b(3) b(4)];
Ax= [-a(2) -a(3) -a(4); 1 0 0; -Cx]
Bx= [1; 0; 0];

[b,a] = ss2tf(Ax, Bx, Cx,0);
%Acker from canonical
KIc=acker(Ax,Bx,[pCL(1),pCL(2), pCL(3)])


CON= [Bn An*Bn An^2*Bn];
CONx= [Bx Ax*Bx Ax^3*Bx];
T= CON*inv(CONx);
KIc= [aCL(2)-a(2) aCL(3)-a(3) aCL(4)-a(4)]
KIn= KIc*inv(T)




