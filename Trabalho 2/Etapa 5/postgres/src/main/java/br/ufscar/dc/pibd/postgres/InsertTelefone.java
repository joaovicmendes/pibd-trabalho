package br.ufscar.dc.pibd.postgres;

import java.sql.*;

public class InsertTelefone {
    static Connection connection;
    static PreparedStatement statement;

    static String query =
            "INSERT INTO Telefone(codigo, telefone) VALUES (?,?);";


    public static String insert(String codigo, String telefone) {
        try {
            connection = DriverManager.getConnection(
                    Utils.DatabaseUrl, Utils.DatabaseUser, Utils.DatabasePassword);
            statement = connection.prepareStatement(query);

            statement.setInt(1, Integer.parseInt(codigo));
            statement.setString(2, telefone);

            statement.executeUpdate();
            return "Telefone adicionado";
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}
