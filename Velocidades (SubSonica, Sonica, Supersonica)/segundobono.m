clc;       
clear all; 

velObject=343;%% m/s
velOnda=343;%%m/s

tmax=500;%%s

tiempos=[];
posiciones=[];

for t=1:tmax
    %%---------------------------------------------
    posObject=velObject*t;
    
    %%---------------------------------------------
    if length(posiciones)>=4
        tiempos(5)=tiempos(4);
        posiciones(5)=posiciones(4);           
    end
    
    if length(posiciones)>=3
        tiempos(4)=tiempos(3);
        posiciones(4)=posiciones(3);           
    end
    
    if length(posiciones)>=2
        tiempos(3)=tiempos(2);
        posiciones(3)=posiciones(2);          
    end
    
    if length(posiciones)>=1
        tiempos(2)=tiempos(1);
        posiciones(2)=posiciones(1);           
    end
    
    tiempos(1)=t;
    posiciones(1)=posObject; 
    %%-----------------------------------------------------
    if length(posiciones)==5
        yc=0;
        n=50;
        %%-------------1---------------------
            xc1=posiciones(1); %% Centro
            r1=velOnda*(t-tiempos(1)); %% y radio
            k1=0:n; 
            fi1=2*pi*k1/n;
            x1=xc1+r1*cos(fi1); 
            y1= yc+r1*sin(fi1);
        %%-------------2---------------------
            xc2=posiciones(2); %% Centro
            r2=velOnda*(t-tiempos(2)); %% y radio
            k2=0:n; 
            fi2=2*pi*k2/n;
            x2=xc2+r2*cos(fi2); 
            y2= yc+r2*sin(fi2);
        %%-------------3---------------------
            xc3=posiciones(3); %% Centro
            r3=velOnda*(t-tiempos(3)); %% y radio
            k3=0:n; 
            fi3=2*pi*k3/n;
            x3=xc3+r3*cos(fi3); 
            y3= yc+r3*sin(fi3);
        %%-------------4---------------------
            xc4=posiciones(4); %% Centro
            r4=velOnda*(t-tiempos(4)); %% y radio
            k4=0:n; 
            fi4=2*pi*k4/n;
            x4=xc4+r4*cos(fi4); 
            y4= yc+r4*sin(fi4);
        %%-------------5---------------------
            xc5=posiciones(5); %% Centro
            r5=velOnda*(t-tiempos(5)); %% y radio
            k5=0:n; 
            fi5=2*pi*k5/n;
            x5=xc5+r5*cos(fi5); 
            y5= yc+r5*sin(fi5);

        plot(posObject,0,'oblack',x1,y1,'-b',x2,y2,'-b',x3,y3,'-b',x4,y4,'-b',x5,y5,'-b');
        title('BONO 2 PROGRAMACION ONDAS (0.5)');
        ax1=-1*(velOnda*(t-tiempos(5)));
        ax2=(velOnda*(t-tiempos(5)));
        
        ax3=posObject+(ax2);
        ax4=posObject-(3*ax2);
        axis([ax4 ax3 ax1 ax2]);
        grid;
    end
    M(t) = getframe;
end

disp('ejecucion terminada');