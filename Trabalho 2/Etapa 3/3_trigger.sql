-- Tentativa de trigger em Pessoa
-- Não funcionou: a tabela Possui é alterada, logo
-- não é possível fazer query nela.
CREATE OR REPLACE TRIGGER onDeletePessoa
BEFORE DELETE ON Pessoa
FOR EACH ROW
BEGIN
    for i in (
            SELECT placa
            FROM Carro NATURAL JOIN (SELECT * FROM Possui WHERE codigo=:old.codigo)
        ) LOOP
        DELETE FROM Carro WHERE Carro.placa = i.placa;
    END LOOP;
END;

-- Tentativa de trigger em possui
-- Não funcionou: ainda reporta o erro que a tabela está sendo alterada,
-- e não deixa atualizar. Tentamos desabilitar o constraint de FK,
-- mas nesse caso retornou erro de integridade.
CREATE OR REPLACE TRIGGER onDeletePossui
BEFORE DELETE ON Possui
FOR EACH ROW
BEGIN
    DELETE FROM Carro WHERE Carro.placa=:old.placa;
END;

-- Testando trigger
select * from Carro;

select * from Possui;

delete from Pessoa where codigo=007;

select * from Carro;

select * from Possui;
