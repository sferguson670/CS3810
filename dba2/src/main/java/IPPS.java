import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.*;
import java.util.*;

public class IPPS {
    private static final String CONFIGURATION_FILE = "config.properties";
    static final String csv_file = "ipps.csv";
    //instantiates lists
    private List drgKeys = new ArrayList();
    private List providerKeys = new ArrayList();
    private List hrrKeys = new ArrayList();
    private List hrrKeys2 = new ArrayList();

    public static void main(String[] args) throws Exception {
        //instantiate runner
        IPPS runner = new IPPS();

        // open config.properties file
        Properties prop = new Properties();
        prop.load(new FileInputStream(CONFIGURATION_FILE));

        String server = prop.getProperty("server");
        String database = prop.getProperty("database");
        String user = prop.getProperty("user");
        String password = prop.getProperty("password");
        String connectURL = "jdbc:mysql://" + server + "/" + database + "?serverTimezone=UTC&user=" + user + "&password=" + password;

        // connects to the database
        Connection conn = DriverManager.getConnection(connectURL);
        System.out.println("Connection to MySQL database " + database + " was successful!");

        //reads file
        try {
            Scanner in = new Scanner(new FileInputStream(csv_file));
            //skips first line
            String first = in.nextLine();
            first = null;
            //runs through file, reads line by line
            while (in.hasNextLine()) {
                String line = in.nextLine();
                String[] data = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)", -1);
                String statement = "";

                //sends data to DRG table
                statement = runner.getDRGInfo(data);
                if (statement.isEmpty()) {
                    //ignore and proceed
                } else {
                    System.out.println(statement);
                    PreparedStatement prpStmt = conn.prepareStatement(statement);
                    prpStmt.execute();
                }

                //sends data to HRR table
                statement = runner.getHRRInfo(data);
                if (statement.isEmpty()) {
                    //ignore and proceed
                } else {
                    System.out.println(statement);
                    PreparedStatement prpStmt = conn.prepareStatement(statement);
                    prpStmt.execute();
                }

                //sends data to Provider table
                statement = runner.getProviderInfo(data);
                if (statement.isEmpty()) {
                    //ignore and proceed
                } else {
                    System.out.println(statement);
                    PreparedStatement prpStmt = conn.prepareStatement(statement);
                    prpStmt.execute();
                }

                //sends data to Charge table
                statement = runner.getChargeInfo(data);
                if (statement.isEmpty()) {
                    //ignore and proceed
                } else {
                    System.out.println(statement);
                    PreparedStatement prpStmt = conn.prepareStatement(statement);
                    prpStmt.execute();
                }
            }
        } catch (FileNotFoundException e) {
            System.out.println("File not found.");
        }

        /*
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
         */

        // closes the connection
        System.out.println("Bye!");
        conn.close();
    }

    /*
     * Takes line data, splits into elements if necessary
     * Checks to see if primary key exists, if not then prepares sql insert
     */
    public String getDRGInfo(String[] data) {
        String[] drgData = data[0].split("-");
        String code = drgData[0].trim().replaceAll("^\"|\"$", "");
        Integer drgCode = Integer.parseInt(code);
        String drgDescription = drgData[1].trim().replaceAll("^\"|\"$", "");

        //if key isn't found, then add key to list, and return sqlInsert
        String sqlInsert = "";
        if (checkDuplicate(drgKeys, drgCode)==false) {
            drgKeys.add(drgCode);
            sqlInsert =  "INSERT INTO DRGs VALUES (" + drgCode + ", \"" + drgDescription + "\")";
        }
        return sqlInsert;
    }

    /*
     * Takes line data, splits into elements if necessary
     * Checks to see if primary keys exists, if not then prepares sql insert
     */
    public String getHRRInfo(String[] data) {
        String[] hrrData = data[7].split("-");
        String hrrCode = hrrData[0].trim();
        String hrrDescription = hrrData[1].trim();

        //if keys isn't found, then add to list, and return sqlInsert
        if ((checkDuplicateString(hrrKeys, hrrCode)==false) || (checkDuplicateString(hrrKeys2, hrrDescription)==false)) {
            hrrKeys.add(hrrCode);
            hrrKeys2.add(hrrDescription);
            return "INSERT INTO HospitalReferralRegions VALUES (\"" + hrrCode + "\" , \"" + hrrDescription + "\")";
        }
        return "";
    }

    /*
     * Takes line data, splits into elements if necessary
     * Checks to see if primary key exists, if not then prepares sql insert
     */
    public String getProviderInfo(String[] data) {
        Integer providerId = Integer.parseInt(data[1].trim());
        String providerName = data[2].trim();
        String providerStreetAddress = data[3].trim();
        String providerCity = data[4].trim();
        String providerState = data[5].trim();
        Integer providerZipCode = Integer.parseInt(data[6].trim());

        //if key isn't found, then add to list, and return sqlInsert
        if (checkDuplicate(providerKeys, providerId)==false) {
            providerKeys.add(providerId);
            if (providerName.startsWith("\"") && providerStreetAddress.startsWith("\"")) {
                return "INSERT INTO Providers VALUES (" + providerId + ", " + providerName + " , " + providerStreetAddress + " , \"" + providerCity + "\" , \"" + providerState + "\" , " + providerZipCode + ")";
            } else if (providerName.startsWith("\"")) {
                return "INSERT INTO Providers VALUES (" + providerId + ", " + providerName + " , \"" + providerStreetAddress + "\" , \"" + providerCity + "\" , \"" + providerState + "\" , " + providerZipCode + ")";
            } else if (providerStreetAddress.startsWith("\"")) {
                return "INSERT INTO Providers VALUES (" + providerId + ", \"" + providerName + "\" , " + providerStreetAddress + " , \"" + providerCity + "\" , \"" + providerState + "\" , " + providerZipCode + ")";
            } else {
                return "INSERT INTO Providers VALUES (" + providerId + ", \"" + providerName + "\" , \"" + providerStreetAddress + "\" , \"" + providerCity + "\" , \"" + providerState + "\" , " + providerZipCode + ")";
            }
        }
        return "";
    }

    /*
     * Takes line data, splits into elements if necessary
     * Checks to see if primary key exists, if not then prepares sql insert
     */
    public String getChargeInfo(String[] data) {
        Integer totalDischarges = Integer.parseInt(data[8].trim());
        Double averageCoveredCharges = Double.parseDouble(data[9].trim());
        Double averageTotalPayments = Double.parseDouble(data[10].trim());
        Double averageMedicarePayments = Double.parseDouble(data[11].trim());

        return "INSERT INTO Charges (totalDischarges, avgCoveredCharges, avgTotalPayments, avgMedicarePayments) VALUES (" + totalDischarges + ", " + averageCoveredCharges + ", " + averageTotalPayments + ", " + averageMedicarePayments + ")";
    }

    /*
     * Checks to see if key (type int) exists in primary keys list
     */
    public boolean checkDuplicate(List list, Integer key) {
        int actualKey = key.intValue();
        boolean found = false;
        if (list.contains(actualKey)) {
            found = true;
        }
        return found;
    }

    /*
     * Checks to see if key (type string) exists in primary keys list
     */
    public boolean checkDuplicateString(List list, String key) {
        boolean found = false;
        if (list.contains(key)) {
            found = true;
        }
        return found;
    }
}

/*
resources used:
https://stackoverflow.com/questions/1757065/java-splitting-a-comma-separated-string-but-ignoring-commas-in-quotes
https://examples.javacodegeeks.com/core-java/sql/jdbc-query-builder-tutorial/
https://www.electrictoolbox.com/article/mysql/delete-all-data-mysql/
https://stackoverflow.com/questions/3844595/how-can-i-make-java-print-quotes-like-hello
https://stackoverflow.com/questions/2608665/how-can-i-trim-beginning-and-ending-double-quotes-from-a-string/25452078
 */