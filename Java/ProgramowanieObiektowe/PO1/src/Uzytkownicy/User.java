package Uzytkownicy;

public class User {
    String name;
    String surname;
    int age;
    boolean ban = false;

    public void giveName(String name){
        this.name = name;
    }

    public void giveSurname(String surname){
        this.surname = surname;
    }

    public void setAge(int age){
        this.age = age;
    }

    public void setBan(){
        this.ban = true;
    }

    public void PrzedstawSie(){
        System.out.println(name + " " + surname + ", l." + age);
    }

    public boolean isAdult(){
        if(this.age>=18){
            return true;
        }
        else{
            return false;
        }
    }

    public void BanKid(){
        if(!this.isAdult()){
            this.ban = true;
        }
    }

    public boolean isAdmin(){
        return false;
    }

    public boolean isBanned(){  //dodatkowa metoda, w celach testowych
        return this.ban;
    }
}
