clc;                             % borra la ventana de comandos/consola
clear;                           % borra  el espacio de memoria (workspace)
close all;                       % cierra todas la ventanas (graficas )

import casadi.*

% crea un problema de optimización vacio 
opti = casadi.Opti();

% defina las variables
x = opti.variable();
% y = ...

% defina la función objectivo
f = x^2 - 2*x ;

% Indicar tipo de optimización mon o max, aún no realiza la minimización opti.minimize(f)                      
% opti.minimize(x^2 - 2*x) también funciona 

% defina la restricciones. Para incluir varias restriccione, solo llame esta 
% función varias veces
% opti.subject_to(   x >= 1.5);
% opti.subject_to( x < 8)

% defina el solucionador
opti.solver('ipopt')                    % Usa IPOPT como solucionador

% solucione el problema de optimizacion
sol = opti.solve();

% lea e imprima la solución 
xopt = sol.value(x);

disp(' ')
if strcmp(sol.stats.return_status, 'Resuelto con exito')      % Si casadi regresa exito
    disp(['Solución óptima encontrada: x = ' num2str(xopt)]);
else
    disp('Problema falló')
end

