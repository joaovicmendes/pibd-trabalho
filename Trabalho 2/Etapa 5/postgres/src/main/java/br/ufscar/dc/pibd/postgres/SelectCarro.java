package br.ufscar.dc.pibd.postgres;

import java.sql.*;

public class SelectCarro {
    static Connection connection;
    static PreparedStatement statement;
    static ResultSet resultSet;

    static String query =
            "SELECT * FROM (Pessoa NATURAL JOIN Possui NATURAL JOIN Carro) WHERE Carro.placa='";
    static String queryEnd = "';";


    public static String selectByPlaca(String placa) {
        try {
            StringBuilder result = new StringBuilder();
            connection = DriverManager.getConnection(
                    Utils.DatabaseUrl, Utils.DatabaseUser, Utils.DatabasePassword);
            statement = connection.prepareStatement(query + placa + queryEnd);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                result.append(" Placa: ").append(placa).append("\n");
                result.append(" Ano: ").append(resultSet.getString("ano")).append("\n");
                result.append(" Modelo: ").append(resultSet.getString("modelo")).append("\n");
                result.append(" Cor: ").append(resultSet.getString("cor")).append("\n");
                result.append(" Dono:\n" );
                result.append("   Código: ").append(resultSet.getString("codigo")).append("\n");
                result.append("   Nome: ").append(resultSet.getString("nome")).append("\n\n");
            }

            // Se teve resultado, pega os carros
            if (result.length() == 0) {
                result.append(" Zero resultados encontrados");
            }

            return result.toString();
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}
