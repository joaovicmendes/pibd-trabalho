package br.ufscar.dc.pibd.postgres;

import java.sql.*;

public class SelectPessoa {
    static Connection connection;
    static PreparedStatement statement;
    static ResultSet resultSet;

    static String query =
            "SELECT * FROM (Pessoa NATURAL JOIN Endereco) WHERE Pessoa.codigo='";
    static String queryCarros =
            "SELECT placa FROM (Pessoa NATURAL JOIN Possui NATURAL JOIN Carro) WHERE Pessoa.codigo='";
    static String queryTelefones =
            "SELECT telefone FROM (Pessoa NATURAL JOIN Telefone) WHERE Pessoa.codigo='";
    static String queryEnd = "';";


    public static String selectByCodigo(String codigo) {
        try {
            StringBuilder result = new StringBuilder();
            connection = DriverManager.getConnection(
                    Utils.DatabaseUrl, Utils.DatabaseUser, Utils.DatabasePassword);
            statement = connection.prepareStatement(query + codigo + queryEnd);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                result.append(" Código: ").append(codigo).append("\n");
                result.append(" Nome: ").append(resultSet.getString("nome")).append("\n");
                result.append(" Data de Nascimento: ").append(resultSet.getString("datanasc")).append("\n");
                result.append(" Homepage: ").append(resultSet.getString("homepage")).append("\n");
                result.append(" Endereço:\n" );
                result.append("   ").append(resultSet.getString("rua")).append(", ").append(resultSet.getString("numero")).append("\n");
                result.append("   ").append(resultSet.getString("complemento")).append("\n");
                result.append("   ").append(resultSet.getString("cep")).append("\n");
                result.append("   ").append(resultSet.getString("bairro")).append(", ").append(resultSet.getString("cidade")).append("\n");
            }

            // Se teve resultado, pega os carros
            if (result.length() > 0) {
                // Buscando carros
                statement = connection.prepareStatement(queryCarros + codigo + queryEnd);
                resultSet = statement.executeQuery();

                result.append(" Carro(s): ").append("\n");
                while (resultSet.next()) {
                    result.append("   ").append(resultSet.getString("placa")).append("\n");
                }
                // Buscando telefones
                statement = connection.prepareStatement(queryTelefones + codigo + queryEnd);
                resultSet = statement.executeQuery();

                result.append(" Telefone(s): ").append("\n");
                while (resultSet.next()) {
                    result.append("   ").append(resultSet.getString("telefone")).append("\n");
                }
            } else {
                result.append(" Zero resultados encontrados");
            }

            return result.toString();
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}
