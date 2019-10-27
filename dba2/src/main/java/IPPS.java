import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.*;
import java.util.*;

public class IPPS {

    private static final String CONFIGURATION_FILE = "config.properties";
    static final String csv_file = "ipps_short.csv";

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

        //reads file
        try {
            Scanner in = new Scanner(new FileInputStream(csv_file));
            //skips first line
            String first = in.nextLine();
            first = null;
            while (in.hasNextLine()) {
                String line = in.nextLine();
                String data[] = line.split(",");
                System.out.println(line);
                //split data into respective columns
                String drglong = data[0];
                String drg[] = drglong.split("-");
                int drgCode = Integer.parseInt(drg[0].trim());
                String drgDefinition = drg[1];

                int providerId = Integer.parseInt(data[1]);
                String providerName = data[3];
                String providerCity = data[4];
                String providerState = data[5];
                int providerZip = Integer.parseInt(data[6]);

                String hospitalReferrallong = data[7].trim();
                String hospitalReferral[] = hospitalReferrallong.split("-");
                String hospitalReferralCode = hospitalReferral[0];
                String hospitalReferralDescription = hospitalReferral[1];


                int totalDischarge = Integer.parseInt(data[8]);
                double averageCoveredCharges = Double.parseDouble(data[9]);
                double averageTotalPayments = Double.parseDouble(data[10]);
                double averageMedicarePayments = Double.parseDouble(data[11]);
                //System.out.println(drgDefinition + " " + providerId + " " + providerName + " " + providerCity + " " + providerState + " " + providerZip  + " " + hospitalReferralDescription + " " + totalDischarge + " " + averageCoveredCharges + " " + averageTotalPayments + " "  + averageMedicarePayments);
            }
        } catch (FileNotFoundException e) {
            System.out.println("File not found.");
        }

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
