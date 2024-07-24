import java.text.SimpleDateFormat;
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
    public String officeCode;
    public String startDate;
    public String endDate;
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

    public int view_employee(int eNumber){
        Scanner sc = new Scanner(System.in);
        try{
            Connection conn;
            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            System.out.println("Database Connected Successfully");
            conn.setAutoCommit(false);

            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM employees WHERE " +
                    "employeeNumber = ? LOCK IN SHARE MODE");
            pstmt.setString(1, String.valueOf(eNumber));
            PreparedStatement sleep = conn.prepareStatement("SELECT SLEEP(3)");

            ResultSet rs = pstmt.executeQuery();
            sleep.executeQuery();
            while (rs.next()){
                eNumber = rs.getInt("employeeNumber");
                lastname = rs.getString("lastName");
                firstname = rs.getString("firstName");
                extension = rs.getString("extension");
                email = rs.getString("email");
                jobTitle = rs.getString("jobTitle");
                employee_type = rs.getString("employee_type");
                isDeactivated = rs.getBoolean("is_deactivated");
            }
            rs.close();


            System.out.println("Employee Number: " + eNumber);
            System.out.println("Last Name: " + lastname);
            System.out.println("First Name: " + firstname);
            System.out.println("Extension: " + extension);
            System.out.println("Email: " + email);
            System.out.println("Job Title: " + jobTitle);
            System.out.println("Employee Type: " + employee_type);
            System.out.println("Is employee deactivated?: " + isDeactivated);

            System.out.println("Press enter key to continue...");
            sc.nextLine();
            pstmt.close();
            sleep.close();
            conn.commit();
            conn.close();
            System.out.println("Success!");
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }

    public int changeEmployeeTypeToInventoryManager(){
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter Employee Number: ");
        eNumber = Integer.valueOf(sc.nextLine());
        System.out.println("Enter Department Code");
        eNumber = sc.nextInt();

        try {
            Connection conn;
            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            System.out.println("Database Connected Successfully");
            conn.setAutoCommit(false);

            PreparedStatement pstmt = conn.prepareStatement("{CALL employeeTypeToInventoryManagers(?, ?)}");
            pstmt.setInt(1, eNumber);
            pstmt.setInt(2, deptCode);

            pstmt.execute();
            System.out.println("Press enter key to continue...");
            sc.nextLine();
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

    public int changeEmployeeTypeToSalesManager(){
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter Employee Number: ");
        eNumber = Integer.valueOf(sc.nextLine());
        System.out.println("Enter Department Code");
        eNumber = sc.nextInt();

        try {
            Connection conn;
            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            System.out.println("Database Connected Successfully");
            conn.setAutoCommit(false);

            PreparedStatement pstmt = conn.prepareStatement("{CALL employeeTypeToSalesManagers(?, ?)}");
            pstmt.setInt(1, eNumber);
            pstmt.setInt(2, deptCode);

            pstmt.execute();
            System.out.println("Press enter key to continue...");
            sc.nextLine();
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

    public int changeEmployeeTypeToSalesRepresentative(){
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter Employee Number: ");
        eNumber = Integer.valueOf(sc.nextLine());

        try {
            Connection conn;
            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            System.out.println("Database Connected Successfully");
            conn.setAutoCommit(false);

            PreparedStatement pstmt = conn.prepareStatement("{CALL employeeTypeToSalesRepresentative(?)}");
            pstmt.setInt(1, eNumber);

            pstmt.execute();
            System.out.println("Press enter key to continue...");
            sc.nextLine();
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

    public void view_salesRepInfo(){
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter Sales Representative Employee Number: ");
        eNumber = sc.nextInt();
        try{
            Connection conn;
            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            System.out.println("Database Connected Successfully");
            conn.setAutoCommit(false);

            System.out.println("Employee Number - Name - Email - Office Code - Start Date - " +
                    "End Date - Reason - Quota - Manager Employee Number");

                PreparedStatement pstmt = conn.prepareStatement("SELECT e.employeeNumber, e.lastName, e.firstName, e.email, sra.officeCode, sra.startDate, sra.endDate, \n" +
                        "       sra.reason, sra.quota, sra.salesManagerNumber\n" +
                        "FROM employees e\n" +
                        "JOIN salesRepAssignments sra ON e.employeeNumber = sra.employeeNumber\n" +
                        "WHERE e.employeeNumber = ? \n" +
                        "LOCK IN SHARE MODE;\n");
                pstmt.setInt(1, eNumber);
                PreparedStatement sleep = conn.prepareStatement("SELECT SLEEP(3)");
                ResultSet rs = pstmt.executeQuery();
                sleep.executeQuery();

                while (rs.next()){
                    lastname = rs.getString("lastName");
                    firstname = rs.getString("firstName");
                    email = rs.getString("email");
                    officeCode = rs.getString("officeCode");
                    startDate = rs.getString("startDate");
                    endDate = rs.getString("endDate");
                    reason = rs.getString("reason");
                    quota = rs.getFloat("quota");
                    salesManagerNum = rs.getInt("salesManagerNumber");
                    System.out.println(eNumber +
                            "  " + lastname + ", " + firstname +
                            "  " + email +
                            "   " + officeCode +
                            "   " + startDate+
                            "   " + endDate+
                            "   " + reason+
                            "   " + quota+
                            "   " + salesManagerNum);
                }
                rs.close();



            System.out.println("Press enter key to continue...");
            sc.nextLine();
            pstmt.close();
            sleep.close();
            conn.commit();
            conn.close();
            System.out.println("Success!");

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public int modify_employee(){
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter Employee Number: ");
        eNumber = sc.nextInt();
        view_employee(eNumber);

        System.out.println("Press Enter to enter new values for employee record");
        sc.nextLine();

        System.out.println("Enter new extension: ");
        extension = sc.nextLine();

        System.out.println("Enter new email: ");
        email = sc.nextLine();

        System.out.println("Enter new Job Title: ");
        jobTitle = sc.nextLine();

        try{
            Connection conn;
            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            System.out.println("Database Connected Successfully");
            conn.setAutoCommit(false);

            PreparedStatement pstmt = conn.prepareStatement("UPDATE employees SET extension = ?, " +
                    "email = ?, jobTitle = ? WHERE employeeNumber = ?");
            pstmt.setString(1, extension);
            pstmt.setString(2, email);
            pstmt.setString(3, jobTitle);
            pstmt.setInt(4, eNumber);

            System.out.println("Please press enter key to continue...");
            sc.nextLine();

            pstmt.executeUpdate();
            pstmt.close();
            conn.commit();
            conn.close();
            return 1;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }

    }
    public int assign_salesRep() {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter Employee Number: ");
        eNumber = sc.nextInt();
        sc.nextLine();

        System.out.println("Enter the following: ");
        System.out.println("Office Code: ");
        officeCode = sc.nextLine();
        System.out.println("Start Date (yyyy-mm-dd): ");
        startDate = sc.nextLine();
        System.out.println("End Date (yyyy-mm-dd): ");
        endDate = sc.nextLine();
        System.out.println("Reason: ");
        reason = sc.nextLine();
        System.out.println("Quota: ");
        quota = sc.nextDouble();
        System.out.println("Sales Manager Number: ");
        salesManagerNum = sc.nextInt();
        System.out.println("Your username: ");
        end_username = sc.nextLine();
        System.out.println("Reason for action: ");
        end_userreason = sc.nextLine();

        try (Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword)) {
            System.out.println("Database Connected Successfully");
            conn.setAutoCommit(false);

            // Check if an entry exists for the employee
            PreparedStatement checkExist = conn.prepareStatement(
                    "SELECT endDate FROM salesRepAssignments WHERE employeeNumber = ? ORDER BY endDate DESC LIMIT 1 LOCK IN SHARE MODE");
            checkExist.setInt(1, eNumber);
            PreparedStatement sleep = conn.prepareStatement("SELECT SLEEP(3)");
            ResultSet rs = checkExist.executeQuery();
            sleep.executeQuery();


            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date newStartDate;
            if (rs.next()) {
                // If an existing entry is found, set the new start date to be the day after the existing end date
                Date existingEndDate = rs.getDate("endDate");
                java.util.Calendar calendar = java.util.Calendar.getInstance();
                calendar.setTime(existingEndDate);
                calendar.add(java.util.Calendar.DAY_OF_YEAR, 1);
                newStartDate = new Date(calendar.getTimeInMillis());
                startDate = dateFormat.format(newStartDate);
            } else {
                // If no existing entry is found, use the provided start date
                newStartDate = new Date(dateFormat.parse(startDate).getTime());
            }

            // Check if the new assignment exceeds one month
            java.util.Calendar calendar = java.util.Calendar.getInstance();
            calendar.setTime(newStartDate);
            calendar.add(java.util.Calendar.MONTH, 1);
            Date maxEndDate = new Date(calendar.getTimeInMillis());
            Date inputEndDate = new Date(dateFormat.parse(endDate).getTime());
            if (inputEndDate.after(maxEndDate)) {
                System.out.println("End date exceeds the maximum allowed one month period. Setting end date to one month from start date.");
                endDate = dateFormat.format(maxEndDate);
            }
            // Insert the new assignment
            PreparedStatement insertAssignment = conn.prepareStatement(
                    "INSERT INTO salesRepAssignments (employeeNumber, officeCode, startDate, endDate, reason, " +
                            "quota, salesManagerNumber, end_username, end_userreason) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            insertAssignment.setInt(1, eNumber);
            insertAssignment.setString(2, officeCode);
            insertAssignment.setString(3, startDate);
            insertAssignment.setString(4, endDate);
            insertAssignment.setString(5, reason);
            insertAssignment.setDouble(6, quota);
            insertAssignment.setInt(7, salesManagerNum);
            insertAssignment.setString(8, end_username);
            insertAssignment.setString(9, end_userreason);
            insertAssignment.executeUpdate();

            System.out.println("Sales representative assigned successfully.");
            System.out.println("Press any key to continue...");

            sc.nextLine();
            rs.close();
            sleep.close();
            checkExist.close();
            insertAssignment.close();
            conn.commit();
            conn.close();
            return 1;
        } catch (SQLException | java.text.ParseException e) {
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
                    "3: View Employee Information\n" +
                    "4: Modify Employee Information\n" +
                    "5: Modify Employee Type\n" +
                    "6: View Sales Representative Information\n" +
                    "7: Assign Sales Representative\n" +
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
                    System.out.println("Enter Employee Number: ");
                    e.eNumber = sc.nextInt();
                    e.view_employee(e.eNumber);
                    break;
                case 4:
                    e.modify_employee();
                    break;
                case 5:
                    System.out.println("Select New Employee Type Assignment: \n" +
                            "1: Change to Inventory Manger\n" +
                            "2: Change to Sales Manager\n" +
                            "3: Change to Sales Representative\n");
                    int subchoice = sc.nextInt();
                    switch (subchoice) {
                        case 1:
                            e.changeEmployeeTypeToInventoryManager();
                            break;
                        case 2:
                            e.changeEmployeeTypeToSalesManager();
                            break;
                        case 3:
                            e.changeEmployeeTypeToSalesRepresentative();
                            break;
                        default:
                            System.out.println("Invalid option, try again");
                    }
                case 6:
                    e.view_salesRepInfo();
                    break;
                case 7:
                    e.assign_salesRep();
                    break;
                default:
                    System.out.println("Please Try Again");
            }

        } while (choice != 0);
        sc.close();
    }
}