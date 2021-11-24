package br.ufscar.dc.pibd.postgres;

import java.sql.*;
import java.util.Date;
import java.text.SimpleDateFormat;

public class InsertPessoa {
    static Connection connection;
    static PreparedStatement statement;

    static String query =
            "INSERT INTO Pessoa(codigo, nome, dataNasc, homepage, cep, rua, numero, complemento) VALUES (?,?,?,?);";


    public static String insert(String codigo, String nome, String data, String homepage, String cep, String rua, int numero, String complemento ) {
        try {
            // connection = DriverManager.getConnection(
            //         Utils.DatabaseUrl, Utils.DatabaseUser, Utils.DatabasePassword);
            // statement = connection.prepareStatement(query);

            // statement.setString(1, Integer.parseInt(codigo));
            // statement.setString(2, nome);
            // statement.setInt(3, SimpleDateFormat("dd/MM/yyyy").parse(data));
            // statement.setString(4, homepage);
            // statement.setString(5, cep);
            // statement.setString(6, rua);
            // statement.setString(7, Integer.parseInt(numero));
            // statement.setString(5, complemento);

            // statement.executeUpdate();
            return "Pessoa inserida";
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}
