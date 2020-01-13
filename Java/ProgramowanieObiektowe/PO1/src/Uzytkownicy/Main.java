package Uzytkownicy;

public class Main {
    public static void main(String[] args){
        User uzytkownik = new User();
        uzytkownik.giveName("PAWEL");
        uzytkownik.giveSurname("KOZMINSKI");
        uzytkownik.setAge(19);
        uzytkownik.PrzedstawSie();

        System.out.println("Is he an adult? " + uzytkownik.isAdult());

        uzytkownik.BanKid();
        System.out.println(uzytkownik.isBanned());

        uzytkownik.PrzedstawSie();
        System.out.println("Is he an admin? " + uzytkownik.isAdmin());

        uzytkownik.setBan();
        System.out.println(uzytkownik.isBanned());

        Administrator admin1 = new Administrator();
        admin1.giveName("ROOT");
        admin1.giveSurname("root");
        admin1.setAge(10);
        admin1.BanKid();
        admin1.setBan();
        admin1.PrzedstawSie();
        System.out.println(admin1.isAdmin());
    }
}
