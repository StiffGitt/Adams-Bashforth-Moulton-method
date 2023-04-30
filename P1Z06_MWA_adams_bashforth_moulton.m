function Y = P1Z06_MWA_adams_bashforth_moulton(Fx,Y0,xspan,n,usecor)
% Projekt 1, zadanie 06
% Mikołaj Wałachowski, 320748
%
% Rozwiązanie numeryczne liniowego równania różniczkowego dowolnego rzędu
% postaci a_m(x)*y^(m)+...+a_1(x)*y'+a_0(x)*y = b(x), przy użyciu metody
% predykator-korektor Adamsa-Bashfortha-Moultona 2-go rzędu
% Wejście:
%   Fx     - tablica komórek zawierających uchwyty do funkcji,
%          - w której F{1} = @(x) b(x) oraz F{i+1} = @(x) a_i(x)
%   Y0     - wektor zawierający kolejno przybliżenie początkowe x0 oraz
%          - oraz wartości y^(i) dla x0, przy 0 <= i <= m-1
%   xspan  - wektor postaci [a b], gdzie a i b to pierwszy i ostatni węzeł
%   n      - liczba iteracji, czyli n+1 ilość równoodległych węzłów,
%            w których przybliżamy funkcję
%   usecor - wartość logiczna determinująca, czy użyty zostanie korektor,
%          - domyślnie true, czyli korektor włączony
% Wyjście:
%   Y      - macierz rozmiaru 2 na n+1, zawierająca w i-tej kolumnie
%          - kolejno i-ty węzeł oraz przyliżoną wartość funkcji w tym węźle

% Ustawienie opcjonalnego argumentu usecor
if nargin == 4
    usecor = true;
end

% Zainicjowanie potrzebnych stałych oraz wektorów
ord = length(Y0); % Rząd RRZ + 1
h = (xspan(2) - xspan(1))/n; % Krok całkowania
alf = [1.5,-0.5]; % Współczynniki A-B 2-go rzędu
mi = [0.5,0.5]; % Współczynniki A-M 2-go rzędu
Y = zeros(ord,n + 1);
Y(:,1) = Y0;

% Stworzenie funkcji, postaci F(Y) = [1 y3 y4 ... f(y1,y2,...,ym+1)]
F = CellToFunc(Fx);

% Wykonanie pierwszej iteracji zmodyfikowaną metodą Eulera
Y(:,2) = Y0 + h*F(Y0 + h/2*F(Y0));

% Wykonanie pozostałych iteracji metodą Adamsa-Bashfortha-Moultona
for i = 2:n
    Y0 = Y(:,i - 1);
    Y1 = Y(:,i);
    % Predyktor 2-go rzędu Adams-Bashforth
    Yp = Y1 + h*(alf(1)*F(Y1) + alf(2)*F(Y0)); 
    % Korektor 2-go rzędu Adams-Moulton
    if usecor
        Y(:,i + 1) = Y1 + h*(mi(1)*F(Yp) + mi(2)*F(Y1));
    else
        Y(:,i + 1) = Yp;
    end
end
% Wyodrębnienie dwóch pierwszych wierszy macierzy, zwracanych w funkcji
Y = Y(1:2,:);
end % function
