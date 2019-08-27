import java.io.*;
import java.util.Scanner;

public class EmployeeCRUDImplement implements EmployeeCRUD {

    //hard coded filename
    static final String EMPLOYEE_FILENAME = "employees.csv";

    @Override
    public void create(Employee employee) {
        //opens the file for read
        //loop through all lines of the file
        boolean found = false;
        try {
            Scanner in = new Scanner(new FileInputStream(EMPLOYEE_FILENAME));
            while (in.hasNextLine()) {
                String line = in.nextLine();
                //ignoring delete employees
                if (line.charAt(0) == '#')
                        continue;

                //break line into employee aspects
                String data[] = line.split(",");
                int id = Integer.parseInt(data[0]);
                if (id == employee.getId()) {
                    found = true;
                    break;
                }
            }
            in.close();
        }
        catch (FileNotFoundException e) {
            //ignoring ...
        }
        if (found) {
            System.out.println("Employee with the same ID already exists.");
        }
        else {
            try {
                PrintStream out = new PrintStream(new FileOutputStream(EMPLOYEE_FILENAME, true));
                out.println(employee);
                out.close();
            }
            catch (FileNotFoundException e){
                e.printStackTrace();
            }
        }
    }

    @Override
    public Employee read(int id) {
        try {
            Scanner in = new Scanner(new FileInputStream(EMPLOYEE_FILENAME));
            while (in.hasNextLine()) {
                String line = in.nextLine();
                //ignoring deleted employees
                if (line.charAt(0) == '#')
                    continue;

                String data[] = line.split(",");
                int key = Integer.parseInt(data[0]);
                if (id == key) {
                    String name = data[1];
                    String dep = data[2];
                    Employee employee = new Employee(id, name, dep);
                    in.close();
                    return employee;
                }
            }
            in.close();
        }
        catch (FileNotFoundException ex ) {
            //ignoring...
        }
        return null;
    }

    @Override
    public void update (int id, Employee employee) {
        try {
            Scanner in = new Scanner(new FileInputStream(EMPLOYEE_FILENAME));
            while (in.hasNextLine()) {
                String line = in.nextLine();
                String data[] = line.split(",");
                int key = Integer.parseInt(data[0]);
                if (id == key) {
                    String name = data[1];
                    String dep = data[2];
                    //update name & department
                    employee.setName(name);
                    employee.setDepartment(dep);
                    in.close();
                    //to make sure program is working
                    System.out.println("Employee with id " + id + " has been updated.");
                }
            }
            in.close();
        }
        catch (FileNotFoundException ex ) {
            //ignoring...
        }
    }

    @Override
    public void delete (int id) {
        try {
            Scanner in = new Scanner(new FileInputStream(EMPLOYEE_FILENAME));
            while (in.hasNextLine()) {
                String line = in.nextLine();
                String data[] = line.split(",");
                int key = Integer.parseInt(data[0]);
                if (id == key) {
                    String name = data[1];
                    String dep = data[2];
                    in.close();
                }
            }
            in.close();
        }
        catch (FileNotFoundException ex ) {
            //ignoring...
        }
    }

    public static void main(String[] args) {
        EmployeeCRUDImplement implement = new EmployeeCRUDImplement();

        //just a hard coded employee for now...
        Employee employee1 = new Employee(2, "Joe", "IT");
        Employee employee2 = new Employee(2, "Sam", "Sales");
        Employee employee3 = new Employee(55, "Emily", "Management");
        Employee employee4 = new Employee(4, "Hannah", "Board");
        //practicing Create function
        implement.create(employee1);
        //practicing Read function
        implement.read(4);
        //practicing Update function
        implement.update(2, employee2);
        //practicing Delete function
        //implement.delete(55);
    }
}
