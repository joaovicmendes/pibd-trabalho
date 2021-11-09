-- Inserindo Endereços
INSERT INTO Endereco(
    cep,
    rua,
    numero,
    cidade,
    bairro,
    complemento
) VALUES (
    '99999-999',
    'Rua Episcopal',
    2474,
    'São Carlos',
    'Centro',
    'Apto 000A'
);

INSERT INTO Endereco(
    cep,
    rua,
    numero,
    cidade,
    bairro,
    complemento
) VALUES (
    '11111-111',
    'Rua França',
    100,
    'Passos',
    'Novo Mundo',
    'Condominio ABC'
);

-- Inserindo Carros
INSERT INTO Carro(
    placa,
    ano,
    modelo
) VALUES (
    'PZQ0125',
    2017,
    2018
);

INSERT INTO Carro(
    placa,
    ano,
    modelo,
    cor
) VALUES (
    'AHX0307',
    2002,
    2002,
    'Coral'
);

-- Inserindo Pessoas
INSERT INTO Pessoa(
    codigo,
    nome,
    dataNasc,
    homepage,
    telefone1,
    telefone2,
    cep,
    rua,
    numero
) VALUES (
    007,
    'Alice Costa',
    TO_DATE('2000/07/25', 'yyyy/mm/dd'),
    'github.com/username',
    '35 9 12345678',
    '16 9 12345678',
    '99999-999',
    'Rua Episcopal',
    2474
);

INSERT INTO Pessoa(
    codigo,
    nome,
    dataNasc,
    homepage,
    telefone1,
    cep,
    rua,
    numero
) VALUES (
    42,
    'Bob da Silva',
    TO_DATE('1991/01/01', 'yyyy/mm/dd'),
    'twitter.com/testestes',
    '35 9 12345678',
    '11111-111',
    'Rua França',
    100
);

-- Inserindo Amizades
INSERT INTO Amizade(
    codigo_pessoa1,
    codigo_pessoa2
) VALUES (
    007,
    42
);

-- Inserindo Possui
INSERT INTO Possui(
    codigo,
    placa
) VALUES (
    007,
    'AHX0307'
);

INSERT INTO Possui(
    codigo,
    placa
) VALUES (
    042,
    'PZQ0125'
);
