package zadanie2;

import java.io.*;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) throws Exception {
        try{
            File file = new File("SacramentocrimeJanuary2006.csv");


        BufferedReader br = new BufferedReader(new FileReader(file));

        String st;

        int maxDistr = 0;
        int dangdistrict = 0;
        int maxType = 0;
        int popOff = 0;
        int wykrtyp;

        int k= 0;

        int[] districtscounter = {0, 0, 0, 0, 0, 0};  //Zauwazmy, ze jest 6 dzielnic, zatem 6 zer
        List<Integer> unrcounter = new ArrayList<Integer>(0); //co do typu wykroczen - jest ich wiele, zatem bedziemy je liczac w ArraylListach
        List<Integer> whichunr = new ArrayList<Integer>(0);

        if((st=br.readLine()) != null){
            String[] tytuly = st.split(",");
        }

        if((st=br.readLine()) != null){
            String[] wykroczenie = st.split(",");

            districtscounter[Integer.parseInt(wykroczenie[2])-1]++;

            unrcounter.add(Integer.parseInt(wykroczenie[6]));
            whichunr.add(1);
        }




       while ((st = br.readLine()) != null) {
            String[] wykroczenie = st.split(",");
            districtscounter[Integer.parseInt(wykroczenie[2])-1]++;
            wykrtyp = Integer.parseInt(wykroczenie[6]);     //typ wykroczenia z tej linijki

            if(unrcounter.contains(wykrtyp)){           //jesli taki typ juz zarejestrowalismy, zwiekszamy jego liczebnosc
                for(int i = 0; i<unrcounter.size(); i++){
                    if(unrcounter.get(i)==wykrtyp){
                        whichunr.set(i, whichunr.get(i)+1);
                        break;  //Znalezlismy juz taki element, nie musimy przeszukiwac arraylist dalej
                    }
                }
            }

            else {      //w przeciwnym przypadku dodajemy nowy dla nas typ przestepstwa
                unrcounter.add(wykrtyp);
                whichunr.add(1);
            }
        }




        BufferedWriter writer = new BufferedWriter(new FileWriter("raportprzestepstw.txt"));

        for(int i = 0; i<6; i++) {
            if (districtscounter[i] > maxDistr) {
                maxDistr = districtscounter[i];
                dangdistrict = i+1;
            }
        }
        for(int i = 0; i<unrcounter.size(); i++){
            if(whichunr.get(i) > maxType){
                maxType = whichunr.get(i);
                popOff = unrcounter.get(i);
            }
        }



        writer.write("Najczesciej popelniano przestepstwa w " + Integer.toString(dangdistrict) + " dzielnicy.\n");
        writer.write("Najczesciej popelniano przestepstwo typu " + Integer.toString(popOff) + ".");
        writer.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}
