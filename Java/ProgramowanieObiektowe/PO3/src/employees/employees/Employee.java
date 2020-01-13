package employees;

public abstract class Employee {
    String name;
    String surname;
    String tel_number;
    String hire_date;
    Double salary;
    Boolean state;


    public Employee(String name, String surname, String tel_number, String hire_date, Double salary, Boolean state){
        this.name = name;
        this.surname = surname;
        this.tel_number = tel_number;
        this.hire_date = hire_date;
        this.salary = salary;
        this.state = state;

    }

    public void info(){
        System.out.print(name + " " + surname + " tel.: " + tel_number + " employed since: " + hire_date + ". Salary: " + Double.toString(salary));
        if(this.state){
            System.out.println(". Currently employed.");
        }
        else{
            System.out.println(". Has been fired.");
        }
    }
}
