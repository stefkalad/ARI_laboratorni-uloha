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
kc = mean(kc)
kc=  18931 

%Vypust leva nadrz
h10= 0.066
alpha= 0.2
a = 2* alpha*sqrt(h10 + hoff)


%Vypust prava nadrz
h20= 0.175
beta=0.0435
b= 2*beta *sqrt(h20 + hoff)

%GRAPHS vypust prava
load('./WERKSPEJS/prepust','ty')
time = ty(4300:5200,1)-934;

%u = ty(4300:5200,2)'
horig = ty(4300:5200,4)';

dhdt = (diff(horig(:))./diff(time(:)))';
b= -dhdt./sqrt(horig(1:900)+hoff)
mean(b)

t = linspace(0, 110, 901);
hlin = 0.175*exp(-t/23);

plot(time, horig)
hold on
plot(t,hlin)
plot(vypustprava(:,1),vypustprava(:,2))

return





%GRAPHS vypust leva
load('./WERKSPEJS/vypustleva','ty')
START= 8700
END= 9200
time = (ty(START:END,1)-1820.4)';
u = ty(START:END,2)';
h = ty(START:END,3)';

dhdt = (diff(h(:))./diff(time(:)))';

a_vector = dhdt./sqrt(abs(kc*uN^2/(rho * g)-h(1:END-START) -hoff));
a= mean(a_vector)

plot(time, u)
hold on
plot(time, h)
plot(time(1:500), dhdt);

%LINEARIZED
t = linspace(0, 20, 1000);
hlin = 0.115*exp(-0.2*t) - 0.047;
plot(t,hlin)


plot(vypustleva(:,1),vypustleva(:,2))
return 






%GRAPHS vypust leva
load('./WERKSPEJS/prepust','ty')
time = ty(:,1);
line1 = ty(:,2)';
line1 = line1(:);

line2 = ty(:,3)';
line2 = line2(:);

time1 = time';
time1 = time1(:);

plot(time1, line1)
hold on
plot(time1, ty(:,3)')
plot(time1, ty(:,4)')
plot(time1, ty(:,5)')
plot(time1, ty(:,6)')















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

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
