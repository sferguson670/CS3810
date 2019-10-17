import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.*;

public class books {
        public static void main(String[] args) throws Exception {
            String server = "localhost";
            String database = "books";
            String user = "book_admin";
            String password = "024680";
            String connectURL = "jdbc:mysql://" + server + "/" + database + "?serverTimezone=UTC&user=" + user + "&password=" + password;

            // connects to the database
            Connection conn = DriverManager.getConnection(connectURL);
            System.out.println("Connection to MySQL database " + database + " was successful!");

            // closes the connection
            System.out.println("Bye!");
            conn.close();
        }
    }
