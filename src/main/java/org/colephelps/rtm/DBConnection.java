package org.colephelps.rtm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
    protected static Connection PGconnection;
    protected static Connection LiteConnection;

    public static Connection getPostgresConnection() {
        return PGconnection;
    }

    public static Connection getLiteConnection() {
        return LiteConnection;
    }

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.out.print(e.getMessage() + "ERROR");
        }

        String url = "jdbc:postgresql://localhost/railtopomodel";
        Properties props = new Properties();
        props.setProperty("user", "postgres");
        props.setProperty("password", "postgres");
        try {
            PGconnection = DriverManager.getConnection(url, props);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            System.out.print(e.getMessage() + "ERROR");
        }

        try {
            LiteConnection = DriverManager.getConnection("jdbc:sqlite:/home/colephelps/Загрузки/42673.db");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
