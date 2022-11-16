% Problema de la cadena colgante con BFGS y retroceso
clear; close all; clc;

plotFigures = true;

N     = 40;         % Número de puntos de las masa (libres)      
tol   = 1E-3;       %  tolerancia de comvergencia     
maxit = 5000;       %  número máximo de iteraciones

% Definición de las resctricciones como una estructura
param.L = 1;
param.D = (70/40)*N;
param.m = 4/N;
param.g = 9.81;
param.N = N;

% Puntos de los extremos de la cadena 
param.xi = [-2 1];          % inicial (y1, z1)
param.xf = [ 2 1];          % final   (yN, zN)

% Valor inicial:  interpolación lineal entre los extremos
y = linspace(param.xi(1), param.xf(1), N+2)';
z = linspace(param.xi(2), param.xf(2), N+2)';
% Eliminación de los extremos de las variables de decisión y apilar estas juntas 
x = reshape([y(2:end-1) z(2:end-1)].',2*N,1);

% Aproximación inicial de la Hessiana
B = eye(length(x));

% Obtener el valor objetivo y el gradiente en el punto inicial
% PARA HACER: ESCRIBA AQUI SU FUNCIÓN DE DIFERENCIA_FINITA 

[F, J] = diferencia_finita(@cc_obj, x, param);

% Verifique si la fución que escribió es correta
if F > 46.93 || F < 46.92 || norm(J) > 6.21 || norm(J) < 6.20  
    error(' Los resultados de su function diferencia_finita.m para el valor inicial no son correctos.')
end

% Imprime la cabecera: No de iteración, norma del gradiente, valor objectivo, norma del paso, tamaño de paso
fprintf('It.  \t | ||grad_f||| f\t\t | ||dvar||\t | t  \n');

% Bucle principal 
for k = 1 : maxit
    
    % PARA HACER: OBTENGA LA DIRECCION DE BUSQUEDA dx USANDO lAS 'B' Y 'J' ACTUALES
    dx = ...;
    
    % Parametros  para el retroceso con regla de  Armijo
    t     = 1.0;    % longitud de paso inicial 
    beta  = 0.8;    % factor de encojimiento
    gamma = 0.1;    % decrecimiento mínimo requerido 

    x_new = x + t * dx; % candidato para el siguiente paso 

    % PARA HACER: IMPLEMENTE SU  CONDICION DE ARMIJO CON RETROCESO AQUI 
    %       (SIGUA REDUCIENDO 't' Y ACTUALIZANDO 'x_new' HASTA QUE SE CUMPLA LA CONDICIÓN)
  
    % Asigne el paso
    [F_new, J_new] = finite_difference(@hc_obj, x_new, param);
        
    % PARA HACER: ACTUALICE SU APROXIMACIÓN 'B' DE LA HESSIAN UTILIZANDO LA FÓRMULA BFGS AQUÍ (SOLO PARA LA PARTE c) 
        
    % Actualice las variables
    x = x_new;
    J = J_new;
    F = F_new;

    % Cada 10 iteraciones imprima la cabecera de nuevo 
    if mod(k,10) == 0
        fprintf('\n');
        fprintf('It.  \t | ||grad_f||| f\t\t | ||dvar||\t | t  \n');
    end
    
    % Imprime alguna información importante 
    fprintf('%d\t | %f\t | %f\t | %f\t | %f \n', k, norm(J), F, norm(dx), t);
    
    % Graficar
    if plotFigures
        y = x(1:2:2*N);
        z = x(2:2:2*N);
        % Graficar  
        figure(1)
        subplot(2,1,1), plot(y, z,'b--');hold on;
        subplot(2,1,1), plot(y, z, 'Or'); hold off;
        xlim([-2, 2])
        ylim([ -3, 1])
        title('Posición de la cadena en la iteración actual')
        subplot(2,1,2), plot(dx)
        title('Paso completo de cada variable de optimización (dz_i)')
        drawnow;
    end
    if norm(J) < tol
        disp('Convergencia lograda.');
        break
    end
end
if k == maxit
    disp(' Se alcanzó el número máximo de iteraciones. Resultado probablemente no óptimo.')
end

% Grafique la solución óptima 
figure(1)
y = x(1:2:2*N);
z = x(2:2:2*N);
subplot(2,1,1), plot(y, z, 'b--');hold on;
title('Posición de la cadena en la solución óptima')
subplot(2,1,1), plot(y, z, 'Or'); hold off;
xlim([-2, 2])
ylim([ -3, 1])
