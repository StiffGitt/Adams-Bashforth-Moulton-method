function F = CellToFunc(Fx)
% Projekt 1, zadanie 06
% Mikołaj Wałachowski, 320748
%
% Funkcja pomocnicza przekształcająca tablicę komórek Fx, zdefiniowaną w
% funkcji bazowej, do uchwytu do funkcji F postaci zdefiniowanej poniżej
% Wejście:
%   Fx     - tablica komórek zawierających uchwyty do funkcji,
%          - w której F{1} = @(x) b(x) oraz F{i+1} = @(x) a_i(x)
% Wyjście:
%   F      - uchwyt do funkcji, przyjmującej jako argument wektor Y,
%          - postaci Y = [y1 y2 ... y(m + 1)], zwracana funkcja jest 
%          - zdefiniowana jako F(Y) = [1 y3 y4 ... f(y1,y2,...,y(m + 1))]

ord = length(Fx) - 1;
% Pomocnicza tablica komórek zawierająca uchwyty do funkcji, postaci
% fi(Y) = F(Y)(i), gdzie F(Y)(i) to i-ty element wektora zwracanego dla 
% wywołania funkcji F(Y)
fcel = cell(ord,1); 

% Wypełnienie pierwszych ord - 1 komórek odpowiednimi uchwytami do funkcji
fcel{1} = @(y) 1;
for i = 2:ord - 1
    fcel{i} = (@(y) y(i + 1));
end

% Funkcja pomocnicza tworząca funkcję odpowiednią dla ostatniej komórki
function out = Fvector(Y)
         out = Fx{1}(Y(1));
         for k = 2:length(Y)
             out = out - Fx{k}(Y(1))*Y(k);
         end
         out = out/Fx{length(Y) + 1}(Y(1));
end
% Wpisanie uchwytu do funkcji Fvector(Y) do ostatniej komórki
fcel{ord} = @Fvector;

% Zdefiniowanie F jako funkcji, która dla danego wektora Y, wywołuję każdą
% z funkcji zapisanych w tablicy komórek fcel
F = @(Y) cellfun(@(f)f(Y),fcel);
end % function

