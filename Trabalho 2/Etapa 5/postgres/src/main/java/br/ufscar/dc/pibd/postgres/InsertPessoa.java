package br.ufscar.dc.pibd.postgres;

import java.sql.*;
import java.util.Date;
import java.text.SimpleDateFormat;

public class InsertPessoa {
    static Connection connection;
    static PreparedStatement statement;

    static String query =
            "INSERT INTO Pessoa(codigo, nome, dataNasc, homepage, cep, rua, numero, complemento) VALUES (?,?,?,?,?,?,?,?);";


    public static String insert(String codigo, String nome, String data, String homepage, String cep, String rua, String numero, String complemento ) {
        try {
            connection = DriverManager.getConnection(
                    Utils.DatabaseUrl, Utils.DatabaseUser, Utils.DatabasePassword);
            statement = connection.prepareStatement(query);

            Date dataNasc = new SimpleDateFormat("dd/MM/yyyy").parse(data);

            statement.setInt(1, Integer.parseInt(codigo));
            statement.setString(2, nome);
            statement.setDate(3, new java.sql.Date(dataNasc.getTime()));
            statement.setString(4, homepage);
            statement.setString(5, cep);
            statement.setString(6, rua);
            statement.setInt(7, Integer.parseInt(numero));
            statement.setString(8, complemento);

            statement.executeUpdate();
            return "Pessoa inserida";
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}
