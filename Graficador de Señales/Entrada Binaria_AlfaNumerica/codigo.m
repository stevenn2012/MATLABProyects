function parcial=codigo(valor)
clc;
disp('Estado de ejecucion de codigo:');
entrada=[];
for i=1:length(valor)
    entrada(i)=str2num(valor(i));
end
%entrada=[0 1 0 1 0 0 0 1 1 0 1];
%entrada=[1 1 1 1 0 0 0 0 1 1 0 0 1 0 1 0];

cadena=[];
puntero=1;
titulo='Cadena de bits: ';
for i=1:length(entrada)
    cadena(puntero)=entrada(i);
    cadena(puntero+1)=entrada(i);
    puntero=puntero+2;
    titulo=strcat(titulo,num2str(entrada(i)));
end

%UNRZ-----------------------------------------------------------------------
disp('Graficando Unipolar NRZ...');
for i=1:length(cadena)
    xValues=[(i-1) i];
    yValues=[cadena(i) cadena(i)];
    hold on;
    subplot(9,1,1)
    plot(xValues,yValues,'r') 
    axis([0 length(cadena) -2 2])
    ylabel('NRZ');
    grid on
    if (i~=length(cadena)) && (cadena(i)~=cadena(i+1))
        xValues=[i i];
        yValues=[0 1];
        line(xValues,yValues);
        hold on;
        plot(xValues,yValues,'r')
    end    
end
title(titulo);
%PNRZ-----------------------------------------------------------------------
disp('Graficando Polar NRZ...');
for i=1:length(cadena)
    if(cadena(i)==0)
        v1=-1;
    else
        v1=1;
    end
    xValues=[(i-1) i];
    yValues=[v1 v1];
    hold on;
    subplot(9,1,2)
    plot(xValues,yValues,'b') 
    axis([0 length(cadena) -2 2])
    ylabel('PNRZ');
    grid on
    if (i~=length(cadena)) && (cadena(i)~=cadena(i+1))
        xValues=[i i];
        yValues=[1 -1];
        line(xValues,yValues);
        hold on;
        plot(xValues,yValues,'b')
    end    
end

%Clock---------------------------------------------------------------------
disp('Graficando Clock...');
for i=1:length(cadena)
    if(mod(i,2)~=0)
        v1=1;
    else
        v1=0;
    end
    xValues=[(i-1) i];
    yValues=[v1 v1];   
    hold on;
    subplot(9,1,3)
    plot(xValues,yValues,'r') 
    axis([0 length(cadena) -2 2])
    ylabel('Clock');
    grid on
    xValues=[i i];
    yValues=[0 1];
    line(xValues,yValues);
    hold on;
    plot(xValues,yValues,'r')   
end

%Manchester----------------------------------------------------------------
disp('Graficando Manchester...');

clock=1;
for i=1:length(cadena)
    if cadena(i)==clock
        v1=-1;
    else
        v1=1;
    end
    xValues=[(i-1) i];
    yValues=[v1 v1];   
    hold on;
    subplot(9,1,4)
    plot(xValues,yValues,'b') 
    axis([0 length(cadena) -2 2])
    ylabel('Mter');
    grid on
    
    if i~=length(cadena) && cadena(i)==cadena(i+1)
        xValues=[i i];
        yValues=[-1 1];
        line(xValues,yValues);
        hold on;
        plot(xValues,yValues,'b') 
    end
    if clock==0
        clock=1;
    else
        clock=0;
    end
end

%Unipolar RZ---------------------------------------------------------------
disp('Graficando Unipolar RZ...');

validar=0;
for i=1:length(cadena)
    if cadena(i)==0 || validar==1
        v1=0;
        validar=0;
    else
        v1=1;
        if cadena(i)==1 && validar==0
            validar=1;
        end
    end
    xValues=[(i-1) i];
    yValues=[v1 v1];
    hold on;
    subplot(9,1,5)
    plot(xValues,yValues,'r') 
    axis([0 length(cadena) -2 2])
    ylabel('URZ');
    grid on
    if (i~=length(cadena)) && ((v1~=cadena(i+1)) || validar==1)
        xValues=[i i];
        yValues=[0 1];
        line(xValues,yValues);
        hold on;
        plot(xValues,yValues,'r')
    end    
end

%Bipolar RZ----------------------------------------------------------------
disp('Graficando Bipolar RZ...');

for i=1:length(cadena)

    if cadena(i)==0
        v1=-1;
    else 
        v1=1;
    end
    
    if mod(i,2)==0
        v1=0;
    end
    
    xValues=[(i-1) i];
    yValues=[v1 v1];
    hold on;
    subplot(9,1,6)
    plot(xValues,yValues,'b') 
    axis([0 length(cadena) -2 2])
    ylabel('BRZ');
    grid on
    
    xValues=[i i];
       
    if i~=length(cadena)
        if cadena(i)<cadena(i+1) || (cadena(i)==cadena(i+1) && v1==1) || (v1==0 && cadena(i+1)==1)
            yValues=[0 1];
        else
            yValues=[-1 0];
         end
    end
    line(xValues,yValues);
    hold on;
    plot(xValues,yValues,'b')
end

%AMI-----------------------------------------------------------------------
disp('Graficando AMI...');

val=0;
for i=1:length(cadena)
    if mod(i,2)~=0
        if cadena(i)==0
            v1=0;
        else
            if val==0
                v1=1;
                val=1;
            else
                v1=-1;
                val=0;
            end
        end
    end
    
    xValues=[(i-1) i];
    yValues=[v1 v1];
    hold on;
    subplot(9,1,7)
    plot(xValues,yValues,'r') 
    axis([0 length(cadena) -2 2])
    ylabel('AMI');
    grid on
    
    if mod(i,2)==0
        if i~=length(cadena)
            if cadena(i)==1 && cadena(i+1)==1
                xValues=[i i];
                yValues=[-1 1];
                line(xValues,yValues);
                hold on;
                plot(xValues,yValues,'r')
            end
            if (v1==1 && cadena(i+1)==0) || (v1==0 && cadena(i+1)==1 && val==0)
               xValues=[i i];
               yValues=[0 1];
               line(xValues,yValues);
               hold on;
               plot(xValues,yValues,'r')
            end
            if (v1==-1 && cadena(i+1)==0) || (v1==0 && cadena(i+1)==1 && val==1)
               xValues=[i i];
               yValues=[-1 0];
               line(xValues,yValues);
               hold on;
               plot(xValues,yValues,'r')
            end
        end
    end
end
%B8ZS-----------------------------------------------------------------------
disp('Graficando B8ZS...');
bitstream=cadena;
 % B8ZS Bipolar with 8-Zeros Substitution
    %   sample data:
    %     d = [ 1 1 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 1 0 ]
    %   usage:
    %       b8zs(d)
    %   author:
    %       Anastasios Latsas

    % pulse height
    pulse = 5;

    % assume that current pulse level is a "low" pulse; this is
    % the pulse level for the bit before given bitstream
    current_level = -pulse;

    % define violation patterns
    % positive_violation: used when bit before violation has positive pulse
    % negative_violation: used when bit before violation has negative pulse
    positive_violation = [ '0' '0' '0' '+' '-' '0' '-' '+' ];
    negative_violation = [ '0' '0' '0' '-' '+' '0' '+' '-' ];

    bit = 1;
    while bit <= length(bitstream)
        % set bit time
        bt=bit-1:0.001:bit;

        if bitstream(bit) == 0
            % count zeros, if more than 8 found introduce violation
            if consecutive_zeros(bitstream, bit) >= 8
                % select violation pattern according to previous pulse
                if current_level > 0
                    pattern = positive_violation;
                else
                    pattern = negative_violation;
                end

                % operate on each bit of violation pattern array
                for v_bit = 1:8
                    % calculate bit time for violation pattern
                    % we continue from previous index
                    % where 'bit' and 'v_bit' variables are used together
                    % we need to substract 1 because pattern[1] is actually
                    % bitstream[bit]
                    v_bt = (v_bit+bit-2):0.001:(v_bit+bit-1);
                    switch pattern(v_bit)
                        case '0'
                            y = zeros(size(v_bt));
                        case '+'
                            y = (v_bt<v_bit+bit-1) * pulse;
                            current_level = pulse;
                        case '-'
                            y = (v_bt<v_bit+bit-1) * -pulse;
                            current_level = -pulse;
                    end

                    % inspect next bit in violation pattern
                    try
                        if pattern(v_bit + 1) == '+'
                            y(end) = pulse;
                        elseif pattern(v_bit + 1) == '-'
                            y(end) = -pulse;
                        end
                    catch e
                            % violation pattern end, try original data
                            try
                                if bitstream(bit+8) == 1
                                    y(end) = -current_level;
                                end
                            catch e
                                % bitstream end, assume next bit is 1
                                y(end) = -current_level;
                            end
                    end
                    draw_pulse(v_bt, y, pulse, v_bit+bit-1, pattern(v_bit))
                end
                % skip zeros in original data
                bit = bit + 8;
                continue
            else
                % less that 8 zeros found, draw 0
                y = zeros(size(bt));
            end
        else
            % each binary 1 has the opposite pulse level from the previous
            current_level = -current_level;
            y = (bt<bit) * current_level;
        end

        % assign last pulse point by inspecting the following bit
        try
            % we care only about binary 1, zeros will always
            % start at zero level (including violation patterns)
            if bitstream(bit+1) == 1
                y(end) = -current_level;
            end
        catch e
            % bitstream end; assume next bit is 1
            y(end) = -current_level;
        end

        % draw pulse
        draw_pulse(bt, y, pulse, bit, num2str(bitstream(bit)))
        % move to the next bit
        bit = bit + 1;
    end
    % draw grid
    grid on;
    axis([0 length(bitstream) -pulse*2 pulse*2]);
    %set(gca,'YTick', [-pulse 0 pulse])
    %set(gca,'XTick', 1:length(bitstream))
    %set(gca,'XTickLabel', '')
    ylabel('B8ZS');

    % //-------------------------------------------------------------------
    % // sub-functions
    % //-------------------------------------------------------------------

    function draw_pulse(x, y, height, b, bit_label)
        % draw a single pulse and the bit it represents
        % parameters:
        %   x:         bit time (axis x)
        %   y:         pulse levels (axis y)
        %   height:    pulse height
        %   b:         bit index in bitstream array
        %   bit_label: the digit this pulse represents
        subplot(9,1,8);
        plot(x, y, 'LineWidth', 1);
        %text(b-0.5, height+2, bit_label)
        hold on;
    end

    function num = consecutive_zeros(bitstream, pos)
        % count consecutive zeros in an array from given position
        % parameters:
        %   bitstream: array of bits to be searched
        %   pos:       position in the array to start counting
        num = 0;
        for b = pos:length(bitstream)
            if bitstream(b) == 0
                num = num + 1;
            else
                return
            end
        end
    end

%HDB3-----------------------------------------------------------------------
disp('Graficando HDB3...');
xn=cadena;
yn=xn;                                          %Codigo a Modificar
num=0;                                          %variable para contar los 1s y determinar si son pares o impares

num=0;                                           %Reinicio de la variable de conteo de 1s
yh=yn;                                           %Variable nueva del codigo almacenado en yn
sign=0;                                          %Variable de signo
V=zeros(1,length(yn));                           %Variable para guardar las violaciones (V)
B=zeros(1,length(yn));                           %Varible para guardar las B
for k=1:length(yn)
    if yn(k)==0
       num=num+1;                               %Incremento del contador de 0s
         if num== 4                             %Comprueba si hay 4 ceros continuos para realizar el cambio
           num=0;                               %Reestablece el contador de 0s
           yh(k)=1*yh(k-4);                     
           V(k)=yh(k);                      %Guarda los bits de violacion (V)
           if yh(k)==sign                   %Comprueba si el bit yh(k) es igual al signo
              yh(k)=-1*yh(k);               %Invierte el signo para evitar signos iguales en los bits de violacion
              yh(k-3)=yh(k);                %Cambia el primer 0 para generar el codigo B00V
              B(k-3)=yh(k);                 %Guarda las B producidas en hdb3
              V(k)=yh(k);                   %Guarda el bit de violacion con el signo ya invertido
              yh(k+1:length(yn))=-1*yh(k+1:length(yn));%Alterna los signos de los 1s despues de detectar un cambio de signo.              
           end
           sign=yh(k);                         %Guarda el signo de la violacion
         end
       else
          num=0;                            %Reestablece el contador de 0s
      end
end                                         
re=[xn',yn',yh',V',B'];
subplot(9,1,9);
stairs([0:length(xn)-1],yh);
axis([0 length(xn) -2 2]);
ylabel('HDB3');
grid on
parcial=1;
disp('Fin de la ejecucion');
end