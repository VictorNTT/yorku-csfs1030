import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// Complile
// $ javac MySqlExample.java 
// Run
// $ java  -cp "path\to\mysql-connector-j-8.1.0.jar;." MySqlExample
// Example:
// $ java  -cp "..\lib\mysql-connector-j-8.1.0.jar;." MySqlExample

public class MySqlExample {

    public static void main(String[] args) {
        
		// For illustration purpose only; not for a production environment.
        String database = "world";
        String username = "user1";
        String password = "user1";
		String url = "jdbc:mysql://localhost:3306/" + database;	

        System.out.println("Loading driver...");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("Driver loaded!");
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("Cannot find the driver in the classpath!", e);
        }

        System.out.println("Connecting database, url=" + url);

        try (Connection connection = DriverManager.getConnection(url, username, password))
        {
            System.out.println("Database connected!");
			
            Statement stmt = connection.createStatement();
			String sql = "Select * from country limit 5";
			
			System.out.println("Running SQL: " + sql);
			
            ResultSet rs = stmt.executeQuery(sql);

            while(rs.next()) {
               System.out.println(
                 rs.getString(1) + ","
                + rs.getString(2) + ","
                + rs.getString(3) + ","
                + rs.getString(4) 
                 );
            }

            System.out.println("\nDone");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
}
