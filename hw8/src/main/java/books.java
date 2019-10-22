import java.io.FileInputStream;
import java.sql.*;
import java.util.*;

public class books {

    private static final String CONFIGURATION_FILE = "config.properties";

        public static void main(String[] args) throws Exception {
            // open config.properties file
            Properties prop = new Properties();
            prop.load(new FileInputStream(CONFIGURATION_FILE));

            String server = prop.getProperty("server");
            String database = prop.getProperty("database");
            String user = prop.getProperty("user");
            String password = prop.getProperty("password");
            String connectURL = "jdbc:mysql://" + server + "/" + database + "?serverTimezone=UTC&user=" + user + "&password=" + password;
            //System.out.println(server + " " + database + " " + user + " " + password + " " + connectURL);

            // connects to the database
            Connection conn = DriverManager.getConnection(connectURL);
            System.out.println("Connection to MySQL database " + database + " was successful!");

            // run a simple query
            Statement stmt = conn.createStatement();
            String sql = "SELECT id, title, author FROM Books";
            ResultSet resultSet = stmt.executeQuery(sql);

            // navigate through the rows of the result set
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String title = resultSet.getString("title");
                String author = resultSet.getString("author");
                System.out.println(id + ", " + title + ", " + author);
            }

            // closes the connection
            System.out.println("Bye!");
            conn.close();
        }
    }
