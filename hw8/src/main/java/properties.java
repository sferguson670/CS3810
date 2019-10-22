import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Properties;

public class properties {
    public static void main(String[] args) {
        try (OutputStream output = new FileOutputStream("config.properties")) {

            Properties prop = new Properties();

            //set the properties value
            prop.setProperty("server", "localhost");
            prop.setProperty("database", "books");
            prop.setProperty("user", "book_admin");
            prop.setProperty("password", "024680");

            //save properties to project root folder
            prop.store(output, null);

            System.out.println(prop);

        } catch (IOException io) {
            io.printStackTrace();
        }
    }
}

/* Used: https://www.mkyong.com/java/java-properties-file-examples/ as a resource */