function X = invLower(A)
%INVLOWER Funkcja do wyznaczania odwrotnosci macierzy dolnej
% Algorytm Forward Substitution
% Wejscie: A - nieosobliwa  macierz dolna
% Wyjscie: X - odwrotnosc macierzy A
if det(A) ==0
    error("Podana macierz ma zerowy wyznacznik")
end
[~, n] = size(A);
I = eye(n);
X = zeros(n, n);
for k = 1:n
    X(k, k) = I(k, k) / A(k, k);
    for j = k+1:n
        X(j, k) = (I(j, k)-A(j, k:j-1)*X(k:j-1, k))./A(j, j);
    end
end
end

