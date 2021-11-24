package br.ufscar.dc.pibd.postgres;

import java.sql.*;

public class InsertEndereco {
    static Connection connection;
    static PreparedStatement statement;

    static String query =
            "INSERT INTO Endereco(cep, rua, numero, complemento, cidade, bairro) VALUES (?,?,?,?,?,?);";


    public static String insert(String cep, String rua, String numero, String complemento, String cidade, String bairro ) {
        try {
            connection = DriverManager.getConnection(
                    Utils.DatabaseUrl, Utils.DatabaseUser, Utils.DatabasePassword);
            statement = connection.prepareStatement(query);

            statement.setString(1, cep);
            statement.setString(2, rua);
            statement.setInt(3, Integer.parseInt(numero));
            statement.setString(4, complemento);
            statement.setString(5, cidade);
            statement.setString(6, bairro);

            statement.executeUpdate();
            return "Endereço inserido";
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}
