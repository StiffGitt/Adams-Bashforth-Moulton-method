function numtest2()
% Projekt 1, zadanie 06
% Mikołaj Wałachowski, 320748
%
% Test porównujący błędy korektora w zależności od kroku całkowania.
figure
hold on
xspan = [0 1];
Fx = {@(x) 0,@(x) 4,@(x) 0,@(x) 0, @(x) 0, @(x) 1};
Y0x = [0;100;0;0;0];
Sx = @(x) (50*(exp(2*x) + 1).*cos(x))./exp(x);

Fstr = ["y^{(IV)} + 4y = 0","cos(x)y' + sin(x)y = 1",...
    "y^{(IV)} - y = x^2"];


N = 10:100;
h = (xspan(2)-xspan(1))./N;
l = length(N);
errMax = zeros(1,l);
errMax2 = zeros(1,l);
deltMax = zeros(1,l);

for i = 1:l
    Y = P1Z06_MWA_adams_bashforth_moulton(Fx,Y0x,xspan,N(i));
    Y2 = P1Z06_MWA_adams_bashforth_moulton(Fx,Y0x,xspan,N(i),false);
    X = Y(1,:);
    Y = Y(2,:);
    Y2 = Y2(2,:);
    Ys = Sx(X);
    errMax(i) = max(abs(Y - Ys));
    errMax2(i) = max(abs(Y2 - Ys));
    deltMax(i) = max(abs(Y-Y2)./Y);
end
plot(h,deltMax)

Fx = {@(x) 1,@(x) sin(x),@(x) cos(x)};
Y0x = [0;1];
Sx = @(x) sin(x) + cos(x);

h = (xspan(2)-xspan(1))./N;
l = length(N);
errMax = zeros(1,l);
errMax2 = zeros(1,l);
deltMax = zeros(1,l);

for i = 1:l
    Y = P1Z06_MWA_adams_bashforth_moulton(Fx,Y0x,xspan,N(i));
    Y2 = P1Z06_MWA_adams_bashforth_moulton(Fx,Y0x,xspan,N(i),false);
    X = Y(1,:);
    Y = Y(2,:);
    Y2 = Y2(2,:);
    Ys = Sx(X);
    
    errMax(i) = max(abs(Y - Ys));
    errMax2(i) = max(abs(Y2 - Ys));
    deltMax(i) = max(abs(Y-Y2)./Y);
    
end
plot(h,deltMax)



Fx = {@(x) x^2,@(x) -1,@(x) 0,@(x) 0, @(x) 0, @(x) 1};
Y0x = [0;1;1;1;1];
Sx = @(x) -cos(x) + 3/2*exp(x) + 1./(2*exp(x)) - x.*x;

h = (xspan(2)-xspan(1))./N;
l = length(N);
errMax = zeros(1,l);
errMax2 = zeros(1,l);
deltMax = zeros(1,l);

for i = 1:l
    Y = P1Z06_MWA_adams_bashforth_moulton(Fx,Y0x,xspan,N(i));
    Y2 = P1Z06_MWA_adams_bashforth_moulton(Fx,Y0x,xspan,N(i),false);
    X = Y(1,:);
    Y = Y(2,:);
    Y2 = Y2(2,:);
    Ys = Sx(X);
    errMax(i) = max(abs(Y - Ys));
    errMax2(i) = max(abs(Y2 - Ys));
    deltMax(i) = max(abs(Y-Y2)./Y);
end
plot(h,deltMax)

title("Zależność błędu predyktora od długości kroku całkowania")
legend(Fstr(1:3),'Location','northwest')
xlabel("h")
ylabel("\epsilon")
xlim([0.01 0.1])
grid on
hold off
end

