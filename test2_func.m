function  test2_func(Fx,Y0x,Sx,N,Fxstr,Y0str,doavg,usecor)
% Projekt 1, zadanie 06
% Mikołaj Wałachowski, 320748
%
% Funkcja pomocnicza do testów poprawności i testów numerycznych
% zadaniem funkcji jest zmierzenie błędu w zależności od kroku całkowania
if nargin == 6
    doavg = true;
    usecor = true;
end
if nargin == 7
    usecor = true;
end

xspan=[0 1];
l=length(N);


errAvg=zeros(1,l);
errMax=zeros(1,l);
errAvg2=zeros(1,l);
errMax2=zeros(1,l);
h=zeros(1,l);


for i=1:l
    %pause;
    h(i)=(xspan(2)-xspan(1))/N(i);
    Y=P1Z06_MWA_adams_bashforth_moulton(Fx,Y0x,xspan,N(i),usecor);
    X=Y(1,:);
    Y=Y(2,:);
    Ys=Sx(X);
    errAbs=abs(Y-Ys);
    errAvg(i)=mean(errAbs);
    errMax(i)=max(errAbs);
    
end
for i=1:l-1
    errMax2(i+1)=errMax(i)/errMax(i+1);
    errAvg2(i+1)=errAvg(i)/errAvg(i+1);
end
fprintf("\nRównanie: %s\nDla przybliżeń początkowych: %s\n",Fxstr,Y0str)
if usecor == false
    fprintf("Z wyłączonym korektorem\n")
end
pause;
tab1=[N;h;errMax;errMax2];
tab2=[N;h;errAvg;errAvg2];
fprintf("\nMaksymalny błąd globalny:\n")
fprintf("liczba iteracji   krok       błąd globalny  " + ...
    "stosunek błędów\n")
fprintf("---------------------------------------------------------------\n")
fprintf("%-5d             %f   %.2e       %.2f\n",tab1)
if doavg == true
    pause;
    fprintf("\n")
    fprintf("Średni błąd globalny:\n")
    fprintf("liczba iteracji   krok       błąd globalny  " + ...
        "stosunek błędów\n")
    fprintf("-----------------------------------------" + ...
        "----------------------\n")
    fprintf("%-5d             %f   %.2e       %.2f\n",tab2)
end

end

