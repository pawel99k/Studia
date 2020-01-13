package Uzytkownicy;

public class Administrator extends User {
    @Override
    public boolean isAdmin() {
        return true;
    }

    @Override
    public void setBan() {
        System.out.println("Nie możesz zbanować admina!");
    }

    @Override
    public void BanKid() {
        System.out.println("Nie możesz zbanować admina!");
    }

    @Override
    public void PrzedstawSie() {
        super.PrzedstawSie();
        System.out.println(". Jest administratorem.");
    }
}
