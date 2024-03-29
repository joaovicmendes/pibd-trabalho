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
