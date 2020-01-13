package employees;

import java.util.ArrayList;

public class Vp extends Employee implements HasSubordinates {
    ArrayList<Employee> subordinates = new ArrayList<Employee>();
    ;

    public Vp(String name, String surname, String tel_number, String hire_date, Double salary, boolean status) {
        super(name, surname, tel_number, hire_date, salary, status);
    }

    void fire(Employee emp) {
        emp.state = false;
    }

    @Override
    public void add_subordinate(Employee empl){
        subordinates.add(empl);
    }


    @Override
    public void get_subordinates() {
        for(int i = 0; i<this.subordinates.size(); i++){
            this.subordinates.get(i).info();
        }
    }


}
