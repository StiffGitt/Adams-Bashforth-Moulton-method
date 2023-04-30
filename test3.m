function test3()
% Projekt 1, zadanie 06
% Mikołaj Wałachowski, 320748
%
% Test sprawdzający zbieżność metody dla równań różniczkowych,
% których rozwiązaniam jest funkcja wielomianowa.
xspan = [0 1];
n = 100;
Sx = cell(4,1);
Fx = cell(4,1);
Y0x = cell(4,1);
Fx{1} = {@(x) 1,@(x) 0,@(x) 1};
Fx{2} = {@(x) 1,@(x) 0,@(x) 0,@(x) 1};
Fx{3} = {@(x) 1,@(x) 0,@(x) 0,@(x) 0,@(x) 1};
Fx{4} = {@(x) 1,@(x) 0,@(x) 0,@(x) 0, @(x) 0, @(x) 1};
Fx{5} = {@(x) -1,@(x) 0,@(x) 0,@(x) -1,@(x) 3};
Fx{6} = {@(x) 5*x + 3,@(x) 0,@(x) 1};
Y0x{1} = [0;1];
Y0x{2} = [0;1;1];
Y0x{3} = [0;1;1;1];
Y0x{4} = [0;1;1;1;1];
Y0x{5} = [0;1;1;1];
Y0x{6} = [0;1];

Sx{1} = @(x) x + 1;
Sx{2} = @(x) x.*x/2 + x + 1;
Sx{3} = @(x) (x.^3)/6 + (x.^2)/2 + x + 1;
Sx{4} = @(x) (x.^4)/24 + (x.^3)/6 + (x.^2)/2 + x + 1;
Sx{5} = @(x) x.*x/2 + x + 1;
Sx{6} = @(x) 5*x.*x/2 + 3*x + 1;

Fstr = ["y' = 1","y'' = 1"," y''' = 1", ...
    "y^(IV) = 1", "3y''' - y'' = -1", "y' = 5x + 3"];
Ystr = ["y(0) = 1","y(0) = 1, y'(0) = 1","y(0) = 1, y'(0) = 1, " + ...
    "y''(0) = 1", "y(0) = 1, y'(0) = 1, y''(0) = 1, y'''(0) = 1", ...
    "y(0) = 1, y'(0) = 1, y''(0) = 1","y(0) = 1"];
Sxstr = ["y(x) = x + 1","y(x) = (x^2)/2 + x + 1","y(x) = (x^3)/6" + ...
    " + (x^2)/2 + x + 1","y(x) = (x^4)/24 + (x^3)/6 + (x^2)/2 + x + 1", ...
    "y(x) = (x^2)/2 + x + 1","y(x) = 5(x^2)/2 + 3x + 1"];

fprintf("Test sprawdzający zbieżność metody dla równań różniczkowych" + ...
    ",\nktórych rozwiązaniam jest funkcja wielomianowa.\n" + ...
    "Zgodnie z własnościami metody drugiego rzędu, przy równaniach" + ...
    "\ndla których rozwiązaniem jest wielomian maksymalnie " + ...
    "drugiego rzędu,\nbłąd powinien być zerowy.\n" + ...
    "Metoda będzie wykonana na przedziale [0 1] dla 100 iteracji.\n")


for i = 1:6
    pause;
    fprintf("\nRównanie: %s,\nPrzybliżenia początkowe: %s\n" + ...
        "Rozwiązanie równania: %s\n",Fstr(i),Ystr(i),Sxstr(i));
    Y = P1Z06_MWA_adams_bashforth_moulton(Fx{i},Y0x{i},xspan,n);
    X = Y(1,:);
    Y = Y(2,:);
    Ys = Sx{i}(X);
    err = max(abs(Y - Ys));
    fprintf("Maksymalny błąd globalny: ")
    disp(err)
end


end

