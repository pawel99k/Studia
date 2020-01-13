import math

ob = float(input("Podaj obwód głowy Zosi (w centymetrach):\n>"))
n_rozdzki = int(input("Podaj liczbę różdżek:\n>"))
n_patyki = int(input("Podaj liczbę znalezionych patyków:\n>"))

#Poprawność danych

if ob<45.0 or ob>60.0 or n_rozdzki<0 or n_patyki<0:
    exit("Podane dane są niepoprawne.")
else:
    print("Poprawne dane.")

promien = ob/(2*math.pi)


wewn = 0.9*promien  #wewnetrzny promien (stozka)
zewn = 3*promien    #zewnetrzny promien (rondo)
h = 5*promien       #wysokosc stozka

#maksymalny zewn wynosi 15*sqrt(3); maksymalna powierzchnia do malowania to 21/110 m2 = 21000/11 cm2

if zewn>(90*math.sqrt(3)/6):
    print("Tektury nie wystarczy")
else:
    print("Tektury wystarczy.")

l = math.sqrt(h**2+wewn**2) # dlugosc tworzacej

pronda = math.pi*(zewn-wewn)*(zewn+wewn) #powierzchnia ronda

pstozka = math.pi*wewn*l #powierzchnia stozka

if (pronda+pstozka)>(21/110*10000):
    print("Zabraknie farby!")
else:
    print("Wystarczy farby!")

#z jednego patyka można stworzyć max. 187/19 różdżek, czyli max. 9

if n_rozdzki>(math.floor(187/19)*n_patyki):
    print("Nie wystarczy patyków!")
else:
    z = math.ceil(n_rozdzki/n_patyki) #maksymalna liczba rozdzek z jednego patyka
    dlug = 187/z  #dlugosc rozdzki
    if dlug>25:
        print("Wystarczy na {0} różdżek, Ich długość może być równa 25 cm.".format(n_rozdzki))
    else:
        print("Wystarczy na {0} różdżek, Ich długość może być równa {1:0.2f} cm.".format(n_rozdzki, dlug))
    
