-- Excluindo DB se já existir e criando novamente
DROP DATABASE ListaTelefonica;
CREATE DATABASE ListaTelefonica;

USE DATABASE ListaTelefonica;

-- Criando tabelas
CREATE TABLE Endereco(
    cep         VARCHAR2(9),
    rua         VARCHAR2(128),
    numero      NUMBER,
    cidade      VARCHAR2(64) NOT NULL,
    bairro      VARCHAR2(64) NOT NULL,
    complemento VARCHAR2(128) NOT NULL,

    PRIMARY KEY (cep, rua, numero)
);

CREATE TABLE Carro(
    placa  VARCHAR2(7) PRIMARY KEY,
    ano    NUMBER NOT NULL,
    modelo VARCHAR2(32) NOT NULL,
    cor    VARCHAR2(32) NOT NULL,
);

CREATE TABLE Pessoa(
    codigo    NUMBER PRIMARY KEY,
    nome      VARCHAR2(128) NOT NULL,
    dataNasc  DATE NOT NULL,
    homepage  VARCHAR2(128),
    telefone1 VARCHAR2(16) NOT NULL,
    telefone2 VARCHAR2(16),
    cep       VARCHAR2(9) NOT NULL,
    rua       VARCHAR2(128) NOT NULL,
    numero    NUMBER NOT NULL,

    FOREIGN KEY (cep, rua, numero)
    REFERENCES Endereco(cep, rua, numero)
);

CREATE TABLE Amizade(
    codigo_pessoa1 NUMBER,
    codigo_pessoa2 NUMBER,
    dataAmizade DATE NOT NULL,

    FOREIGN KEY (codigo_pessoa1) REFERENCES Pessoa(codigo),
    FOREIGN KEY (codigo_pessoa2) REFERENCES Pessoa(codigo),
    PRIMARY KEY (codigo_pessoa1, codigo_pessoa2),
);

CREATE TABLE Possui(
    codigo NUMBER,
    placa VARCHAR2(7),

    FOREIGN KEY (codigo) REFERENCES Pessoa(codigo),
    FOREIGN KEY (placa) REFERENCES Carro(placa),
    PRIMARY KEY (codigo, placa),
);
