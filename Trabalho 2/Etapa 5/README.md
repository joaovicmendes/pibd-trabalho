# Projeto e Implementação de Bancos de Dados (1001546)
Trabalho 2 - Etapa 5: Integrar o banco de dados a uma interface de usuário

Para inicializar o banco, é preciso ter instalado o `docker` e o `docker-compose`. Na raíz da parta da etapa 5, para subir o banco de dados basta executar o comando:
```
docker-compose up
```

Para popular, é preciso executar os scripts em ordem:
1. `1_create.sql`
2. `2_plsql.sql`

Agora, dentro da pasta `postgres`, para compilar e executar o projeto basta realizar os comandos:
```
mvn clean compile assembly:single
java -jar target/postgres-1.0-jar-with-dependencies.jar
```

# Grupo
- [Allan Mansilha Cidreira](https://github.com/AllanMansilha), 760565
- [Amanda Peixoto Manso](https://github.com/amandapmn), 759847
- [João Victor Mendes Freire](https://github.com/joaovicmendes), 758943
- [Julia Cinel Chagas](https://github.com/jcinel), 759314
