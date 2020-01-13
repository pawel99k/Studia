import math

def bubble(t):  #definiujemy funkcję sortującą - korzystamy z metody bubble sort
    assert len(t)>0
    n = len(t)
    for i in range(n, 0, -1):    #i jest zakresem wykonywania drugiej petli, w kolejnym kroku jest on o 1 mniejszy
        for j in range(1, i):
            if t[j-1] > t[j]:
               a = t[j-1]
               t[j-1] = t[j]
               t[j] = a
    return t

def median(t):      #funkcja wyliczajaca wartosc mediany
    assert len(t)>0
    n = len(t)
    if n%2==0:
        mediana = 0.5*(t[n//2]+t[(n-2)//2])     #wynik dzielenia i tak jest l. calkowita, ale // zwraca int
        return mediana
    return t[(n-1)//2]   #w przeciwnym wypadku (dla nieparzystego n) - dzielenie calkowite by zwracalo inta

def piekwartyl(t):    #wartosc pierwszego kwartyla
    assert len(t)>0
    n = len(t)
    kon = math.floor((n-1)/2) #!!!!!!  #koncowy indeks pierwszej polowy ciagu, potrzebny do obliczenia kwartyla
    x = [None]*(kon+1)
    for i in range(kon+1):
        x[i] = t[i]
    return median(x)

def trzkwartyl(t):   #wartosc trzeciego kwartyla
    assert len(t)>0
    n = len(t)
    pocz = math.ceil((n-1)/2)
    x = [None]*(n-pocz)
    for i in range(pocz, n):
        x[i-pocz] = t[i]   #wpisywanie do tablicy x zaczynamy od indeksu pocz-pocz(=0), konczymy na n-1-pocz, czyli ostatnim miejscu listy x
    return median(x)
    
def iqr(t):         #rozstep cwiartkowy
    assert len(t)>0
    return trzkwartyl(t)-piekwartyl(t)

def dolnywas(t):    #granica dolna wasa, przy zalozeniu ze tablica jest juz posortowana
    assert len(t)>0
    minim = piekwartyl(t)   #ostatecznie dolna granica wasa powinna byc niewieksza niz wartosc 1 kwartyla
    for i in range(math.ceil(len(t)/4)+1):  #ograniczenie jest taki, ze znajdzie sie w 'range' indeks wartosci pierwszego kwartyla lub nastepny indeks
         if t[i]>=piekwartyl(t)-1.5*iqr(t) and t[i]<minim:
            minim = t[i]
    return minim

def gornywas(t):    #granica gorna wasa, przy zal. ze wartosci sa posortowane
    assert len(t)>0
    maxim= trzkwartyl(t)   #ostatecznie gorna granica wasa powinna byc niemniejsza niz wartosc 3 kwartyla
    for i in range(math.floor(len(t)*0.75)-1, len(t)):
        if t[i]<=trzkwartyl(t)+1.5*iqr(t) and t[i]>maxim:
            maxim = t[i]
    return maxim

def boxplot(t):         #funkcja rysujaca wykres
    assert len(t)>0
    n = len(t)
    tab = bubble(t)     #tab jest posortowana tablica t
    diff = tab[len(tab)-1]-tab[0]
    difference = diff/10
    for i in range(11):
        print("{0:4.2f}".format(t[0]+difference*i)+" "*4, end="")   #wypisanie pierwszej linii
    print("\n"+" "+"|-------"*10+"| ")
    print("\n")
    medi = median(t)
    pie = piekwartyl(t)
    trz = trzkwartyl(t)
    dol = dolnywas(t)
    gor = gornywas(t)
    y1 = int((pie - tab[0])/diff*84) #liczba spacji poczatkowych w pierwszej linijce pudelka
    y2 = int((tab[len(tab)-1]-trz)/diff*82) #liczba spacji koncowych    
    z1 = int((dol-tab[0])/diff*84)
    z2 = int((tab[len(tab)-1]-gor)/diff*84)
    print(" "*y1+"-"*(84-y2-y1)+" "*y2)
    print(" "*z1+"-"*(y1-z1)+"|"+" "*(z2-z1)+"|"+"-"*(84-z2))
    print(" "*y1+"-"*(84-y2-y1)+" "*y2)
#Koniec czasu :(

