package employees;

public class Main {
    public static void main(String[] args){

        Manager menedzer = new Manager("Marek", "Markowy", "000111222", "2013-04-05", 10200.9, true);
        Accountant ksiegowa = new Accountant("Maria", "Marciniak", "2223333444", "2014-09-23", 9000.1, true);
        Accountant ksiegowa2 = new Accountant("Anna", "Marciniak", "2223333444", "2014-09-23", 9000.1, true);
        Accountant ksiegowa3 = new Accountant("Maja", "Marciniak", "2223333444", "2014-09-23", 9000.1, true);
        Accountant ksiegowa4 = new Accountant("Karolina", "Marciniak", "2223333444", "2014-09-23", 9000.1, true);
        Vp vp = new Vp("Dariusz", "Kowalski", "5555677664", "2015-08-09", 11100.2, true);
        Developer developer = new Developer("Antoni","Nowak", "088850656", "2011-03-08", 5000.0, true);


        ksiegowa4.info();
        vp.info();
        menedzer.change_salary(vp, 20000.0);    //menedzer moze zmienic pensje jedynie Developerowi lub Ksiegowemu - brak efektu

        developer.info();
        menedzer.change_salary(developer, 1000.0);
        developer.info();   //brak zmiany pensji, ktory nie miala byc podwyzka
        menedzer.change_salary(developer, 10002.0);
        developer.info();       //teraz zmiana juz jest


        vp.fire(vp);
        vp.info();  //zwolnił sam siebie - no cóż...

        menedzer.add_subordinate(ksiegowa);
        menedzer.add_subordinate(ksiegowa2);
        menedzer.add_subordinate(ksiegowa3);
        vp.fire(ksiegowa3);

        menedzer.get_subordinates();
    }
}
