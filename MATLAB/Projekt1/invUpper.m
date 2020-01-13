function X = invUpper(A)
%INVUPPER Funkcja do wyznaczania odwrotnosci macierzy gornej
% Algorytm Backward Substitution
% Wejscie: A - nieosobliwa  macierz gorna
% Wyjscie: X - odwrotnosc macierzy A
if det(A) ==0
    error("Podana macierz ma zerowy wyznacznik")
end
[~, n] = size(A);
I = eye(n);
X = zeros(n, n);
for k = n:-1:1
    X(k, k) = I(k, k) / A(k, k);
    for j = k-1:-1:1
        X(j, k) = (I(j, k)-A(j, j+1:k)*X(j+1:k, k))./A(j, j);
    end
end
end

