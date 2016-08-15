clc;
clear all;
t=[-0.02:0.0000001:0.02];

%%pruebas -----------------------------------------------------------------

Vmax=25; %%voltaje maximo
Vmin=0; %%voltaje minimo

%%-------------------------------------------------------------------------
%%punto 4 -----------------------------------------------------------------

%Vmax=25; %%voltaje maximo
%Vmin=15; %%voltaje minimo

%%-------------------------------------------------------------------------
%%Punto 7 -----------------------------------------------------------------

%Vmax=12; %%voltaje maximo
%Vmin=4; %%voltaje minimo

%%-------------------------------------------------------------------------
%%punto 10 -----------------------------------------------------------------

%Ec1=16; %%valores punto 9
%Em1=6.4; %%valores punto 9

%Vmax=Ec1+Em1; %%voltaje maximo
%Vmin=Ec1-Em1; %%voltaje minimo

%%-------------------------------------------------------------------------
%%frecuencia de las señales -----------------------------------------------

fc=5000;%% frecuencia de la portadora
fm=100;%% crecuencia maxima de la señal modulante

%%-------------------------------------------------------------------------
%%Calculos ----------------------------------------------------------------

Ec=(1/2)*(Vmax+Vmin); %%Amplitud maxima ddel voltaje de la portadora no modulada
Em=(1/2)*(Vmax-Vmin); %%cambio maximo de amplitud de la forma de onda del voltaje de salida
m=Em/Ec;%% coeficiente de modulacion

AC=(m*Ec)/2; %% Amplitud del lado inferior y lado superior

w=2*pi*fc; %%frecuencia Angular
w1=2*pi*(fc+fm);%%frecuencia Angular lado superior
w2=2*pi*(fc-fm);%%frecuencia Angular lado inferior

V1=(Ec*sin(w*t))-(AC*cos(w1*t))+(AC*cos(w2*t)); %%ecuacion de voltaje respecto al tiempo

%%-------------------------------------------------------------------------

plot (t,V1,'b');
grid on 
hold on



