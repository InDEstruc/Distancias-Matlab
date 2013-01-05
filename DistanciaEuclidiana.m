clc
clear

% Nombre: Distancia Euclidiana
% Descripcion: Calcula la distancia entre dos puntos para varios puntos
% Fecha: 22 de marzo de 2012

%%
% NOTAS
% 1) Cambiar el nombre del archivo 'distancias.xls'por el nombre del
% archivo con igual extensión
% 2) Cambiar el nombre de la hoja 'Hoja' por el nombre de la estacion


%%

Claves = xlsread('distancias.xls', 'Hoja', 'C2:C100');
Coordenadas = xlsread('distancias.xls', 'Hoja', 'G2:H100');
X = Coordenadas (:,1);
Y = Coordenadas (:,2);
%%
disp('Iniciando calculos')
disp(' ')
disp(' ')

n=length(X);
format long g

for i=1:n-1
    for j=i+1:n
        D(j,i) = sqrt((X(i)-X(j))^2+(Y(i)-Y(j))^2);
        % - - - - -
        
        % - - - - -
    end
end

for i=1:n-1
    for j=1:n
        % - - - - - 
        if D(j,i) == 0
            D(j,i) = NaN;
        end
        % - - - - -
    end
end

%%
Excel= xlswrite('distancias.xls', 'Distancias Euclidianas', 'Hoja', 'O1');
Excel= xlswrite('distancias.xls', Claves', 'Hoja', 'O2');
Excel= xlswrite('distancias.xls', Claves, 'Hoja', 'N3');
Excel= xlswrite('distancias.xls', D, 'Hoja', 'O3');

disp('Proceso Terminado')
