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
/

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
/

CREATE OR REPLACE PROCEDURE insertPessoa(
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
  VALUES (0, i_nome, i_dataNasc, i_homepage, i_cep, i_rua, i_numero, i_complemento);

  COMMIT;

END;
/

CREATE OR REPLACE PROCEDURE insertTelefone(
	   i_codigo IN NUMBER,
	   i_telefone IN VARCHAR2)
IS
BEGIN

  INSERT INTO Telefone (codigo, telefone) 
  VALUES (i_codigo, i_telefone);

  COMMIT;

END;
/

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
/

CREATE OR REPLACE PROCEDURE insertPossui(
	   i_codigo IN NUMBER,
	   i_placa IN VARCHAR2)
IS
BEGIN

  INSERT INTO Possui (codigo, placa) 
  VALUES (i_codigo, i_placa);

  COMMIT;

END;
/

---4 Faça um procedimento para cada tabela de seu esquema relacional para que permita a alteração de dados.

CREATE OR REPLACE PROCEDURE alterEndereco(
	   o_cep IN VARCHAR2,
	   o_rua IN VARCHAR2,
	   o_numero IN NUMBER,
	   o_complemento IN VARCHAR2,
	   a_rua IN VARCHAR2,
	   a_numero IN NUMBER,
	   a_complemento IN VARCHAR2,
	   a_cidade IN VARCHAR2,
	   a_bairro IN VARCHAR2)
IS
BEGIN

  UPDATE Endereco 
  SET 
    rua = a_rua,
    numero = a_numero,
    complemento = a_complemento,
    cidade = a_cidade, 
    bairro = a_bairro 
  
  WHERE (
    cep = o_cep and 
    rua = o_rua and 
    numero = o_numero and 
    complemento = o_complemento);
    
  COMMIT;

END;
/

CREATE OR REPLACE PROCEDURE alterCarro(
	   a_placa IN VARCHAR2,
	   a_ano IN NUMBER,
	   a_modelo IN VARCHAR2,
	   a_cor IN VARCHAR2)
IS
BEGIN

  UPDATE Carro SET ano = a_ano, modelo = a_modelo, cor = a_cor WHERE placa = a_placa;
    
  COMMIT;

END;
/

CREATE OR REPLACE PROCEDURE alterPessoa(
	   a_codigo IN NUMBER,
	   a_nome IN VARCHAR2,
	   a_dataNasc IN DATE,
	   a_homepage IN VARCHAR2,
	   a_cep IN VARCHAR2,
	   a_rua IN VARCHAR2,
	   a_numero IN NUMBER,
	   a_complemento IN VARCHAR2)
IS
BEGIN

  UPDATE Pessoa SET nome = a_nome, dataNasc = a_dataNasc, homepage = a_homepage, cep = a_cep, rua = a_rua, numero = a_numero, complemento = a_complemento WHERE codigo = a_codigo;
    
  COMMIT;

END;
/

CREATE OR REPLACE PROCEDURE alterTelefone( 
    o_codigotel IN NUMBER, 
    o_telefone IN VARCHAR2, 
    a_telefone IN VARCHAR2) 
IS 
BEGIN 
    UPDATE Telefone SET telefone = a_telefone WHERE (codigo = o_codigotel and telefone = o_telefone); 
    COMMIT; 
END; 
/

CREATE OR REPLACE PROCEDURE alterAmizade(
	   a_codigo_p1 IN NUMBER,
	   a_codigo_p2 IN NUMBER,
	   a_dataA IN DATE)
IS
BEGIN

  UPDATE Amizade SET dataAmizade = a_dataA WHERE (codigo_pessoa1 = a_codigo_p1 and codigo_pessoa2 = a_codigo_p2);
    
  COMMIT;

END;
/

CREATE OR REPLACE PROCEDURE alterPossui(
	   a_codigo IN NUMBER,
	   a_placa IN VARCHAR2)
IS
BEGIN

  UPDATE Possui SET placa = a_placa WHERE codigo = a_codigo;
    
  COMMIT;

END;
/

-- 5. Faça uma trigger que use sequências para a inserção das chaves das tuplas de pessoa (disparar antes de inserção na tabela pessoa).

CREATE OR REPLACE TRIGGER onInsertPessoa
BEFORE INSERT ON Pessoa
FOR EACH ROW
BEGIN
    :NEW.codigo := Pessoa_codigo_seq.nextval;
END;
/

-- 6. Faça no mínimo 10 inserts para cada tabela utilizando as procedures criadas.

BEGIN
insertEndereco('12345678', 'Rua Episcopal', 1000, 'Apto 12', 'São Carlos', 'Centro');
insertEndereco('23456789', 'Av. da Moda', 34, 'Vazio', 'São Carlos', 'Vila Nery');
insertEndereco('34567890', 'Av. Brasil', 234, 'São Carlos Clube', 'São Carlos', 'Centro');
insertEndereco('45678901', 'Rua São João', 987, 'Apto 14', 'Descalvado', 'Algum');
insertEndereco('56789012', 'Rua Teste', 2343, 'Apto 12C', 'Dourado', 'Jardin Canada');
insertEndereco('67890123', 'Avenida Exemplo', 4554, 'Apartamento Azul', 'Matão', 'Centro');
insertEndereco('78901234', 'Rua Cuba', 121, 'String', 'São José dos Campos', 'Novo Mundo');
insertEndereco('89012345', 'Rua França', 131, 'Complemento', 'Passos', 'Exemplo');
insertEndereco('90123456', 'Rua', 323, 'Em frente à Farmácia', 'São Caetano', 'Bairro');
insertEndereco('01234567', 'Endereço', 44, 'Condominio Vila', 'São Paulo', 'Teste');

insertCarro('ABC0001', 2018, 'Onix', 'Branco');
insertCarro('ABC0002', 2002, 'Jaguar', 'Chumbo');
insertCarro('ABC0003', 2013, 'Jaguar', 'Preto');
insertCarro('ABC0004', 2000, 'Corolla', 'Prata');
insertCarro('ABC0005', 2021, 'X40', 'Prata');
insertCarro('ABC0006', 2020, 'Ka', 'Preto');
insertCarro('ABC0007', 2007, 'HB20', 'Branco');
insertCarro('ABC0008', 2018, 'March', 'Prata');
insertCarro('ABC0009', 2018, 'April', 'Azul');
insertCarro('ABC0010', 2013, 'Azul?', 'Vermelho');

insertPessoa('Alice', TO_DATE('2000/09/25', 'yyyy/mm/dd'), 'github.com', '12345678', 'Rua Episcopal', 1000, 'Apto 12');
insertPessoa('Bob', TO_DATE('1999/06/15', 'yyyy/mm/dd'), 'meusite.com', '23456789', 'Av. da Moda', 34, 'Vazio');
insertPessoa('Carlos', TO_DATE('1997/10/17', 'yyyy/mm/dd'), 'stackoverlow.com', '34567890', 'Av. Brasil', 234, 'São Carlos Clube');
insertPessoa('Daniel', TO_DATE('1996/12/27', 'yyyy/mm/dd'), 'facebook.com/Daniel', '45678901', 'Rua São João', 987, 'Apto 14');
insertPessoa('Eduarda', TO_DATE('2000/11/16', 'yyyy/mm/dd'), 'meusite.com', '56789012', 'Rua Teste', 2343, 'Apto 12C');
insertPessoa('Fabio Jr', TO_DATE('2001/09/25', 'yyyy/mm/dd'), 'meusite.com', '67890123', 'Avenida Exemplo', 4554, 'Apartamento Azul');
insertPessoa('Gabriela', TO_DATE('2002/07/29', 'yyyy/mm/dd'), 'meusite.com', '78901234', 'Rua Cuba', 121, 'String');
insertPessoa('Helena', TO_DATE('1998/05/07', 'yyyy/mm/dd'), 'meusite.com', '89012345', 'Rua França', 131, 'Complemento');
insertPessoa('Iago', TO_DATE('1999/06/01', 'yyyy/mm/dd'), 'meusite.com', '90123456', 'Rua', 323, 'Em frente à Farmácia');
insertPessoa('Jonas', TO_DATE('1999/07/15', 'yyyy/mm/dd'), 'meusite.com', '01234567', 'Endereço', 44, 'Condominio Vila');

insertTelefone(1, '35912341234');
insertTelefone(1, '16912341234');
insertTelefone(2, '11900000000');
insertTelefone(2, '11900000001');
insertTelefone(3, '35912341234');
insertTelefone(4, '11900000005');
insertTelefone(5, '11900000006');
insertTelefone(6, '11900000007');
insertTelefone(7, '11900000008');
insertTelefone(7, '35999999999');
insertTelefone(8, '12901010101');
insertTelefone(9, '12901010022');
insertTelefone(10, '11987674532');
insertTelefone(10, '12999497728');

insertAmizade(1, 2, TO_DATE('2005/01/16', 'yyyy/mm/dd'));
insertAmizade(1, 4, TO_DATE('2005/01/16', 'yyyy/mm/dd'));
insertAmizade(2, 4, TO_DATE('2005/01/16', 'yyyy/mm/dd'));
insertAmizade(3, 7, TO_DATE('2009/07/23', 'yyyy/mm/dd'));
insertAmizade(3, 8, TO_DATE('2009/07/24', 'yyyy/mm/dd'));
insertAmizade(3, 10, TO_DATE('2009/07/23', 'yyyy/mm/dd'));
insertAmizade(7, 8, TO_DATE('2009/07/22', 'yyyy/mm/dd'));
insertAmizade(7, 10, TO_DATE('2009/07/23', 'yyyy/mm/dd'));
insertAmizade(10, 1, TO_DATE('2018/03/05', 'yyyy/mm/dd'));
insertAmizade(10, 2, TO_DATE('2018/03/05', 'yyyy/mm/dd'));

insertPossui(1, 'ABC0001');
insertPossui(2, 'ABC0002');
insertPossui(3, 'ABC0003');
insertPossui(4, 'ABC0004');
insertPossui(5, 'ABC0005');
insertPossui(6, 'ABC0006');
insertPossui(6, 'ABC0007');
insertPossui(7, 'ABC0006');
insertPossui(7, 'ABC0007');
insertPossui(8, 'ABC0008');
insertPossui(9, 'ABC0009');
insertPossui(9, 'ABC0010');

END;
/

-- 7. Faça uma função que retorne o nome da pessoa.

CREATE OR REPLACE FUNCTION getNomePessoa
  (p_codigo IN NUMBER)
  RETURN VARCHAR2
  IS
    p_nome VARCHAR2(128);
  BEGIN
     SELECT nome INTO p_nome FROM Pessoa WHERE codigo = p_codigo;
     RETURN p_nome;
  END;
/

-- Utilizando cursor implicito

CREATE OR REPLACE FUNCTION getNomePessoaCursor
  (p_codigo IN NUMBER)
  RETURN VARCHAR2
  IS
    p_nome VARCHAR2(128);
  BEGIN
     SELECT nome INTO p_nome FROM Pessoa WHERE codigo = p_codigo;
     IF sql%found then RETURN p_nome;
     ELSE RETURN ('Nenhum usuário encontrado!');
    END IF;
  END;
/

-- 8. Faça uma função que retorne o número de amigos que ela possui.

CREATE OR REPLACE FUNCTION getNumAmigosPessoa
  (p_codigo IN NUMBER)
  RETURN VARCHAR2
  IS
    p_num_amigos NUMBER;
  BEGIN
     SELECT num_amigos INTO p_num_amigos FROM Pessoa WHERE codigo = p_codigo;
     RETURN p_num_amigos;
  END;
/

-- 9. Faça um procedimento que atualize os atributos número de amigos de acordo com as informações presentes no banco
-- Utilizando cursor explicito
CREATE OR REPLACE PROCEDURE atualizaNumAmigos
    IS
    new_num_amigos NUMBER;
    nome_pessoa VARCHAR2(10);
    codigo_pessoa NUMBER;
    CURSOR CAMIGOS IS SELECT nome, codigo FROM Pessoa;
    BEGIN
    
    OPEN CAMIGOS;
    
    --- Primeira volta do loop
    FETCH CAMIGOS INTO nome_pessoa, codigo_pessoa;
    
    -- Enquanto o cursor encontra pessoas
    while CAMIGOS%found LOOP
    
        -- Calculando número de amizades
        SELECT COUNT(*) INTO new_num_amigos
        FROM Amizade 
        WHERE codigo_pessoa1=codigo_pessoa OR codigo_pessoa2=codigo_pessoa;
        
        dbms_output.put_line ('A quantidade de amigos que o usuário '|| nome_pessoa || ' tem é: ' || new_num_amigos);

        -- Atualizando tabela
        UPDATE Pessoa SET Pessoa.num_amigos=new_num_amigos WHERE Pessoa.codigo=codigo_pessoa;
        
        -- Continua o loop
        FETCH CAMIGOS INTO nome_pessoa, codigo_pessoa;
        
    END LOOP;
    close CAMIGOS;
END;
/

-- 10. Faça um procedimento que atualize o número de pessoas de acordo com as informações presentes no banco.

CREATE OR REPLACE PROCEDURE atualizaNumCarros
    IS
    new_num_carros NUMBER;
    BEGIN
    FOR i IN (SELECT codigo FROM Pessoa) LOOP
        -- Calculando número de carros
        SELECT COUNT(*) INTO new_num_carros
        FROM Possui 
        WHERE codigo=i.codigo;

        -- Atualizando tabela
        UPDATE Pessoa SET Pessoa.num_carros=new_num_carros WHERE Pessoa.codigo=i.codigo;
    END LOOP;
END;
/

-- 11. Faça um trigger que atualize automaticamente o número de amigos quando a mesma fizer uma nova amizade ou quando desfizer alguma amizade.

CREATE OR REPLACE TRIGGER onChangeAmizade
BEFORE INSERT OR DELETE ON Amizade
FOR EACH ROW
BEGIN
  IF INSERTING THEN
      UPDATE Pessoa SET num_amigos=(num_amigos+1) WHERE codigo=:NEW.codigo_pessoa1;
      UPDATE Pessoa SET num_amigos=(num_amigos+1) WHERE codigo=:NEW.codigo_pessoa2;
  ELSIF DELETING THEN
      UPDATE Pessoa SET num_amigos=(num_amigos-1) WHERE codigo=:OLD.codigo_pessoa1;
      UPDATE Pessoa SET num_amigos=(num_amigos-1) WHERE codigo=:OLD.codigo_pessoa2;
  END IF;
END;
/

-- 12.  Faça um trigger que atualize automaticamenteo número de carros da pessoa, quando a mesma tiver mais um carro ou quando vencder um carro.

CREATE OR REPLACE TRIGGER onChangePossui
BEFORE INSERT OR DELETE ON Possui
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    UPDATE Pessoa SET num_carros=(num_carros+1) WHERE codigo=:NEW.codigo;
  ELSIF DELETING THEN
    UPDATE Pessoa SET num_carros=(num_carros-1) WHERE codigo=:OLD.codigo;
  END IF;
END;
/

-- 13. Faça uma view que retorne todas os nomes das pessoas que não tem amigos.

create or replace view PESSOAS_SEM_AMIGOS as
select nome from Pessoa
where num_amigos = 0;
/

---14. Faça uma view que retorne o nome das pessoas que tem o carro modelo ‘Jaguar’ e dos seus amigos.
select nome 
from
(
    select unique nome, codigo
    from 
    ( -- donos de jaguar
        select nome, codigo 
        from Pessoa 
            natural join Possui
            natural join (select * from Carro where modelo='Jaguar')
    )
    union
    ( -- amigos deles
        select nome, codigo
        from (
            select codigo_pessoa2
            from Pessoa
                natural join Possui
                natural join (select * from Carro where modelo='Jaguar')
                join Amizade on codigo_pessoa1=codigo
        ) join Pessoa on codigo=codigo_pessoa2
    )
);
