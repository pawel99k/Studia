#zdefiniowanie funkcji sign
def sign(x):
    if x>0 or x==0:
        return 1
    else:
        return -1

#Algorytm Perceptron - zgodnie z instrukcjami w zadaniu, wyznacza w1 oraz w2

f = open("wine_train.txt")
w1 = 0  #wartosci poczatkowe: w1=0 oraz w2=0
w2 = 0
while True:
    linia = f.readline()
    if linia == "":
        break
    x, y, z = str.split(linia)
    x = float(x)
    y = float(y)
    z = int(z)
    znakz = sign(w1*x + w2*y)
    if znakz != z:
        if znakz == -1:
            w1 = w1+x
            w2 = w2+y
        else:
            w1 = w1-x
            w2 = w2-y
f.close()

#Rysowanie wykresu

import matplotlib.pyplot as plt
import numpy as np

fig = plt.figure() #inicjowanie
f = open("wine_train.txt")
while True:
    linia = f.readline()
    if linia == "":
        break
    x, y, z = str.split(linia)
    x = float(x)
    y = float(y)
    z = int(z)
    if z==1:
        plt.scatter(x, y, color="red")
    else:
        plt.scatter(x, y, color="blue")
f.close()

a = -1*w1/w2 # Obliczanie wsp. kierunkowego prostej o rownaniu w1*x+w2*y = 0, oczywiscie b=0
# nanoszenie na wykres prostej o wspolczynniku kierunkowym a oraz wyrazie wolnym b:
u = np.linspace(-1.4, 1.6)
plt.plot(u, a*u)
fig.savefig('output.png', dpi=90) # zapisywanie rysunku

#Zdefiniowanie funkcji klasyfikator - punkt 3

def klasyfikator(w1, w2, x, y):
    if w1==0 or w2==0:
        raise Exception("w1 lub w2 jest zerowy")
    if w1*x+w2*y<0:
        z = -1
    else:
        z = 1
    return z   
    
#sprawdzanie dokladnosci

f = open("wine_test.txt")
TN = 0
FP = 0
FN = 0
TP = 0
while True:
    linia = f.readline()
    if linia == "":
        break
    x, y, z = str.split(linia)
    x = float(x)
    y = float(y)
    z = int(z)
    zoczekiwane = klasyfikator(w1, w2, x, y)
    if zoczekiwane == -1 and z == -1:
        TN += 1
    elif zoczekiwane == 1 and z == -1:
        FP += 1
    elif zoczekiwane == -1 and z == 1:
        FN += 1
    else:
        TP += 1
f.close()

Accuracy = (TP+TN)/(TP+TN+FP+FN) #dokladnosc klasyfikatora

f = open("output.txt", "a") #rysowanie tabelki oraz dokladnosc - do pliku output
print(" "*3, "|{0:^5d}|{1:^5d}".format(-1, 1),  file = f)
print("-"*16, file = f)
print(" -1 |", "{0:^4d}|{1:^5d}".format(TN, FP), file = f)
print(" -1 |", "{0:^4d}|{1:^5d}".format(FN, TP), file = f)
print("Accuracy = {0:0.4f}".format(Accuracy), file = f)
f.close()
 
