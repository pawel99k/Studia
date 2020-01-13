package queue;

public class Queue<T> {
    WezelKolejki<T> poczatek;
    WezelKolejki<T> koniec;
    int obecnyRozmiar = 0;
    int maxRozmiar;

    public Queue(int maxRozmiar) {
        this.maxRozmiar = maxRozmiar;
    }

    private class WezelKolejki<T> {
        private T element;
        private WezelKolejki<T> nastepny;


        private WezelKolejki(T newElement, WezelKolejki nastepny) {
            this.element = newElement;
            this.nastepny = nastepny;
        }

    }


    public void push(T wartosc) {
        if (obecnyRozmiar >= maxRozmiar) {
            throw new StackOverflowError("Przekroczono rozmiar");
        } else {
            if (this.koniec != null) {
                WezelKolejki nowy = new WezelKolejki<>(wartosc, this.koniec);
                this.koniec.nastepny = nowy;
                this.koniec = nowy;
            } else {
                WezelKolejki nowy = new WezelKolejki<>(wartosc, null);
                this.koniec = nowy;
                this.poczatek = nowy;
            }
            obecnyRozmiar++;
        }
    }


    public T pop() {
        if (obecnyRozmiar == 0) {
            throw new IllegalStateException("Pusta Kolejka");
        }
        T wartosc = this.poczatek.element;
        this.poczatek = this.poczatek.nastepny;
        obecnyRozmiar--;
        return wartosc;
    }

    public int getSize() {
        return obecnyRozmiar;
    }
}