package br.ufscar.dc.pibd.postgres;

import java.sql.*;

public class InsertCarro {
    static Connection connection;
    static PreparedStatement statement;

    static String query =
            "INSERT INTO Carro(placa, ano, modelo, cor) VALUES (?,?,?,?);";


    public static String insert(String placa, String ano, String modelo, String cor) {
        try {
            connection = DriverManager.getConnection(
                    Utils.DatabaseUrl, Utils.DatabaseUser, Utils.DatabasePassword);
            statement = connection.prepareStatement(query);

            statement.setString(1, placa);
            statement.setInt(2, Integer.parseInt(ano));
            statement.setString(3, modelo);
            statement.setString(4, cor);

            statement.executeUpdate();
            return "Carro inserido";
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}
