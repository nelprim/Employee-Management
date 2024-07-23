import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class EmployeeManagement {

    public void addEmployee(String lastName, String firstName, String extension, String email, String jobTitle, String employeeType, int depCode, String endUsername, String endUserReason) throws SQLException {
        try (Connection conn = DatabaseConnector.getConnection();
             CallableStatement stmt = conn.prepareCall("{CALL add_employee(?, ?, ?, ?, ?, ?, ?, ?, ?)}")) {
            stmt.setString(1, lastName);
            stmt.setString(2, firstName);
            stmt.setString(3, extension);
            stmt.setString(4, email);
            stmt.setString(5, jobTitle);

            // Map employeeType to the expected procedure values
            String procedureEmployeeType;
            if ("S".equalsIgnoreCase(employeeType)) {
                procedureEmployeeType = "Sales Representatives";
            } else if ("N".equalsIgnoreCase(employeeType)) {
                // You can choose either 'Inventory Manager' or 'Sales Manager' based on your requirement
                procedureEmployeeType = "Sales Manager";
            } else {
                throw new IllegalArgumentException("Invalid employee type");
            }
            stmt.setString(6, procedureEmployeeType);

            stmt.setInt(7, depCode);
            stmt.setString(8, endUsername);
            stmt.setString(9, endUserReason);
            stmt.execute();
        }
    }
    public void changeEmployeeTypeToInventoryManager(int employeeNumber, int deptCode) throws SQLException {
        try (Connection conn = DatabaseConnector.getConnection();
             CallableStatement stmt = conn.prepareCall("{CALL employeeTypeToInventoryManagers(?, ?)}")) {
            stmt.setInt(1, employeeNumber);
            stmt.setInt(2, deptCode);
            stmt.execute();
        }
    }

    public void changeEmployeeTypeToSalesManager(int employeeNumber, int deptCode) throws SQLException {
        try (Connection conn = DatabaseConnector.getConnection();
             CallableStatement stmt = conn.prepareCall("{CALL employeeTypeToSalesManager(?, ?)}")) {
            stmt.setInt(1, employeeNumber);
            stmt.setInt(2, deptCode);
            stmt.execute();
        }
    }

    public void changeEmployeeTypeToSalesRepresentative(int employeeNumber) throws SQLException {
        try (Connection conn = DatabaseConnector.getConnection();
             CallableStatement stmt = conn.prepareCall("{CALL employeeTypeToSalesRepresentative(?)}")) {
            stmt.setInt(1, employeeNumber);
            stmt.execute();
        }
    }
}
