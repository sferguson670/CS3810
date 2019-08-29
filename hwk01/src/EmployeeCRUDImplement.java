import java.io.*;
import java.util.Scanner;

public class EmployeeCRUDImplement implements EmployeeCRUD {

    //hard coded filename
    static final String EMPLOYEE_FILENAME = "employees.csv";

    @Override
    public void create(Employee employee) {
        //method to make sure there is no employee with same ID
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
        //creates employee with all data filled
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
        //reads ID and updates information to employee with associated id
        Employee temp = new Employee(id, "", "");
        delete(id);
        //rewrite employee information
        temp.setName(employee.getName());
        temp.setDepartment(employee.getDepartment());
        create(temp);
    }

    @Override
    public void delete (int id) {
        //removes employee with associated id
        File tempFile = new File("temp.csv");
        try {
            Scanner in = new Scanner(new FileInputStream(EMPLOYEE_FILENAME));
            while (in.hasNextLine()) {
                String line = in.nextLine();
                if (line.charAt(0) == '#')
                    continue;
                String data[] = line.split(",");
                int key = Integer.parseInt(data[0]);
                if (id != key) {
                    PrintStream out = new PrintStream(new FileOutputStream(tempFile, true));
                    out.println(line);
                    out.close();
                }
            }
            in.close();
        }
        catch (FileNotFoundException e) {
            //ignoring ...
        }
        tempFile.renameTo(new File(EMPLOYEE_FILENAME));
    }

    public static void main(String[] args) {
        EmployeeCRUDImplement implement = new EmployeeCRUDImplement();

        //just a hard coded employee for now...
        Employee employee1 = new Employee(2, "Joe", "IT");
        Employee employee2 = new Employee(3, "Sam", "Sales");
        Employee employee3 = new Employee(5, "Joe", "IT Department Manager");

        implement.create(employee1);
        implement.create(employee2);

        implement.read(employee1.getId());
        implement.read(employee2.getId());

        implement.update(employee1.getId(), employee3);

        implement.delete(employee2.getId());

    }
}
