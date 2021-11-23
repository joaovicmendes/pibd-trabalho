-- Criando tabelas
CREATE TABLE Endereco(
    cep         VARCHAR(9),
    rua         VARCHAR(128),
    numero      INTEGER,
    complemento VARCHAR(128),
    cidade      VARCHAR(64) NOT NULL,
    bairro      VARCHAR(64) NOT NULL,	
    PRIMARY KEY (cep, rua, numero, complemento)
);

CREATE TABLE Carro(
    placa  VARCHAR(7) PRIMARY KEY,
    ano    INTEGER NOT NULL,
    modelo VARCHAR(32) NOT NULL,
    cor    VARCHAR(32) DEFAULT 'Branco'
);

CREATE TABLE Pessoa(
    codigo      INTEGER,
    nome        VARCHAR(128) NOT NULL,
    dataNasc    DATE NOT NULL,
    homepage    VARCHAR(128),
    cep         VARCHAR(9) NOT NULL,
    rua         VARCHAR(128) NOT NULL,
    numero      INTEGER NOT NULL,
    complemento VARCHAR(128) NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (cep, rua, numero, complemento) REFERENCES Endereco(cep, rua, numero, complemento)
);

CREATE TABLE Telefone(
    codigo   INTEGER,
    telefone VARCHAR(16) NOT NULL,
    FOREIGN KEY (codigo) REFERENCES Pessoa(codigo),
    PRIMARY KEY (codigo, telefone)
);

CREATE TABLE Amizade(
    codigo_pessoa1 INTEGER,
    codigo_pessoa2 INTEGER,
    dataAmizade DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (codigo_pessoa1) REFERENCES Pessoa(codigo),
    FOREIGN KEY (codigo_pessoa2) REFERENCES Pessoa(codigo),
    PRIMARY KEY (codigo_pessoa1, codigo_pessoa2)
);

CREATE TABLE Possui(
    codigo INTEGER,
    placa VARCHAR(7),
    FOREIGN KEY (codigo) REFERENCES Pessoa(codigo) ON DELETE CASCADE,
    FOREIGN KEY (placa) REFERENCES Carro(placa) ON DELETE CASCADE,
    PRIMARY KEY (codigo, placa)
);
