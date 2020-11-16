-- A1.1 Defina uma tabela temporária t_funcionario com os seguintes atributos: pnome varchar(255), cpf varchar(11), sexo character(2), salario numeric, cpf_supervisor varchar(11), dnr integer

DROP TABLE IF EXISTS t_funcionario;
CREATE TEMP TABLE t_funcionario(
  pnome varchar(255),
  cpf varchar(11),
  sexo character(2),
  salario numeric,
  cpf_supervisor varchar(11),
  dnr integer
);

-- A1.2. Crie uma function que apague todos os registros da tabela t_funcionario e, em seguida copie os registros da tabela funcionário para t_funcionário.
-- Nome da function: copiafuncionario

DROP FUNCTION IF EXISTS copiafuncionario;
CREATE OR REPLACE FUNCTION copiafuncionario() RETURNS SETOF RECORD AS $$
DECLARE f RECORD;
BEGIN
DELETE FROM t_funcionario;
FOR f IN
SELECT pnome,
  cpf,
  sexo,
  salario,
  cpf_supervisor,
  dnr
FROM funcionario LOOP
INSERT INTO t_funcionario (pnome, cpf, sexo, salario, cpf_supervisor, dnr)
values (
    f.pnome,
    f.cpf,
    f.sexo,
    f.salario,
    f.cpf_supervisor,
    f.dnr
  );
END LOOP;
RETURN QUERY
SELECT *
FROM t_funcionario;
RETURN;
END;
$$ LANGUAGE PLPGSQL;

-- A1.3. Faça uma chamada a função criada

SELECT *
FROM copiafuncionario() AS (
    pnome varchar(255),
    cpf varchar(11),
    sexo character(2),
    salario numeric,
    cpf_supervisor varchar(11),
    dnr integer
  );