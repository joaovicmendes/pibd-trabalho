package br.ufscar.dc.pibd.postgres;

import java.sql.*;
import java.util.Date;
import java.text.SimpleDateFormat;

public class InsertAmizade {
    static Connection connection;
    static PreparedStatement statement;

    static String query =
            "INSERT INTO Amizade(codigo_pessoa1, codigo_pessoa2, dataAmizade) VALUES (?,?,?);";


    public static String insert(String codigo_pessoa1, String codigo_pessoa2, String dataAmizade) {
        try {
            connection = DriverManager.getConnection(
                    Utils.DatabaseUrl, Utils.DatabaseUser, Utils.DatabasePassword);
            statement = connection.prepareStatement(query);

            statement.setInt(1, Integer.parseInt(codigo_pessoa1));
            statement.setInt(2, Integer.parseInt(codigo_pessoa2));
            statement.setDate(3, new java.sql.Date(dataAmizade.getTime()));

            statement.executeUpdate();
            return "Amizade inserida";
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}
