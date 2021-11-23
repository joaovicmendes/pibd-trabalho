package br.ufscar.dc.pibd.postgres;

import java.sql.*;

public class InsertPossui {
    static Connection connection;
    static PreparedStatement statement;

    static String query =
            "INSERT INTO Possui(codigo, placa) VALUES (?,?);";


    public static String insert(String codigo, String placa) {
        try {
            connection = DriverManager.getConnection(
                    Utils.DatabaseUrl, Utils.DatabaseUser, Utils.DatabasePassword);
            statement = connection.prepareStatement(query);

            statement.setInt(1, Integer.parseInt(codigo));
            statement.setString(2, placa);

            statement.executeUpdate();
            return "Carro associado ao proprietário";
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}
