function [f] = hc_obj(x, param)

% Implementa la funcion obhetivo de la cadena colgante
% Note que solo los puntos de las masas  intermedias son varialbes de descición

% Suponemos que x = [y1, z1, y2, z2 ..., yN, zN].

N = size(x, 1)/2;
y = x(1:2:2*N);
z = x(2:2:2*N);

L   = param.L;
D   = param.D;
m   = param.m;
g   = param.g;
LoN = L / (N+1); % (N+2-1) puesto que el número total de masas es N+2

xi = param.xi;
xf = param.xf;

% Inicializa el potencial 
f = 0;
% Itera sobre los puntos y actualiza el potencial
for k = 1 : N - 1
   f = f + 0.5 * D * (sqrt( ( y(k+1) - y(k) ).^2 + ( z(k+1) - z(k) ).^2 ) - LoN)^2 + m * g * z(k);
end
% Añade la última energía gravitatcional 
f = f + z(end) * m * g;

% Agrega el potencial de los puntos fijo (ahora tenemos un problema no restringido )
f = f + 0.5 * D * sum(sqrt( ( xi(1) - y(1) ).^2   + ( xi(2) - z(1) ).^2   ) - LoN)^2;
f = f + 0.5 * D * sum(sqrt( ( xf(1) - y(end) ).^2 + ( xf(2) - z(end) ).^2 ) - LoN)^2;

end
