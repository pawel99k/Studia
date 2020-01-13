package MultipleTable;

import java.util.Scanner;

public class Main {
    public static void main(String[] args){
        Scanner scanner = new Scanner(System.in);
        int zakres;
        System.out.println("Podaj zakres");
        zakres = scanner.nextInt();
        Table tablicadziesieciu = new Table(zakres);
        tablicadziesieciu.FillTable();
        System.out.println("Zakres: " + tablicadziesieciu.Range());

        int x1, y1;
        System.out.println("Podaj pierwszy czynnik");
        x1 = scanner.nextInt();
        System.out.println("Podaj drugi czynnik");
        y1 = scanner.nextInt();

        System.out.println("Wynik: " + tablicadziesieciu.Result(x1, y1));

        System.out.println("Sprawdz czy iloczyn dwoch liczb jest wiekszy od trzeciej:");
        int a, b, c;
        a = scanner.nextInt();
        b = scanner.nextInt();
        c = scanner.nextInt();
        System.out.println(tablicadziesieciu.moreorless(a, b, c));

        tablicadziesieciu.Print();
    }
}
