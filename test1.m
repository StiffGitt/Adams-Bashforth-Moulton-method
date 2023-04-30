function   test1()
% Projekt 1, zadanie 06
% Mikołaj Wałachowski, 320748
%
%Sprawdzenie zbieżności metody dla wybranych funkcji
xspan = [0 1];
n = 100;
Sx = cell(4,1);
Fx = cell(4,1);
Y0x = cell(4,1);
Fx{1} = {@(x) 1,@(x) sin(x),@(x) cos(x)};
Fx{2} = {@(x) 3*exp(5*x),@(x) -12,@(x) -4,@(x) 1};
Fx{3} = {@(x) 9*exp(2*x),@(x) -2,@(x) -3,@(x) 0,@(x) 1};
Fx{4} = {@(x) x^2,@(x) -1,@(x) 0,@(x) 0, @(x) 0, @(x) 1};

Y0x{1} = [0;1];
Y0x{2} = [0;1;1];
Y0x{3} = [0;1;1;1];
Y0x{4} = [0;1;1;1;1];

Sx{1} = @(x) sin(x) + cos(x);
Sx{2} = @(x) 3*exp(6*x)/4 - 3*exp(5*x)/7 + 19./(28*exp(2*x));
Sx{3} = @(x) x.*exp(2*x) - 2*exp(2*x)/9 + (5*x/3 + 11/9)./exp(x);
Sx{4} = @(x) -cos(x) + 3/2*exp(x) + 1./(2*exp(x)) - x.*x;

fprintf("Test mający na celu sprawdzenie poprawności " + ...
    "metody,\ndla wybranych równań różniczkowych różnych rzędów\n" + ...
    "Wykresy przedstawiają przybliżenia obliczone badaną " + ...
    "metodą\nnaniesione na wykres dokładnego rozwiązania RRZ.\n" + ...
    "Metoda będzie wykonana na przedziale [0 1] dla 100 iteracji.\n")
Fstr = ["cos(x)y' + sin(x)y = 1","y'' - 4y' - 12y = 3e^(5x)",...
    "y''' - 3y' - 2y = 9e^(2x)","y^(IV) - y = x^2"];
Ystr = ["y(0) = 1","y(0) = 1, y'(0) = 1","y(0) = 1, y'(0) = 1, " + ...
    "y''(0) = 1", "y(0) = 1, y'(0) = 1, y''(0) = 1, y'''(0) = 1"];
Sxstr = ["y(x) = sin(x) + cos(x)","y(x) = 3*exp(6*x)/4 - " + ...
    "3*exp(5*x)/7 + 19/28*exp(2*x)", ...
    "y(x) = x*exp(2*x) - 2*exp(2*x)/9 + (5*x/3 + 11/9)/exp(x)", ...
    "y(x) = -cos(x) + 3/2*exp(x) + 1/(2*exp(x)) - x*x"];
for i = 1:4
    pause;
    fprintf("\nRównanie: %s,\ndla przybliżeń początkowych: %s\n", ...
        Fstr(i),Ystr(i));
    figure(i)
    Y = P1Z06_MWA_adams_bashforth_moulton(Fx{i},Y0x{i},xspan,n);
    X = Y(1,:);
    Y = Y(2,:);
    Ys = Sx{i}(X);
    plot(X,Ys,X,Y,'o');
    title(Sxstr(i))
    xlim([0 1.2])
    err = max(abs(Y - Ys));
    fprintf("Maksymalny błąd globalny: %f\n",err)
end
pause
close all
end

