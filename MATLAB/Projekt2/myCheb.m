function out = myCheb(x, vec)
%myCheb Funkcja sluzy do obliczania wartości funckji z tresci zadania
%   Funkcja: f(x)=a0+a1*|T1(x)|+...+an*|Tn(x)|, gdzie T(x) to wielomiany Czebyszewa I rodzaju
%   WEJSCIE: x - argument funkcji
%   vec - wektor wspolczynnikow [a0; a1...an] 
%   WYJSCIE: out - wartosc ww. funkcji w punkcie x

n = length(vec);
if n==1
    out = vec(1);
else
    pom1 = 1;
    out =  vec(1);
    pom2 = x;
    out = out + abs(pom2) * vec(2);
    for iter = 3:n
        pom3 = 2 .* x .* pom2 - pom1;
        out = out + vec(iter) .* abs(pom3);
        pom1 = pom2;
        pom2 = pom3;
    end
end
end
