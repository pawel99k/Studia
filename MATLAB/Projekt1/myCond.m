function [wsk, rR, rL] = myCond(A)
%MYCOND Funkcja oblicza wskaznik uwarunkowania kwadratowej macierzy
%nieosobliwej z wykorzystaniem normy Frobeniusa oraz rozkladu PA=LU
%oraz 
%   Wejscie: A - kwadratowa macierz nieosobliwa
%   Wyjscie: wsk - Wskaznik uwarunkowania Frobeniusa;
%   rR oraz rL

if det(A) == 0
    error("Podana macierz ma zerowy wyznacznik")
end
[~, n] = size(A);
I = eye(n);
[L, U, P] = gepp(A);
odwL = invLower(L);
odwU = invUpper(U);
odwA = odwU * odwL * P;
wsk = norm(odwA, 'fro') * norm(A, 'fro');

rR = norm(A * odwA-I) / norm(A) / norm(odwA);
rL = norm(odwA * A-I) / norm(A) / norm(odwA);

end

