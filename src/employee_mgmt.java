import java.util.*;
import java.sql.*;
import java.util.Date;

public class employee_mgmt {
    public String dbUrl = "jdbc:mysql://localhost:3306/dbadm2.6";
    public String dbUsername = "root";
    public String dbPassword = "Neil_hawkins15";
    public Integer eNumber;
    public String lastname;
    public String firstname;
    public String extension;
    public String email;
    public String jobTitle;
    public String employee_type;
    public Boolean isDeactivated;
    public Integer deptCode;
    public Integer officeCode;
    public Date startDate;
    public Date endDate;
    public String reason;
    public double quota;
    public Integer salesManagerNum;

    public employee_mgmt(){

    }

    public void addEmployee(){
        Scanner sc = new Scanner(System.in);
        System.out.println("Please enter the following details: \n");
        System.out.println("Last Name: ");
        lastname = sc.nextLine();

        System.out.println("First Name: ");
        firstname = sc.nextLine();

        System.out.println("Extension: ");
        extension = sc.nextLine();

        System.out.println("Email: ");
        email = sc.nextLine();

        System.out.println("Job Title: ");
        jobTitle = sc.nextLine();

        System.out.println("Employee Type (1: Sales Representative 2: Sales Manager 3: Inventory Manager): ");
        employee_type = sc.nextLine();

        System.out.println("Department Code: ");
        deptCode = Integer.valueOf(sc.nextLine());

        try{
            Connection conn;
            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            System.out.println("Database Connected Successfully");
            conn.setAutoCommit(false);

            PreparedStatement pstmt = conn.prepareStatement("CALL add_employee(?, ?, ? ,?, ?, ?, ?, null, null)");
            pstmt.setString(1, lastname);
            pstmt.setString(2, firstname);
            pstmt.setString(3, extension);
            pstmt.setString(4, email);
            pstmt.setString(5, jobTitle);
            pstmt.setString(6, employee_type);
            pstmt.setString(7, String.valueOf(deptCode));

            System.out.println("Press any key to continue...");
            sc.nextLine();

            pstmt.executeQuery();
            pstmt.close();
            conn.commit();
            conn.close();
            System.out.println("Success!");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deactivate_employee(){

    }

    public static void main(String[] args)  {
        Scanner sc = new Scanner(System.in);
        int choice = 0;
        employee_mgmt e = new employee_mgmt();
        System.out.println("Welcome to Employee Management! Menu: \n" +
                "1: Add Employee\n" +
                "2: Deactivate Employee\n" +
                "3: Modify Employee Information\n" +
                "4: To be Continued...\n" +
                "0: Quit");
        choice = sc.nextInt();

        switch (choice){
            case 0:
                System.out.println("Goodbye!");
                break;
            case 1:
                e.addEmployee();
                break;
            case 2:
                e.deactivate_employee();
                break;
            case 3:
                e.addEmployee();
                break;
            case 4:
                e.addEmployee();
                break;
        }
    }
}