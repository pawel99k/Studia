package employees;

import java.util.ArrayList;

public class Manager extends Employee implements HasSubordinates {
    ArrayList<Employee> subordinates = new ArrayList<Employee>();


    public Manager(String name, String surname, String tel_number, String hire_date, Double salary, boolean status) {
        super(name, surname, tel_number, hire_date, salary, status);
    }

    void change_salary(Employee emp, Double new_sal) {              //new_sal - wysokosc nowej pensji
        if (emp.state) {            //pracownik musi byc zatrudniony
            if (emp instanceof Developer | emp instanceof Accountant) {     //podwyzke mozna dac tylko Developerowi lub Ksiegowemu
                if(emp.salary<new_sal) {            //ma to byc PODWYZKA
                    emp.salary = new_sal;
                }
            }
        }
    }
    @Override
    public void add_subordinate(Employee empl){
        subordinates.add(empl);
    }


    @Override
    public void get_subordinates() {
        for(int i = 0; i<this.subordinates.size(); i++){
            System.out.println(i+1 + ". podwładny:");
            this.subordinates.get(i).info();
        }
    }
}