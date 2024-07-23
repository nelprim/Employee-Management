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
    public String end_username;
    public String end_userreason;

    public employee_mgmt(){

    }

    public int addEmployee(){
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

        System.out.println("Your Username: ");
        end_username = sc.nextLine();

        System.out.println("Reason for action: ");
        end_userreason = sc.nextLine();

        try{
            Connection conn;
            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            System.out.println("Database Connected Successfully");
            conn.setAutoCommit(false);

            PreparedStatement pstmt = conn.prepareStatement("CALL add_employee(?, ?, ? ,?, ?, ?, ?, ?, ?)");
            pstmt.setString(1, lastname);
            pstmt.setString(2, firstname);
            pstmt.setString(3, extension);
            pstmt.setString(4, email);
            pstmt.setString(5, jobTitle);
            pstmt.setString(6, employee_type);
            pstmt.setString(7, String.valueOf(deptCode));
            pstmt.setString(8, end_username);
            pstmt.setString(9, end_userreason);

            System.out.println("Press any key to continue...");
            sc.nextLine();

            pstmt.executeQuery();
            pstmt.close();
            conn.commit();
            conn.close();
            System.out.println("Success!");
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }

    public int deactivate_employee(){
        Scanner sc = new Scanner(System.in);

        System.out.println("Please enter the necessary information: ");

        System.out.println("Employee Number to be deactivated: ");
        eNumber = sc.nextInt();

        System.out.println("Your Username: ");
        end_username = sc.nextLine();

        System.out.println("Reason for action: ");
        end_userreason = sc.nextLine();

        try{
            Connection conn;
            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            System.out.println("Database Connected Successfully");
            conn.setAutoCommit(false);

            PreparedStatement pstmt = conn.prepareStatement("CALL deactivateEmployee(?, ?, ?)");
            pstmt.setString(1, String.valueOf(eNumber));
            pstmt.setString(2, end_username);
            pstmt.setString(3, end_userreason);

            System.out.println("Press any key to continue...");
            sc.nextLine();

            pstmt.executeQuery();
            pstmt.close();
            conn.commit();
            conn.close();
            System.out.println("Success!");
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
    }
    }



    public static void main(String[] args)  {
        Scanner sc = new Scanner(System.in);
        int choice = 0;
        employee_mgmt e = new employee_mgmt();

        do {
            System.out.println("Welcome to Employee Management! Menu: \n" +
                    "1: Add Employee\n" +
                    "2: Deactivate Employee\n" +
                    "3: Modify Employee Information\n" +
                    "4: To be Continued...\n" +
                    "0: Quit");
            choice = sc.nextInt();

            switch (choice) {
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
                default:
                    System.out.println("Please Try Again");
            }

        } while (choice != 0);
        sc.close();
    }
}