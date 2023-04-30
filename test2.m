function test2()
% Projekt 1, zadanie 06
% Mikołaj Wałachowski, 320748
%
% Test badający rząd zastosowanej metody.
fprintf("Test badający rząd zastosowanej metody.\n" + ...
    "Metoda będzie wykonywana dla różnej liczby " + ...
    "iteracji na ustalonym RRZ.\nNastępnie wyliczony " + ...
    "zostanie średni błąd globalny\noraz maksymalny błąd globalny," + ...
    " na podstawie dokładnego rozwiązania RRZ.\nWyliczony " + ...
    "zostanie również iloraz błędów globalnych,\ndla dwóch kolenych" + ...
    " wartości kroku, oznaczony jako stosunek błędów.\n" + ...
    "Metoda zostanie wykonana na przedziale [0 1].\n" )
pause;
Fx = {@(x) 3*x*exp(-3*x)-2*exp(3*x).*cos(x),@(x) 10,@(x) 6,@(x) 1};
Y0x = [0;1;1];
Sx = @(x) (-(exp(6*x)-79).*sin(x)-(3*exp(6*x)-63).*cos(x))./(60*exp(3*x)) ...
    +(3*x)./exp(3*x);
Fxstr = "y'' + 6y' + 10y = 3x*exp(-3x) - 2*exp(3x)*cos(x)";
Y0str = "y(0) = 1, y'(0) = 1";
N1 = [10,40,160,640,2560,2560*4];
N2 = [10,100,1000,10000];
test2_func(Fx,Y0x,Sx,N1,Fxstr,Y0str)
pause;
test2_func(Fx,Y0x,Sx,N2,Fxstr,Y0str)
%Nowa funkcje
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
Fstr = ["cos(x)y' + sin(x)y = 1","y'' - 4y' - 12y = 3e^(5x)",...
    "y''' - 3y' - 2y = 9e^(2x)","y^(IV) - y = x^2"];
Ystr = ["y(0) = 1","y(0) = 1, y'(0) = 1", ...
    "y(0) = 1, y'(0) = 1, y''(0) = 1", ...
    "y(0) = 1, y'(0) = 1, y''(0) = 1, y'''(0) = 1"];

for i = 1:4
    pause;
    test2_func(Fx{i},Y0x{i},Sx{i},N1,Fstr(i),Ystr(i))
end
end

