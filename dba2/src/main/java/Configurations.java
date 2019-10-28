import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Properties;

public class Configurations {
    public static void main(String[] args) {
        try (OutputStream output = new FileOutputStream("config.properties")) {

            Properties prop = new Properties();

            //set the properties value
            prop.setProperty("server", "localhost");
            prop.setProperty("database", "ipps");
            prop.setProperty("user", "ipps");
            prop.setProperty("password", "032423");

            //save properties to project root folder
            prop.store(output, null);

            System.out.println(prop);

        } catch (IOException io) {
            io.printStackTrace();
        }
    }
}
