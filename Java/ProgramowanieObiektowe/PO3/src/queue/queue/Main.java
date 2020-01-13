package queue;

public class Main {
    public static void main(String[] args){
        Queue<Integer> kolejka = new Queue<>(5);
        System.out.println(kolejka.getSize());
        kolejka.push(1);
        kolejka.push(2);
        kolejka.push(3);
        System.out.println(kolejka.getSize());
        System.out.println(kolejka.pop());
        kolejka.push(4);
        kolejka.push(5);
        System.out.println(kolejka.getSize());
        System.out.println(kolejka.pop());
        kolejka.push(6);
        kolejka.push(7);
        System.out.println(kolejka.getSize());
        System.out.println(kolejka.pop());
        System.out.println(kolejka.pop());
        System.out.println(kolejka.pop());
        System.out.println(kolejka.pop());
        System.out.println(kolejka.pop());

        kolejka.push(5); //jest ok
    }
}
