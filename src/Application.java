/*import java.sql.SQLException;
import java.util.Scanner;
public class Application {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        EmployeeManagement manager = new EmployeeManagement();

        try {
            while (true) {
                System.out.println("Select an operation:");
                System.out.println("1. Add an Employee");
                System.out.println("2. Change Employee Type to Sales Manager");
                System.out.println("3. Change Employee Type to Sales Representative");
                System.out.println("4. Change Employee Type to Inventory Manager");
                System.out.println("5. Exit");

                int choice = scanner.nextInt();
                scanner.nextLine(); // consume the leftover newline

                switch (choice) {
                    case 1:
                        // Add an employee
                        System.out.println("Enter details to add an employee:");
                        System.out.print("Last Name: ");
                        String lastName = scanner.nextLine();

                        System.out.print("First Name: ");
                        String firstName = scanner.nextLine();

                        System.out.print("Extension: ");
                        String extension = scanner.nextLine();

                        System.out.print("Email: ");
                        String email = scanner.nextLine();

                        System.out.print("Job Title (e.g., Sales Rep, Sales Manager): ");
                        String jobTitle = scanner.nextLine();

                        System.out.print("Employee Type (S for Sales Rep, N for Manager): ");
                        String employeeType = scanner.nextLine();

                        System.out.print("Is Deactivated (0 for no, 1 for yes): ");
                        int isDeactivated = scanner.nextInt();
                        scanner.nextLine(); // consume the leftover newline

                        System.out.print("End Username: ");
                        String endUsername = scanner.nextLine();

                        System.out.print("End User Reason: ");
                        String endUserReason = scanner.nextLine();

                        manager.addEmployee(lastName, firstName, extension, email, jobTitle, employeeType, isDeactivated, endUsername, endUserReason);
                        System.out.println("Employee added successfully.");
                        break;

                    case 2:
                        // Change employee type to Sales Manager
                        System.out.print("Enter Employee Number: ");
                        int empNumberManager = scanner.nextInt();

                        System.out.print("Enter Department Code: ");
                        int deptCodeManager = scanner.nextInt();
                        scanner.nextLine(); // consume the leftover newline

                        manager.changeEmployeeTypeToSalesManager(empNumberManager, deptCodeManager);
                        System.out.println("Employee type changed to Sales Manager successfully.");
                        break;

                    case 3:
                        // Change employee type to Sales Representative
                        System.out.print("Enter Employee Number: ");
                        int empNumberRep = scanner.nextInt();
                        scanner.nextLine(); // consume the leftover newline

                        manager.changeEmployeeTypeToSalesRepresentative(empNumberRep);
                        System.out.println("Employee type changed to Sales Representative successfully.");
                        break;

                    case 4:
                        // Change employee type to Inventory Manager
                        System.out.print("Enter Employee Number: ");
                        int empNumberInventory = scanner.nextInt();

                        System.out.print("Enter Department Code: ");
                        int deptCodeInventory = scanner.nextInt();
                        scanner.nextLine(); // consume the leftover newline

                        manager.changeEmployeeTypeToInventoryManager(empNumberInventory, deptCodeInventory);
                        System.out.println("Employee type changed to Inventory Manager successfully.");
                        break;

                    case 5:
                        // Exit
                        System.out.println("Exiting...");
                        return;

                    default:
                        System.out.println("Invalid choice. Please enter a number between 1 and 5.");
                        break;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error executing database operation: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Input error: " + e.getMessage());
        } finally {
            scanner.close();
        }
    }
}
*/