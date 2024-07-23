import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

public class SalesOrder {

    public int orderNumber;
    public String orderDate;
    public String requiredDate;
    public String shippedDate;
    public String status;
    public String comments;

    public SalesOrder() {}

    public int getInfo() {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter Order Number:");
        orderNumber = sc.nextInt();
        sc.nextLine(); // consume the newline character

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsales2.6?useTimezone=true&serverTimezone=UTC&user=root&password=root")) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn.setAutoCommit(false);
            System.out.println("Connection Successful");

            try (PreparedStatement pstmt = conn.prepareStatement("SELECT orderDate, requiredDate, shippedDate, status, comments FROM orders WHERE orderNumber=? LOCK IN SHARE MODE")) {
                pstmt.setInt(1, orderNumber);

                System.out.println("Press enter key to start retrieving the data");
                sc.nextLine();

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        orderDate = rs.getString("orderDate");
                        requiredDate = rs.getString("requiredDate");
                        shippedDate = rs.getString("shippedDate");
                        status = rs.getString("status");
                        comments = rs.getString("comments");
                    } else {
                        System.out.println("Order not found.");
                        return 0;
                    }
                }

                System.out.println("Order Date:    " + orderDate);
                System.out.println("Required Date: " + requiredDate);
                System.out.println("Shipped Date:  " + shippedDate);
                System.out.println("Status:        " + status);
                System.out.println("Comments:      " + comments);

                System.out.println("Press enter key to end transaction");
                sc.nextLine();

                conn.commit();
                return 1;
            } catch (SQLException e) {
                conn.rollback();
                System.out.println(e.getMessage());
                return 0;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }

    public int updateInfo() {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter Order Number:");
        orderNumber = sc.nextInt();
        sc.nextLine(); // consume the newline character

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsales2.6?useTimezone=true&serverTimezone=UTC&user=root&password=root")) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn.setAutoCommit(false);
            System.out.println("Connection Successful");

            try (PreparedStatement pstmt = conn.prepareStatement("SELECT orderDate, requiredDate, shippedDate, status, comments FROM orders WHERE orderNumber=? FOR UPDATE")) {
                pstmt.setInt(1, orderNumber);

                System.out.println("Press enter key to start retrieving the data");
                sc.nextLine();

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        orderDate = rs.getString("orderDate");
                        requiredDate = rs.getString("requiredDate");
                        shippedDate = rs.getString("shippedDate");
                        status = rs.getString("status");
                        comments = rs.getString("comments");
                    } else {
                        System.out.println("Order not found.");
                        return 0;
                    }
                }

                System.out.println("Order Date:    " + orderDate);
                System.out.println("Required Date: " + requiredDate);
                System.out.println("Shipped Date:  " + shippedDate);
                System.out.println("Status:        " + status);
                System.out.println("Comments:      " + comments);

                System.out.println("Press enter key to enter new values for the order");
                sc.nextLine();

                System.out.println("Enter new Required Date (YYYY-MM-DD): ");
                requiredDate = sc.nextLine();
                

                System.out.println("Enter new Status: ");
                String newStatus = sc.nextLine();

                // Ensure status update follows the allowed sequence
                if (isStatusUpdateValid(status, newStatus)) {
                    System.out.println("Invalid status update.");
                    return 0;
                }

                System.out.println("Enter new Comments: ");
                String newComments = sc.nextLine();
                comments += " " + newComments; // Append new comments

                try (PreparedStatement updatePstmt = conn.prepareStatement("UPDATE orders SET requiredDate=?, status=?, comments=? WHERE orderNumber=?")) {
                    updatePstmt.setString(1, requiredDate);
                    updatePstmt.setString(2, newStatus);
                    updatePstmt.setString(3, comments);
                    updatePstmt.setInt(4, orderNumber);
                    updatePstmt.executeUpdate();
                }

                if (newStatus.equals("Shipped")) {
                    System.out.println("Enter Shipped Date (YYYY-MM-DD): ");
                    shippedDate = sc.nextLine();
                    try (PreparedStatement updatePstmt = conn.prepareStatement("UPDATE orders SET shippedDate=? WHERE orderNumber=?")) {
                        updatePstmt.setString(1, shippedDate);
                        updatePstmt.setInt(2, orderNumber);
                        updatePstmt.executeUpdate();
                    }
                }

                conn.commit();
                return 1;
            } catch (SQLException e) {
                conn.rollback();
                System.out.println(e.getMessage());
                return 0;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }

    public void insertOrder() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        Scanner sc = new Scanner(System.in);
        System.out.println("Enter order number (Enter 0 if new Order): ");
        int orderNumber = Integer.parseInt(sc.nextLine());
        System.out.println("Enter product code: ");
        String productCode = sc.nextLine();
        System.out.println("Enter quantity: ");
        int quantity = Integer.parseInt(sc.nextLine());
        System.out.println("Enter price: ");
        double price = Double.parseDouble(sc.nextLine());
        System.out.println("Enter required date (YYYY-MM-DD): ");
        String requiredDateString = sc.nextLine();
        Date requiredDate = null;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            java.util.Date utilDate = sdf.parse(requiredDateString);
            requiredDate = new java.sql.Date(utilDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            System.out.println("Invalid date format.");
            sc.close();
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsales2.6?useTimezone=True&serverTimezone=UTC&user=root&password=root");
            conn.setAutoCommit(false);

            int newOrderNumber = 0;
            if (orderNumber == 0) {
                pstmt = conn.prepareStatement("SELECT MAX(orderNumber) + 1 AS newOrderNumber FROM orders FOR UPDATE");
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    newOrderNumber = rs.getInt("newOrderNumber");
                }
                if (newOrderNumber == 0) {
                    newOrderNumber = 800001;
                }
                rs.close();
                pstmt.close();

                pstmt = conn.prepareStatement("INSERT INTO orders (orderNumber, requiredDate) VALUES (?, ?)");
                pstmt.setInt(1, newOrderNumber);
                pstmt.setDate(2, (java.sql.Date) requiredDate);
                pstmt.executeUpdate();
                orderNumber = newOrderNumber;
                pstmt.close();
            }

            pstmt = conn.prepareStatement("SELECT * FROM orderdetails FOR UPDATE");  // Write Lock
            rs = pstmt.executeQuery();

            String sql = "SELECT MAX(orderNumber) as maxOrderNumber FROM orders";
            rs = pstmt.executeQuery(sql);

            while (rs.next()) {
                orderNumber = rs.getInt("maxOrderNumber");
            }

            pstmt = conn.prepareStatement("INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach) VALUES (?, ?, ?, ?)");
            pstmt.setInt(1, orderNumber);
            pstmt.setString(2, productCode);
            pstmt.setInt(3, quantity);
            pstmt.setDouble(4, price);
            pstmt.executeUpdate();
            pstmt.close();

            pstmt = conn.prepareStatement("SELECT SLEEP(3);");
            pstmt.executeQuery();

            pstmt = conn.prepareStatement("SELECT * FROM current_products WHERE productCode = ? FOR UPDATE");  // Write Lock
            pstmt.setString(1, productCode);
            rs = pstmt.executeQuery();
            if (!rs.next()) {
                System.out.println("Product code not found.");
                conn.rollback();
                return;
            }


            //pstmt = conn.prepareStatement("SELECT * FROM current_products WHERE productCode = ? FOR UPDATE");  // Write Lock
            //pstmt.setString(1, productCode);
            //rs = pstmt.executeQuery();
            //if (rs.next()) {
            //    System.out.println("Product code not found.");
            //    conn.rollback();
            //    return;
            //}
            
            System.out.println("Press enter key to continue");
            sc.nextLine();

            conn.commit();
            System.out.println("Order added successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
    }

    private boolean validateAndProcessProduct(Connection conn, String productCode, int quantityOrdered, double priceEach) throws SQLException {
        try (PreparedStatement pstmt1 = conn.prepareStatement("SELECT quantityInStock FROM current_products WHERE productCode=?");
             PreparedStatement pstmt2 = conn.prepareStatement("SELECT MSRP FROM product_pricing WHERE productCode=?")) {
             
            pstmt1.setString(1, productCode);
            pstmt2.setString(1, productCode);

            try (ResultSet rs1 = pstmt1.executeQuery();
                 ResultSet rs2 = pstmt2.executeQuery()) {
                 
                if (rs1.next() && rs2.next()) {
                    int quantityInStock = rs1.getInt("quantityInStock");
                    double msrp = rs2.getDouble("MSRP");

                    if (quantityOrdered > quantityInStock) {
                        System.out.println("Ordered quantity exceeds stock available.");
                        return false;
                    }

                    if (priceEach > msrp * 1.0 || priceEach < msrp * 0.8) {
                        System.out.println("Price must be within 20% discount to 100% markup of MSRP.");
                        return false;
                    }

                    // Update inventory
                    try (PreparedStatement updatePstmt = conn.prepareStatement("UPDATE current_products SET quantityInStock=quantityInStock-? WHERE productCode=?")) {
                        updatePstmt.setInt(1, quantityOrdered);
                        updatePstmt.setString(2, productCode);
                        updatePstmt.executeUpdate();
                    }
                    
                    return true;
                } else {
                    System.out.println("Product not found.");
                    return false;
                }
            }
        }
    }

    private void insertOrderDetails(Connection conn, int orderNumber, String productCode, int quantityOrdered, double priceEach) throws SQLException {
        try (PreparedStatement pstmt = conn.prepareStatement("INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach) VALUES (?, ?, ?, ?)")) {
            pstmt.setInt(1, orderNumber);
            pstmt.setString(2, productCode);
            pstmt.setInt(3, quantityOrdered);
            pstmt.setDouble(4, priceEach);
            pstmt.executeUpdate();
        }
    }

    private boolean isStatusUpdateValid(String oldStatus, String newStatus) {
        // Define valid status transitions
        Map<String, List<String>> validTransitions = new HashMap<>();
        validTransitions.put("In-Process", Arrays.asList("Shipped", "Disputed"));
        validTransitions.put("Shipped", Arrays.asList("Disputed", "Completed"));
        validTransitions.put("Disputed", Arrays.asList("Resolved"));
        validTransitions.put("Resolved", Arrays.asList("Completed"));
        
        List<String> allowedStatuses = validTransitions.get(oldStatus);
        return allowedStatuses != null && allowedStatuses.contains(newStatus);
    }

    public int cancelOrder() {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter Order Number to Cancel:");
        orderNumber = sc.nextInt();
        sc.nextLine(); // consume the newline character

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsales2.6?useTimezone=true&serverTimezone=UTC&user=root&password=root")) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn.setAutoCommit(false);
            System.out.println("Connection Successful");

            try (PreparedStatement pstmt = conn.prepareStatement("SELECT status FROM orders WHERE orderNumber=? FOR UPDATE")) {
                pstmt.setInt(1, orderNumber);

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        String currentStatus = rs.getString("status");
                        if (currentStatus.equals("Shipped") || currentStatus.equals("Completed")) {
                            System.out.println("Order cannot be cancelled as it is already shipped or completed.");
                            return 0;
                        }
                    } else {
                        System.out.println("Order not found.");
                        return 0;
                    }
                }

                // Cancel order and update inventory
                try (PreparedStatement updateOrderPstmt = conn.prepareStatement("UPDATE orders SET status=?, comments=CONCAT(comments, ?) WHERE orderNumber=?");
                     PreparedStatement updateDetailsPstmt = conn.prepareStatement("UPDATE orderdetails od JOIN current_products cp ON od.productCode = cp.productCode SET cp.quantityInStock = cp.quantityInStock + od.quantityOrdered WHERE od.orderNumber = ?")) {

                    updateOrderPstmt.setString(1, "Cancelled");
                    updateOrderPstmt.setString(2, " Order was cancelled by System.");
                    updateOrderPstmt.setInt(3, orderNumber);
                    updateOrderPstmt.executeUpdate();

                    // Return products to inventory
                    updateDetailsPstmt.setInt(1, orderNumber);
                    updateDetailsPstmt.executeUpdate();

                    conn.commit();
                    System.out.println("Order cancelled and products returned to inventory.");
                    return 1;
                } catch (SQLException e) {
                    conn.rollback();
                    System.out.println(e.getMessage());
                    return 0;
                }
            } catch (SQLException e) {
                conn.rollback();
                System.out.println(e.getMessage());
                return 0;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }

    private void cancelOrderById(Connection conn, int orderNumber) throws SQLException {
        try (PreparedStatement pstmt = conn.prepareStatement("SELECT status FROM orders WHERE orderNumber=? FOR UPDATE")) {
            pstmt.setInt(1, orderNumber);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String currentStatus = rs.getString("status");
                    if (currentStatus.equals("In-Process")) {
                        try (PreparedStatement updateOrderPstmt = conn.prepareStatement("UPDATE orders SET status=?, comments=CONCAT(comments, ?) WHERE orderNumber=?");
                             PreparedStatement updateDetailsPstmt = conn.prepareStatement("UPDATE orderdetails od JOIN current_products cp ON od.productCode = cp.productCode SET cp.quantityInStock = cp.quantityInStock + od.quantityOrdered WHERE od.orderNumber = ?")) {

                            updateOrderPstmt.setString(1, "Cancelled");
                            updateOrderPstmt.setString(2, " Order was automatically cancelled by the system.");
                            updateOrderPstmt.setInt(3, orderNumber);
                            updateOrderPstmt.executeUpdate();

                            // Return products to inventory
                            updateDetailsPstmt.setInt(1, orderNumber);
                            updateDetailsPstmt.executeUpdate();

                            System.out.println("Order " + orderNumber + " was automatically cancelled.");
                        }
                    }
                }
            }
        }
    }

    public void updateOrderedProducts() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int oldQuantity;
        double oldPrice;

        System.out.println("\nUpdate an order");
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter order number: ");
        int orderNumber = Integer.parseInt(sc.nextLine());
        System.out.println("Enter product code: ");
        String productCode = sc.nextLine();
        System.out.println("Enter new quantity: ");
        int quantity = Integer.parseInt(sc.nextLine());
        System.out.println("Enter new price: ");
        double price = Double.parseDouble(sc.nextLine());

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsales2.6?useTimezone=True&serverTimezone=UTC&user=root&password=root");
            conn.setAutoCommit(false);

            String sql = "SELECT * FROM current_products WHERE productCode = ? FOR UPDATE";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productCode);
            rs = pstmt.executeQuery();

            pstmt = conn.prepareStatement("SELECT SLEEP(3);");
            pstmt.executeQuery();

            String checkSql = "SELECT * FROM orderdetails WHERE orderNumber = ? AND productCode = ? FOR UPDATE";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setInt(1, orderNumber);
            pstmt.setString(2, productCode);
            
            rs = pstmt.executeQuery();

            if (rs.next()) {
                oldQuantity = rs.getInt("quantityOrdered");
                oldPrice = rs.getDouble("priceEach");

                String updateSql = "UPDATE orderdetails SET quantityOrdered = ?, priceEach = ? WHERE orderNumber = ? AND productCode = ?";
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setInt(1, quantity);
                pstmt.setDouble(2, price);
                pstmt.setInt(3, orderNumber);
                pstmt.setString(4, productCode);
                pstmt.executeUpdate();
                System.out.println("\n\nOrder details updated successfully.");
            } else {
                System.out.println("Order number and product code combination not found.");
                conn.rollback(); // Rollback if record is not found
                return;
            }

            // Update the quantity in current_products
            String selectProductSql = "SELECT quantityInStock FROM current_products WHERE productCode = ? FOR UPDATE";
            pstmt = conn.prepareStatement(selectProductSql);
            pstmt.setString(1, productCode);
            pstmt.executeQuery();

            // Display new values of update
            System.out.println("Order Number: " + orderNumber);
            System.out.println("Product Code: " + productCode);
            System.out.println("Old Quantity Ordered: " + oldQuantity);
            System.out.println("Old Price Each: " + oldPrice);
            System.out.println("New Quantity Ordered: " + quantity);
            System.out.println("New Price Each: " + price);

            System.out.println("Press enter key to continue");
            sc.nextLine();

            conn.commit();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        sc.close();
    }

    public void viewProduct() {
        String productCode;
        double minPrice;
        double maxPrice;
        Scanner sc = new Scanner(System.in);
    
        System.out.println("Enter product code to view: ");
        productCode = sc.nextLine();  
    
        Connection conn = null;
        PreparedStatement pstmt = null;
        CallableStatement cstmtMax = null;
        CallableStatement cstmtMin = null;
        ResultSet rs = null;
    
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsales2.6?useTimezone=True&serverTimezone=UTC&user=root&password=root");
            System.out.println("Connection Successful");
            conn.setAutoCommit(false);
    
            String sql = "SELECT * FROM products WHERE productCode = ? LOCK IN SHARE MODE";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productCode);  
    
            cstmtMax = conn.prepareCall("{? = CALL getPrice(?, ?)}");
            cstmtMax.registerOutParameter(1, Types.DOUBLE);
            cstmtMax.setString(2, productCode);
            cstmtMax.setString(3, "MAX");
            cstmtMax.execute();
            maxPrice = cstmtMax.getDouble(1);
    
            cstmtMin = conn.prepareCall("{? = CALL getPrice(?, ?)}");
            cstmtMin.registerOutParameter(1, Types.DOUBLE);
            cstmtMin.setString(2, productCode);
            cstmtMin.setString(3, "MIN");
            cstmtMin.execute();
            minPrice = cstmtMin.getDouble(1);
    
            // Execute the SQL query
            rs = pstmt.executeQuery();
            if (rs.next()) {
                String productName = rs.getString("productName");
                String productScale = rs.getString("productScale");
                String productVendor = rs.getString("productVendor");
                String productDescription = rs.getString("productDescription");
                double buyPrice = rs.getDouble("buyPrice");
                String productCategory = rs.getString("product_category");
    
                System.out.println("Product Code: " + productCode);
                System.out.println("Product Name: " + productName);
                System.out.println("Product Scale: " + productScale);
                System.out.println("Product Vendor: " + productVendor);
                System.out.println("Product Description: " + productDescription);
                System.out.println("Buy Price: " + buyPrice);
                System.out.println("Product Category: " + productCategory);
                System.out.println("Minimum Price: " + minPrice);
                System.out.println("Maximum Price: " + maxPrice);
                System.out.println();
            } else {
                System.out.println("No product found with the given code.");
            }
    
            System.out.println("Press enter key to continue");
            sc.nextLine();
            
            conn.commit(); // Commit the transaction if all is good
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback in case of an error
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (cstmtMax != null) cstmtMax.close();
                if (cstmtMin != null) cstmtMin.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            sc.close();
        }
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        SalesOrder salesOrder = new SalesOrder();
        boolean running = true;
    
        while (running) {
            System.out.println("\n[ Sales Order Management System ]");
            System.out.println("1. View Order Information");
            System.out.println("2. Update Order Information");
            System.out.println("3. Insert New Order");
            System.out.println("4. Update Ordered Products");
            System.out.println("5. View Product Information");
            System.out.println("6. Cancel Order");
            System.out.println("7. Exit");
            System.out.print("Choose an option: ");
    
            try {
                int choice = sc.nextInt();
                sc.nextLine();  // Consume the newline character
    
                switch (choice) {
                    case 1:
                        salesOrder.getInfo();
                        break;
                    case 2:
                        salesOrder.updateInfo();
                        break;
                    case 3:
                        salesOrder.insertOrder();
                        break;
                    case 4:
                        salesOrder.updateOrderedProducts();
                        break;
                    case 5:
                        salesOrder.viewProduct();
                        break;
                    case 6:
                        salesOrder.cancelOrder();
                        break;
                    case 7:
                        running = false;
                        System.out.println("Exiting...");
                        break;
                    default:
                        System.out.println("Invalid choice. Please choose again.");
                }
            } catch (NoSuchElementException e) {
                System.out.println("Invalid input. Please enter a number.");
                sc.nextLine();
            }
    
            System.out.println();
        }
        sc.close();
    }
}