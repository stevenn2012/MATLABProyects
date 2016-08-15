clc;       
clear all;  

%%---------------Datos Linea 1---------------------------------------------
desfase1=0;      %%Desfase
frecuencia1=1500; %%Frecuencia Angular
amplitud1=100;    %%Amplitud

%%---------------Datos Linea 2---------------------------------------------
desfase2=0;      %%Desfase
frecuencia2=10;%%Frecuencia Angular
amplitud2=100;    %%Amplitud

%%---------------Datos del tiempo------------------------------------------
t=0;             %%Tiempo inicial
tmax=1;          %%Tiempo maximo
paso=0.0001;      %%Tamaño del Paso para el Tiempo

%%---------------Vectores y punteros para rastro Linea 1-------------------
px1=[];          %%Guarda posiciones en x para linea 1
py1=[];          %%Guarda posiciones en y para linea 1
nx1=0;           %%controla posicion para el vector px1
ny1=0;           %%controla posicion para el vector py1

%%---------------Vectores y punteros para rastro Linea 2-------------------
px2=[];          %%Guarda posiciones en x para linea 2
py2=[];          %%Guarda posiciones en y para linea 2
nx2=0;           %%controla posicion para el vector px2
ny2=0;           %%controla posicion para el vector py2

%%---------------Controlador del tiempo------------------------------------
i=1;

%%---------------Inicio----------------------------------------------------
while t<tmax

    %%-----------Tiempo Actual Para el Sistema-----------------------------
    t=paso*i

    %%-----------Calculo Posicion Linea 1----------------------------------
    posx1=amplitud1*cos(frecuencia1*t+desfase1); %%Posicion en x linea 1
    posy1=amplitud1*sin(frecuencia1*t+desfase1); %%Posicion en y linea 1
    
    %%-----------Calculo Posicion Linea 2----------------------------------
    posx2=amplitud2*cos(frecuencia2*t+desfase2); %%Posicion en x linea 2
    posy2=amplitud2*sin(frecuencia2*t+desfase2); %%Posicion en y linea 2
   
    %%------------Vectores De Posicion-------------------------------------
    P1=[0 0];                     %%Punto inicial linea 1
    P2=[posx1 posy1];             %%Punto final linea 1, Punto inicial linea 2
    P3=[posx2+posx1 posy2+posy1]; %%Punto final linea 2
    
    %%-------------Vectores del Rastro Linea 1-----------------------------
        px1(nx1+1)=posx1;         %%Guarda posicion linea 1 en x
        py1(ny1+1)=posy1;         %%Guarda posicion linea 1 en y
        nx1=nx1+1;                %%Incrementa puntero de px1
        ny1=ny1+1;                %%Incrementa puntero de py1
     
    %%--------------Vectores del Rastro Linea 2----------------------------
        px2(nx2+1)=posx2+posx1;   %%Guarda posicion linea 2 en x
        py2(ny2+1)=posy2+posy1;   %%Guarda posicion linea 2 en y
        nx2=nx2+1;                %%Incrementa puntero de px2
        ny2=ny2+1;                %%Incrementa puntero de py2
        
    %%---------------Graficacion lineas y rastros actuales-----------------
    plot(0,0,'o',[P1(1) P2(1)],[P1(2) P2(2)],'b',px1',py1','-.green',[P2(1) P3(1)],[P2(2) P3(2)],'black',px2',py2','-red');
    %%grid;   %%Grilla en la ventana
    title('BONO DE ONDAS Y CAMPOS ELECTRO MAGNETICOS (0.7)'); %%Titulo de la grafica
    
    %%---------------Dimensiones de la ventana-----------------------------
    axis([-1*(amplitud1+amplitud2) (amplitud1+amplitud2) -1*(amplitud1+amplitud2) (amplitud1+amplitud2)]);
    
    %%---------------Guardar Frame actual----------------------------------
    M(i) = getframe;  
    
    %%---------------Incremento controlador del tiempo---------------------
    i=i+1;
    
end

%%-------------------Verificacion de fin de ejecucion----------------------
disp('ejecucion terminada');

