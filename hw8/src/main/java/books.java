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
