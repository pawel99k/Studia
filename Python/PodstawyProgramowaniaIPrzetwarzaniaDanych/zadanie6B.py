import math
class Wielomian:

    def __init__(self, wspolczynniki):
        """
        Konstruktor, przyjmuje liste zawierajaca wartosci wspolczynnikow
        
        """        
        assert isinstance(wspolczynniki, list)
        n = len(wspolczynniki)
        stopien_wielomianu = 0
        for i in range(n):
            assert isinstance(i, int) or isinstance(i, float)
            if wspolczynniki[i] != 0:
                stopien_wielomianu = i+1      #ost. !=0 l. w tab. 'wspolczynniki' jest wsp. przy najwyzszej potedze
        self.__wspolczynniki = [0]*stopien_wielomianu
        for i in range(stopien_wielomianu):
            self.__wspolczynniki[i] = wspolczynniki[i]

    def __repr__(self):
        """
        zwraca string reprezentujacy wielomian w podstaci np. 3x^2 - 2x^1 + 1 
        """
        if len(self.__wspolczynniki) < 1: return ""
        if self.__wspolczynniki[0]<0:                           #dla wyrazu wolnego
            wypis = "- " + str(abs(self.__wspolczynniki[0]))
        elif self.__wspolczynniki[0]>0:
            wypis = "+ " + str(self.__wspolczynniki[0])
        else:
            wypis = ""
        for i in range(1, len(self.__wspolczynniki)-1):             # dla wspolczynnikow przy x oprocz najwyz. pot.
            if self.__wspolczynniki[i]<0:
                wypis = "- " + str(abs(self.__wspolczynniki[i])) + "x^" + str(i) + " " + wypis
            elif self.__wspolczynniki[i]>0:
                wypis = "+ " + str(self.__wspolczynniki[i]) + "x^" + str(i) + " " + wypis
        # dla wspolczynnika przy najw. potedze:
        wypis = str(self.__wspolczynniki[len(self.__wspolczynniki)-1]) + "x^" + str(len(self.__wspolczynniki)-1) + " " + wypis
        return wypis
    
    def get_stopien(self):
        if len(self.__wspolczynniki)>0:
            return len(self.__wspolczynniki)-1  #co jest istotnie stopniem wielomianu
        return 0
    def get_wspolczynniki(self):
        return self.__wspolczynniki
        
    def __call__(self, x):
        """
        wartosc wielomianu w p. x wg schematu Hornera
        """
        if len(self.__wspolczynniki)==0: return 0
        czynnik = self.__wspolczynniki[len(self.__wspolczynniki)-1]
        for i in range(2, len(self.__wspolczynniki)+1):
            #czynnik = self.__wspolczynniki[len(self.__wspolczynniki)-i]
            czynnik = czynnik*x + self.__wspolczynniki[len(self.__wspolczynniki)-i]
        return czynnik

    def plot(self, a=0, b=1, hline=0):
        """
        rysuje wykresy
        """
        import matplotlib.pyplot as plt
        e = (b-a)/100
        x = [a+i*e for i in range(100)]
        y = [self(e) for e in x]
        plt.plot(x, y) # rysuje lamana laczaca punkty
        z = [hline for ilosc in range(100)]
        plt.plot(x, z)
        plt.show()

    def pochodna(self):
        """
        Zwraca obiekt klasy Wielomian - pochodna z wielomianu argumentu
        """
        stopien_wielomianu = Wielomian.get_stopien(self)
        wsp_pochodnej = [None] * (stopien_wielomianu)
        for i in range(stopien_wielomianu):
            wsp_pochodnej[i] = self.__wspolczynniki[i+1]*(i+1)
        return Wielomian(wsp_pochodnej)

    def miejsce_zerowe(self, start, eps=1e-12, M=100):
        """
        Wyznaczanie miejsca zerowego metoda Newtona
        """
        if len(self.__wspolczynniki)==1:
            if self.__wspolczynniki[0] == 0: return 0 #kazda liczba jest miejscem zerowym, w tym 0
            else: return math.nan
        y = start
        for i in range(1, M+1):
            if Wielomian.pochodna(self)(y) == 0: return math.nan
            x = y - self(y)/(Wielomian.pochodna(self)(y))
            if abs(self(x))<eps or abs(x-y)< eps:
                return x
            y = x
        return math.nan


w1 = Wielomian([1,2,3])
print("""--- test 1 ---\nw1: {0},
    stopien: {1:d},
    w1(0) = {2:6.3f},
    w1(1) = {3:6.3f},
    miejsce zerowe: {4:6.3f}\n""".format(w1, w1.get_stopien(), w1(0), w1(1), w1.miejsce_zerowe(start=0)))
d1 = w1.pochodna()
print("""d1: {0},
    stopien: {1:d},
    d1(0) = {2:6.3f},
    d1(1) = {3:6.3f},
    miejsce zerowe: {4:6.3f}""".format(d1, d1.get_stopien(), d1(0), d1(1), d1.miejsce_zerowe(start=0)))
w2 = Wielomian([3])
print("""--- test 2 ---\nw2: {0},
    stopien: {1:d},
    w2(0) = {2:6.3f},
    w2(1) = {3:6.3f},
    miejsce zerowe: {4:6.3f}\n""".format(w2, w2.get_stopien(), w2(0), w2(1), w2.miejsce_zerowe(start=0)))
d2 = w2.pochodna()
print("""d2: {0},
    stopien: {1:d},
    d2(0) = {2:6.3f},
    d2(1) = {3:6.3f},
    miejsce zerowe: {4:6.3f}""".format(d2, d2.get_stopien(), d2(0), d2(1), d2.miejsce_zerowe(start=0)))
w2 = Wielomian([3])
print("""--- test 2 ---\nw2: {0},
        stopien: {1:d},
        w2(0) = {2:6.3f},
        w2(1) = {3:6.3f},
        miejsce zerowe: {4:6.3f}\n""".format(w2, w2.get_stopien(), w2(0), w2(1), w2.miejsce_zerowe(start=0)))
d2 = w2.pochodna()
print("""d2: {0},
        stopien: {1:d},
        d2(0) = {2:6.3f},
        d2(1) = {3:6.3f},
        miejsce zerowe: {4:6.3f}""".format(d2, d2.get_stopien(), d2(0), d2(1), d2.miejsce_zerowe(start=0)))
w3 = Wielomian([8, -7, 6, -5, 4, -3, 2, -1, 0])
print("""--- test 3 ---\nw3: {0},
    stopien: {1:d},
    w3(0) = {2:6.3f},
    w3(1) = {3:6.3f},
    miejsce zerowe: {4:6.3f}\n""".format(w3, w3.get_stopien(), w3(0), w3(1), w3.miejsce_zerowe(start=0)))
d3 = w3.pochodna()

print("""d3: {0},
    stopien: {1:d},
    d3(0) = {2:6.3f},
    d3(1) = {3:6.3f},
    miejsce zerowe: {4:6.3f}""".format(d3, d3.get_stopien(), d3(0), d3(1), d3.miejsce_zerowe(start=-5)))

w3.plot() # zob. Rys. 1
d3.plot()
