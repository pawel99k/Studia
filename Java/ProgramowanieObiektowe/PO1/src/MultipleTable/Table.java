package MultipleTable;

import java.util.Arrays;

public class Table {
    int n;
    int[][] tab;

    public Table(int n){
        this.n = n;
        this.tab = new int[n][n];
    }

    public void FillTable(){
        for(int i = 0; i<n; i++){
            for(int j = 0; j<n; j++){
                tab[i][j] = (i+1)*(j+1);
            }
        }
    }

    public int Range(){
        return this.n;
    }

    public void Print(){
        System.out.println(Arrays.deepToString(tab));
    }

    public int Result(int x, int  y){
        if(x>n || y>n || x<0 || y<0) {
            System.out.println("Przekroczono zakres. Niepoprawne dane.");
            return 0;
        }
        else{
            return tab[x-1][y-1];
        }
    }

    public boolean moreorless(int a, int b, int c) {
        if (a > n || b > n || a < 0 || b < 0) {
            System.out.println("Przekroczono zakres.");
            return false;
        }
        else{
            return tab[a-1][b-1]>c;
        }
    }
}
