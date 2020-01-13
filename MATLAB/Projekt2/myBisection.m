function [result, n] = myBisection(vec, a, b)
%myBisection Funkcja wyznacza zero funkcji metoda bisekcji na przedziale [a, b]
%   Funkcja: f(x)=a0+a1*|T1(x)|+...+an*|Tn(x)|, gdzie T(x) to wielomiany Czebyszewa I rodzaju
%   WEJSCIE: vec - wektor wspolczynnikow vec
%   a, b - krance przedzialu, w ktorym poszukiwane jest 0
%   WYJSCIE: result - wyszukane miejsce zerowe funkcji

args = linspace(a, b, abs(a-b) * 1000);

if myCheb(a, vec) * myCheb(b, vec) >= 0
   plot(args, myCheb(args, vec), '-', args, linspace(0, 0, length(args)), '--')
   title('Warunek wstępny niespełniony')
   error("Miejsce zerowe nie moglo zostac obliczone metoda bisekcji")
end
przyp = zeros([100000, 1]);
n=0;
while abs(myCheb((a+b)/2, vec)) >= 10^ -12
    n = n + 1;
    przyp(n) = (a+b)/2;
    if myCheb((a+b)/2, vec) * myCheb(a, vec) < 0
        b = (a+b)/2;
    else     
        a = (a+b)/2;       
    end
    if n>99999
        figure
        subplot(1, 2, 1)
        plot(1:n, przyp, 'o')
        subplot(1, 2, 2)
        plot(args, myCheb(args, vec), '-', args, linspace(0, 0, length(args)), '--')
        error("Iteracja sie nie powiodla")
    end
end
result = (a+b)/2;
n = n + 1;
przyp(n) = result; 

%rysowanie wykresu
figure
subplot(9, 1, 1:3)
plot(1:n, przyp(1:n), 'o')
title('Wyznaczane potencjalne miejsce zerowe w kolejnych iteracjach')
xlabel('Iteracje')
ylabel('Połowa przedziału')
subplot(9, 1, 5:9)
plot(args, myCheb(args, vec), '-', args, linspace(0, 0, length(args)), '--')
legend('Badana funkcja', 'y = 0')
xlabel('x')
ylabel('y')
title('Wykres funkcji, dla której wyznaczane jest zero')
end