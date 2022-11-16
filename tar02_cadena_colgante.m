clc;                             % borra la ventana de comandos/consola
clear;                           % borra  el espacio de memoria (workspace)
close all;                       % cierra todas la ventanas (graficas )

import casadi.*

% crea un problema de optimización vacio 
opti = casadi.Opti();

N = 40;                     % numero de masas

% PARA HACER : complete la definición de las variablea AQUI
% SUGERENCIA : opti.variable(n) crea un vector columna de tamaño n
%              opti.variable(n,m) crea una matriz n-por-m 
%              luego opti.variable(n,1) es lo mismo que opti.variable(n)
y = 3;
z = 4;

m = 4/N;                    % masa
Di = (70/40)*N;             % constante del resorte 
g0 = 9.81;                  % gravedad

Vcadena = 0;
for i = 1:N
    % PARA HACER: complete la función objetivo (i.e. energia potential) AQUI
    Vcadena = Vcadena + ...;
end

% pasar la funcion objetivo a  opti
opti.minimize(Vcadena)

% PARA HACER: complete la restricción de (igualdad) AQUI
opti.subject_to( ... )
...
   
% Establezca el solucionador y resuelva el problema:
opti.solver('ipopt')
sol = opti.solve();

% obtiene la solution y grafica los resultados 
Y = sol.value(y);
Z = sol.value(z);

figure;
plot(Y,Z,'--or'); hold on;
plot(-2,1,'xg','MarkerSize',10);
plot(2,1,'xg','MarkerSize',10);
xlabel('y'); ylabel('z');
title('Solución óptima de la cadena colgante (sin restricciones extra)')

