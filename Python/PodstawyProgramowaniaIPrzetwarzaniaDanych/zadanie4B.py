import random


def stworz_plansze(n, maxiter):
    assert n>0
    A = [[0]*n for i in range(n)]
    for i in range(maxiter):                      #maxiter - l. prob postawienia statku
        rozmiar = random.randint(1, 4)            #losowana dlugosc statku
        if rozmiar>n: break                       #gdy rozmiar statku jest wiekszy od rozmiaru planszy
        x_pocz = random.randint(0, n-rozmiar)     #1 wsp. tak by statek sie zmiescil
        y_pocz = random.randint(0, n-1)           #2 wsp. dowolna na calej szerokosci
        curx = x_pocz
        cury = y_pocz
        sprawdzacz = True
        for i in range(rozmiar):                                 #ta petla sprawdza czy statek nie bedzie sie z zadnym stykal
            if sprawdzacz == False: break                        #gdy sprawdzacz==False, wiemy ze statek sie styka
            for j in range(-1, 2):                               #j przybiera wartosci -1, 0, 1, sprawdzamy sasiednie pola
                if (curx+j) < 0 or (curx+j) >= n: continue       #jesli indeks poza tablica
                for k in range(-1, 2):                           #wartosci k podobnie jak j
                    if (cury+k) < 0 or (cury+k) >= n: continue
                    if A[curx+j][cury+k] == 1: sprawdzacz = False   #jesli sie styka 
        if sprawdzacz == True:                                      #wowczas nanosimy na plansze statek
            for i in range(rozmiar):
                A[x_pocz+i][y_pocz] = 1
    return A

def odkryj_pole(Plansza, x, y):
    assert len(Plansza)>0
    assert x<len(Plansza) and y<len(Plansza[0])
    assert x>=0 and y>=0
    if Plansza[x][y]==0 or Plansza[x][y] == 1: Plansza[x][y] += 2      #pole odkrywamy tylko gdy jest zakryte, 0 na 2, 1 na 3
    

def czy_wszystkie_trafione(Plansza):
    assert len(Plansza)>0
    assert len(Plansza) == len(Plansza[0])  #upewnienie sie czy tablica jest kwadratowa
    for i in range(len(Plansza)):
        for j in range(len(Plansza)):
            if Plansza[i][j] == 1:
                return False
    return True

def wypisz(A):
    n = len(A)
    # wypisanie numerow kolumn planszy
    for k in range(n):
        if k == 0: print(str.format("{0:^4s}", " "), end="")
        print(str.format("{0:^3s}", str(k)), end="")
    print("\n"+"-"*(n*3+4), end="")
    for i in range(n):
        for j in range(n+1):
            # wypisanie numerow wierszy planszy
            if j == 0: print("\n", str.format("{0:^2s}|", str(i)), end="")
            elif A[i][j-1] == 0 or A[i][j-1] == 1: print(" "*3, end="")           #' ' gdy pole nie jest odkryte
            elif A[i][j-1] == 2: print(str.format("{0:^3s}", "o"), end="")        #'o' pole odkryte bez statku
            elif A[i][j-1] == 3: print(str.format("{0:^3s}", "x"), end="")        #'x' pole odkryte zawierajace fragment statku
    print("\n")

def gra(n=10, maxiter=10):
    Plansza = stworz_plansze(n, maxiter)
    wypisz(Plansza)
    while not czy_wszystkie_trafione(Plansza):
        x = input("Podaj nr wiersza:\n>")
        y = input("Podaj nr kolumny:\n>")
        if x=="" or y=="":                          #podczas testow zdarzylo mi sie tyle razy, ze zaczelo irytowac 
            print("Niepoprawne współrzędne, spróbuj ponownie.")
            continue
        x = int(x)
        y = int(y)
        if x<0 or y<0 or x>=n or y>=n:
            print("Niepoprawne współrzędne, spróbuj ponownie.")
            continue
        odkryj_pole(Plansza, x, y)
        wypisz(Plansza)
    print("Zwycięstwo! Gratulacje")

gra()
