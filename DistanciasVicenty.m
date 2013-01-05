disp ( ' ' )
disp ( '---------------------------------- INICIO DEL PROGRAMA ---------------------------------- ' )
disp ( ' ' )
disp ( 'Se Borrará la Ventana de Trabajo y las Variables' )
disp ( ' ' )
disp ( 'Precione Cualquier Tecla Para Continuar' )
disp ( ' ' )

pause
clc 
clear

% PROGRAMA KRIGING-1.
%
% Nombre: Distancia en la Esfera Terrestre Entre Dos Puntos.
% Descripcion: Calcula la matriz de distancia entre los diversos puntos a partir 
% de las coordenadas geográficas con el desarrollo del método inverso de VICENTY 
% aplicado al método de la GRAN DISTANCIA DEL CIRCULO. 
% Realizado por: E. ING. Edwin M. R. Martínez.
% Fecha: 23 de marzo de 2012.
% Nota: En la aplicación de dicho método se espera un error menor al 2%
% del valor real.


%%

% NOTAS:
% 1) Verificar que los datos en el archivo de Excel se encuentran en el
% siguiente formato por columnas y que el resto de las casillas se encuentren libres:
%
% PAIS/EDO/CLAVE/NOMBRE/LONGITUD/LATITUD/DATOS AUXILIARES DE 1 A 7 COLUMNAS MÁXIMO/
% 2) Verificar que sean un máximo de cien puntos por calcular.
% 3) Cambiar el nombre del archivo 'distancias.xls'por el nombre del
% archivo con igual extensión.
% 4) Cambiar el nombre de la hoja 'Hoja' por el nombre de la estación.
% Ambos cambios pueden realizarse presionando Control+F y seleccionando
% remplazar el nombre por el necesario en todo el programa.
% 5) Iniciar el programa y verificar resultados.

%%

Claves = xlsread ( 'Distancias_NL.xls' , '19059' , 'C2:C100' ) ; % Lectura de las Claves de los datos.
Coordenadas = xlsread ( 'Distancias_NL.xls' , '19059' , 'E2:F100' ) ; % Lectura de Coordenadas Geográficas.
longitud = Coordenadas ( : , 1 ) ; % Valor de la longitud geográfica de los puntos.
latitud = Coordenadas ( : , 2 ) ; % Valor de la latitud geográfica de los puntos.

%%

%Comienzo del proceso de calculos del programa.
disp ( 'Iniciando los Cálculos' )
disp ( ' ' )
disp ( 'Espere un Momento' )
disp ( ' ' )

n = length ( longitud ) ; % Lectura del número de datos.
format long  % Arreglo del formato numérico.
D ( 1 , 1 ) = 0 ;

%Arreglo numérico para el tratamiento de la información.
for i = 1 : n 
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    for j = i : n
        % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        if i == j
            
            D (j , i) = 0; % Distancia nula entre un mismo punto.
            
        else % Cálculo de la distancia con el método geodésico.
            % Lectura y acomodo de información para la aplicación de la
            % ecuación principal del método.}
            
            log1 = ( abs ( longitud ( j ) ) * pi ) / 180 ;
            log2 = ( abs ( longitud (i ) ) * pi ) / 180 ;
            lat1 = ( abs ( latitud ( j ) ) * pi ) / 180 ;
            lat2 = ( abs ( latitud ( i ) * pi ) ) / 180 ;
            delta = abs ( log1 - log2 ) ;
            promedio = ( abs ( latitud ( i ) + latitud ( j ) ) ) / 2 ;
            R = 1000 * 6379.57 + abs ( ( 15 -  promedio ) ) * ( 0.782 ) ; % Arreglo del radio terrestre.
            D ( j , i ) = R * atan ( sqrt ( ( cos ( lat2 ) * sin ( delta ) ) ^ 2 + ( cos ( lat1 ) * sin ( lat2 ) - sin ( lat1 ) * cos ( lat2 ) * cos ( delta ) ) ^ 2 ) / ( ( sin ( lat1 ) * sin ( lat2 ) ) + ( cos ( lat1 ) * cos ( lat2 ) * cos ( delta ) ) ) ) ;
            % Ecuación principal de la mezcla de los métodos desarrollada
            % previamente.
            
        end
        % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
end

for i = 1 : n % Impresión de datos de información nula.
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    for j = 1 : n
        
        % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
        if i ~= j
            % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
            if D ( j , i ) == 0
                
                D ( j , i ) = NaN;
                
            end
            % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        end
        % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
end

%%
% Impresión de información final y proceso de guardado en el archivo
% original respectivo.

Excel_1 = xlswrite ( 'Distancias_NL.xls' , 'Matriz de Distancias_Aguascalientes Estación 19059 ' , '19059', 'O1') ;
Excel_2 = xlswrite ( 'Distancias_NL.xls' , Claves' , '19059' , 'O2' ) ; % Imprime las Claves en Forma Transpuesta.
Excel_3 = xlswrite ( 'Distancias_NL.xls' , Claves , '19059' , 'N3' ) ;
Excel = xlswrite ( 'Distancias_NL.xls' , D , '19059' , 'O3' ) ;

disp ( ' ' )
disp ( 'Proceso Terminado' )
disp ( ' ' )
disp ( 'La Matriz se ha Guardado en el Archivo de Excel Correspondiente' )
disp ( ' ' )
disp ( '---------------------------- FIN DEL PROGRAMA ---------------------------- ' )
disp ( ' ' )

format short  % Arreglo del formato numérico.
