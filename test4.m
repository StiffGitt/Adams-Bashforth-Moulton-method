function test4()
% Projekt 1, zadanie 06
% Mikołaj Wałachowski, 320748
%
% Test sprawdzający skutki wyłączenia korektora.
xspan = [0 1];
n = 1000;
Sx = cell(4,1);
Fx = cell(4,1);
Y0x = cell(4,1);
Fx{1} = {@(x) 1,@(x) sin(x),@(x) cos(x)};
Fx{2} = {@(x) 3*exp(5*x),@(x) -12,@(x) -4,@(x) 1};
Fx{3} = {@(x) 9*exp(2*x),@(x) -2,@(x) -3,@(x) 0,@(x) 1};
Fx{4} = {@(x) x^2,@(x) -1,@(x) 0,@(x) 0, @(x) 0, @(x) 1};
Fx{5} = {@(x) 3*x*exp(-3*x)-2*exp(3*x).*cos(x),@(x) 10,@(x) 6,@(x) 1};

Y0x{1} = [0;1];
Y0x{2} = [0;1;1];
Y0x{3} = [0;1;1;1];
Y0x{4} = [0;1;1;1;1];
Y0x{5} = [0;1;1];

Sx{1} = @(x) sin(x) + cos(x);
Sx{2} = @(x) 3*exp(6*x)/4 - 3*exp(5*x)/7 + 19./(28*exp(2*x));
Sx{3} = @(x) x.*exp(2*x) - 2*exp(2*x)/9 + (5*x/3 + 11/9)./exp(x);
Sx{4} = @(x) -cos(x) + 3/2*exp(x) + 1./(2*exp(x)) - x.*x;
Sx{5} = @(x) (-(exp(6*x) - 79).*sin(x) - (3*exp(6*x) - 63) ...
    .*cos(x))./(60*exp(3*x)) + (3*x)./exp(3*x);

Fstr = ["cos(x)y' + sin(x)y = 1","y'' - 4y' - 12y = 3e^(5x)",...
    "y''' - 3y' - 2y = 9e^(2x)","y^(IV) - y = x^2",...
    "y'' + 6y' + 10y = 3x*exp(-3x) - 2*exp(3x)*cos(x)"];
Ystr = ["y(0) = 1","y(0) = 1, y'(0) = 1","y(0) = 1, y'(0) = 1, " + ...
    "y''(0) = 1", "y(0) = 1, y'(0) = 1, y''(0) = 1, y'''(0) = 1", ...
    "y(0) = 1, y'(0) = 1"];

fprintf("Test sprawdzający skutki wyłączenia korektora.\n" + ...
    "Dla podanych funkcji sprawdzony zostanie maksymalny " + ...
    "błąd globalny\nz " + ...
    "włączonym korektorem i po wyłączeniu korektora.\n" + ...
    "Spodziewanym wynikiem jest mniejszy błąd przy włączonym" + ...
    " korektorze,\nco świadczy o poprawnym działaniu wzoru" + ...
    " Adamsa-Moultona.\n" + ...
    "Metoda będzie wykonana na przedziale [0 1] dla 1000 iteracji.\n")

for i = 1:5
    pause;
    fprintf("\nRównanie: %s,\nPrzybliżenia początkowe: %s\n" + ...
        "\n",Fstr(i),Ystr(i));
    Y = P1Z06_MWA_adams_bashforth_moulton(Fx{i},Y0x{i},xspan,n);
    X = Y(1,:);
    Y = Y(2,:);
    Ys = Sx{i}(X);
    err = max(abs(Y-Ys));
    fprintf("Maksymalny błąd globalny z korektorem: ")
    disp(err)
    Y = P1Z06_MWA_adams_bashforth_moulton(Fx{i},Y0x{i},xspan,n,false);
    X = Y(1,:);
    Y = Y(2,:);
    Ys = Sx{i}(X);
    err = max(abs(Y-Ys));
    fprintf("Maksymalny błąd globalny bez korektora: ")
    disp(err)
end

end

