function [L, A, P] = gepp(A)
%GEPP Wlasna implementacji metody eliminacji Gaussa 
% Wejscie: A - nieosobliwa macierz kwadratowa o elementach w C
% Wyjscie: L oraz A - macierze dekompozycji, gdzie:
% L - trojkatna dolna z diagonala zlozona jedynie z 1
% A - trojkatna gorna
% P - macierz permutacji 
if det(A) == 0
    error("Podana maicerz ma zerowy wyznacznik")
end
[~, n] = size(A);
P = eye(n);
L = eye(n);
for t = 1:(n-1)
    [~, indeks] = max(abs(A(t:n, t)));
    if t+indeks-1 ~= t %jesli spelniony, zamieniamy odpowiednie wiersze
         T = eye(n);
         T([t, t+indeks-1], :) = T([t+indeks-1, t], :);
         A = T*A;
         P = T*P;
         L([t, t+indeks-1], 1:t-1) = L([t+indeks-1, t], 1:t-1);
    end
    L(t+1:n, t) = A(t+1:n, t) ./ A(t, t);
    A(t+1:n, t:n) = A(t+1:n, t:n) - L(t+1:n, t)*A(t, t:n);
end
end