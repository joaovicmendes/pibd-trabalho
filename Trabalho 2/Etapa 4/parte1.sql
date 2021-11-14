-- Criando tabelas
CREATE TABLE Endereco(
    cep         VARCHAR2(9),
    rua         VARCHAR2(128),
    numero      NUMBER,
    complemento VARCHAR2(128),
    cidade      VARCHAR2(64) NOT NULL,
    bairro      VARCHAR2(64) NOT NULL,

    PRIMARY KEY (cep, rua, numero, complemento)
);

CREATE TABLE Carro(
    placa  VARCHAR2(7) PRIMARY KEY,
    ano    NUMBER NOT NULL,
    modelo VARCHAR2(32) NOT NULL,
    cor    VARCHAR2(32) DEFAULT 'Branco'
);

CREATE TABLE Pessoa(
    codigo      NUMBER PRIMARY KEY,
    nome        VARCHAR2(128) NOT NULL,
    dataNasc    DATE NOT NULL,
    homepage    VARCHAR2(128),
    cep         VARCHAR2(9) NOT NULL,
    rua         VARCHAR2(128) NOT NULL,
    numero      NUMBER NOT NULL,
    complemento VARCHAR2(128) NOT NULL,

    FOREIGN KEY (cep, rua, numero, complemento) REFERENCES Endereco(cep, rua, numero, complemento)
);

CREATE TABLE Telefone(
    codigo   NUMBER,
    telefone VARCHAR2(16) NOT NULL,

    FOREIGN KEY (codigo) REFERENCES Pessoa(codigo),
    PRIMARY KEY (codigo, telefone)
);

CREATE TABLE Amizade(
    codigo_pessoa1 NUMBER,
    codigo_pessoa2 NUMBER,
    dataAmizade DATE DEFAULT SYSDATE,

    --oracle usa ON DELETE RESTRICT por padrão, portanto deve ser omitido
    FOREIGN KEY (codigo_pessoa1) REFERENCES Pessoa(codigo),
    FOREIGN KEY (codigo_pessoa2) REFERENCES Pessoa(codigo),
    PRIMARY KEY (codigo_pessoa1, codigo_pessoa2)
);

CREATE TABLE Possui(
    codigo NUMBER,
    placa VARCHAR2(7),

    FOREIGN KEY (codigo) REFERENCES Pessoa(codigo) ON DELETE CASCADE,
    FOREIGN KEY (placa) REFERENCES Carro(placa) ON DELETE CASCADE,
    PRIMARY KEY (codigo, placa)
);

---1. Crie uma sequência para o código da pessoa.

CREATE SEQUENCE Pessoa_codigo_seq;

---2. Altere a tabela da pessoa adicionando um atributo que conta o número de carros da pessoa, e adicionando um atributo que conta o número de amigos da pessoa. Ambos os atributos devem ser inteiros.

ALTER TABLE Pessoa
    ADD (num_carros NUMBER, num_amigos NUMBER);
    
---3. Faça um procedimento para cada tabela de seu esquema relacional para que permita a inserção de dados.

CREATE OR REPLACE PROCEDURE insertEndereco(
	   i_cep IN VARCHAR2,
	   i_rua IN VARCHAR2,
	   i_numero IN NUMBER,
	   i_complemento IN VARCHAR2,
	   i_cidade IN VARCHAR2,
	   i_bairro IN VARCHAR2)
IS
BEGIN

  INSERT INTO Endereco (cep, rua, numero, complemento, cidade, bairro) 
  VALUES (i_cep, i_rua, i_numero, i_complemento, i_cidade, i_bairro);

  COMMIT;

END;

CREATE OR REPLACE PROCEDURE insertCarro(
	   i_placa IN VARCHAR2,
	   i_ano IN NUMBER,
	   i_modelo IN VARCHAR2,
	   i_cor IN VARCHAR2)
IS
BEGIN

  INSERT INTO Carro (placa, ano, modelo, cor) 
  VALUES (i_placa, i_ano, i_modelo, i_cor);

  COMMIT;

END;

CREATE OR REPLACE PROCEDURE insertPessoa(
	   i_codigo IN NUMBER,
	   i_nome IN VARCHAR2,
	   i_dataNasc IN DATE,
	   i_homepage IN VARCHAR2,
	   i_cep IN VARCHAR2,
	   i_rua IN VARCHAR2,
	   i_numero IN NUMBER,
	   i_complemento IN VARCHAR2)
IS
BEGIN

  INSERT INTO Pessoa (codigo, nome, dataNasc, homepage, cep, rua, numero, complemento) 
  VALUES (i_codigo, i_nome, i_dataNasc, i_homepage, i_cep, i_rua, i_numero, i_complemento);

  COMMIT;

END;

CREATE OR REPLACE PROCEDURE insertTelefone(
	   i_codigo IN NUMBER,
	   i_telefone IN VARCHAR2)
IS
BEGIN

  INSERT INTO Telefone (codigo, telefone) 
  VALUES (i_codigo, i_telefone);

  COMMIT;

END;

CREATE OR REPLACE PROCEDURE insertAmizade(
	   i_codigo_p1 IN NUMBER,
	   i_codigo_p2 IN NUMBER,
	   i_dataAmizade in DATE)
IS
BEGIN

  INSERT INTO Amizade (codigo_pessoa1, codigo_pessoa2, dataAmizade) 
  VALUES (i_codigo_p1, i_codigo_p2, i_dataAmizade);

  COMMIT;

END;
